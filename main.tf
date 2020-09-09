provider "google" {
  project = "bolero-internal-labs"
  region  = "europe-north1"
  zone    = "europe-north1-a"
}
resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "My Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Allocator - CPU Utilization"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\" AND metadata.system_labels.name=\"instance-1\""
      duration   = "65s"
      comparison = "COMPARISON_GT"
      threshold_value = "0.8"
      trigger {
	  count = 1
      }
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
}

