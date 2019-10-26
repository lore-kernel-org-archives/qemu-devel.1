Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A8CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2C72084C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Led3oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2C72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOMQO-0006mU-Kz
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 09:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iOMO0-0003LT-J1
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iOMNz-0001aI-8n
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:45:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iOMNz-0001Zn-31
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:45:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id l10so5328982wrb.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=EpzeIFeXnhMEhnfWwzh2aMRc7ftcklDZsSQpL8WJVZ4=;
 b=e0Led3oWTZsyhDxJ/XqrQQIvtT3tuWUESJq5/yClo5mWpQjipVY5fvZDNEwGTT3B8r
 DWdIrr7s4OjhXiMnqqmGYF6dU9mR7tj6IJNdnLE4QFsvPWGAnD/BUAkan85AiiCeujZz
 D7rg2dPv1uxEP0nOVBDF9mYSUe6HXlWbC9xA3enXZPy8YDj9Lo9toDXcOJ6gOD0dIP/F
 4F52rbBjdgt8+X9ib0YEfqmvnp/4AgQfaQ7y+acxnI+LzGsFPUCySkNaDvyW8Zmo+Yle
 CsUcZwCJ1mhINgudpVT1o7A0OAnQktzmO9/lh0JCBqBiaOD7FarRn1K+nl8yDH1M0z4j
 y9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=EpzeIFeXnhMEhnfWwzh2aMRc7ftcklDZsSQpL8WJVZ4=;
 b=WuK3moMSIM3+h2wLWO1PvXOnFUn3UtJ4rAGoqxITGFFH/ofI3zfEbk6JYImmd5iPOX
 PqGVbCVogDy3rtAiQQ85tV1b/GYTxDotDGBbRvl5uV8cuOLCFUCBI8lMsctCLnRW5c6c
 zLB4vpIe3l63mCIu3FVywe6Jf2P+2L9H2N56sIsnyaluYO9g3xh8X5MDtDRg60Hdh1gA
 Bg1orsxCJbva/XSTluF+Ap5NgWgPtBTN3Zw36zo69HtM6G/RF2d8nqkWu+OQqu5z6oiH
 3Uh8K2F0Oz9trlxtJzvt0xmsfz3HugX0HUBzbWezpICPpzW8ok+8eE82F2HVnhIGofKl
 AxwA==
X-Gm-Message-State: APjAAAWZadO5gqZHGHD1fGdTrcLjb+LSo7G6j0l542nD0LwbcnZ7tmo9
 Sf+8ygnPRqIUf1OKZwJF2DVqrSGt
X-Google-Smtp-Source: APXvYqwBP/lY6tH5EUogAgNCelQsj8vaX8G/FQua3dXbNM+cFP8UfHOoD5c4GyKmzUzbUseQ5HJBeg==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr7167400wrq.208.1572097541650; 
 Sat, 26 Oct 2019 06:45:41 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r11sm2834514wrx.67.2019.10.26.06.45.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 26 Oct 2019 06:45:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 37/39] target/i386: move FERR handling to target/i386
Date: Sat, 26 Oct 2019 15:45:38 +0200
Message-Id: <1572097538-18898-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572097538-18898-1-git-send-email-pbonzini@redhat.com>
References: <1572097538-18898-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

Move it out of pc.c since it is strictly tied to TCG.  This is
almost exclusively code movement, the next patch will implement
IGNNE.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             | 17 +++--------------
 hw/i386/pc_piix.c        |  4 +++-
 hw/i386/pc_q35.c         |  4 +++-
 include/hw/i386/pc.h     |  1 -
 target/i386/cpu.h        |  3 ++-
 target/i386/fpu_helper.c | 26 +++++++++++++++++++++++++-
 6 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5fce60c..66d865b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -381,23 +381,12 @@ static uint64_t ioport80_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 /* MSDOS compatibility mode FPU exception support */
-static qemu_irq ferr_irq;
-
-void pc_register_ferr_irq(qemu_irq irq)
-{
-    ferr_irq = irq;
-}
-
-/* XXX: add IGNNE support */
-void cpu_set_ferr(CPUX86State *s)
-{
-    qemu_irq_raise(ferr_irq);
-}
-
 static void ioportF0_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
-    qemu_irq_lower(ferr_irq);
+    if (tcg_enabled()) {
+        cpu_clear_ferr();
+    }
 }
 
 static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3a4a64a..c15929a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -213,7 +213,9 @@ static void pc_init1(MachineState *machine,
         ioapic_init_gsi(gsi_state, "i440fx");
     }
 
-    pc_register_ferr_irq(x86ms->gsi[13]);
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
 
     pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index def3bc2..b9c3e18 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -261,7 +261,9 @@ static void pc_q35_init(MachineState *machine)
         ioapic_init_gsi(gsi_state, "q35");
     }
 
-    pc_register_ferr_irq(x86ms->gsi[13]);
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5923318..f040a72 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -176,7 +176,6 @@ void vmmouse_set_data(const uint32_t *data);
 extern int fd_bootchk;
 
 bool pc_machine_is_smm_enabled(PCMachineState *pcms);
-void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b772e82..01e052b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1761,7 +1761,8 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 int cpu_get_pic_interrupt(CPUX86State *s);
 /* MSDOS compatibility mode FPU exception support */
-void cpu_set_ferr(CPUX86State *s);
+void x86_register_ferr_irq(qemu_irq irq);
+void cpu_clear_ferr(void);
 /* mpx_helper.c */
 void cpu_sync_bndcs_hflags(CPUX86State *env);
 
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 005f1f6..4db0059 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -26,6 +26,10 @@
 #include "exec/cpu_ldst.h"
 #include "fpu/softfloat.h"
 
+#ifdef CONFIG_SOFTMMU
+#include "hw/irq.h"
+#endif
+
 #define FPU_RC_MASK         0xc00
 #define FPU_RC_NEAR         0x000
 #define FPU_RC_DOWN         0x400
@@ -58,6 +62,26 @@
 #define floatx80_l2e make_floatx80(0x3fff, 0xb8aa3b295c17f0bcLL)
 #define floatx80_l2t make_floatx80(0x4000, 0xd49a784bcd1b8afeLL)
 
+#if !defined(CONFIG_USER_ONLY)
+static qemu_irq ferr_irq;
+
+void x86_register_ferr_irq(qemu_irq irq)
+{
+    ferr_irq = irq;
+}
+
+void cpu_clear_ferr(void)
+{
+    qemu_irq_lower(ferr_irq);
+}
+
+static void cpu_set_ferr(void)
+{
+    qemu_irq_raise(ferr_irq);
+}
+#endif
+
+
 static inline void fpush(CPUX86State *env)
 {
     env->fpstt = (env->fpstt - 1) & 7;
@@ -137,7 +161,7 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
     }
 #if !defined(CONFIG_USER_ONLY)
     else {
-        cpu_set_ferr(env);
+        cpu_set_ferr();
     }
 #endif
 }
-- 
1.8.3.1

