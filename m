Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEF4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C8420707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPsUG5l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C8420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvMj-0003do-1E
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIV-0005QD-IF; Mon, 31 Aug 2020 21:41:20 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIR-0005dp-Nu; Mon, 31 Aug 2020 21:41:19 -0400
Received: by mail-pj1-x1041.google.com with SMTP id g6so866300pjl.0;
 Mon, 31 Aug 2020 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vguI5U0bhxwSlVEjuemI3fZ5Fw5Lf5dy0E2vha1rC8E=;
 b=BPsUG5l93uqSiOB2AXABG6Ls79BcYZ3eKNDxGCLSyl4UQ1JOL4djTk800XH8rQqjiP
 xJV3y4SjbJgHrj5e51OrnbQ48Gzg76i0MSrN0y/IUqT8GAsxXZPCisl1ZRtrT+/0sJxH
 55HIQC0it6DHFCKKWXY0uTtD05EpMgf7Bb+v4V0CUkW7t1OADy6yyPxMPGGZhqrx8zP7
 WxZ+Yi3yyiu/Ckj1xibQZT6hoIgc4Zf169lRFb4sicPMfFoz3ZwT0KcArC3sNsnD1Osz
 W3jVd/oQXeGeH4WrlacyaGm+IgaD29iLZlyKHMA1czO3029IyuwRMWy4s4drjAF/FGwC
 WIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vguI5U0bhxwSlVEjuemI3fZ5Fw5Lf5dy0E2vha1rC8E=;
 b=FQolgl0bRyzmpEATRb5DsazF9hE2uIZxSTWNqOOlbO40OsMxwhjqRJXO8y2OTenTxj
 NRdRDvmmSbAsOgFJp1vhbbLCTVZXnxqN8YzoMmNWllXiSvPf4xti71vseTAXmEcnC/l1
 TlpZZJG5SluNIFy4GWg4se1DmyUc5f5XRghB9d7SBunCNvcx7+yfNAryLmHTc14zyMEj
 fZzGEC+a3T9efrAQ40TKeuUXF0R8Frov0OujT20cHa5Pz2aFUnCSqJSYxPA+LvwAdvEZ
 smIga6xGUx47Fx+1ONPzxidFkeFmdhCVQNLPGnYRFbIh52NIJYo7vLXLJPqIZWc/XQzC
 ujFQ==
X-Gm-Message-State: AOAM530dSpEr8OQz2O4gN254tN/YvqkSQNz+1+MwEd6UCLCT28okR+mF
 U4DtxgckfzRMZ0oQTQfATc3w87+5ugs=
X-Google-Smtp-Source: ABdhPJwUfEoGTGMxQv9dWFWfcQfBw+AkgSbnM9KblFltlVl7zPU4UG6KhufWri7++vvS72xxn92aNQ==
X-Received: by 2002:a17:902:bd06:: with SMTP id
 p6mr3325056pls.255.1598924473653; 
 Mon, 31 Aug 2020 18:41:13 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.41.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:41:13 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 14/16] hw/riscv: microchip_pfsoc: Hook GPIO controllers
Date: Tue,  1 Sep 2020 09:39:09 +0800
Message-Id: <1598924352-89526-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1041.google.com
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


