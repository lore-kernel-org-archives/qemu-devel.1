Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB64C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CCD206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n+aCLJKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCD206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtXY-0001yq-B5
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOm-0007xX-8O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtO6-0006ZL-Sz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtJz-00065w-Oq; Wed, 29 Apr 2020 16:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192123; x=1619728123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V4JMB03R57xU/l231U+ZmY2qS+gGKlGPiocloP9j6yI=;
 b=n+aCLJKiMmtxetjPc0ZlGod+lqQhXvR2wbxZkZ/KEHQiXOwDNPeHE6OR
 qtFH+0Lc8az0ykWvEtTmAHuHxZHT4vFdmLdNI9BFHTQ8RVNQ5OaOfIW4+
 3FFZ2orcGPKrty/lVJJo6yc7UxWskV8wrzk6nA/miCEy/aAt9t0u9MzkF
 WF5q8DNdkLIjMMz4sfhuIaL5Tg++sug/8U1vlYL2SThPR3TDkt3JaLqyC
 IktHY9lVmDhZfb+JkisU5H/vbPQkWGJYSWeUuys08IE59swRczL8cMnNL
 vQFh7dof497dLJIguIsbWCXOOUl7xduCP2jBzV0c51Kdkl3rrBn18SPIR g==;
IronPort-SDR: eQDWtC9AUmGJ+Ktyh4324E5Io0aTmg5cQahANnmOqKnIPm/caBdVH9aVjW13JxTZd0prMYmk+I
 WJClCOqW6XothpJOexRM+ODYrDNq4Qd7AqiZpb6S2adp3eu1aId3D9OZQQQubGkzC9UKpI5qi2
 ymYRnaDxbKzb7ZU5hbRE5TxAm0fQzR6gaiiu7UQYxIYg5zSUy7PlUuSzZGNrJYPgpdgr5QILhu
 bcLyG/z5nTr+gyowelA09wh7G7EMlkg1RTfqmVSVMAerEMIWx8bi3VhU+0Ru3j3wlfHnFG5rjp
 D84=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507035"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:38 +0800
IronPort-SDR: CeRKygex5l3tRKGpoVTJ/HpyKXe5KVGrN76WAEhMgXp4l5hU0YsRMKy9p74fM8x9AVk59JChUA
 LL52X7LIV6Azw7uZ2noEq/9DN4faDP3eY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:43 -0700
IronPort-SDR: sDB1xR12VpedGS0KGRXXFsa7kDST6+JO5JZ6D7vssW1rYxOyX7agMMNvEN1UYa/alHj40g8RF5
 ns7s0+s+RTzQ==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 05/14] riscv: AND stage-1 and stage-2 protection flags
Date: Wed, 29 Apr 2020 13:19:57 -0700
Message-Id: <20200429202006.775322-6-alistair.francis@wdc.com>
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


