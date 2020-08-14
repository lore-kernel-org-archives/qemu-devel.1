Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A85BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68C7204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtISJnIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68C7204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cxt-0002Ib-4F
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cmO-0000Sk-Bn; Fri, 14 Aug 2020 12:42:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cmL-0002kM-Oh; Fri, 14 Aug 2020 12:42:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id m34so4781299pgl.11;
 Fri, 14 Aug 2020 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ioPpzPUjXkN5DEhK9Aq7JKvWoqfFkviHfvQXK5203Vw=;
 b=KtISJnILLAFot9Y8m414xrj0rfRLs/YCeANq8oqx2YTNsqBRwYFKRR51D6dTtQOYz+
 crQbKZ3JrqbrHlDFdwlzKoJQmQmkuU85hQrOkrLM21HPsDd/DZ0eOqiUA5VxviznKYHB
 jrO6IPcDNcB9YpTBjVFZTqOFL2PT3wmk/SVtNfcVsxxJmdoO44H/oR3xoxXggKvUSwdv
 0oB+EH4ZczpHcHt9Hkp3VWJv3dzYXErMHTW3T4fJMVZHqaC78W4E3U9ahwic3EFsgiVd
 jpVCN3XxK8MEmIR6/fptHgRhLKJsgoS3IeqtR01mQyo6kLuPk2Mx7JiqgmRcNM4kqPVh
 GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ioPpzPUjXkN5DEhK9Aq7JKvWoqfFkviHfvQXK5203Vw=;
 b=KT7TLG+BPxZAorMom+RPwLfx7gcuW0d6SwXb87flf/oJgLapi4Ylel9fRqs+OqZaRV
 OSsZQFsXcx/1QbHujyOk3IOLL1P0/pLGTGbO2rQkSr5rqredhYAhjPQyh3i6NGHxki2A
 sRRIgAtXfwoOFQ4crmY/jwHoNXnO6DKF7ipDNsOVe+W2DZJ/dDDtOGC5/BtIE+SZRM8i
 Ifm5bd62qJMmVRGhtKEszeOsIpFcus/vj3roNNathYpfenDUMch0nR7q0vV1Q1DmrtIi
 0C5YQMZhMggCmgg2OyfogXSYVtZ2+lp3wYVmG1bTPnBM8Ry6daBnOimSGCoGkjooc23b
 0OMQ==
X-Gm-Message-State: AOAM531ALJWeoN57Jk86lv4xb6IsJ7zjuEY9I7MBj5MbdPryIun1xx0L
 Or0fnE3L6WYDn5aBmWGheFU=
X-Google-Smtp-Source: ABdhPJw3sxoNCzWbYUNNxpoCjX8woJ4VG4zaayPUPkVBrRQ20jxyy9m1nbGDUvYe/YDW629Ke7WAZg==
X-Received: by 2002:a05:6a00:2247:: with SMTP id
 i7mr2456019pfu.217.1597423324147; 
 Fri, 14 Aug 2020 09:42:04 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.42.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:42:03 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 16/18] hw/riscv: microchip_pfsoc: Hook GPIO controllers
Date: Sat, 15 Aug 2020 00:40:54 +0800
Message-Id: <1597423256-14847-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>
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

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/microchip_pfsoc.c         | 14 ++++++++++++++
 include/hw/riscv/microchip_pfsoc.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 625b511..139284a 100644
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
@@ -308,6 +311,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 60f994c..993b17c 100644
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
-- 
2.7.4


