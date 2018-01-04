Received: from eggs.gnu.org ([2001:4830:134:3::10]:45629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eXBvQ-0006Qx-Du
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eXBvM-0005PC-KD
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:15:40 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:23387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eXBvL-0005I9-Qk
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:15:36 -0500
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
	<1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
	<cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
	<130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
	<671681eb-5d03-1797-4b0e-70b6e8b7b257@redhat.com>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <b3231ee0-a232-057b-dbfe-bd31e0d4bf02@profihost.ag>
Date: Thu, 4 Jan 2018 21:15:28 +0100
MIME-Version: 1.0
In-Reply-To: <671681eb-5d03-1797-4b0e-70b6e8b7b257@redhat.com>
Content-Type: multipart/mixed; boundary="------------CA81285F695AD4139BA699E1"
Content-Language: de-DE
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

This is a multi-part message in MIME format.
--------------CA81285F695AD4139BA699E1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

attached the relevant patch for everybody who needs it.

Greets,
Stefan
Am 04.01.2018 um 16:53 schrieb Paolo Bonzini:
> On 04/01/2018 09:35, Alexandre DERUMIER wrote:
>>>> So you need: 
>>>> 1.) intel / amd cpu microcode update 
>>>> 2.) qemu update to pass the new MSR and CPU flags from the microcode update 
>>>> 3.) host kernel update 
>>>> 4.) guest kernel update 
>>
>> are you sure we need to patch guest kernel if we are able to patch qemu ?
> 
> Patching the guest kernel is only required to protect the guest kernel
> from guest usermode.
> 
>> If I understand, patching the host kernel, should avoid that a vm is reading memory of another vm.
>> (the most critical)
> 
> Correct.
> 
>> patching the guest kernel, to avoid that a process from the vm have access to memory of another process of same vm.
> 
> Correct.
> 
> The QEMU updates are pretty boring, mostly taking care of new MSR and
> CPUID flags (and adding new CPU models).
> 
> They are not needed to protect the guest from "Meltdown", only
> "Spectre"---the former only needs a guest kernel update.  Also, to have
> any effect, the guest kernels must also have "Spectre" patches which
> aren't upstream yet for either KVM or the rest of Linux.  So the QEMU
> patches are much less important than the kernel side.
> 
>>> https://access.redhat.com/solutions/3307851 
>>> "Impacts of CVE-2017-5754, CVE-2017-5753, and CVE-2017-5715 to Red Hat Virtualization products" 
> 
> It mostly repeats the contents of the RHEL document
> https://access.redhat.com/security/vulnerabilities/speculativeexecution,
> with some information specific to RHV.
> 
> Thanks,
> 
> Paolo
> 
>> i don't have one but the content might be something like this: 
>> https://www.suse.com/de-de/support/kb/doc/?id=7022512 
>>
>> So you need: 
>> 1.) intel / amd cpu microcode update 
>> 2.) qemu update to pass the new MSR and CPU flags from the microcode update 
>> 3.) host kernel update 
>> 4.) guest kernel update 
>>
>> The microcode update and the kernel update is publicly available but i'm 
>> missing the qemu one. 
>>
>> Greets, 
>> Stefan 
>>
>>> ----- Mail original ----- 
>>> De: "aderumier" <aderumier@odiso.com> 
>>> À: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>>> Cc: "qemu-devel" <qemu-devel@nongnu.org> 
>>> Envoyé: Jeudi 4 Janvier 2018 08:24:34 
>>> Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches 
>>>
>>>>> Can anybody point me to the relevant qemu patches? 
>>>
>>> I don't have find them yet. 
>>>
>>> Do you known if a vm using kvm64 cpu model is protected or not ? 
>>>
>>> ----- Mail original ----- 
>>> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>>> À: "qemu-devel" <qemu-devel@nongnu.org> 
>>> Envoyé: Jeudi 4 Janvier 2018 07:27:01 
>>> Objet: [Qemu-devel] CVE-2017-5715: relevant qemu patches 
>>>
>>> Hello, 
>>>
>>> i've seen some vendors have updated qemu regarding meltdown / spectre. 
>>>
>>> f.e.: 
>>>
>>> CVE-2017-5715: QEMU was updated to allow passing through new MSR and 
>>> CPUID flags from the host VM to the CPU, to allow enabling/disabling 
>>> branch prediction features in the Intel CPU. (bsc#1068032) 
>>>
>>> Can anybody point me to the relevant qemu patches? 
>>>
>>> Thanks! 
>>>
>>> Greets, 
>>> Stefan 
>>>
>>
>>
> 

--------------CA81285F695AD4139BA699E1
Content-Type: text/x-patch;
 name="0065-i386-kvm-MSR_IA32_SPEC_CTRL-and-MSR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0065-i386-kvm-MSR_IA32_SPEC_CTRL-and-MSR.patch"

>From b4fdfeb4545c09a0fdf01edc938f9cce8fcaa5c6 Mon Sep 17 00:00:00 2001
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 7 Nov 2017 16:39:49 +0800
Subject: [PATCH] i386/kvm: MSR_IA32_SPEC_CTRL and MSR_IA32_PRED_CMD

CPUID(EAX=0X7,ECX=0).EDX[26]/[27] indicates the support of
MSR_IA32_SPEC_CTRL and MSR_IA32_PRED_CMD. Expose the CPUID
to the guest. Also add the support of transferring the MSRs during live
migration.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
[BR: BSC#1068032 CVE-2017-5715]
Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 target/i386/cpu.c     |  3 ++-
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm.c     | 15 ++++++++++++++-
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 55f72b679f..01761db3fc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2823,13 +2823,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
+            host_cpuid(index, 0, eax, ebx, ecx, edx);
             *eax = 0; /* Maximum ECX value for sub-leaves */
             *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
             *ecx = env->features[FEAT_7_0_ECX]; /* Feature flags */
             if ((*ecx & CPUID_7_0_ECX_PKU) && env->cr[4] & CR4_PKE_MASK) {
                 *ecx |= CPUID_7_0_ECX_OSPKE;
             }
-            *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
+            *edx = env->features[FEAT_7_0_EDX] | *edx;
         } else {
             *eax = 0;
             *ebx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a458c3af9b..9aa2480c63 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -333,6 +333,7 @@
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
+#define MSR_IA32_SPEC_CTRL              0x00000048
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -639,6 +640,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26)
+#define CPUID_7_0_EDX_PRED_CMD      (1U << 27)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
@@ -1181,6 +1184,7 @@ typedef struct CPUX86State {
 
     uint64_t xss;
 
+    uint64_t spec_ctrl;
     TPRAccess tpr_access_type;
 } CPUX86State;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865dbee0..b35f02064b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -75,6 +75,7 @@ static bool has_msr_star;
 static bool has_msr_hsave_pa;
 static bool has_msr_tsc_aux;
 static bool has_msr_tsc_adjust;
+static bool has_msr_spec_ctrl;
 static bool has_msr_tsc_deadline;
 static bool has_msr_feature_control;
 static bool has_msr_misc_enable;
@@ -1096,6 +1097,10 @@ static int kvm_get_supported_msrs(KVMState *s)
                     has_msr_tsc_adjust = true;
                     continue;
                 }
