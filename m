Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D90C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A982072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XF99wHMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A982072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrdt-0006O2-JX
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraB-0008KM-Jy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra9-0003UH-2B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra4-0003Ps-08; Wed, 29 Apr 2020 14:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185432; x=1619721432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V4JMB03R57xU/l231U+ZmY2qS+gGKlGPiocloP9j6yI=;
 b=XF99wHMhgFy1GmHhQTWWFEUPa8TH/Vz1/CvEnDGcZq4wDnzlNM6YInVS
 u234OMWd3IkWLrK13Kn5ZLeCDz7noPInu4kqB6dbH/q6doaQiGarZlNt9
 JLh0NR2Q/dmjOTBMwR96hUmr29bj0citxP2Wt64yUrtH83MDQMHErBekt
 4UQI4UMPcVI6ebcPtSfhTKBmKOA+gS+88qQbp0x1dTCw7X/uxsogLRpLZ
 EJe4zuNJnB/taoo3pQJ3PAX7hC3Nk74X6Wkd2mrs61cXe/2eNZLU0Hui3
 HNTI3a06ekJ0Nnf4uQwT0GC1oiwT5Wfr34iUzVvgByTVDMWR/DI6saJG9 g==;
IronPort-SDR: SfMcyCMQkKxBjHuYR6Acg08w8qIZMLWcsbgJSQBpXfMPEtk3bE6hNrpnVowOg9uDEV+vQ8M1nM
 hd5cKECxRi9917A6AaKypxGp2wx1Rkil8hr3Ivtn9ayW3iaa7y9qDHMf6PDSEXQ4ZgfZQhZXVy
 KudC48TxhD7v352M2tsQ5qKc8mU66p/UZzVcb0oRMj/QcBiBUzqSsNnU+Pf0R/0yZeiOvwdxtz
 Ag9KAKrJjDL13obt3Wsdlxmr2aj9Fclq+U5Ms6y6QzLUR7XBSzumALe6P6KeTx3C0vAQ5Gx+Td
 CWQ=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935140"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:05 +0800
IronPort-SDR: SgFEKWjHZ5FwDFTOdjRF/MKvSTsnfSrGgZiyuYYLbKfL99E5DKUOs31tt7i2nr/4UpfwJdgPcU
 c3k9GtoerLkjZdU/w7qXyN/pYIA1fhMOM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:09 -0700
IronPort-SDR: fETdQyidHjnMHYlUrkY61gFLkGOW8y0zGJIF4cSrpIpK1ArQaC7GFNiEBuxZpB9/jdGgVsWT7p
 06eSB16oKD4Q==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 05/14] riscv: AND stage-1 and stage-2 protection flags
Date: Wed, 29 Apr 2020 11:28:47 -0700
Message-Id: <20200429182856.2588202-6-alistair.francis@wdc.com>
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
Cc: qemu-riscv@nongnu.org, Anup Patel <anup@brainfault.org>,
 palmerdabbelt@google.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Take the result of stage-1 and stage-2 page table walks and AND the two
protection flags together. This way we require both to set permissions
instead of just stage-2.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Anup Patel <anup@brainfault.org>
Message-id: 846f1e18f5922d818bc464ec32c144ef314ec724.1585262586.git.alistair.francis@wdc.com
Message-Id: <846f1e18f5922d818bc464ec32c144ef314ec724.1585262586.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f36d184b7b..50e13a064f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -707,7 +707,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #ifndef CONFIG_USER_ONLY
     vaddr im_address;
     hwaddr pa = 0;
-    int prot;
+    int prot, prot2;
     bool pmp_violation = false;
     bool m_mode_two_stage = false;
     bool hs_mode_two_stage = false;
@@ -757,13 +757,15 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             /* Second stage lookup */
             im_address = pa;
 
-            ret = get_physical_address(env, &pa, &prot, im_address,
+            ret = get_physical_address(env, &pa, &prot2, im_address,
                                        access_type, mmu_idx, false, true);
 
             qemu_log_mask(CPU_LOG_MMU,
                     "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
                     TARGET_FMT_plx " prot %d\n",
-                    __func__, im_address, ret, pa, prot);
+                    __func__, im_address, ret, pa, prot2);
+
+            prot &= prot2;
 
             if (riscv_feature(env, RISCV_FEATURE_PMP) &&
                 (ret == TRANSLATE_SUCCESS) &&
-- 
2.26.2


