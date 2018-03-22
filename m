Received: from eggs.gnu.org ([2001:4830:134:3::10]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ez2ph-0001nQ-IA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ez2pg-0007Fa-I4
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:12:53 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 22 Mar 2018 17:12:23 +0100
Message-Id: <20180322161226.29796-2-lvivier@redhat.com>
In-Reply-To: <20180322161226.29796-1-lvivier@redhat.com>
References: <20180322161226.29796-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] error: Strip trailing '\n' from error
 string arguments (again again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Re-run Coccinelle script scripts/coccinelle/err-bad-newline.cocci,
and found new error_report() occurences with '\n'.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 target/i386/hvf/hvf.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 15870a4f36..c36753954b 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -86,25 +86,25 @@ static void assert_hvf_ok(hv_return_t ret)
 
     switch (ret) {
     case HV_ERROR:
-        error_report("Error: HV_ERROR\n");
+        error_report("Error: HV_ERROR");
         break;
     case HV_BUSY:
-        error_report("Error: HV_BUSY\n");
+        error_report("Error: HV_BUSY");
         break;
     case HV_BAD_ARGUMENT:
-        error_report("Error: HV_BAD_ARGUMENT\n");
+        error_report("Error: HV_BAD_ARGUMENT");
         break;
     case HV_NO_RESOURCES:
-        error_report("Error: HV_NO_RESOURCES\n");
+        error_report("Error: HV_NO_RESOURCES");
         break;
     case HV_NO_DEVICE:
-        error_report("Error: HV_NO_DEVICE\n");
+        error_report("Error: HV_NO_DEVICE");
         break;
     case HV_UNSUPPORTED:
-        error_report("Error: HV_UNSUPPORTED\n");
+        error_report("Error: HV_UNSUPPORTED");
         break;
     default:
-        error_report("Unknown Error\n");
+        error_report("Unknown Error");
     }
 
     abort();
@@ -191,7 +191,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     if (mem) {
         mem->size = 0;
         if (do_hvf_set_memory(mem)) {
-            error_report("Failed to reset overlapping slot\n");
+            error_report("Failed to reset overlapping slot");
             abort();
         }
     }
@@ -211,7 +211,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     }
 
     if (x == hvf_state->num_slots) {
-        error_report("No free slots\n");
+        error_report("No free slots");
         abort();
     }
 
@@ -221,7 +221,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     mem->region = area;
 
     if (do_hvf_set_memory(mem)) {
-        error_report("Error registering new memory slot\n");
+        error_report("Error registering new memory slot");
         abort();
     }
 }
@@ -884,7 +884,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             }
             default:
-                error_report("Unrecognized CR %d\n", cr);
+                error_report("Unrecognized CR %d", cr);
                 abort();
             }
             RIP(env) += ins_len;
@@ -930,7 +930,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             env->error_code = 0;
             break;
         default:
-            error_report("%llx: unhandled exit %llx\n", rip, exit_reason);
+            error_report("%llx: unhandled exit %llx", rip, exit_reason);
         }
     } while (ret == 0);
 
-- 
2.14.3
