Received: from eggs.gnu.org ([2001:4830:134:3::10]:57950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddYlK-0007z3-RT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddYlH-0006L6-NT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1ddYlH-0006Ib-Dp
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:19:15 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  4 Aug 2017 11:14:01 +0200
Message-Id: <20170804091403.13478-2-lprosek@redhat.com>
In-Reply-To: <20170804091403.13478-1-lprosek@redhat.com>
References: <20170804091403.13478-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] i386/kvm: use a switch statement for MSR
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rkrcmar@redhat.com

Switch is easier on the eye and might lead to better codegen.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 target/i386/kvm.c | 76 +++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6db7783..ed119ca 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1081,66 +1081,54 @@ static int kvm_get_supported_msrs(KVMState *s)
             int i;
 
             for (i = 0; i < kvm_msr_list->nmsrs; i++) {
-                if (kvm_msr_list->indices[i] == MSR_STAR) {
+                switch (kvm_msr_list->indices[i]) {
+                case MSR_STAR:
                     has_msr_star = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_VM_HSAVE_PA) {
+                    break;
+                case MSR_VM_HSAVE_PA:
                     has_msr_hsave_pa = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_TSC_AUX) {
+                    break;
+                case MSR_TSC_AUX:
                     has_msr_tsc_aux = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_TSC_ADJUST) {
+                    break;
+                case MSR_TSC_ADJUST:
                     has_msr_tsc_adjust = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_TSCDEADLINE) {
+                    break;
+                case MSR_IA32_TSCDEADLINE:
                     has_msr_tsc_deadline = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_SMBASE) {
+                    break;
+                case MSR_IA32_SMBASE:
                     has_msr_smbase = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_MISC_ENABLE) {
+                    break;
+                case MSR_IA32_MISC_ENABLE:
                     has_msr_misc_enable = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_BNDCFGS) {
+                    break;
+                case MSR_IA32_BNDCFGS:
                     has_msr_bndcfgs = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_XSS) {
+                    break;
+                case MSR_IA32_XSS:
                     has_msr_xss = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_CRASH_CTL) {
+                    break;;
+                case HV_X64_MSR_CRASH_CTL:
                     has_msr_hv_crash = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_RESET) {
+                    break;
+                case HV_X64_MSR_RESET:
                     has_msr_hv_reset = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_VP_INDEX) {
+                    break;
+                case HV_X64_MSR_VP_INDEX:
                     has_msr_hv_vpindex = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_VP_RUNTIME) {
+                    break;
+                case HV_X64_MSR_VP_RUNTIME:
                     has_msr_hv_runtime = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_SCONTROL) {
+                    break;
+                case HV_X64_MSR_SCONTROL:
                     has_msr_hv_synic = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_STIMER0_CONFIG) {
+                    break;
+                case HV_X64_MSR_STIMER0_CONFIG:
                     has_msr_hv_stimer = true;
-                    continue;
+                    break;
                 }
+
             }
         }
 
-- 
2.9.3