+                if (kvm_msr_list->indices[i] == MSR_IA32_SPEC_CTRL) {
+                    has_msr_spec_ctrl = true;
+                    continue;
+                }
                 if (kvm_msr_list->indices[i] == MSR_IA32_TSCDEADLINE) {
                     has_msr_tsc_deadline = true;
                     continue;
@@ -1667,6 +1672,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, env->xss);
     }
+    if (has_msr_spec_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
+    }
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
         kvm_msr_entry_add(cpu, MSR_CSTAR, env->cstar);
@@ -2081,7 +2089,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, 0);
     }
-
+    if (has_msr_spec_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
+    }
 
     if (!env->tsc_valid) {
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
@@ -2303,6 +2313,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_XSS:
             env->xss = msrs[i].data;
             break;
+        case MSR_IA32_SPEC_CTRL:
+            env->spec_ctrl = msrs[i].data;
+            break;
         default:
             if (msrs[i].index >= MSR_MC0_CTL &&
                 msrs[i].index < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 78ae2f986b..a6d429ad1a 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -868,6 +868,25 @@ static const VMStateDescription vmstate_xss = {
     }
 };
 
+static bool spec_ctrl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->spec_ctrl != 0;
+}
+
+static const VMStateDescription vmstate_spec_ctrl = {
+    .name = "cpu/spec_ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spec_ctrl_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.spec_ctrl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_X86_64
 static bool pkru_needed(void *opaque)
 {
@@ -1049,6 +1068,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_hyperv_stimer,
         &vmstate_avx512,
         &vmstate_xss,
+        &vmstate_spec_ctrl,
         &vmstate_tsc_khz,
 #ifdef TARGET_X86_64
         &vmstate_pkru,

--------------CA81285F695AD4139BA699E1--
