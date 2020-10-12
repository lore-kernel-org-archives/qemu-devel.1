Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE54C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B767C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2jJHQOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B767C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRupJ-0001ES-Ka
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucM-00027S-J5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucL-0002vQ-1a
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so18463236wrq.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OtZ8xecNb90sNX6MOb7lEpaLU7iDzMbfu7tSNksXSOc=;
 b=k2jJHQOFoTksM4/FYYSptEbhuneEnscar6rjcHzsLabHBHq6kBda16lWg6bb09BqcT
 Mc/XRqktdSg9ZIUxtGNG6bIayWI8F8Qwr69bRXEvKxbsu2qZxttS3cL0WbFaK435wXP/
 jgitAX0jSpwPG7iXsKejvX7W2tuUYoeK8t2yxGo+MmglmDa4mZP4MOUuIabrW790f4o8
 jSzqf74+Skx01OHl5Gk1B7vTqU5sA5YOgXdfRk6Ua55DYHXaw9XJ0WFrzZE6rgWBMuh5
 uQcmaQ4pjZslytsBxDgGTwTeghk9i43fF/P4RJhvPuBZ6/4XBVMxMDTekUBuh6R/Yh4W
 kOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OtZ8xecNb90sNX6MOb7lEpaLU7iDzMbfu7tSNksXSOc=;
 b=EFEJqSlcH3m5oSgoYYtJ2kAKmxXLmVnXNlAMDRafv9WuNWeVWNw40P6tKvlg3AFq+A
 OQGBaMu7yg1oL4xwEQm7tP97kRYbzxCCh9GNBtmdGS6qlVj4lBO0ADFE0WzKQhiYT5yC
 XiZMDsE4ywSnnO59jdKd7ueb+zlzmvhBQBUEQNSyuFlucbwQZHwVbLP5JB+6UQdjtitl
 xcGi10YwTYBAwRktOEJKuvkt8siI+ODwmTw037TG767zJLFeTB/PKHtuDSlhImH9efcl
 q4txloFt/m1YGNXRH46aB619lvfWwlWnr2B6olv3GFytmNshyOlt5ZTHovxuza9E53Bn
 mptQ==
X-Gm-Message-State: AOAM530ZuoAXoniicre6DEhZS0kRi7EvK5NCi2FZpecI5tAofXOL2TXj
 CU87tEOpJ3vxm6vnbTyvRD761C+kRkY=
X-Google-Smtp-Source: ABdhPJwbQE6G0hhqj10cmVQAYs17b+B9aMuhJgVik7SQOLeah03ww1csdTUJR9n0Egni/iQghUln3g==
X-Received: by 2002:adf:f207:: with SMTP id p7mr31113174wro.152.1602496783499; 
 Mon, 12 Oct 2020 02:59:43 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l5sm23785997wrq.14.2020.10.12.02.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/21] hw/mips/malta: Set CPU frequency to 320 MHz
Date: Mon, 12 Oct 2020 11:58:02 +0200
Message-Id: <20201012095804.3335117-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CoreLV card with ID 0x420's CPU clocked at 320 MHz. Create
a 'cpuclk' output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4019c9dc1a8..1e2b750719e 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "hw/clock.h"
 #include "hw/southbridge/piix.h"
 #include "hw/isa/superio.h"
 #include "hw/char/serial.h"
@@ -57,6 +58,7 @@
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
+#include "hw/qdev-clock.h"
 
 #define ENVP_ADDR           0x80002000l
 #define ENVP_NB_ENTRIES     16
@@ -94,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MaltaState, MIPS_MALTA)
 struct MaltaState {
     SysBusDevice parent_obj;
 
+    Clock *cpuclk;
     MIPSCPSState cps;
     qemu_irq i8259[ISA_NUM_IRQS];
 };
@@ -1159,7 +1162,7 @@ static void main_cpu_reset(void *opaque)
     }
 }
 
-static void create_cpu_without_cps(MachineState *ms,
+static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
                                    qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     CPUMIPSState *env;
@@ -1167,7 +1170,7 @@ static void create_cpu_without_cps(MachineState *ms,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = MIPS_CPU(cpu_create(ms->cpu_type));
+        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1189,6 +1192,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
+    qdev_connect_clock_in(DEVICE(&s->cps), "clk-in", s->cpuclk);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
@@ -1203,7 +1207,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
     if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
         create_cps(ms, s, cbus_irq, i8259_irq);
     } else {
-        create_cpu_without_cps(ms, cbus_irq, i8259_irq);
+        create_cpu_without_cps(ms, s, cbus_irq, i8259_irq);
     }
 }
 
@@ -1421,10 +1425,19 @@ void mips_malta_init(MachineState *machine)
     pci_vga_init(pci_bus);
 }
 
+static void mips_malta_instance_init(Object *obj)
+{
+    MaltaState *s = MIPS_MALTA(obj);
+
+    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpu-refclk");
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


