Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC973C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F5F20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eqp9KWGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F5F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbPp-0005AF-St
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3472fa30f=alistair.francis@wdc.com>)
 id 1jHbLn-0001Dy-S9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3472fa30f=alistair.francis@wdc.com>)
 id 1jHbLm-0001Mo-PX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:51:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3472fa30f=alistair.francis@wdc.com>)
 id 1jHbLm-0001L2-GS; Thu, 26 Mar 2020 18:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585263122; x=1616799122;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nu1k2YInD1z4OmhzuT9vF/dekBAG0pZjrUjpjyIB2mY=;
 b=Eqp9KWGJuBYNvSAd8Hce5eDGIPcINlnwpiwTESaVSv29HHVxd6ASJTxe
 gWtrK6mYtrsA1ge+ArAok5IbDBQdePBa8RJTOyjgMH8euSITm+RYM3AYM
 J03cZ+h5cQQKB3pukFnmZM2WhZiWubE1NrK9P9eSbW/WcRW8PBFM8Y8QD
 RChidVIdfsqdYRhhsGL1Fa0cn+JJThqsfo9JNoE0lVR1FDOY8d9dZAU4J
 1IL0lnwxd2a/POM0sFmDuUHNIuusZQKIbmMbFL+X5nMluLLQh4Xzzf2Bf
 vNyIE5eu2NauyGclfSy6VTv/nR9vIZhKUXbKtEPLHxKw7UoZWqP02hncx g==;
IronPort-SDR: Zd6M6TVWNoaTEOz+zH+ZPgbocRJFqeyy3KIbJgddv0EjODR9tCMBEN8dgXkBoi4gjm643470jH
 cWsG0DykkBKRwW/2l4psMyIozvYv8fdTONB6rSx1Kf5E9ZtFLgOCKgYJc0nG7zHYBHis3JDu52
 hCUjUZykdy8GOOGfw+PyQ70u4PGkZi3uKfZH7vb26qLD6fI+adfNldx+GVRosho8xNoLse0QSB
 q3BiZL4rY/5MqOTaTDIyntortfQRIgeGXjIA8EMiK5lbilG/OZPtP1qSFU5Sh6/kj2PVERduUo
 CyU=
X-IronPort-AV: E=Sophos;i="5.72,310,1580745600"; d="scan'208";a="235858180"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2020 06:52:01 +0800
IronPort-SDR: Gl8/aWlWVWvUq5YR6iPwTzWhM6y6Q1iQy/emjgdRNi7P73uTLivSPWfJNL3iuDINdmEvFF07Fh
 6fDB/bGhrn5HrfMLPAFWP7A8BFETFiDaCz85FAgWB0ABtJRii01IAOXFjwfz2aJr95hBgwze2Y
 evHno/l4F/tIjb+7hKmCJcEdapOYkQo3P5bNEduB5iHp50rshD1KHfDlppJZSRVfdeMjfU6fta
 09s2bziHxHXfk6WophjSQaji9/G+/4XIsPeq+bSSpYrqzQU62Ia86BkWDtjmD7cSY4JsPdTV1T
 uTarp3oirRjBa2WCW0+punhL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 15:42:47 -0700
IronPort-SDR: ys1GDTncR0JUslY5A5g6yJhRUHtj0+XpIwuJZI9ypaIYkGFHOGdV8BVhBKKJS5nqiC3XHUcXy0
 9ffQCn/ljgGeHdMjsuO+LhC2vZltnb/Y+gW8K4nyzWzVY5/rAXf9STHWb9qRDXqEL4DHLE03EJ
 TSCCTw0chhkIJM3xvKQoFO2k0w2pyZOvhWda8VJBbqewntvzEW/6UxSMG2uglW+Q29c3nnQNdu
 YPYKZOsEvgmo/iKSBsHabU3ofWbLbry4MiLKSqRl9BiahRum1oTHyHAAK03gX1iKQTkKKfIpBt
 ULg=
WDCIronportException: Internal
Received: from 2j0d3g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.54.250])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Mar 2020 15:51:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH for 5.0 v1 2/2] riscv: AND stage-1 and stage-2 protection flags
Date: Thu, 26 Mar 2020 15:44:09 -0700
Message-Id: <846f1e18f5922d818bc464ec32c144ef314ec724.1585262586.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585262586.git.alistair.francis@wdc.com>
References: <cover.1585262586.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Take the result of stage-1 and stage-2 page table walks and AND the two
protection flags together. This way we require both to set permissions
instead of just stage-2.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.26.0


