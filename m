Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E408FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996592166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996592166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdn4-0000yL-OT
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:24:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiO-0005qx-3J
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiM-0006KQ-07
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiL-0005kg-Om
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B73C309B6D5;
	Fri, 17 May 2019 14:19:30 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8003A78576;
	Fri, 17 May 2019 14:19:28 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:16 +0200
Message-Id: <20190517141924.19024-2-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-1-vkuznets@redhat.com>
References: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 17 May 2019 14:19:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/9] i386/kvm: convert hyperv enlightenments
 properties from bools to bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Representing Hyper-V properties as bits will allow us to check features
and dependencies between them in a natural way.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 hw/i386/pc.c          |  3 +-
 target/i386/cpu.c     | 44 +++++++++++++++--------
 target/i386/cpu.h     | 37 +++++++++++--------
 target/i386/hyperv.c  |  2 +-
 target/i386/kvm.c     | 83 ++++++++++++++++++-------------------------
 target/i386/machine.c |  2 +-
 6 files changed, 91 insertions(+), 80 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d98b737b8f..77c479e667 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2387,7 +2387,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
     }
     cpu->thread_id =3D topo.smt_id;
=20
-    if (cpu->hyperv_vpindex && !kvm_hv_vpindex_settable()) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
+        !kvm_hv_vpindex_settable()) {
         error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX")=
;
         return;
     }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c5514d4..9530b28d42 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5819,21 +5819,37 @@ static Property x86_cpu_properties[] =3D {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID=
),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
+
     { .name  =3D "hv-spinlocks", .info  =3D &qdev_prop_spinlocks },
-    DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false)=
,
-    DEFINE_PROP_BOOL("hv-vapic", X86CPU, hyperv_vapic, false),
-    DEFINE_PROP_BOOL("hv-time", X86CPU, hyperv_time, false),
-    DEFINE_PROP_BOOL("hv-crash", X86CPU, hyperv_crash, false),
-    DEFINE_PROP_BOOL("hv-reset", X86CPU, hyperv_reset, false),
-    DEFINE_PROP_BOOL("hv-vpindex", X86CPU, hyperv_vpindex, false),
-    DEFINE_PROP_BOOL("hv-runtime", X86CPU, hyperv_runtime, false),
-    DEFINE_PROP_BOOL("hv-synic", X86CPU, hyperv_synic, false),
-    DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
-    DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false=
),
-    DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenmen=
t, false),
-    DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
-    DEFINE_PROP_BOOL("hv-evmcs", X86CPU, hyperv_evmcs, false),
-    DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
+    DEFINE_PROP_BIT64("hv-relaxed", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RELAXED, 0),
+    DEFINE_PROP_BIT64("hv-vapic", X86CPU, hyperv_features,
+                      HYPERV_FEAT_VAPIC, 0),
+    DEFINE_PROP_BIT64("hv-time", X86CPU, hyperv_features,
+                      HYPERV_FEAT_TIME, 0),
+    DEFINE_PROP_BIT64("hv-crash", X86CPU, hyperv_features,
+                      HYPERV_FEAT_CRASH, 0),
+    DEFINE_PROP_BIT64("hv-reset", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RESET, 0),
+    DEFINE_PROP_BIT64("hv-vpindex", X86CPU, hyperv_features,
+                      HYPERV_FEAT_VPINDEX, 0),
+    DEFINE_PROP_BIT64("hv-runtime", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RUNTIME, 0),
+    DEFINE_PROP_BIT64("hv-synic", X86CPU, hyperv_features,
+                      HYPERV_FEAT_SYNIC, 0),
+    DEFINE_PROP_BIT64("hv-stimer", X86CPU, hyperv_features,
+                      HYPERV_FEAT_STIMER, 0),
+    DEFINE_PROP_BIT64("hv-frequencies", X86CPU, hyperv_features,
+                      HYPERV_FEAT_FREQUENCIES, 0),
+    DEFINE_PROP_BIT64("hv-reenlightenment", X86CPU, hyperv_features,
+                      HYPERV_FEAT_REENLIGHTENMENT, 0),
+    DEFINE_PROP_BIT64("hv-tlbflush", X86CPU, hyperv_features,
+                      HYPERV_FEAT_TLBFLUSH, 0),
+    DEFINE_PROP_BIT64("hv-evmcs", X86CPU, hyperv_features,
+                      HYPERV_FEAT_EVMCS, 0),
+    DEFINE_PROP_BIT64("hv-ipi", X86CPU, hyperv_features,
+                      HYPERV_FEAT_IPI, 0),
+
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0128910661..11fa9e643e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -743,6 +743,22 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
 #define MSR_ARCH_CAP_SSB_NO     (1U << 4)
