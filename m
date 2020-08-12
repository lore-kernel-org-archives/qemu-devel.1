Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4A020774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y8fnDNWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4A020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zTh-0007SO-WE
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQZ-0002Ph-Gg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQU-0005qL-A0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272054; x=1628808054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cq3JJ2MpSltXdXGTDk4g6h8slBE4eUBzmWJR3+MONy4=;
 b=Y8fnDNWsohO1JGq4De+U6nQNkvnvouyPuwof0Lx19Un4mc1tgwf1ggGo
 9BBNvT1jEkN4DmTm7wO8b5yb+fYB86xHKjP5kcYknEEEbutXCuXQao7nD
 7Z6KxduFCN44mrHVTMmD4p9x/EjcaiRVYd9ilGLHGf8xcZjX43Do6Ninu
 wInAy8okkICwuiU4OTNFJYe63PEI15iZGPJffVP713t2WK+qdBr0ne5vU
 lGpUH4jt1nz4w1sToyAPcLqSTYLOnYcuda86wQZjdr04xl/9tl6pxDi0p
 TZYFQMds9Ds3N5K8fKKzXTNKTjiZ7ojW8wOMrcz51NR9YGUNyTCQShNm9 w==;
IronPort-SDR: vzxksyaYzy0JPqvXAfWxATOa/VFuUVV7HXTuJT1MPOU+Tyr5uLCaeEDI8IjeUOi9nBpPaMu4sP
 y5g3Y+Ae2HXLTA0aOqsOghr+injqRWQRrQ4ao51yW3LJJkUjC1RGWzl2XCyI/Ehygp6CXoGUVW
 XVz2ajj137SdDV4M6CpOOCnyab5K0YH0qzB/ZJrdcdYruLuhsZu31qTLy0Pt+KyRdR4Mb4xkp6
 5CF187fVShHcIWjVXfN8kxBEcXO5J/3NGhAN7hKmNC1o4GMQXBl9SzhhnN9ON52MVyLuPt7cFc
 rio=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144799065"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:52 +0800
IronPort-SDR: 06lz8vpcsuitd8R24fUqVXYNia/JwSWaJiYtVP8DMXAnQZiE/mmqSHisPEatgSCIyD/XedL2GJ
 Vwx7CgeX5P1w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:43 -0700
IronPort-SDR: CP1thwQz0Z8sWV+jU49rdnZVrFIPi1wnQxfChyD4c5GYZPFTvhUCp8pNR0IpIlxj4d+WYMZWwH
 WtVMH3HQM6Kg==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] target/riscv: Fix the translation of physical address
Date: Wed, 12 Aug 2020 15:30:41 -0700
Message-Id: <20200812223045.96803-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zong Li <zong.li@sifive.com>

The real physical address should add the 12 bits page offset. It also
causes the PMP wrong checking due to the minimum granularity of PMP is
4 byte, but we always get the physical address which is 4KB alignment,
that means, we always use the start address of the page to check PMP for
all addresses which in the same page.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <370a983d0f9e8a9a927b9bb8af5e7bc84b1bf9b1.1595924470.git.zong.li@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..2f337e418c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -543,7 +543,8 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            *physical = ((ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT) |
+                        (addr & ~TARGET_PAGE_MASK);
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
@@ -630,7 +631,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         }
     }
 
-    return phys_addr;
+    return phys_addr & TARGET_PAGE_MASK;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.27.0


