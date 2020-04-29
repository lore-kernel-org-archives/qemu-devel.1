Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C1C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970B5206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e7+4mPcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970B5206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtVG-0006ee-NG
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOl-0007x2-QU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtO6-0006U1-A5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtK0-00065g-7B; Wed, 29 Apr 2020 16:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192124; x=1619728124;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H3Rf0GK2uIFQ8+W/s2BSGxfdGYDmRN5HO2AJN6YT9+s=;
 b=e7+4mPczxfQGovmNkbmAE7VUaZjBpQVB+g2Qaj2P127+vluWB3xtKifo
 n3J98FlXcWCsy1qd95KtBeF5nvwdaRs8cLRb0SHmpwnpvPu2hFhRJqVcG
 OpnNyh0zWr9mFPn8S4Mu7scu2w6zCQFSwePmI4p93GugXSzFOh5hAB4p6
 PJF6hWhl4mhUKzosvAWrWmXlFR/NohDsCDleFGXahi3fmAPW9/EeYBLZM
 /Pq2QPOC2VFdb/6zmqE1MMrE24QmlCAsLP4xiLPTGpiM6OR6Rcn65o8Z5
 lxGPyJLszZdUAQiEkW3JlO61VCiFjF0BY45YxBlu+RCOfVXpYeJXoH5K4 A==;
IronPort-SDR: Cro0Yxt4SFVg0kF2lubYALtooFLnZp7FJg5MOpRIU8hNM95SPRNm59ELTuMJMvIDlc77yRXhrY
 9HvlvpvHaPU6gndhGbK+H79LtDl9/m9lMr4sYH3dCDh7LxU6jyxFbYZ3oOBs4utMvdCrm4GVzV
 M/WF8bT2d09zY5qkwTHh6yHhOipk00/mfQfnN3TKAtTgV+10aeblbpUFQLPpvE3iwrjJe3KJ4Q
 g8ENW8MOR26NMhKL6Z3ToRYHeGGdQXODiWqQKM3/Fhsj0enn5fdUlvP3TVtSOjXm/4b/i3PLgo
 ZYQ=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507036"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:39 +0800
IronPort-SDR: UepNfKPcrSlTDuZsyT17vn8dyd08okyl/eFVGUfVd/29ZEu6VWYcBVGyghe7rjrc2/zIihFypu
 W9vkF96Uhsoowu6styyoSz30u2mpiTVMU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:43 -0700
IronPort-SDR: 0m7svYeg0sHPm+HR/JlEkk0atHJohH655el0u6ai1ward+LaHsgzvV4+J99nbFJuo0GcTTQlGt
 nQCUc//vaKCw==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 06/14] riscv: Fix Stage2 SV32 page table walk
Date: Wed, 29 Apr 2020 13:19:58 -0700
Message-Id: <20200429202006.775322-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429202006.775322-1-alistair.francis@wdc.com>
References: <20200429202006.775322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 16:28:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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


