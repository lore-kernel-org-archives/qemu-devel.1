Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE93DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780F720724
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F413loeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780F720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MbF-0008Tw-Lv
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 02:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRJ-00024z-CN
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRG-0000Cq-Vb
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075499; x=1629611499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HFomMPFVynBzSUqMvkaxLSCrmIDsz6VmLxR+HSai9LA=;
 b=F413loeTmWCQRHMkvtcgmOdh7+3xqLGHqwiJmnbTAMzylPAjy8OMclvL
 zRocoUCivQ92DqmpcYWdYvwq4a0ge/4zCZZ6DInW58jjtVZDEZpsI4Wl0
 YK//RzijKzaEuc2FVFzD29hyWhNIEjta3vF0YFQOz30bl9uVc1g2GKm/T
 LKdmmhU/MiluZFZny1Fh6sbl9CF5so2dFlGfFruAPybB9SOeko05QvxnQ
 +RvomOVNhpjoprh21bCVcmE6S/692XuEZ7N/dXA000FCpvahuJ7SfCu38
 S99dgINMo+HsQ2TyJZM+EhDTbNUFRkOQbKKEtRYh3T4qa4rrTW70pZE5V A==;
IronPort-SDR: 9gxeBV4jvAMKrG5rjPMIlNM5hrAqyDwAQ5B/eHYbi9cIBoWmZPO+tLsstK/2Pi3WIjRXvSlCTs
 pvAkvJEOnToOrOhv/t9U1esSlJyP52G7X7unfA5Z97fc7FCRdEzkrydQtTZSBINVyOen4NcjGJ
 APDA+OPc3OftXN9PCF7q+7C121W3dA6TuK+VEmcP4NXR1pqiKaNxH3DfOncGfkTEHVNo/AXEy8
 kxFpeCp+9MeI/S+N5Cf6zP5jAGW89bjOhGeRoPIV9Cmt2KmVYD1GYLg2SLWl8uQq0LDXA2Bg8m
 G/I=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571969"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:21 +0800
IronPort-SDR: ptzJKBD5dr/afPduETN/m2kEIaCHf3BXKLigITpUQAoMK1sNCY8PurkbhRVzVoRFqFF0TYco0T
 G11Baq11enQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:39:01 -0700
IronPort-SDR: 6CE1K7uxQXjGCxqzV3GCpnl++T7ZtqGRni61XFLBFTiBly0bcXh1OGqFMmru3IsXHTrqnJdPt5
 8GruCCpkvOcw==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 16/20] target/riscv: Fix the translation of physical address
Date: Fri, 21 Aug 2020 22:40:57 -0700
Message-Id: <20200822054101.1202175-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com,
 Zong Li <zong.li@sifive.com>
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
2.28.0


