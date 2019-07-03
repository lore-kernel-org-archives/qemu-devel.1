Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417AC06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91462218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91462218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiazQ-0007An-Qa
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapZ-0005y8-8X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapY-0006sa-8k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapY-0006nD-1x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so1150301lfa.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tHJ8TJeA8y3lZE06LLG15C3UoFOsuUPcKgVUlFGD2eo=;
 b=GwTHRJVeH69VULbul4TEnXp2/PLjEnew+Ysc1+XKf8ujrZ+yE5kp1gt2Stou+Ml6rN
 ZArubXdZtZbxTDkm2GGuTMaSvB93WHSp0+Jmqi+HLp85c0o3arqNxKv7iS7dUG2ypmLe
 WlG2O1d5ROgrCiysH+nGu7+mawKyx11eQVm2yVz9Npg0jVWpKn/ZatgQRfsXaQ5uqrkL
 NVmff/Kasgfw7aDhfSX+Z1diRaEXuw0bcf13OqsmDdaX6wI9Xshugb72n3l/KMimPyK8
 BQy1GKqA8/BKyUo2XKc1hnc8+ohUsZBwI1LJqgKPI4FIqdH+LbrZRDMJ7SmkZ8xRn4F3
 Wkxw==
X-Gm-Message-State: APjAAAU3kp71pFJ0xM8VBBvrpCBn43PWMaoMAQKwCwMmciMXbD6UBWgZ
 o2ONeWv+yVuWIl1jjHutal8/SPDrefcgrw==
X-Google-Smtp-Source: APXvYqyuiIk+wleDbejEspM+dfPiJcUX9JS9D5MT/5qe28JxnqZXkBHNfg6Cmo+JuCnroX9eMseljw==
X-Received: by 2002:a19:9156:: with SMTP id y22mr16788597lfj.43.1562143289182; 
 Wed, 03 Jul 2019 01:41:29 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id 2sm334879lji.94.2019.07.03.01.41.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:28 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:27 -0700
Message-Id: <20190703084048.6980-12-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.68
Subject: [Qemu-devel] [PULL 11/32] riscv: virt: Correct pci "bus-range"
 encoding
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

The largest pci bus number should be calculated from ECAM size,
instead of its base address.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 84d94d0c42d8..487f61404b21 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -298,7 +298,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
     qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
     qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
-                           memmap[VIRT_PCIE_ECAM].base /
+                           memmap[VIRT_PCIE_ECAM].size /
                                PCIE_MMCFG_SIZE_MIN - 1);
     qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
     qemu_fdt_setprop_cells(fdt, nodename, "reg", 0, memmap[VIRT_PCIE_ECAM].base,
-- 
2.21.0


