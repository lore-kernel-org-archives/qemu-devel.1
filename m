Received: from eggs.gnu.org ([2001:4830:134:3::10]:49173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcF-0007Mi-3x
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcD-0004wJ-T8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcD-0004wE-Mu
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:03 -0500
Message-Id: <20180327143014.1767669-4-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] error: Strip trailing '\n' from error
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

Re-run Coccinelle script scripts/coccinelle/err-bad-newline.cocci,
and found new error_report() occurrences with '\n'.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20180323143202.28879-3-lvivier@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 target/i386/hvf/hvf.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 15870a4f366..c36753954be 100644
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
