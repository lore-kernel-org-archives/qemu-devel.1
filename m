Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF75DC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B043A2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DM2bjjNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B043A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycGA-0007MH-CK
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6x-0003SH-7S
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6v-0005bT-7D
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6u-0005aF-Vl
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id o4so4026806wmh.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZNL72tQPdI8dzNTcNNXhQyWga+jG4To7j6GoDCCb7u0=;
 b=DM2bjjNgv4874A3MwDqrKzsITN6mfBOJZsPZ2OMUb7IjiS88Us334WgD79lUQbuaRA
 MDHtEGLowtAvLMrbhxSHdNU/xk+id3huvsGa9vcLBgWDMDW60gC2tLmQXty1KhNZZ48O
 72OQ6aMjoOGm/RQJFm5cxAYLLJ3TBcsoslD5iT7uHwRSLv/qxS19+jIA9u8pD1knd6GZ
 QXNVUh9lS9XWEwJWS/EDLbS5noEpg55QIKiMQl4PvwoMTP5QFlroQ7bwtZwL12+QOI4c
 mHc5gKmMGzc3eHPD9PPu7ej3US0g9uqj+AkSu/JDxWAuFSK3n/vGF5VAZqXNUDCZcjQ8
 ae6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZNL72tQPdI8dzNTcNNXhQyWga+jG4To7j6GoDCCb7u0=;
 b=WdEC3kefxGh4M4EnHsRqEh2TmmvF2TZPQCswVb7/9OkBFFydN7UXXR7L+yBKbXrRQ0
 0RGeXNUwhJK/MafNtpjO5rBH2Eic/aogJGsSt8AWl6JL/SU18KFPD+2r4DIXVf3cNvTa
 OFMLCS2sHdMbeZK8LV7/Nm2Sl8/jIHDhyi1cPB8r9i5+qIt4Im2zMAAKkrcWMaq49a/y
 FGRUpggDQq7WGUhu07nacCdd03Jbue9exlXPFySz+rAUOo0opMyHtRZ1ntZeIFt2JJ1o
 I739h+EuvvAgcTSTGK/RZGCbupQiMg14Qf7jmH1gIVmB3kgpr8DGk5Pr/8rRFrQFQGI3
 GScQ==
X-Gm-Message-State: APjAAAWl3zjnFTRhXi5FB5E46D5/nRg3fC3BMbQXwdpmYW7ZyLTQKM6n
 qdU2DdqX9qSSq8WKkx4mayfB1JEMm2tONg==
X-Google-Smtp-Source: APXvYqyAN3l6TJH2bS9ZZuUbqX4r6einTCn1ZU+KCnzbHNxJmbxSpxp0PRSdSR5+nVd3lJaPKsO01w==
X-Received: by 2002:a05:600c:144:: with SMTP id
 w4mr7824801wmm.94.1565961459621; 
 Fri, 16 Aug 2019 06:17:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:07 +0100
Message-Id: <20190816131719.28244-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 17/29] target/arm/cpu64: Ensure kvm really
 supports aarch64=off
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

If -cpu <cpu>,aarch64=off is used then KVM must also be used, and it
and the host must support running the vcpu in 32-bit mode. Also, if
-cpu <cpu>,aarch64=on is used, then it doesn't matter if kvm is
enabled or not.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 14 ++++++++++++++
 target/arm/cpu64.c   | 12 ++++++------
 target/arm/kvm64.c   |  9 +++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2a07333c615..98af1050a75 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -207,6 +207,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/**
+ * kvm_arm_aarch32_supported:
+ * @cs: CPUState
+ *
+ * Returns: true if the KVM VCPU can enable AArch32 mode
+ * and false otherwise.
+ */
+bool kvm_arm_aarch32_supported(CPUState *cs);
+
 /**
  * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
  * IPA address space supported by KVM
@@ -247,6 +256,11 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->host_cpu_probe_failed = true;
 }
 
+static inline bool kvm_arm_aarch32_supported(CPUState *cs)
+{
+    return false;
+}
+
 static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     return -ENOENT;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ee55237a9b2..ab63115c776 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -426,13 +426,13 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
      * restriction allows us to avoid fixing up functionality that assumes a
      * uniform execution state like do_interrupt.
      */
-    if (!kvm_enabled()) {
-        error_setg(errp, "'aarch64' feature cannot be disabled "
-                         "unless KVM is enabled");
-        return;
-    }
-
     if (value == false) {
+        if (!kvm_enabled() || !kvm_arm_aarch32_supported(CPU(cpu))) {
+            error_setg(errp, "'aarch64' feature cannot be disabled "
+                             "unless KVM is enabled and 32-bit EL1 "
+                             "is supported");
+            return;
+        }
         unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
     } else {
         set_feature(&cpu->env, ARM_FEATURE_AARCH64);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 22d19c9aec6..3d91846beb8 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -24,7 +24,9 @@
 #include "exec/gdbstub.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
+#include "hw/boards.h"
 #include "internals.h"
 
 static bool have_guest_debug;
@@ -593,6 +595,13 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return true;
 }
 
+bool kvm_arm_aarch32_supported(CPUState *cpu)
+{
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+
+    return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
+}
+
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
 int kvm_arch_init_vcpu(CPUState *cs)
-- 
2.20.1


