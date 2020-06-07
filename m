Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4050C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 21:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765592067B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 21:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGzwlNnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765592067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji2aF-0001mN-Mp
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 17:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1ji2ZU-0001L7-RH
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 17:11:12 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1ji2ZS-0005UZ-PZ
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 17:11:12 -0400
Received: by mail-qt1-x844.google.com with SMTP id g18so13145752qtu.13
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KHf+Vmi8xc/vMhM+B7yEwcWlFM+npGXMYwLWVfs1t7Q=;
 b=iGzwlNnPJUpGogtMzBc1MR8Y8s2Kc3il/wUr4AzWTh9x8oKjhYr5hCHnFKMxFOKzKS
 P+Fd9ppYiawzVtpYhdkPDOKtkUjbgg5AOC8AGwhP84ZJGAAtrDDsYBBr57Xbb05VdI4O
 4wB/JRVWme7YsDzg4EXZJOfR5ZampqAvXgFkU18mlwyfmAzw8ou3RbmrVtgTbdGV7wgl
 byYo1Gw/AQO56K3Gep1ScvilmNwLdPgczFTAOSGtzhKBg13Hu7nuYyDviULW5gMi49eV
 deXIEDuGByIiEEm3B5b9bkrz+wmtlQf/ZYtkJr8SP7kYLFX6TDH1KTwYGhCLbg1kdGWE
 JvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KHf+Vmi8xc/vMhM+B7yEwcWlFM+npGXMYwLWVfs1t7Q=;
 b=WTleyd+Xge9ptFQwYab4b+DANUgtLAKYAN886rpKP1iLT+0B+jUqT7n+bHD4h15vnX
 j19Hcco9Gbt9j3yS699S6uYP0hor5t5ePQ40A5fLEzLrH9QGtACpjNjIvVsL28R17vHb
 FbGMBzQ/eZw/4JT5FUemqbVrXYKy9+oKQ1jj4i4ZA2ZrGUE3UNsTdvwSXoegEUFMjHR5
 78tHuqRKY9lkEAzbyuyWUFea6mCduFJdSkqAE2sA52SeSXMyfy9y1QU+OJndIk0BTqCG
 0rdZe9sTp3ub2ce4keso6I3EZ2+NsG9WDDdjDH/lLJhsPxAA42ygFwPrgPDmC+JW8qDJ
 XrTQ==
X-Gm-Message-State: AOAM530JgImBjI8HpyM6RJ47IkRZ5hZzsw+SVKrZ7RucIh5HrwhU+DTN
 CiwQL2gsaHDXisfe+X7bUiH11dsT
X-Google-Smtp-Source: ABdhPJxiDC7zw4F/j7itnGxnqCRRX4aoCqSCtCsM1SQFljg4eHeS0WcszQwxxZUbUcI+PDa4dz48Gw==
X-Received: by 2002:ac8:dd:: with SMTP id d29mr20890944qtg.392.1591564267860; 
 Sun, 07 Jun 2020 14:11:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:1700:3c90:1b60:40e2:cfda:b7a4:16f3])
 by smtp.gmail.com with ESMTPSA id p16sm5337599qkg.63.2020.06.07.14.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2020 14:11:06 -0700 (PDT)
From: agrecascino123@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v5] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
Date: Sun,  7 Jun 2020 17:10:59 -0400
Message-Id: <20200607211100.22858-1-agrecascino123@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=agrecascino123@gmail.com; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Catherine A. Frederick" <chocola@animebitch.es>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Catherine A. Frederick" <chocola@animebitch.es>

Signed-off-by: Catherine A. Frederick <chocola@animebitch.es>
---
Okay, I removed the bad "fix" on sar_i64, and the asserts in the various functions. 
Crossing my fingers here.

 tcg/ppc/tcg-target.inc.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7da67086c6..5cb1556912 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2610,21 +2610,33 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_shl_i32:
         if (const_args[2]) {
-            tcg_out_shli32(s, args[0], args[1], args[2]);
+            /*
+             * Limit shift immediate to prevent illegal instruction
+             * from bitmask corruption
+             */
+            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
         } else {
             tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_shr_i32:
         if (const_args[2]) {
-            tcg_out_shri32(s, args[0], args[1], args[2]);
+            /*
+             * Both use RLWINM, which has a 5 bit field for the
+             * shift mask.
+             */
+            tcg_out_shri32(s, args[0], args[1], args[2] & 31);
         } else {
             tcg_out32(s, SRW | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_sar_i32:
         if (const_args[2]) {
-            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2]));
+            /*
+             * SRAWI has a 5 bit sized field for the shift mask
+             * as well.
+             */
+            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2] & 31));
         } else {
             tcg_out32(s, SRAW | SAB(args[1], args[0], args[2]));
         }
@@ -2696,20 +2708,32 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_shl_i64:
         if (const_args[2]) {
-            tcg_out_shli64(s, args[0], args[1], args[2]);
+            /*
+             * Limit shift immediate to prevent illegal instruction from
+             * from bitmask corruption
+             */
+            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
         } else {
             tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_shr_i64:
         if (const_args[2]) {
-            tcg_out_shri64(s, args[0], args[1], args[2]);
+            /*
+             * Same applies here, as both RLDICL, and RLDICR have a
+             * 6 bit large mask for the shift value
+             */
+            tcg_out_shri64(s, args[0], args[1], args[2] & 63);
         } else {
             tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_sar_i64:
         if (const_args[2]) {
+            /*
+             * Already done here, as it's a split field, and
+             * somebody noticed it would have overflowed.
+             */
             int sh = SH(args[2] & 0x1f) | (((args[2] >> 5) & 1) << 1);
             tcg_out32(s, SRADI | RA(args[0]) | RS(args[1]) | sh);
         } else {
-- 
2.26.2


