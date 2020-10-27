Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744DC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E0A2225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYQOfLzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E0A2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQDO-0001MO-BS
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPo4-0002gb-Qp; Tue, 27 Oct 2020 10:18:36 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:37158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPo2-0007i7-2p; Tue, 27 Oct 2020 10:18:36 -0400
Received: by mail-pj1-x1032.google.com with SMTP id lt2so823043pjb.2;
 Tue, 27 Oct 2020 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ls26fnfG9ZZq/yQ/l/9wvw2sQVViaGDjGlmHXraWck8=;
 b=sYQOfLzLrPuKwPRzc7UfqGogFg4oj+ji3MPSAbiik/YWNZG1DrD44Wadr2JqSU3GTB
 0q5Cl/aek5e/fSngl3DG76OFaRqwpARexDNRrpui/Xf7/MEu1M9C0tamlmZ09JjQ0B73
 bbyYPDpqFtV1/V2ksKPSWmJK6FDXppKFhW4VNP5p8xEY/CK8mZ+7Mfto9pQiAYUPpzRr
 GtWL/NAw1zar45vMBw6mEoyulQ6ZdBz8ll9YsKF02vQtd4lO98W3Padq29mE7myBabKm
 ELpwegDpm/UuXH8f0F5xKvvjdqWnElrPcp4IyrRb0CRo1XkmdefDjyGhsAhk8ZS04WvE
 yo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ls26fnfG9ZZq/yQ/l/9wvw2sQVViaGDjGlmHXraWck8=;
 b=OxtBna7bYHSHfs1UntzO3RFbp6z3TuihMvRhtsl6n3HOsgSR8bDN2sc8k2Gy5wf/w8
 cNZKXIpzVUReSHmoou3BildfckAE9OLjnNvHHNHM6zBKzzBfRZiwEnyH7WFTtPDNDQtS
 yBea/kbBfFCDfNYU0/Gvrcsnf8VB32B+2wlm6dyXmmkrmfod0p40419zKfVLgBQmxfHm
 NhJeJcChZmEngyT8ktZAWRKjsXhhYe0etM8vbKcD4KxdrkhJIE9VYQDGhEKGSQEuZhUp
 oMpegSwu4EvbyDjCP2LLmQthkFoLvy1oLabydpEPAI3rpLqC9W2JeWI8Q5MCvv8OLPkj
 a7Bw==
X-Gm-Message-State: AOAM532kC7Jf4YN2AeY8T9NDLRlydv9PLbMNVvieeqgCkCjxj33OSKXd
 ys6bLggfQU2QwnpxsI9uylw=
X-Google-Smtp-Source: ABdhPJwKyG06HEG6ehWXpb5JiiaJ+Ii7cpdxkawC5F+SX1m1BGw3o27J+aYA9sM4GrrWFCkVPsdifg==
X-Received: by 2002:a17:90a:e656:: with SMTP id
 ep22mr2261624pjb.107.1603808312362; 
 Tue, 27 Oct 2020 07:18:32 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id mn15sm1600297pjb.21.2020.10.27.07.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:18:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [RESEND PATCH 6/9] hw/riscv: microchip_pfsoc: Connect the SYSREG
 module
Date: Tue, 27 Oct 2020 22:17:37 +0800
Message-Id: <20201027141740.18336-7-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027141740.18336-1-bmeng.cn@gmail.com>
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1032.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Previously SYSREG was created as an unimplemented device. Now that
we have a simple SYSREG module, connect it.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/Kconfig                   | 1 +
 hw/riscv/microchip_pfsoc.c         | 9 ++++++---
 include/hw/riscv/microchip_pfsoc.h | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8f043e38e0..facb0cbacc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_SYSREG
     select MSI_NONBROKEN
     select SIFIVE_CLINT
     select SIFIVE_PDMA
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 05fb5004a1..69117c6000 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -135,6 +135,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "sysreg", &s->sysreg,
+                            TYPE_MCHP_PFSOC_SYSREG);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -262,9 +265,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SYSREG */
-    create_unimplemented_device("microchip.pfsoc.sysreg",
-        memmap[MICROCHIP_PFSOC_SYSREG].base,
-        memmap[MICROCHIP_PFSOC_SYSREG].size);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
+                    memmap[MICROCHIP_PFSOC_SYSREG].base);
 
     /* MPUCFG */
     create_unimplemented_device("microchip.pfsoc.mpucfg",
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a244ae6d39..245c82db61 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -26,6 +26,7 @@
 #include "hw/dma/sifive_pdma.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
+#include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 
@@ -47,6 +48,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCSysregState sysreg;
     SiFivePDMAState dma;
     CadenceGEMState gem0;
     CadenceGEMState gem1;
-- 
2.25.1


