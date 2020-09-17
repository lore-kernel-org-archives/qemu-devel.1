Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65C820770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65C820770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIl6O-0002g0-Pz
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 00:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIl2R-0004h9-4f; Wed, 16 Sep 2020 23:56:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4706 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIl2O-0000Ua-Jc; Wed, 16 Sep 2020 23:56:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 77EC5D3B1E63DD802CA3;
 Thu, 17 Sep 2020 11:56:42 +0800 (CST)
Received: from localhost (10.174.187.87) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:56:33 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 08/10] disas/: fix some comment spelling errors
Date: Thu, 17 Sep 2020 11:54:11 +0800
Message-ID: <20200917035413.701-9-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200917035413.701-1-zhaolichang@huawei.com>
References: <20200917035413.701-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.87]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:20:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the disas folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 disas/hppa.c | 2 +-
 disas/m68k.c | 8 ++++----
 disas/ppc.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 2dbd1fc445..dcf9a47f34 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -2021,7 +2021,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 			fput_fp_reg (GET_FIELD (insn, 6, 10), info);
 		      break;
 
-		      /* 'fA' will not generate a space before the regsiter
+		      /* 'fA' will not generate a space before the register
 			 name.  Normally that is fine.  Except that it
 			 causes problems with xmpyu which has no FP format
 			 completer.  */
diff --git a/disas/m68k.c b/disas/m68k.c
index 863409c67c..aefaecfbd6 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -70,7 +70,7 @@ struct floatformat
   unsigned int exp_start;
   unsigned int exp_len;
   /* Bias added to a "true" exponent to form the biased exponent.  It
-     is intentionally signed as, otherwize, -exp_bias can turn into a
+     is intentionally signed as, otherwise, -exp_bias can turn into a
      very large number (e.g., given the exp_bias of 0x3fff and a 64
      bit long, the equation (long)(1 - exp_bias) evaluates to
      4294950914) instead of -16382).  */
@@ -479,7 +479,7 @@ struct m68k_opcode_alias
       and remaining 3 bits of register shifted 9 bits in first word.
       Indicate upper/lower in 1 bit shifted 7 bits in second word.
       Use with `R' or `u' format.
-   n  `m' withouth upper/lower indication. (For M[S]ACx; 4 bits split
+   n  `m' without upper/lower indication. (For M[S]ACx; 4 bits split
       with MSB shifted 6 bits in first word and remaining 3 bits of
       register shifted 9 bits in first word.  No upper/lower
       indication is done.)  Use with `R' or `u' format.
@@ -854,7 +854,7 @@ fetch_arg (unsigned char *buffer,
 
 /* Check if an EA is valid for a particular code.  This is required
    for the EMAC instructions since the type of source address determines
-   if it is a EMAC-load instruciton if the EA is mode 2-5, otherwise it
+   if it is a EMAC-load instruction if the EA is mode 2-5, otherwise it
    is a non-load EMAC instruction and the bits mean register Ry.
    A similar case exists for the movem instructions where the register
    mask is interpreted differently for different EAs.  */
@@ -1080,7 +1080,7 @@ print_indexed (int basereg,
 
 /* Returns number of bytes "eaten" by the operand, or
    return -1 if an invalid operand was found, or -2 if
-   an opcode tabe error was found.
+   an opcode table error was found.
    ADDR is the pc for this arg to be relative to.  */
 
 static int
diff --git a/disas/ppc.c b/disas/ppc.c
index 63e97cfe1d..02be878198 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -5226,7 +5226,7 @@ operand_value_powerpc (const struct powerpc_operand *operand,
       if ((operand->flags & PPC_OPERAND_SIGNED) != 0)
 	{
 	  /* BITM is always some number of zeros followed by some
-	     number of ones, followed by some numer of zeros.  */
+	     number of ones, followed by some number of zeros.  */
 	  unsigned long top = operand->bitm;
 	  /* top & -top gives the rightmost 1 bit, so this
 	     fills in any trailing zeros.  */
-- 
2.26.2.windows.1


