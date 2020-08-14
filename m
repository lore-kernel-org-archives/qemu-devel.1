Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD2C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8AC420866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q+V22kMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AC420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bV0-0003mI-So
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQU-0003hq-0H
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQQ-0007f7-MI
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418122; x=1628954122;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cq3JJ2MpSltXdXGTDk4g6h8slBE4eUBzmWJR3+MONy4=;
 b=Q+V22kMizGVQdYJYKjcN/9BEQXOIuYAMZm//s8j211w4c15UmXwylD2W
 HKk3FY+9wTUnp4flKppMAv/I2ZAQ0YXPmPoaU5LTizZ09KAlFzoxPz/r5
 okqdk39Rr25v91bqj29EmMmMCbUHDalyfUSDYmhg94dqNPtq9KjSFZhIU
 8I+1afE5H++MAfcZywEfTwRdrY6wRg3EZLZw7roQleHl1R5yO/0/dTaxa
 tFy+LOFgckLWlaJPvu3RrHkgfMvbcVdo8LAIwdhyZ/76RihF9SIkHsJSL
 Hk4mkPfST1K31G4WbOkurgRNiCbWJlLNng5EPkwTe+X2dPsYouRBkqEYz g==;
IronPort-SDR: qXASkT2yfI5THj3q8+Cz3Ae3qw0x6OwwISQoJ5mB942A4/zyW7LIGFnVrXXKvfvXPSsZZhAJtB
 yxiRHS+CZRmTTBEsnarFhInirrnVAU062k6TFYCnpuWf2LGDu5ACoqh0hf4JJgbnjIZjlGeJ49
 JgJIKJbQ+8ewyPkNVE3lJUfgojH8Eqb7O9O8MY6moHW7B+eFA/wOCc5b+5z4bIv0SHiY3LcKvR
 6xnnlG+JIVWHLHgYAby/CcP3SLc/1B1I4+TvSlEVU5OyxP72hRmzyoRKlRq+gn3TkwqL0mO1UB
 gpM=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="254369413"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:15 +0800
IronPort-SDR: GDoPO4L5PiZ+AftC2UGcdzPeV42jwx6R0mbGGhi8M+yDD4fdbx5g+gZUxbUQR3jiQ3OlR5AKSe
 ehxwfPFeZ/mQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:21 -0700
IronPort-SDR: hUkl20Fq3LASW33aKLJ4k83uiiwwosZX2F3gAJhADQp9a1g1YsOY1+OO/GwcVi01ovFI9/f54Z
 AwUd6gt6Wr7A==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/20] target/riscv: Fix the translation of physical address
Date: Fri, 14 Aug 2020 08:05:02 -0700
Message-Id: <20200814150506.2070566-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:16
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