=20
+/* Supported Hyper-V Enlightenments */
+#define HYPERV_FEAT_RELAXED             0
+#define HYPERV_FEAT_VAPIC               1
+#define HYPERV_FEAT_TIME                2
+#define HYPERV_FEAT_CRASH               3
+#define HYPERV_FEAT_RESET               4
+#define HYPERV_FEAT_VPINDEX             5
+#define HYPERV_FEAT_RUNTIME             6
+#define HYPERV_FEAT_SYNIC               7
+#define HYPERV_FEAT_STIMER              8
+#define HYPERV_FEAT_FREQUENCIES         9
+#define HYPERV_FEAT_REENLIGHTENMENT     10
+#define HYPERV_FEAT_TLBFLUSH            11
+#define HYPERV_FEAT_EVMCS               12
+#define HYPERV_FEAT_IPI                 13
+
 #ifndef HYPERV_SPINLOCK_NEVER_RETRY
 #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
 #endif
@@ -1381,23 +1397,11 @@ struct X86CPU {
=20
     CPUX86State env;
=20
-    bool hyperv_vapic;
-    bool hyperv_relaxed_timing;
     int hyperv_spinlock_attempts;
     char *hyperv_vendor_id;
-    bool hyperv_time;
-    bool hyperv_crash;
-    bool hyperv_reset;
-    bool hyperv_vpindex;
-    bool hyperv_runtime;
-    bool hyperv_synic;
     bool hyperv_synic_kvm_only;
-    bool hyperv_stimer;
-    bool hyperv_frequencies;
-    bool hyperv_reenlightenment;
-    bool hyperv_tlbflush;
-    bool hyperv_evmcs;
-    bool hyperv_ipi;
+    uint64_t hyperv_features;
+
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
@@ -1934,4 +1938,9 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const X8=
6XSaveArea *buf);
 void x86_cpu_xsave_all_areas(X86CPU *cpu, X86XSaveArea *buf);
 void x86_update_hflags(CPUX86State* env);
=20
+static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
+{
+    return !!(cpu->hyperv_features & BIT(feat));
+}
+
 #endif /* I386_CPU_H */
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index b264a28620..26efc1e0e6 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -52,7 +52,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_e=
xit *exit)
=20
     switch (exit->type) {
     case KVM_EXIT_HYPERV_SYNIC:
-        if (!cpu->hyperv_synic) {
+        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
             return -1;
         }
=20
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5c0d..3daac1e4f4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -635,28 +635,12 @@ unsigned long kvm_arch_vcpu_id(CPUState *cs)
 #define KVM_CPUID_SIGNATURE_NEXT                0x40000100
 #endif
=20
-static bool hyperv_hypercall_available(X86CPU *cpu)
-{
-    return cpu->hyperv_vapic ||
-           (cpu->hyperv_spinlock_attempts !=3D HYPERV_SPINLOCK_NEVER_RET=
RY);
-}
-
 static bool hyperv_enabled(X86CPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     return kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0 &&
-           (hyperv_hypercall_available(cpu) ||
-            cpu->hyperv_time  ||
-            cpu->hyperv_relaxed_timing ||
-            cpu->hyperv_crash ||
-            cpu->hyperv_reset ||
-            cpu->hyperv_vpindex ||
-            cpu->hyperv_runtime ||
-            cpu->hyperv_synic ||
-            cpu->hyperv_stimer ||
-            cpu->hyperv_reenlightenment ||
-            cpu->hyperv_tlbflush ||
-            cpu->hyperv_ipi);
+        ((cpu->hyperv_spinlock_attempts !=3D HYPERV_SPINLOCK_NEVER_RETRY=
) ||
+         cpu->hyperv_features);
 }
=20
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -705,14 +689,14 @@ static int hyperv_handle_properties(CPUState *cs)
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
=20
-    if (cpu->hyperv_relaxed_timing) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
         env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
     }
-    if (cpu->hyperv_vapic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
         env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |=3D HV_APIC_ACCESS_AVAILABLE;
     }
