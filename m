Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7906C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0871421D41
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0871421D41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmRm-0002oU-1r
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmAY-00066v-FU; Fri, 09 Oct 2020 02:46:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38566 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmAS-0001Jw-45; Fri, 09 Oct 2020 02:46:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 481517CB3C467CBC3AEB;
 Fri,  9 Oct 2020 14:46:07 +0800 (CST)
Received: from localhost (10.174.186.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 14:46:00 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 10/14] i386/: fix some comment spelling errors
Date: Fri, 9 Oct 2020 14:44:45 +0800
Message-ID: <20201009064449.2336-11-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201009064449.2336-1-zhaolichang@huawei.com>
References: <20201009064449.2336-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.238]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:46:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David
 Edmondson <david.edmondson@oracle.com>, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/i386.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 target/i386/cpu.c           | 4 ++--
 target/i386/hax-interface.h | 4 ++--
 target/i386/hax-windows.c   | 2 +-
 target/i386/kvm.c           | 2 +-
 target/i386/machine.c       | 6 +++---
 target/i386/translate.c     | 8 ++++----
 target/i386/whpx-all.c      | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f37eb7b675..79ecb1c370 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4677,7 +4677,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
     return name;
 }
 
-/* Compatibily hack to maintain legacy +-feat semantic,
+/* Compatibility hack to maintain legacy +-feat semantic,
  * where +-feat overwrites any feature set by
  * feat=on|feat even if the later is parsed after +-feat
  * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
@@ -6898,7 +6898,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
     GuestPanicInformation *panic_info;
 
     if (!cs->crash_occurred) {
-        error_setg(errp, "No crash occured");
+        error_setg(errp, "No crash occurred");
         return;
     }
 
diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
index 537ae084e9..edef4fdf5d 100644
--- a/target/i386/hax-interface.h
+++ b/target/i386/hax-interface.h
@@ -238,7 +238,7 @@ enum exit_status {
     HAX_EXIT_UNKNOWN_VMEXIT,
     /* HALT from guest */
     HAX_EXIT_HLT,
-    /* Reboot request, like because of tripple fault in guest */
+    /* Reboot request, like because of triple fault in guest */
     HAX_EXIT_STATECHANGE,
     /* the vcpu is now only paused when destroy, so simply return to hax */
     HAX_EXIT_PAUSED,
@@ -295,7 +295,7 @@ struct hax_qemu_version {
     uint32_t min_version;
 } __attribute__ ((__packed__));
 
-/* The mac specfic interface to qemu, mostly is ioctl related */
+/* The mac specific interface to qemu, mostly is ioctl related */
 struct hax_tunnel_info {
     uint64_t va;
     uint64_t io_va;
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 6c82dfb54f..4297c457a2 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -174,7 +174,7 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
     if (!ret) {
         err = GetLastError();
         if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
-            fprintf(stderr, "hax module verion is too long to hold.\n");
+            fprintf(stderr, "hax module version is too long to hold.\n");
         }
         fprintf(stderr, "Failed to get Hax module version:%lu\n", err);
         return -EFAULT;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8b12387d30..e97315f394 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1164,7 +1164,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
 /*
  * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
  * case of success, errno < 0 in case of failure and 0 when no Hyper-V
- * extentions are enabled.
+ * extensions are enabled.
  */
 static int hyperv_handle_properties(CPUState *cs,
                                     struct kvm_cpuid_entry2 *cpuid_ent)
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 233e46bb70..03af4a1e5f 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -264,12 +264,12 @@ static int cpu_pre_save(void *opaque)
      * hypervisor, its exception payload (CR2/DR6 on #PF/#DB)
      * should not be set yet in the respective vCPU register.
      * Thus, in case an exception is pending, it is
-     * important to save the exception payload seperately.
+     * important to save the exception payload separately.
      *
      * Therefore, if an exception is not in a pending state
      * or vCPU is not in guest-mode, it is not important to
      * distinguish between a pending and injected exception
-     * and we don't need to store seperately the exception payload.
+     * and we don't need to store separately the exception payload.
      *
      * In order to preserve better backwards-compatible migration,
      * convert a pending exception to an injected exception in
@@ -1156,7 +1156,7 @@ static int nested_state_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
     if (nested_state->size > max_nested_state_len) {
-        error_report("Recieved unsupported nested state size: "
+        error_report("Received unsupported nested state size: "
                      "nested_state->size=%d, max=%d",
                      nested_state->size, max_nested_state_len);
         return -EINVAL;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index caea6f5fb1..5cdfe0ebc4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -893,7 +893,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 }
 
 /* perform a conditional store into register 'reg' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
 {
     int inv, jcc_op, cond;
@@ -1026,7 +1026,7 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
 }
 
 /* generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
@@ -1043,7 +1043,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 }
 
 /* Generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used.
+   value 'b'. In the fast case, T0 is guaranteed not to be used.
    A translation block must end soon.  */
 static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
@@ -6841,7 +6841,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->prefix & PREFIX_LOCK) {
             switch (op) {
             case 0: /* bt */
-                /* Needs no atomic ops; we surpressed the normal
+                /* Needs no atomic ops; we suppressed the normal
                    memory load for LOCK above so do it now.  */
                 gen_op_ld_v(s, ot, s->T0, s->A0);
                 break;
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index f4f3e33eac..9127c2749d 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1235,7 +1235,7 @@ int whpx_init_vcpu(CPUState *cpu)
     vcpu = g_malloc0(sizeof(struct whpx_vcpu));
 
     if (!vcpu) {
-        error_report("WHPX: Failed to allocte VCPU context.");
+        error_report("WHPX: Failed to allocate VCPU context.");
         ret = -ENOMEM;
         goto error;
     }
-- 
2.26.2.windows.1


