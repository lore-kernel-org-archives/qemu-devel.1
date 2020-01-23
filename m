Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C472071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9/Dg+eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C472071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufCb-0000cw-Rx
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrY-0005EH-Kv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrX-0003m4-3N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrW-0003gy-S1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:35 -0500
Received: by mail-wm1-x335.google.com with SMTP id f129so2613332wmf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sIQ5W5UHd6LBNn/RrQOAOd5yBbO+3FGu4Aq0XOiBiHM=;
 b=l9/Dg+eQZ75w9soBwCO6fh2v6EqLEzATIGICcRJRPZXmiipOkVkC8Yla8S1A1D+8pK
 rFbWamRgwQipXWdbO7PiiSRk/dLwNSqlgD2lG/wA07utjKOzFYg8qwN5szSonEe40y7D
 OARYAcrM+vH6grYXfxXD7CZLSLU0OkWgMeKGuRons0wyMTieqDWxdUQH7PwGdxzQVnQl
 +U0InAQek3KoCaoLI4cXeNMXs4md5kumYNaabZ49wI7bRduQVmLWcNHA1nYF11wxKHij
 LqBJLS49H2EAnedQ6kw8ZuwCw4v+u0g1e9fdhzASJ7cCZsBwCsN4flNV5D+C7Vf2LKxE
 qpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sIQ5W5UHd6LBNn/RrQOAOd5yBbO+3FGu4Aq0XOiBiHM=;
 b=KodbTBzrfiAm0QGIqWRsW1sPT+Oge2U16PJq5yQs7H9+Krmkz203Ed8UFJ1DmEoAS1
 RPnEs4id68sbCg1SgLR6rhrfcrxWTyeXDwpJLmgG7wR54rCUYcHxTisA/H5FWiHJ/NX7
 C9ZiDYTNUN8c7cog7UaqCeiQzFs7c0LbQCNWzzvqyPEuRWAlf7c2zNKYRS3LewtspOHC
 XMT8aYD0t9Gp7zjiRoJHmYQmHYLYBjFQLgQCtGx2LjT2AuVExD7JarjnrMaHZuU/fKzu
 Nii0jU5MrQDkVzqFZwc1o9JkhJ0XTeChx6oYZKORDtSe1COR8VMjygye4JujaR4ILeQW
 cYBA==
X-Gm-Message-State: APjAAAWwx5+bZv40GjSnKw3gTeg+Xodv37PZ311RWWN5PiXpdggOBwMJ
 65zq5nyi9yZDLpD/uNf5gtVcl6sZ
X-Google-Smtp-Source: APXvYqw47qhhzW7kQNkUAeBOLynk2iTEnGb8NKNwJy/XBatNlpd22p8R/UMyBCeluw8DVqVqD4Aj6w==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr4414604wmi.20.1579787372743;
 Thu, 23 Jan 2020 05:49:32 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/59] accel: Replace current_machine->accelerator by
 current_accel() wrapper
Date: Thu, 23 Jan 2020 14:48:32 +0100
Message-Id: <1579787342-27146-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We actually want to access the accelerator, not the machine, so
use the current_accel() wrapper instead.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200121110349.25842-10-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 accel/tcg/tcg-all.c | 2 +-
 memory.c            | 2 +-
 target/arm/kvm64.c  | 5 ++---
 target/i386/kvm.c   | 2 +-
 target/ppc/kvm.c    | 4 ++--
 vl.c                | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1ada2f4..c111312 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -164,7 +164,7 @@ static NotifierList kvm_irqchip_change_notifiers =
 
 int kvm_get_max_memslots(void)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    KVMState *s = KVM_STATE(current_accel());
 
     return s->nr_slots;
 }
@@ -1848,7 +1848,7 @@ static int kvm_max_vcpu_id(KVMState *s)
 
 bool kvm_vcpu_id_is_valid(int vcpu_id)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    KVMState *s = KVM_STATE(current_accel());
     return vcpu_id >= 0 && vcpu_id < kvm_max_vcpu_id(s);
 }
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 1dc384c..1802ce0 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -124,7 +124,7 @@ static void tcg_accel_instance_init(Object *obj)
 
 static int tcg_init(MachineState *ms)
 {
-    TCGState *s = TCG_STATE(current_machine->accelerator);
+    TCGState *s = TCG_STATE(current_accel());
 
     tcg_exec_init(s->tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
diff --git a/memory.c b/memory.c
index d7b9bb6..8547987 100644
--- a/memory.c
+++ b/memory.c
@@ -3104,7 +3104,7 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
         };
         GArray *fv_address_spaces;
         GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
-        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+        AccelClass *ac = ACCEL_GET_CLASS(current_accel());
 
         if (ac->has_memory) {
             fvi.ac = ac;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b..e3c580e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -26,7 +26,6 @@
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
-#include "hw/boards.h"
 #include "internals.h"
 
 static bool have_guest_debug;
@@ -613,14 +612,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
 bool kvm_arm_aarch32_supported(CPUState *cpu)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    KVMState *s = KVM_STATE(current_accel());
 
     return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
 }
 
 bool kvm_arm_sve_supported(CPUState *cpu)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    KVMState *s = KVM_STATE(current_accel());
 
     return kvm_check_extension(s, KVM_CAP_ARM_SVE);
 }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 1b67090..6ef291d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -149,7 +149,7 @@ bool kvm_allows_irq0_override(void)
 
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    KVMState *s = KVM_STATE(current_accel());
 
     return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b5799e6..06fd0cc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -258,7 +258,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
 
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    KVMState *s = KVM_STATE(current_accel());
     struct ppc_radix_page_info *radix_page_info;
     struct kvm_ppc_rmmu_info rmmu_info;
     int i;
@@ -2907,7 +2907,7 @@ void kvmppc_svm_off(Error **errp)
         return;
     }
 
-    rc = kvm_vm_ioctl(KVM_STATE(current_machine->accelerator), KVM_PPC_SVM_OFF);
+    rc = kvm_vm_ioctl(KVM_STATE(current_accel()), KVM_PPC_SVM_OFF);
     if (rc && rc != -ENOTTY) {
         error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
     }
diff --git a/vl.c b/vl.c
index 9f5f477..368dda1 100644
--- a/vl.c
+++ b/vl.c
@@ -2824,7 +2824,7 @@ static void configure_accelerators(const char *progname)
     }
 
     if (init_failed) {
-        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+        AccelClass *ac = ACCEL_GET_CLASS(current_accel());
         error_report("falling back to %s", ac->name);
     }
 
-- 
1.8.3.1



