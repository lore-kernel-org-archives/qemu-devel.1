Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D708C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF33020B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEhTsuy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF33020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVuL2-0003at-3V
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:53:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hVuJe-0002t0-US
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hVuJe-0002Gk-2p
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:52:10 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
	id 1hVuJc-0002Fp-0x; Wed, 29 May 2019 04:52:08 -0400
Received: by mail-pg1-x543.google.com with SMTP id h17so982916pgv.0;
	Wed, 29 May 2019 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=kS9RwfTWm7yJJiKansvU2AvQ0hnlJBsSRKgE5jXjYTI=;
	b=LEhTsuy7OuQN3yJeX8u96tFxbMduV5X4UGXTxM6OGEcfjS9OJK24Ec+0FORgchb8wu
	rSIj/WjoCCE1V2BfM/uwpKpr+i+3z5uhRhvEG2+ko1y7gHWSyoEOpsAYxI3e7KOTkUnY
	5W6Bm1iTVanPQ9hiUV4F+JQ0TIDMI3vt0q7p98S1iAgA+lpwDMsqJG5uap8jEviokCQ2
	D3b+3EVXMS/jmbBJb6ka9Q9+mBvbmrUvJVeiHDdWhn5fZYZs2b7PF2DCbzQv2jfFetEQ
	KhBPE8H7/yreuEk59HqKR0nJv9jokOp8W/Wg3DfXzMy911rj4A+x8pC6P9Wya95BMlZy
	nJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=kS9RwfTWm7yJJiKansvU2AvQ0hnlJBsSRKgE5jXjYTI=;
	b=nQfqDu5e1Hk/Mlm4z2XOOrgynLpGtUDDqi3oQXe+KjeucGYQXbJYNoT0En0gtjbler
	Ww3jo5peLvMqxb+6eHM08ckax0emMSHCZttKl789PFynsnvrK3jHNg1cQfkR8d07zJ3k
	lGArq0d5kmpB5hNKQVerLqldIrSvaUR4cpxKaMKge2fZXy+g2nMoIus6kRuji1v1zo5C
	xrmoctIwoHlK66KuA+Qk/DNfLvjiEVFko9MWixUPJ6zCVIXyp8Eh7Bd3nwcNPq/DcvL6
	HOw3OnkiOX3xy6RSZDtdd8oNzd9zQMzkP8NMnvJEbXqKFYHnfI4DJgO+NQ3eNPrnXRQv
	6pgQ==
X-Gm-Message-State: APjAAAWdrqcKKhAWqzloTEvpuHV2+fMKODwZxT5Fe1JYvPMhEGx8uCz0
	GieSqtuyJdtGiVwcjVr1CyIZe3mJ
X-Google-Smtp-Source: APXvYqz8bmnpoQpg410Xq1RIALZdOTrKcVxM63F9hjaug5EBQk5GGssoXPEldQZ7A5WSDPRctlbjpw==
X-Received: by 2002:a17:90a:240c:: with SMTP id
	h12mr10916017pje.12.1559119926436; 
	Wed, 29 May 2019 01:52:06 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
	[147.11.224.80]) by smtp.gmail.com with ESMTPSA id
	k3sm16310838pgo.81.2019.05.29.01.52.05
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Wed, 29 May 2019 01:52:05 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>
Date: Wed, 29 May 2019 01:52:01 -0700
Message-Id: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH] riscv: virt: Correct pci "bus-range" encoding
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The largest pci bus number should be calculated from ECAM size,
instead of its base address.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fc4c6b3..d6132d9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -299,7 +299,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
     qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
     qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
-                           memmap[VIRT_PCIE_ECAM].base /
+                           memmap[VIRT_PCIE_ECAM].size /
                                PCIE_MMCFG_SIZE_MIN - 1);
     qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
     qemu_fdt_setprop_cells(fdt, nodename, "reg", 0, memmap[VIRT_PCIE_ECAM].base,
-- 
2.7.4


