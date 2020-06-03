Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A9BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC5220829
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj5I7+RH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC5220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgcaZ-0004f2-ID
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 19:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgcZx-0004F7-2k
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:13:49 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:33607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgcZw-0007tw-5j
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:13:48 -0400
Received: by mail-qv1-xf41.google.com with SMTP id e20so2056414qvu.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hwP2B6uIAgMEYGoiG4eOPnhC1OBHVueuJUBIlZFOzVU=;
 b=Zj5I7+RHpWqcpmGDufhQVFJQvOp0bCgnNcxznW6Lts1Ta1o1rt/aKhZZgH9GvM14w6
 y2ukH/5cECF5nzvd2HvLb9G+ZL/3hdfpB3kWUAGNUolF+jd4M0ThhMCy0Zs5UEyyCurs
 fAJIufXaTa/2hUcQfyWeSohiyl8EiM7uIXQmhiyhshvTTOyCs/Fimqq4JLvE/pdXpALR
 zCvZhnAYNzsAWWHRzxavog2SpsMt03eU6VgcSnhQ+XB+bEcwgbaAeqi9ZrD4hAT7RAlG
 d+qxmYPK4LhZ9CeK67ScXhN7PrwW3gb5L0JUBGBVJFAvFvvmM3W+6OYLNseH8TO2ujUN
 mSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hwP2B6uIAgMEYGoiG4eOPnhC1OBHVueuJUBIlZFOzVU=;
 b=VZ8dG+pGVZzSJ4BUHQnDx+qy275tsuc9iFsns4DDKfBPRfPuYrPxwMgJdPj0Se+Hcq
 RZZVgv6zeEqpSVwvnRxIrAK3ZNipVj6T0IGDgEQf9+BNpPyFc8rNwvijU6mv96xpppKR
 PMhvggpGq9Nk7jOhQ5Kgs55G/H3lm2Eung3dKAx+EhFitFXGauYCsM6V6/IJs02i/AZ+
 nGAJLCxwx/KVB3Vt7EcUq6xBJyDekbDz3ALtdwbrUuASPOkDQF2gHGNRX7pfygr866+8
 TtBXcGBf/MtI1pkzPEejGe8aKiA4KaCaPJGCKP/5W2a5c28CBmoKKPp0kcui+/V6DZlT
 K/xA==
X-Gm-Message-State: AOAM530jEiOLHCxTLOQFPq658uIjiIV7WMaBO3O2t+yXev0PTznVsPJ+
 YpfeGhQiJDWeDVpSA7/q9kdLym3Fdjo=
X-Google-Smtp-Source: ABdhPJzbe3hPTFLeMGOwjFW9DodnZeDxir6PAkSzduRY+5sQv6lnghrs3VpfSWxaqMZR/9BIZS6JxA==
X-Received: by 2002:a0c:b516:: with SMTP id d22mr2247284qve.88.1591226026593; 
 Wed, 03 Jun 2020 16:13:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:3c90:1b60:f82d:3924:25c:6df5])
 by smtp.gmail.com with ESMTPSA id y54sm3390735qtj.28.2020.06.03.16.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 16:13:45 -0700 (PDT)
From: agrecascino123@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
Date: Wed,  3 Jun 2020 19:13:30 -0400
Message-Id: <20200603231330.5819-1-agrecascino123@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=agrecascino123@gmail.com; helo=mail-qv1-xf41.google.com
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
Cc: "Catherine A. Frederick" <mptcultist@floorchan.org>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Catherine A. Frederick" <mptcultist@floorchan.org>

Signed-off-by: Catherine A. Frederick <mptcultist@floorchan.org>
---
 tcg/ppc/tcg-target.inc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7da67086c6..3cab56fe91 100644
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
 
@@ -2610,21 +2614,27 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_shl_i32:
         if (const_args[2]) {
-            tcg_out_shli32(s, args[0], args[1], args[2]);
+            /* Limit shift immediate to prevent illegal instruction
+               from bitmask corruption */
+            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
         } else {
             tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_shr_i32:
         if (const_args[2]) {
-            tcg_out_shri32(s, args[0], args[1], args[2]);
+            /* Both use RLWINM, which has a 5 bit field for the
+               shift mask. */
+            tcg_out_shri32(s, args[0], args[1], args[2] & 31);
         } else {
             tcg_out32(s, SRW | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_sar_i32:
         if (const_args[2]) {
-            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2]));
+            /* SRAWI has a 5 bit sized field for the shift mask
+               as well. */
+            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2] & 31));
         } else {
             tcg_out32(s, SRAW | SAB(args[1], args[0], args[2]));
         }
@@ -2696,21 +2706,27 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_shl_i64:
         if (const_args[2]) {
-            tcg_out_shli64(s, args[0], args[1], args[2]);
+            /* Limit shift immediate to prevent illegal instruction from
+               from bitmask corruption */
+            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
         } else {
             tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_shr_i64:
         if (const_args[2]) {
-            tcg_out_shri64(s, args[0], args[1], args[2]);
+            /* Same applies here, as both RLDICL, and RLDICR have a
+               6 bit large mask for the shift value */
+            tcg_out_shri64(s, args[0], args[1], args[2] & 63);
         } else {
             tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_sar_i64:
         if (const_args[2]) {
-            int sh = SH(args[2] & 0x1f) | (((args[2] >> 5) & 1) << 1);
+            /* Same for SRADI, except there's no function
+               to call into. */
+            int sh = SH(((args[2] & 63) & 0x1f) | ((((args[2] & 63) >> 5) & 1) << 1));
             tcg_out32(s, SRADI | RA(args[0]) | RS(args[1]) | sh);
         } else {
             tcg_out32(s, SRAD | SAB(args[1], args[0], args[2]));
-- 
2.26.2


