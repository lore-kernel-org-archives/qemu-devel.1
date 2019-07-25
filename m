Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DDC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867C72238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="U7hXDZsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867C72238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfVQ-0006IG-LW
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@163.com>) id 1hqfV9-0005h2-5X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1hqfV8-0001Oj-07
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:17:51 -0400
Received: from m12-11.163.com ([220.181.12.11]:34380)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1hqfV6-0001GA-DI
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=XYGvuCX+KWz2p3Yp4I
 gK88E8PGcyLildAag07w7TWyg=; b=U7hXDZsObFiRKU90KkKSDKLm8hqNkkiXvk
 qeXCvy5hH7fG3nwk4RWjexC7TGrKXPynd+R9Nec7hNaXIA0vYZJHW2zhinu12ZjG
 g6L+uUROTe5XGe/sDCe2w46YpQjS8dun84LaXEmwh5MGBn2QfWy8hjtqwzIO9l/h
 RoTA4YOC0=
Received: from localhost.localdomain (unknown [115.204.176.247])
 by smtp7 (Coremail) with SMTP id C8CowAD30jARyDldD21rFg--.55737S2;
 Thu, 25 Jul 2019 23:17:38 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com
Date: Thu, 25 Jul 2019 08:16:39 -0700
Message-Id: <20190725151639.21693-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAD30jARyDldD21rFg--.55737S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JryrAw1rCF47CrWfCF1Dtrb_yoW7Xw1rpa
 y3AFWUJrWDJayFgw4IqF97AryrJrW8ua9rWF4agwnxAFyUXrn5Xr10y347uFykWFWakF18
 uFy7XrsrGFsrAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRW5lnUUUUU=
X-Originating-IP: [115.204.176.247]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKRL8bVXlsYS7dgAAsi
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.11
Subject: [Qemu-devel] [PATCH] target-i386: kvm: 'kvm_get_supported_msrs'
 cleanup
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Function 'kvm_get_supported_msrs' is only called once
now, get rid of the static variable 'kvm_supported_msrs'.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 target/i386/kvm.c | 185 +++++++++++++++++++++++-----------------------
 1 file changed, 91 insertions(+), 94 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dbbb13772a..07c9250f45 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1837,108 +1837,105 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
 
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
2.17.1