-    if (cpu->hyperv_time) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TIME)) {
         if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <=3D=
 0) {
             fprintf(stderr, "Hyper-V clocksources "
                     "(requested by 'hv-time' cpu flag) "
@@ -723,7 +707,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |=3D HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |=3D HV_REFERENCE_TSC_AVAILABLE;
     }
-    if (cpu->hyperv_frequencies) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_FREQUENCIES)) {
         if (!has_msr_hv_frequencies) {
             fprintf(stderr, "Hyper-V frequency MSRs "
                     "(requested by 'hv-frequencies' cpu flag) "
@@ -733,7 +717,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_FREQUENCY_MSRS;
         env->features[FEAT_HYPERV_EDX] |=3D HV_FREQUENCY_MSRS_AVAILABLE;
     }
-    if (cpu->hyperv_crash) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
         if (!has_msr_hv_crash) {
             fprintf(stderr, "Hyper-V crash MSRs "
                     "(requested by 'hv-crash' cpu flag) "
@@ -742,7 +726,7 @@ static int hyperv_handle_properties(CPUState *cs)
         }
         env->features[FEAT_HYPERV_EDX] |=3D HV_GUEST_CRASH_MSR_AVAILABLE=
;
     }
-    if (cpu->hyperv_reenlightenment) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_REENLIGHTENMENT)) {
         if (!has_msr_hv_reenlightenment) {
             fprintf(stderr,
                     "Hyper-V Reenlightenment MSRs "
@@ -753,7 +737,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_REENLIGHTENMENTS_C=
ONTROL;
     }
     env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
-    if (cpu->hyperv_reset) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RESET)) {
         if (!has_msr_hv_reset) {
             fprintf(stderr, "Hyper-V reset MSR "
                     "(requested by 'hv-reset' cpu flag) "
@@ -762,7 +746,7 @@ static int hyperv_handle_properties(CPUState *cs)
         }
         env->features[FEAT_HYPERV_EAX] |=3D HV_RESET_AVAILABLE;
     }
-    if (cpu->hyperv_vpindex) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
         if (!has_msr_hv_vpindex) {
             fprintf(stderr, "Hyper-V VP_INDEX MSR "
                     "(requested by 'hv-vpindex' cpu flag) "
@@ -771,7 +755,7 @@ static int hyperv_handle_properties(CPUState *cs)
         }
         env->features[FEAT_HYPERV_EAX] |=3D HV_VP_INDEX_AVAILABLE;
     }
-    if (cpu->hyperv_runtime) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RUNTIME)) {
         if (!has_msr_hv_runtime) {
             fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
                     "(requested by 'hv-runtime' cpu flag) "
@@ -780,10 +764,10 @@ static int hyperv_handle_properties(CPUState *cs)
         }
         env->features[FEAT_HYPERV_EAX] |=3D HV_VP_RUNTIME_AVAILABLE;
     }
