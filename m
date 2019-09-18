Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A07C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B676208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B676208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcTv-000268-Pn
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsr-0007lS-FD
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsp-00078g-St
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsp-00078L-NQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so26806pgl.11
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=zoTfnPNo+HKyoYh1Fp8HDEvDsUoKiwqregGDjCmxaIA=;
 b=bDNLTGtHkNxOFQyVbxBgFxZi1lJOLoDR3yVEexWvLXtFU/z+dWyB9sRr+go6Iit7gU
 s3fcWBlbm4pvXBnlIgVgq9IOMqgtVICwjUIHc9rayzeXns29SBOA4/w8ikWcRN7u8BBG
 7dNy8QP6lTKWiRUL4AavxRUPb7v6tD+qBM3eZgru8M2tL/rj7iDVpT+E7bZCLGDxVMFE
 RRXbOrG9Y8je1uI77fC9mG1TgY/F6gxuqTdyx7Q6Ype8A/cC2inh0Sib2xvoOpfk/Lxr
 krhyzebSPt7aBPCgAo2NgfHWXOZEJeN2Rd7OJKPl5hE2vmVnX1+GsyCCBxmDjMINV1Jn
 Ltew==
X-Gm-Message-State: APjAAAVm1hQ7eAEduKhVWTzeUz0Z+TJF7bI6xJclW1ViKRPABeglCZ+x
 LLRwCm3+rhp5qASAEWmIs9y72g==
X-Google-Smtp-Source: APXvYqyMsaKhmUbCXAf9TQciQDi4MI6xYzyllKPq4Io0+dtQffhbMUhHWb2uDT8XEGCj2cYoly3v+g==
X-Received: by 2002:a17:90a:1b48:: with SMTP id
 q66mr4416574pjq.79.1568820522421; 
 Wed, 18 Sep 2019 08:28:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 16sm5728461pgp.23.2019.09.18.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:41 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:33 -0700
Message-Id: <20190918145640.17349-42-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 41/48] riscv: sifive_u: Instantiate OTP memory
 with a serial number
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This adds an OTP memory with a given serial number to the sifive_u
machine. With such support, the upstream U-Boot for sifive_fu540
boots out of the box on the sifive_u machine.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 9 +++++++++
 include/hw/riscv/sifive_u.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 24f8c19eee..f5f0c3cbb2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,6 +10,7 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
+ * 4) OTP (One-Time Programmable) memory with stored serial number
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -64,10 +65,12 @@ static const struct MemmapEntry {
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
+    [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
 
+#define OTP_SERIAL          1
 #define GEM_REVISION        0x10070109
 
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
@@ -422,6 +425,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
                           TYPE_SIFIVE_U_PRCI);
+    sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
+                          TYPE_SIFIVE_U_OTP);
+    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
@@ -498,6 +504,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
+    object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
+
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
     }
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 7dfd1cb22e..4d4733cb6a 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -23,6 +23,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/riscv/sifive_u_prci.h"
+#include "hw/riscv/sifive_u_otp.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
@@ -39,6 +40,7 @@ typedef struct SiFiveUSoCState {
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
     SiFiveUPRCIState prci;
+    SiFiveUOTPState otp;
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
@@ -60,6 +62,7 @@ enum {
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
+    SIFIVE_U_OTP,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM
 };
-- 
2.21.0


