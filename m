Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF332C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869592063F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869592063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWi2-0002VC-RT
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHa-0003Dn-HO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHW-00008O-Uk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHW-0006mV-HB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so1187191pgn.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tHJ8TJeA8y3lZE06LLG15C3UoFOsuUPcKgVUlFGD2eo=;
 b=gFVJJJOaYU7EKQ2w7fZ5Se9Dco0JFQpvOxGsllFTAVKFApiyEgkPsjaVEz1E1+ANnT
 DSws7brIqY39pJpKPhkaHrYNYsVYsjBCmykVdpuqykfoQWsXHvgs5nDSKMjbdUaC56Ei
 LM2jdilqiJu3R+4L0oXtxq1IEqCPpNAyLDpnh85R3ftXw9yO797sFLa1XwrexTO5o+u3
 7dwC6JHHUvcbidQnbQzllQqAs2BBZQRBsDRdsDn9r35oE2jX6swDd/f7qxYBWXG7pw3y
 QKPigw9h5lp7Id2eP9knrlMr760NNLb3Z232IAU1NJLdijoLMymcIbcadFtKhz01vJ8x
 63vA==
X-Gm-Message-State: APjAAAWXvoMvx8dHbwt/tPL/Ai/vS8Orp+7YoNvaA2SCA8wyXnG8D1TC
 K3CaZL4oUnJV31cmx6swVobd9Q==
X-Google-Smtp-Source: APXvYqxAAiSGsJEMq09qAbmcVjS+lWBRmocPW0miY46BEjRuxT0HRsJB0zJ/PMtGlOiiuAHiSv9DZA==
X-Received: by 2002:a17:90a:7f02:: with SMTP id
 k2mr6180344pjl.78.1561649029253; 
 Thu, 27 Jun 2019 08:23:49 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id f186sm3156781pfb.5.2019.06.27.08.23.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:23:48 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:48 -0700
Message-Id: <20190627152011.18686-12-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: [Qemu-devel] [PULL 11/34] riscv: virt: Correct pci "bus-range"
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


