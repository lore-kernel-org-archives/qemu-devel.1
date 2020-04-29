Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A705CC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732F52072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gLvfl+mU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732F52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrfi-00014e-Jy
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraD-0008OA-Ez
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraB-0003Uy-3X
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra5-0003Ps-8D; Wed, 29 Apr 2020 14:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185434; x=1619721434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H3Rf0GK2uIFQ8+W/s2BSGxfdGYDmRN5HO2AJN6YT9+s=;
 b=gLvfl+mUoF6QViAfi0TQRNW9BxVhhhwwSqTPVcl7QXNxoZNkT+Ds6MFO
 AHon52DbrAeS9OURcv+oHsZXBheX6BSGut2JHMZ3ocIPgSg/Cji/nlkrI
 V079Z/iKZ2LshAIuawMD2TGAbeVwIowSRDpx2WLWjjDvnypAK7Z0yYYpB
 JCtbpW46mAJv6jepSj9ycaIodfeRHWnpZJdUEJyOWX5LA2k/6oojHmhN2
 lTrA23zJDsydjKcPatVZNGZiY/7ZsWTFQ3v5u0gYazizCqYLacdbKRPWq
 b2MQUMrdBRJue6QRQt4m4M1mgozIJLDrhie6xp7HKwKUUBguQGzZO/Kvb Q==;
IronPort-SDR: Odtz9RtK4yukYFjLkl7PPCBAXAcQYRKgeiGfVWnvO4Btfsl+ZeIhicSJ3OrJfEwkFTWUtijMAP
 gXXY2OWGcEmrWRBN/CZbZJd8Ma0ZEekr8y4MRaCbWP99Y/QKhqaBFQolPoKetc3fpv3S5wJ+bB
 8Cf2iUjk5EjRW+5OB6YGzE9IAu8fhAF8lsM9nRZd8+1Bsqqb6817T0ZgnvQVA265We2uaF20B+
 tVObTrLV9m5MhAqVee5Rbjl5qYmL4FraOYxz2KsbBnuDyfpBKqOXmfOXWz6dYtUsKulyUATwJ9
 qZ8=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935142"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:06 +0800
IronPort-SDR: UXb1/ASlPfPPHstv3Tk3GT+kdTbkLEcq10ZQkC4eQsFmPBN1sntJkXq0PNg9UNJ33lzVeF9Pm4
 wR0F6HqOKrP4pRLB4oEJffI/oUOY96uSw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:10 -0700
IronPort-SDR: oacbIocZ4C1rRt/d5AjOi+jHqCXiVXYBwKJrxI1Y2JpdI9i3/LTVFOhvRzjRQM8jQQvhX+Kbke
 MNy5oH+WvOiA==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 06/14] riscv: Fix Stage2 SV32 page table walk
Date: Wed, 29 Apr 2020 11:28:48 -0700
Message-Id: <20200429182856.2588202-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

As-per RISC-V H-Extension v0.5 draft, the Stage2 SV32 page table has
12bits of VPN[1] and 10bits of VPN[0]. The additional 2bits in VPN[1]
is required to handle the 34bit intermediate physical address coming
from Stage1 SV32 page table. The 12bits of VPN[1] implies that Stage2
SV32 level-0 page table will be 16KB in size with total 4096 enteries
where each entry maps 4MB of memory (same as Stage1 SV32 page table).

The get_physical_address() function is broken for Stage2 SV32 level-0
page table because it incorrectly computes output physical address for
Stage2 SV32 level-0 page table entry.

The root cause of the issue is that get_physical_address() uses the
"widened" variable to compute level-0 physical address mapping which
changes level-0 mapping size (instead of 4MB). We should use the
"widened" variable only for computing index of Stage2 SV32 level-0
page table.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200330082724.120444-1-anup.patel@wdc.com
Message-Id: <20200330082724.120444-1-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 50e13a064f..bc80aa87cf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -559,12 +559,7 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            if (i == 0) {
-                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
-                             PGSHIFT;
-            } else {
-                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
-            }
+            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
-- 
2.26.2


