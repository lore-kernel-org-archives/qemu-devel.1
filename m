Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC91C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A93214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A93214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyJc-0001Kf-LJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8H-0005VP-Ey
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8F-00038B-W3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8F-00037H-OM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED02830615C6;
 Tue, 20 Aug 2019 07:00:38 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E952F11E53F;
 Tue, 20 Aug 2019 07:00:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:29 +0200
Message-Id: <1566284395-30287-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 20 Aug 2019 07:00:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/36] target-i386: kvm:
 'kvm_get_supported_msrs' cleanup
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Function 'kvm_get_supported_msrs' is only called once
now, get rid of the static variable 'kvm_supported_msrs'.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190725151639.21693-1-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 185 +++++++++++++++++++++++++++---------------------------
 1 file changed, 91 insertions(+), 94 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 327c95a..a66b956 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1839,108 +1839,105 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
 
 static int kvm_get_supported_msrs(KVMState *s)
 {
-    static int kvm_supported_msrs;
     int ret = 0;
+    struct kvm_msr_list msr_list, *kvm_msr_list;
 
-    /* first time */
-    if (kvm_supported_msrs == 0) {
-        struct kvm_msr_list msr_list, *kvm_msr_list;
+    /*
+     *  Obtain MSR list from KVM.  These are the MSRs that we must
+     *  save/restore.
+     */
+    msr_list.nmsrs = 0;
+    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, &msr_list);
+    if (ret < 0 && ret != -E2BIG) {
+        return ret;
+    }
+    /*
+     * Old kernel modules had a bug and could write beyond the provided
+     * memory. Allocate at least a safe amount of 1K.
+     */
+    kvm_msr_list = g_malloc0(MAX(1024, sizeof(msr_list) +
+                                          msr_list.nmsrs *
+                                          sizeof(msr_list.indices[0])));
 
-        kvm_supported_msrs = -1;
+    kvm_msr_list->nmsrs = msr_list.nmsrs;
+    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
+    if (ret >= 0) {
+        int i;
 
-        /* Obtain MSR list from KVM.  These are the MSRs that we must
-         * save/restore */
-        msr_list.nmsrs = 0;
-        ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, &msr_list);
-        if (ret < 0 && ret != -E2BIG) {
-            return ret;
-        }
-        /* Old kernel modules had a bug and could write beyond the provided
-           memory. Allocate at least a safe amount of 1K. */
-        kvm_msr_list = g_malloc0(MAX(1024, sizeof(msr_list) +
-                                              msr_list.nmsrs *
-                                              sizeof(msr_list.indices[0])));
-
-        kvm_msr_list->nmsrs = msr_list.nmsrs;
-        ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
-        if (ret >= 0) {
-            int i;
-
-            for (i = 0; i < kvm_msr_list->nmsrs; i++) {
-                switch (kvm_msr_list->indices[i]) {
-                case MSR_STAR:
-                    has_msr_star = true;
-                    break;
-                case MSR_VM_HSAVE_PA:
-                    has_msr_hsave_pa = true;
-                    break;
-                case MSR_TSC_AUX:
-                    has_msr_tsc_aux = true;
-                    break;
-                case MSR_TSC_ADJUST:
-                    has_msr_tsc_adjust = true;
-                    break;
-                case MSR_IA32_TSCDEADLINE:
-                    has_msr_tsc_deadline = true;
-                    break;
-                case MSR_IA32_SMBASE:
-                    has_msr_smbase = true;
-                    break;
-                case MSR_SMI_COUNT:
-                    has_msr_smi_count = true;
-                    break;
-                case MSR_IA32_MISC_ENABLE:
-                    has_msr_misc_enable = true;
-                    break;
-                case MSR_IA32_BNDCFGS:
-                    has_msr_bndcfgs = true;
-                    break;
-                case MSR_IA32_XSS:
-                    has_msr_xss = true;
-                    break;
-                case HV_X64_MSR_CRASH_CTL:
-                    has_msr_hv_crash = true;
-                    break;
-                case HV_X64_MSR_RESET:
-                    has_msr_hv_reset = true;
-                    break;
-                case HV_X64_MSR_VP_INDEX:
-                    has_msr_hv_vpindex = true;
-                    break;
-                case HV_X64_MSR_VP_RUNTIME:
-                    has_msr_hv_runtime = true;
-                    break;
-                case HV_X64_MSR_SCONTROL:
-                    has_msr_hv_synic = true;
-                    break;
-                case HV_X64_MSR_STIMER0_CONFIG:
-                    has_msr_hv_stimer = true;
-                    break;
-                case HV_X64_MSR_TSC_FREQUENCY:
-                    has_msr_hv_frequencies = true;
-                    break;
-                case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
-                    has_msr_hv_reenlightenment = true;
-                    break;
-                case MSR_IA32_SPEC_CTRL:
-                    has_msr_spec_ctrl = true;
-                    break;
-                case MSR_VIRT_SSBD:
-                    has_msr_virt_ssbd = true;
-                    break;
-                case MSR_IA32_ARCH_CAPABILITIES:
-                    has_msr_arch_capabs = true;
-                    break;
-                case MSR_IA32_CORE_CAPABILITY:
-                    has_msr_core_capabs = true;
-                    break;
-                }
+        for (i = 0; i < kvm_msr_list->nmsrs; i++) {
+            switch (kvm_msr_list->indices[i]) {
+            case MSR_STAR:
+                has_msr_star = true;
+                break;
+            case MSR_VM_HSAVE_PA:
+                has_msr_hsave_pa = true;
+                break;
+            case MSR_TSC_AUX:
+                has_msr_tsc_aux = true;
+                break;
+            case MSR_TSC_ADJUST:
+                has_msr_tsc_adjust = true;
+                break;
+            case MSR_IA32_TSCDEADLINE:
+                has_msr_tsc_deadline = true;
+                break;
+            case MSR_IA32_SMBASE:
+                has_msr_smbase = true;
+                break;
+            case MSR_SMI_COUNT:
+                has_msr_smi_count = true;
+                break;
+            case MSR_IA32_MISC_ENABLE:
+                has_msr_misc_enable = true;
+                break;
+            case MSR_IA32_BNDCFGS:
+                has_msr_bndcfgs = true;
+                break;
+            case MSR_IA32_XSS:
+                has_msr_xss = true;
+                break;
+            case HV_X64_MSR_CRASH_CTL:
+                has_msr_hv_crash = true;
+                break;
+            case HV_X64_MSR_RESET:
+                has_msr_hv_reset = true;
+                break;
+            case HV_X64_MSR_VP_INDEX:
+                has_msr_hv_vpindex = true;
+                break;
+            case HV_X64_MSR_VP_RUNTIME:
+                has_msr_hv_runtime = true;
+                break;
+            case HV_X64_MSR_SCONTROL:
+                has_msr_hv_synic = true;
+                break;
+            case HV_X64_MSR_STIMER0_CONFIG:
+                has_msr_hv_stimer = true;
+                break;
+            case HV_X64_MSR_TSC_FREQUENCY:
+                has_msr_hv_frequencies = true;
+                break;
+            case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+                has_msr_hv_reenlightenment = true;
+                break;
+            case MSR_IA32_SPEC_CTRL:
+                has_msr_spec_ctrl = true;
+                break;
+            case MSR_VIRT_SSBD:
+                has_msr_virt_ssbd = true;
+                break;
+            case MSR_IA32_ARCH_CAPABILITIES:
+                has_msr_arch_capabs = true;
+                break;
+            case MSR_IA32_CORE_CAPABILITY:
+                has_msr_core_capabs = true;
+                break;
             }
         }
-
-        g_free(kvm_msr_list);
     }
 
+    g_free(kvm_msr_list);
+
     return ret;
 }
 
-- 
1.8.3.1



