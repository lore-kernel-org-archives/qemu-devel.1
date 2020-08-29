Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F58C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5359C20707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuuDT7ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5359C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2ih-0003Pf-Gj
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2dD-0001PM-Lg; Sat, 29 Aug 2020 11:19:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2dA-0005G2-4X; Sat, 29 Aug 2020 11:19:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id j7so3322683oij.9;
 Sat, 29 Aug 2020 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vguI5U0bhxwSlVEjuemI3fZ5Fw5Lf5dy0E2vha1rC8E=;
 b=iuuDT7epacLK9ZYu/D25eeFlZw4rqt7AXQBYuKEcI3TLvH0HnfwkvEo5/ofsEuX+Lf
 CAeDfgTHcZ2S2B3WsD5yB5vbii6OK4p2uL/NHiewCGmGNAvedW3srqqtn7tUER4Vxj/o
 KVX7A3flPOoFx70n4pcpPHMrPw/ONuYzpXWPKyzzrlmVIObi7b7yY8dUfDTOQNKaEuSB
 V04/n1dp8EDOx75v5RE37L66/a3qkNSDB4fjd7Y6gG0X0uO1/G6dnq6Pw4QvzMV+VumD
 KGmoAu1qx3g1exJRMqgKfe2Mn8XzuITeuJXa5MtVrHEDlc/6ISCaaBDowXZMiQ4kGmmZ
 2Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vguI5U0bhxwSlVEjuemI3fZ5Fw5Lf5dy0E2vha1rC8E=;
 b=uHZjXsILkRYZL24/nTOkieJ/NZKmed2rk1YdSMaIAvwJum2A6NQUnnrZE38uYoYuZv
 QJLb5lzM9lrEw53rV/uyvnojtEQkorU6xS/SU3N9xKcAxb6bqfCfLvx97dNKVQPBLQ70
 9cRJFarRFxjRBnEGq77XNJ8CquVVV6wMhPVzB0O/UtgcDWX/6P768vQ9p4jw99dn56e3
 jnPIOZel8NGAWyn+liN1lyqK8KT65w9L5ZtdVcyDdcTBXtzbrT5FCosAO1pYoJVzBXEj
 CILd+gJnUZa5CzYRUcEOPBB0Y8oThKwmMSUfKH8rBvH2pmMgEFKhWs9Nx5n1C94SuOkk
 60Fg==
X-Gm-Message-State: AOAM533CYi2PGbaG91ZzuoaZeatz4ohwpNf6KUdnXfOL6zJ5Q1uegjrZ
 lJ2QIwJ2XUgm7jpNRwvDTdg=
X-Google-Smtp-Source: ABdhPJyd5G4NFygo/nDdwr/Snnz3Bb5I55RfvelEgwfTFNWxyl1Kb/bY17bwDvlyf/bEgJ4juUbFfw==
X-Received: by 2002:aca:53c4:: with SMTP id h187mr2209520oib.126.1598714338791; 
 Sat, 29 Aug 2020 08:18:58 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:58 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 14/16] hw/riscv: microchip_pfsoc: Hook GPIO controllers
Date: Sat, 29 Aug 2020 23:17:38 +0800
Message-Id: <1598714261-8320-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=bmeng.cn@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Microchip PolarFire SoC integrates 3 GPIOs controllers. It seems
enough to create unimplemented devices to cover their register
spaces at this point.

With this commit, QEMU can boot to U-Boot (2nd stage bootloader)
all the way to the Linux shell login prompt, with a modified HSS
(1st stage bootloader).

For detailed instructions on how to create images for the Icicle
Kit board, please check QEMU RISC-V WiKi page at:
https://wiki.qemu.org/Documentation/Platforms/RISCV

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h |  3 +++
 hw/riscv/microchip_pfsoc.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 6d20853..8bfc7e1 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -89,6 +89,9 @@ enum {
     MICROCHIP_PFSOC_MMUART4,
     MICROCHIP_PFSOC_GEM0,
     MICROCHIP_PFSOC_GEM1,
+    MICROCHIP_PFSOC_GPIO0,
+    MICROCHIP_PFSOC_GPIO1,
+    MICROCHIP_PFSOC_GPIO2,
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB_CFG,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 7f25609..11ebdd1 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -89,6 +89,9 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
     [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
     [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
+    [MICROCHIP_PFSOC_GPIO0] =           { 0x20120000,     0x1000 },
+    [MICROCHIP_PFSOC_GPIO1] =           { 0x20121000,     0x1000 },
+    [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
     [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
@@ -311,6 +314,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem1), 0,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM1_IRQ));
 
+    /* GPIOs */
+    create_unimplemented_device("microchip.pfsoc.gpio0",
+        memmap[MICROCHIP_PFSOC_GPIO0].base,
+        memmap[MICROCHIP_PFSOC_GPIO0].size);
+    create_unimplemented_device("microchip.pfsoc.gpio1",
+        memmap[MICROCHIP_PFSOC_GPIO1].base,
+        memmap[MICROCHIP_PFSOC_GPIO1].size);
+    create_unimplemented_device("microchip.pfsoc.gpio2",
+        memmap[MICROCHIP_PFSOC_GPIO2].base,
+        memmap[MICROCHIP_PFSOC_GPIO2].size);
+
     /* eNVM */
     memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
                            memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
-- 
2.7.4


