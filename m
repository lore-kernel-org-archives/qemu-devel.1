Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994E5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662192133F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mz89vmlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662192133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BWJ-0007Mo-3A
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQr-0001bk-Pv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQq-00005K-PJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQq-0008UJ-Eh; Fri, 23 Aug 2019 11:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566573892; x=1598109892;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HavBuiu9o+dhYuPr9DtZDz8tL0ixVJOlU6zBl4mUFso=;
 b=mz89vmlIlX7Xkn+6JJg4fSZQAINm4KoXeekfwQEszSah2BHS/Xf1NOZJ
 i8PldDiLVBJD5HgVaLFkp4uz+WTVNOsyEbPG3POHZBxi+1y6AamxY8NIm
 KOciwwYVNy83FrrRegarvGJTr+oYhkahLuS2dbwO9niyZdMPCtBz5/HMa
 R74G6v1Yrbn1uwq4A1Ea6XEnNv5JP6Jay/b/LnVvzHYiuuYLOYXuqmUfp
 SlaU3vJE8fg50XZYthrrDVE24VCHyPw+gSsYVbAAimMdwDIKsWwxoKnBK
 KVfclNNYCGMrlmp7iez8GBh53KgaPt7K7hNRWu9ZTL8RwH1ZzEJZTE5DA w==;
IronPort-SDR: nPCuerFax3eWZFHT5xS7sCfbCf4jNXmZDzQupxQG7ixRWY6LaIIgL+zhsQ82yNe1Eoq8WEx5Fi
 /E24+92TEepUUEkYJr9w0j5dYMOe0WqDnz0/YTSYNrvI/Ynx5SeAW/PNU2uZMOBsLwTVG7mb5H
 axouIOFwYb8ZmnocYSDRwi0ger1qe8ri7IokPRBAV+2OeN5qqcI36r90/6uH3OXKRMLFccrk/b
 48Fogdave0PrUOPaAOSTEpdh1lBexDTQ78i5t8e9Pndyd/WSuUqH98b5R2lU2mWRC4wQJrD5JW
 Nwg=
X-IronPort-AV: E=Sophos;i="5.64,421,1559491200"; d="scan'208";a="121112423"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 23:24:52 +0800
IronPort-SDR: hGaNfzoZVxWkNRv5DVXn6psL7cSLJPxSA4eeVmp5lthWS05xhEeNiaQf3b0X45dKrHyb2/AN6z
 lIj1KlznQUxm51vlT1iaPsJjRd4h5FftJMoLyvIqMArz8odysr9jYgjKC0Abs1SS5XTYId6ykR
 NVZ4HSIv+U8wjozD4ruKWerWBrAWQAhATA+GXhVCAMXNPOjkjb8cRXxVCaEJ77OBZRICiEagMA
 w+OmUNTEcHjDpPf6ryhuXUHowt5zl4KmVnQR4DM9QnwfGfeKu59fO1Evo3K8jmqlUpRkfxyBKj
 ACbidL7steMTmtgwUiuzFCWz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:22:09 -0700
IronPort-SDR: qy5CXmtGjA6wMmjZ7kVjnApH0FmPBaQCnD2uBgudTehQL8lpwToVCNVYbMPxmittanRubcNuul
 z74SK/6NnETwIwt/UnMavH7v/OqzMxPV1po0rc9eY3RXksEd6uhvp3Ari5ijI5VOli46PvwScX
 FQY9nHftWbM5AwXJar/kMdRLdYjroKQ/95EZOkM7nwdL8jb3xpeEWZ/u/FFNqZE0tMr0TfDLDD
 1TwO6btDcp093TtZkKwB1UgkHdOZOcNg8K8n93rRmMkmtoj7uah7fxgJ1cL8I0OMMuJa9q7AWa
 yRs=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 08:24:52 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 08:21:12 -0700
Message-Id: <f48008aade6df437a599000ca8531fbbf80b6e80.1566573576.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566573576.git.alistair.francis@wdc.com>
References: <cover.1566573576.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v4 2/7] riscv: plic: Remove unused interrupt
 functions
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 64a1a10380..98e4304b66 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -162,18 +162,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
     }
 }
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, true);
-    sifive_plic_update(plic);
-}
-
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, false);
-    sifive_plic_update(plic);
-}
-
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index b0edba2884..4421e81249 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
     uint32_t aperture_size;
 } SiFivePLICState;
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
-
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t num_sources, uint32_t num_priorities,
     uint32_t priority_base, uint32_t pending_base,
-- 
2.22.0


