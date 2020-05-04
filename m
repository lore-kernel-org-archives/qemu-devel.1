Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C9C4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C116206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmBwTTt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C116206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWYw-0005Ag-N5
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXv-0003Qc-CG
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXu-0007SH-96
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id g13so19828773wrb.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wjlVRGkMMBwX1c1DhJs0bovGn/YH+9pT7jecXBlciV4=;
 b=dmBwTTt8wkr83YhTxJlTiwDXk2fu3KlOk3hi6R2sjVHSQlBZWeN9x3t/IWIUeL/pAf
 JdyCQj7ACfvtLp4PS0bPXyOAIb/Dm82iwxOQ/XSEnDmjW/eVFNOFjI+ce1j9X2I36bkL
 JjOrIhJxOycUwcnwyVyQgK8ZsF076KVE3VsDs6AW71eng33tDVpybHPuFi1nlUbMvcIo
 5Lb6raLcU8leR4Our6Km0QtZvAY1gZiGIuk63g7nXIN3rPlNh3Cw/m7mOH4p5KQQgvEx
 ZxESH1pQpqZJjc7EhBGrWPUfysRj0+XbxgC73X+gEplr9O8djVTkTQHIq8EUpJXpXuIq
 iVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wjlVRGkMMBwX1c1DhJs0bovGn/YH+9pT7jecXBlciV4=;
 b=BDRN1mR5iFJD6kWXALOewMJnOmzFUgzSgaO0GZh8muHBEP2Tm7R1Gd3H/8JBagoPDG
 FeomNSzae+uAT9MVJa+0ZFxPVuHzULTkYjtRrJA6GuJkBF7oV090xyqqruFqaHsLZUN5
 tHloQNW5zj4lJY/3iOtj/7Zv5ic6TUr6GWj2rW1tmtdkYHh8FCxtSBxUegAjO0sZXnVU
 I9s1JrHex94Gr/Udrc/cJZ/rs1Ct5jsvguwYNQMq0s+9tLsEd7A/wTBQX5oOFd/4vg1e
 cVRjvh+MJjRdLvCxAXr5pf/pZuM0+qadApTdu9wpEztXGtounrjR9ke3odyK7xCIdQ85
 +TmQ==
X-Gm-Message-State: AGi0Pua14p9xytQLjJxN0HOp0mfruNg6/rtArkp/2lXG4Kt8tK1WqUII
 0sdbOfbLSqioFb7MSlnHCfl46lkW
X-Google-Smtp-Source: APiQypKKN24hGLA1QcCqHGfFTQW/tP2Vl4u4+0fyjr0V0QMw5qM+Lv1Ao33h2BYijMCkgJwSuriUmA==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr19144238wru.12.1588581228719; 
 Mon, 04 May 2020 01:33:48 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 2sm13048053wre.25.2020.05.04.01.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:33:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/i386: Make vmmouse helpers static
Date: Mon,  4 May 2020 10:33:42 +0200
Message-Id: <20200504083342.24273-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504083342.24273-1-f4bug@amsat.org>
References: <20200504083342.24273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmmouse helpers are only used in hw/i386/vmmouse.c,
make them static.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/pc.h |  4 ----
 hw/i386/vmmouse.c    | 22 +++++++++++++++++++++-
 hw/i386/vmport.c     | 23 +----------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index de49a57506..05e19455bb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -129,10 +129,6 @@ typedef struct PCMachineClass {
 
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 
-/* vmport.c */
-void vmmouse_get_data(uint32_t *data);
-void vmmouse_set_data(const uint32_t *data);
-
 /* pc.c */
 extern int fd_bootchk;
 
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 78b36f6f5d..b3aef41327 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -25,11 +25,11 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "ui/console.h"
-#include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "vmport.h"
+#include "cpu.h"
 
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
@@ -71,6 +71,26 @@ typedef struct VMMouseState
     ISAKBDState *i8042;
 } VMMouseState;
 
+static void vmmouse_get_data(uint32_t *data)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    CPUX86State *env = &cpu->env;
+
+    data[0] = env->regs[R_EAX]; data[1] = env->regs[R_EBX];
+    data[2] = env->regs[R_ECX]; data[3] = env->regs[R_EDX];
+    data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
+}
+
+static void vmmouse_set_data(const uint32_t *data)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    CPUX86State *env = &cpu->env;
+
+    env->regs[R_EAX] = data[0]; env->regs[R_EBX] = data[1];
+    env->regs[R_ECX] = data[2]; env->regs[R_EDX] = data[3];
+    env->regs[R_ESI] = data[4]; env->regs[R_EDI] = data[5];
+}
+
 static uint32_t vmmouse_get_status(VMMouseState *s)
 {
     DPRINTF("vmmouse_get_status()\n");
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 00d47e0c4c..1aaaab691a 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -23,10 +23,10 @@
  */
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "vmport.h"
+#include "cpu.h"
 #include "trace.h"
 
 #define VMPORT_CMD_GETVERSION 0x0a
@@ -109,27 +109,6 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
     return ram_size;
 }
 
-/* vmmouse helpers */
-void vmmouse_get_data(uint32_t *data)
-{
-    X86CPU *cpu = X86_CPU(current_cpu);
-    CPUX86State *env = &cpu->env;
-
-    data[0] = env->regs[R_EAX]; data[1] = env->regs[R_EBX];
-    data[2] = env->regs[R_ECX]; data[3] = env->regs[R_EDX];
-    data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
-}
-
-void vmmouse_set_data(const uint32_t *data)
-{
-    X86CPU *cpu = X86_CPU(current_cpu);
-    CPUX86State *env = &cpu->env;
-
-    env->regs[R_EAX] = data[0]; env->regs[R_EBX] = data[1];
-    env->regs[R_ECX] = data[2]; env->regs[R_EDX] = data[3];
-    env->regs[R_ESI] = data[4]; env->regs[R_EDI] = data[5];
-}
-
 static const MemoryRegionOps vmport_ops = {
     .read = vmport_ioport_read,
     .write = vmport_ioport_write,
-- 
2.21.3


