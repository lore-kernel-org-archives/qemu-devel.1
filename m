Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719F9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9BC2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCljUExE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9BC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwvf-00019C-Ul
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkx-0004NZ-II
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkv-0006O2-QJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id e2so1947910wme.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSBlQ/cHcjkhSqd54ydbqbvmimFAYZ4LEPOfJ36z3ww=;
 b=RCljUExErAWfY1BnCIGs6/HJidmUa6ERmKsHCxDi1ETd91UopsAwWn/4yAcyIfxdOh
 kZjB9JiWf0bemE5s6aL1jxTi4uddL1dcRbxXhGvdmu2gALEEa2IDyeL5RDgt189mh5MA
 9In2Iux8BvHakrT9xzp+XwL3+ajisLuBaGxnroadiTGZ7/Szb+xI7B7DMMg2lJwJiiJr
 iiu7+ATKqhNZG6goYEfbqEletYqxfNnxmGFrHr6Duhqf6wc5KxpdUQKgCY5TipNFyxVD
 l2Reg7aKPF0AEOQaguhY9i47GBza4gzfllgQ0pvPVTp4RRWmknayjnaLYSL4wx3USfNu
 4jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QSBlQ/cHcjkhSqd54ydbqbvmimFAYZ4LEPOfJ36z3ww=;
 b=U7lL/lL4BADbtfOlE+alxRJYeAPP+vqej8RUrP4kfHSQWETUoK7dnCCu6df13MBeVb
 W/N/EUDbMT9buQNDbdu1RmUpXot7KgoH5X78jkW9kaNBQBYjjVYxENj1RYQJ2keyicqt
 ee3xjCja6EWJAK6UK85EuS1nW4V76fKB/JFpYB2kN4p/hOGhfVccXxvTHUd2WlQ41k5j
 If+EomTd6TjZn1qbbHgoiIeeIVY72dRjhnRs53xXX5rsz4ljKzVuFYmCco0mK20zw3T8
 eOjQAmxNcvc82Sbdby6DlQLHnyuHFz7ZgIiUkW+76/qhbjK6Wvimp4EPJvjcxQgGf7r0
 NMpQ==
X-Gm-Message-State: AOAM532/P875tWM586I77J8CyDksp3T72xMA43NmKY0YRmFTLW4WgUEp
 8+ftGB015ZZcz0g+M3Tv38G9rN6eHSM=
X-Google-Smtp-Source: ABdhPJzjWnX4Rsab/ORwPnFbv6kj/haXDTBwuB7ZxHowE9ZkNxeauv2TJGJyaeN6BjfNywCX+z+qlw==
X-Received: by 2002:a1c:4943:: with SMTP id w64mr226120wma.62.1601313363847;
 Mon, 28 Sep 2020 10:16:03 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:16:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] hw/mips/malta: Set CPU frequency to 320 MHz
Date: Mon, 28 Sep 2020 19:15:36 +0200
Message-Id: <20200928171539.788309-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CoreLV card with ID 0x420's CPU clocked at 320 MHz. Create
a 'cpuclk' output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4019c9dc1a8..62ec543a610 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -57,6 +57,7 @@
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
+#include "hw/qdev-clock.h"
 
 #define ENVP_ADDR           0x80002000l
 #define ENVP_NB_ENTRIES     16
@@ -94,6 +95,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MaltaState, MIPS_MALTA)
 struct MaltaState {
     SysBusDevice parent_obj;
 
+    Clock *cpuclk;
     MIPSCPSState cps;
     qemu_irq i8259[ISA_NUM_IRQS];
 };
@@ -1159,7 +1161,7 @@ static void main_cpu_reset(void *opaque)
     }
 }
 
-static void create_cpu_without_cps(MachineState *ms,
+static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
                                    qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     CPUMIPSState *env;
@@ -1167,7 +1169,9 @@ static void create_cpu_without_cps(MachineState *ms,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = MIPS_CPU(cpu_create(ms->cpu_type));
+        cpu = MIPS_CPU(object_new(ms->cpu_type));
+        qdev_connect_clock_in(DEVICE(cpu), "clk", s->cpuclk);
+        qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1189,6 +1193,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
+    qdev_connect_clock_in(DEVICE(&s->cps), "clk", s->cpuclk);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
@@ -1203,7 +1208,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
     if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
         create_cps(ms, s, cbus_irq, i8259_irq);
     } else {
-        create_cpu_without_cps(ms, cbus_irq, i8259_irq);
+        create_cpu_without_cps(ms, s, cbus_irq, i8259_irq);
     }
 }
 
@@ -1421,10 +1426,19 @@ void mips_malta_init(MachineState *machine)
     pci_vga_init(pci_bus);
 }
 
+static void mips_malta_instance_init(Object *obj)
+{
+    MaltaState *s = MIPS_MALTA(obj);
+
+    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpuclk");
+    clock_set_hz(s->cpuclk, 320000000); /* 320 MHz */
+}
+
 static const TypeInfo mips_malta_device = {
     .name          = TYPE_MIPS_MALTA,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MaltaState),
+    .instance_init = mips_malta_instance_init,
 };
 
 static void mips_malta_machine_init(MachineClass *mc)
-- 
2.26.2


