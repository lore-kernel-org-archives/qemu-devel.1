Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BADC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D1720756
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBTJltPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D1720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnBg-0001UT-5J
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpP-0003Tc-IG
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpN-0003rE-RN
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so8363820wmj.5
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TadARjLJ/nsMStaSHgFw9Eo2VdlMk7HODNJ8C7SZvtU=;
 b=bBTJltPSYyk6fzuDWmONLzc21U0QmrLswc5nggfsj6YJElBYXQw6qQSZcseJpxlVG1
 FOEF9amcoRivMQL0RXSfsF26Jx8op1ar8r9VwvxMpNq3qBcMftULSX+Ugsy0QW9v6TOR
 RDZNVhl6mNfdND1SJi94fOb3oYqykTKowMo/IO9JrzFZWzR/VM40NBZ44lgwjYkqtSu0
 qW0+IPW9wfUplCE9djOMnV2/SNLT68yI3kMGyZqVs3WMTu/rbQHaHtX05q5VTpyGjx09
 UxVxnn0NTfa/jHQWuH8/aj3jstFIt1lZ3ENsCjHEsR8FGqcrfKGMKhTBuw4FCk4Ps+Ns
 TI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TadARjLJ/nsMStaSHgFw9Eo2VdlMk7HODNJ8C7SZvtU=;
 b=PikWC8aMCPwVOs43Z6P9tXYyv8/LLYyoiu6o/fJGmlMKgqGhB3MKka9bCamTNQo657
 pDuGbyybnd43SZhC48WxLUpaU3L6Nj/KutvHglZEjDzhYwziMGn+3iWzb3VFrZVmPdtR
 HXW7bz4SQQ2Wnz4v45XE0lxJr8TN+6f5ToP/criKt94uinGO6IeCm+eY+npOwFxk2zDk
 hWaElb3YRrlC2vR0ry2RS0mvzsmninxQdd+grT9bU8mm4+55aSjoFCBRLMWbG/8l2MaB
 4vR88ZKdT82RN7uMRsw7DC3T8ONOcR1jXtO5NYOX3Z4dn6Waq5cimOMTcbuSlcYFtntG
 aZFg==
X-Gm-Message-State: AOAM530GKipr8xCUFNOvWrtTfb/Z3z/Xee19dLKrnyl3Jz80c6M1kLtM
 FchXm3aH2qsvlaRrkEUKNGrn6P+pKYc=
X-Google-Smtp-Source: ABdhPJyMLICiN8XfsjOPCptb8uC0gmIw7ENPj+i9oQvsXHoqAtdc0o1ikPhnrAV+YT1Um3mGFvtNjQ==
X-Received: by 2002:a1c:63c3:: with SMTP id x186mr9070526wmb.66.1602943496369; 
 Sat, 17 Oct 2020 07:04:56 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id x21sm8374368wmi.3.2020.10.17.07.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/44] hw/mips/malta: Set CPU frequency to 320 MHz
Date: Sat, 17 Oct 2020 16:02:27 +0200
Message-Id: <20201017140243.1078718-29-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CoreLV card with ID 0x420's CPU clocked at 320 MHz. Create
a 'cpuclk' output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-20-f4bug@amsat.org>
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


