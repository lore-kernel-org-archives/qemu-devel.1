Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F26C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA20920738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae+NWKiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA20920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgf2s-0006gR-0D
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 21:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgf21-0006FQ-I6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:50:57 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgf1z-0004kE-V0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:50:57 -0400
Received: by mail-qk1-x742.google.com with SMTP id v79so4473848qkb.10
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rGE0s6wPpiv3V360U0lLWlWSvw08ZPmcpzSrbnwG/Fg=;
 b=Ae+NWKiHDu/uEAKrOgRWnGPQrDaWYSTqZDYs6UOQwPZhB49RTXBJG3PfSusetr7fSW
 p55adj5TJp75kSv9D5+S/Xybq1JH0jm2xxCJVEkaEpILxSJPK4kf1seUZHntk7G8VNTM
 jqAcROQc5sA4uytZ3LGzBP8T51DkbI8Vt8dRPydFFxUd06P5nAG53NNEEXqoBScXioWC
 QeTBWg250MIL/dHZZm7DeLxFZhX38zT0VuRgW3CwsTnoIcmrCNbzxYmcb8gU4W472EJw
 sAbGbj+AULgOshUcjVylnhMuOq8MdaR9B3wt7nVtvtysvLjgXBN8tnAol6CyN1zePSiZ
 A15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rGE0s6wPpiv3V360U0lLWlWSvw08ZPmcpzSrbnwG/Fg=;
 b=CxDbsSHKwesOJIY535H2uNWYdNDJx1UGjWaUZvx/lRuLQu0rZrNUIDy/oRorI14t3O
 p4W01AgimNhuJTXDOSuM8NcSsIClGOTroY1XMY2PZacEIHcsqKiVSDjkbG2jP/xaB1K2
 fEotGD1S1MBEhkqCa7Oeyl860Bbw59FMAHymw2J0WrhzwZXybBHxCnWCI0zDDnGlY1q7
 RXna8mWohhUpYh+5RgHb6P+70anr/UIUp0YyBu6HoZX19rqrcKGjdkJ2SyvO+G68E2HE
 Rj4O8/ieWIXPLqvpbDl9eiLzvEur3uOIdteZJkWxMJaVEQKX4f65GyL8ULzGM9WtcR8c
 0VKA==
X-Gm-Message-State: AOAM532NW/De4p7gWsahmyiuaKBSwwyYzW9X0ORzW9PEvp6YKQXpqLOI
 hzOfXN3p2JylVVUAJYPUpBa2rQ4oNkQ=
X-Google-Smtp-Source: ABdhPJysUgkbm+Dx9Rt3OopQPsYs8IleLv3FfUoKQ3PT85Dh3K4VZSpJMxsCElxq91ZMhksmxlfhtA==
X-Received: by 2002:a37:688c:: with SMTP id d134mr2685524qkc.492.1591235454406; 
 Wed, 03 Jun 2020 18:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:3c90:1b60:f82d:3924:25c:6df5])
 by smtp.gmail.com with ESMTPSA id l188sm3009805qke.127.2020.06.03.18.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 18:50:53 -0700 (PDT)
From: agrecascino123@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v4] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
Date: Wed,  3 Jun 2020 21:50:27 -0400
Message-Id: <20200604015027.8075-1-agrecascino123@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=agrecascino123@gmail.com; helo=mail-qk1-x742.google.com
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
This should finally do it, sorry for the style issues on v3.

 tcg/ppc/tcg-target.inc.c | 41 ++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7da67086c6..5ed4e4c011 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -790,21 +790,25 @@ static inline void tcg_out_ext32u(TCGContext *s, TCGReg dst, TCGReg src)
 
 static inline void tcg_out_shli32(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    tcg_debug_assert((c < 32) && (c >= 0));
     tcg_out_rlw(s, RLWINM, dst, src, c, 0, 31 - c);
 }
 
 static inline void tcg_out_shli64(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    tcg_debug_assert((c < 64) && (c >= 0));
     tcg_out_rld(s, RLDICR, dst, src, c, 63 - c);
 }
 
 static inline void tcg_out_shri32(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    tcg_debug_assert((c < 32) && (c >= 0));
     tcg_out_rlw(s, RLWINM, dst, src, 32 - c, c, 31);
 }
 
 static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    tcg_debug_assert((c < 64) && (c >= 0));
     tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
 }
 
@@ -2610,21 +2614,33 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
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
@@ -2696,21 +2712,34 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
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
-            int sh = SH(args[2] & 0x1f) | (((args[2] >> 5) & 1) << 1);
+            /*
+             * Same for SRADI, except there's no function
+             * to call into.
+             */
+            int sh = SH(((args[2] & 63) & 0x1f)
+                        | ((((args[2] & 63) >> 5) & 1) << 1));
             tcg_out32(s, SRADI | RA(args[0]) | RS(args[1]) | sh);
         } else {
             tcg_out32(s, SRAD | SAB(args[1], args[0], args[2]));
-- 
2.26.2


