Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D321CC43465
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EF82100A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EF82100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi9I-0007VV-H5
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 15:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhry-0006Uc-BQ; Sat, 19 Sep 2020 14:45:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrv-0001T2-Me; Sat, 19 Sep 2020 14:45:57 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MumVX-1kb6Dm2kjr-00rnO7; Sat, 19 Sep 2020 20:45:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] disas/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:49 +0200
Message-Id: <20200919184451.2129349-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BTJflAAr8RmxrOXvUIfLapFUTFo5ADqXvPsdDBbVMnaqADDkUZt
 Giz8/eOIhhqkpS9LPQ6HpJMjI8axYHwQzuflWIvnVbyPCjFL4lASAdCdju1cgOttFbQQ7Xx
 L1Ne5fbMBP88aQCmi257gkS5fVKxcAUcMjTj5w66IxckMrOWJ+6EQpzqKWx07Nc1qX89aPf
 4f+VS/uvpQY4I+NZIzy2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GTZiQbERvRc=:VyDIi8XOob9YryTdpo506z
 gQyFqPQW91NLOBsk64CmKdjHo58n7eUQLOopbhQIGF6masMGvGg6BcCFbniUkj3cwCr/9LiiD
 tRiEbwWB/qNZ7jVtFKvknHmS48+kB0Szn5n9m7RiLTI0I/2uFrBCOpfGdP5pohFPbsXSDNga5
 Xplt9eNzya+hU6Gi9shCh9hm2FVGbKgxidr9KVKKW5Od87dpP7/51DVFCfiaRgwLJzuhiCul4
 lxx/PoGPIIO37YPgXa1vGWUyBooa2CXqZTodGMO5Ijcf7O5tFKVgya77f+vNkeOL+Ogvgc5K2
 Swb8ze9zMgayr4sQj92yuOH1SO0HpDHsfJRyxLLBnNxW9k7RpMjB4/hx0aheuU5jNHE2Gh5mH
 oOcWsx+gt966t40fFYiXwRA6fFV6Rn07UIDatm0cP1QFjACLUzsZad73fI3f27prwjKBKwNP4
 /L2cErwZLXsC9+/6Ymm1wfb3fgAo0yviKmZB/FAMtn/9H4WhCxIe6fBKfzHEc0D/mgyfXBHTf
 cctf170v8ZlbeTCxv9DlF9ONxasPM3pCo4yXIgZv2rUl6GRFwo/Ph5aXxmWQ2ucs7TaWSIu+u
 dA1R3CLOIh2kH1kbdTBRmH28LGkDT434/9feoqIhUm+bTqGWHIk2mHib3eVFjIBNEnZp0faae
 3o8ZqgU5iYZ2YEeDEh+Og0yRQD6HgZiczcQW/s1jZuQzWRlCVV9iSISZ0cVRp27ypFfpAHq1Y
 zPmiLFIUlrGmGUkebmIit3njOZXdN9T3MsWnJoDXJMNjPrUgPH7M7L/5p5dWoWLMpif+vTd6l
 dMpfPv5u3lD5E6e3D/lKIFeLmyK0fsXkNrcwI56iQBVVExX2f8Nz8tenFSRRAv08WdMKw2G
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the disas folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200917075029.313-9-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 disas/hppa.c | 2 +-
 disas/m68k.c | 8 ++++----
 disas/ppc.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 2dbd1fc4454e..dcf9a47f3489 100644
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
index 863409c67ccb..aefaecfbd6cb 100644
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
index 63e97cfe1da2..02be87819832 100644
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
2.26.2