-    if (cpu->hyperv_synic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
         unsigned int cap =3D KVM_CAP_HYPERV_SYNIC;
         if (!cpu->hyperv_synic_kvm_only) {
-            if (!cpu->hyperv_vpindex) {
+            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
                 fprintf(stderr, "Hyper-V SynIC "
                         "(requested by 'hv-synic' cpu flag) "
                         "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
@@ -800,20 +784,20 @@ static int hyperv_handle_properties(CPUState *cs)
=20
         env->features[FEAT_HYPERV_EAX] |=3D HV_SYNIC_AVAILABLE;
     }
-    if (cpu->hyperv_stimer) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_STIMER)) {
         if (!has_msr_hv_stimer) {
             fprintf(stderr, "Hyper-V timers aren't supported by kernel\n=
");
             return -ENOSYS;
         }
         env->features[FEAT_HYPERV_EAX] |=3D HV_SYNTIMERS_AVAILABLE;
     }
-    if (cpu->hyperv_relaxed_timing) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_RELAXED_TIMING_RECOMME=
NDED;
     }
-    if (cpu->hyperv_vapic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_APIC_ACCESS_RECOMMENDE=
D;
     }
-    if (cpu->hyperv_tlbflush) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
         if (kvm_check_extension(cs->kvm_state,
                                 KVM_CAP_HYPERV_TLBFLUSH) <=3D 0) {
             fprintf(stderr, "Hyper-V TLB flush support "
@@ -824,7 +808,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_REMOTE_TLB_FLUSH_RECOM=
MENDED;
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
     }
-    if (cpu->hyperv_ipi) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_IPI)) {
         if (kvm_check_extension(cs->kvm_state,
                                 KVM_CAP_HYPERV_SEND_IPI) <=3D 0) {
             fprintf(stderr, "Hyper-V IPI send support "
@@ -835,7 +819,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_CLUSTER_IPI_RECOMMENDE=
D;
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
     }
-    if (cpu->hyperv_evmcs) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
         uint16_t evmcs_version;
=20
         if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
@@ -857,7 +841,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     CPUState *cs =3D CPU(cpu);
     int ret;
=20
-    if (cpu->hyperv_vpindex && !hv_vpindex_settable) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) && !hv_vpindex_set=
table) {
         /*
          * the kernel doesn't support setting vp_index; assert that its =
value
          * is in sync
@@ -882,7 +866,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
=20
-    if (cpu->hyperv_synic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
         uint32_t synic_cap =3D cpu->hyperv_synic_kvm_only ?
             KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
         ret =3D kvm_vcpu_enable_cap(cs, synic_cap, 0);
@@ -973,7 +957,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             memset(signature, 0, 12);
             memcpy(signature, cpu->hyperv_vendor_id, len);
         }
-        c->eax =3D cpu->hyperv_evmcs ?
+        c->eax =3D hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
             HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
         c->ebx =3D signature[0];
         c->ecx =3D signature[1];
@@ -1017,7 +1001,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         kvm_base =3D KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall =3D true;
=20
-        if (cpu->hyperv_evmcs) {
+        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
             __u32 function;
=20
             /* Create zeroed 0x40000006..0x40000009 leaves */
@@ -1361,7 +1345,7 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
         env->mp_state =3D KVM_MP_STATE_RUNNABLE;
     }
=20
-    if (cpu->hyperv_synic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
         int i;
         for (i =3D 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
             env->msr_hv_synic_sint[i] =3D HV_SINT_MASKED;
@@ -2101,11 +2085,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_HYPERCALL,
                                   env->msr_hv_hypercall);
             }
-            if (cpu->hyperv_time) {
+            if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TIME)) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC,
                                   env->msr_hv_tsc);
             }
-            if (cpu->hyperv_reenlightenment) {
+            if (hyperv_feat_enabled(cpu, HYPERV_FEAT_REENLIGHTENMENT)) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTRO=
L,
                                   env->msr_hv_reenlightenment_control);
                 kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL,
@@ -2114,7 +2098,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                                   env->msr_hv_tsc_emulation_status);
             }
         }
-        if (cpu->hyperv_vapic) {
+        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
                               env->msr_hv_vapic);
         }
@@ -2130,11 +2114,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (has_msr_hv_runtime) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, env->msr_hv_ru=
ntime);
         }
-        if (cpu->hyperv_vpindex && hv_vpindex_settable) {
+        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)
+            && hv_vpindex_settable) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_INDEX,
                               hyperv_vp_index(CPU(cpu)));
         }
-        if (cpu->hyperv_synic) {
+        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
             int j;
=20
             kvm_msr_entry_add(cpu, HV_X64_MSR_SVERSION, HV_SYNIC_VERSION=
);
@@ -2474,13 +2459,13 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, HV_X64_MSR_HYPERCALL, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_GUEST_OS_ID, 0);
     }
-    if (cpu->hyperv_vapic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
         kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE, 0);
     }
-    if (cpu->hyperv_time) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TIME)) {
         kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC, 0);
     }
-    if (cpu->hyperv_reenlightenment) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_REENLIGHTENMENT)) {
         kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS, 0);
@@ -2495,7 +2480,7 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_hv_runtime) {
         kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, 0);
     }
-    if (cpu->hyperv_synic) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
         uint32_t msr;
=20
         kvm_msr_entry_add(cpu, HV_X64_MSR_SCONTROL, 0);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..ef4da3828d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -634,7 +634,7 @@ static bool hyperv_runtime_enable_needed(void *opaque=
)
     X86CPU *cpu =3D opaque;
     CPUX86State *env =3D &cpu->env;
=20
-    if (!cpu->hyperv_runtime) {
+    if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_RUNTIME)) {
         return false;
     }
=20
--=20
2.20.1


