Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0597206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0bz8qB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0597206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsWFZ-0002WC-4q
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEa-0000vj-FL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEY-0000fL-Sm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id d10so3650431pll.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qxipx9m0vKeP12B9CxfpMSMsmfVBM9RcOjG9qZgvzwg=;
 b=b0bz8qB12ZZi91OgFBDHu+nLsCehcBtofcgLpJz8Ob5PtCV70tOUllcYegKAEuv3Wp
 dRRx30v9FqmFIAWhF546BpMKXaX8fqqfJ6tY7g8r3YLMuVGAyZrsxx+/PL9O/3/Y7cKm
 3JyjQKWUFQiLfKRxxXOsw+qW2pTeL9A0fnOzB1BEfKp241LeptdTo3Bd0ZInTh5mlX6H
 zbyTa7Az64m6rJn1eHoM8kgTmavdWqrNWmrgulKbNXSjluNOxVzyfdlA1aLvPhp0jmXa
 T3llOE5s+avY9MPzBNSnqLks32vapxNfkuLEZ6R6G+b4hJE6McxKGlLwMThhdFdeFtnw
 8PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qxipx9m0vKeP12B9CxfpMSMsmfVBM9RcOjG9qZgvzwg=;
 b=f6DU90zQWGI26gmlCA6cq7g+bAflaoP9h+LKDqSkmwB1D1usGAS9m1nVmmZPmyYrsa
 ZPoUlvt7Nbg7/WubN0Okfq3ydvSPKyWPaE2QsesVkjL4WvFzsLSMq5BR1CrX408JE6EG
 mFC1rBZ6q0175TvVPnQAyH5osfT8QxunAvLap8svvq8k5Bej1nRDqZs/w7dEBIf6qhCZ
 X4UA1Gz5AG/biinIreoA/G0fAc5G4OaVFBl7x1nA9hzv5KdAwFxHkaNVipLO86lXwVIY
 /3zXy9CC65OFsKdu/mgqDhUD/njyAHGf0nTyP2m3qzBWp8YmYYxI08CfU9gdZbedNoTQ
 EFpw==
X-Gm-Message-State: AOAM533ZXPnCQw93A9+7H6H0LghYfFLx4Me8E+T6FYEMM1X0jX+mS04X
 +PmAq1XKbk/M4l2SZf/GhPgYPVXa2zI=
X-Google-Smtp-Source: ABdhPJz9R9l56rwNCYtlioBidRaxu4H6/SEZ9IjX00H/TMsks0cgMxeFW6ZDiKjPXeJcFf7UkYKiIQ==
X-Received: by 2002:a17:90a:222d:: with SMTP id
 c42mr616406pje.126.1594061573146; 
 Mon, 06 Jul 2020 11:52:53 -0700 (PDT)
Received: from localhost.localdomain (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id q6sm19988179pfg.76.2020.07.06.11.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 11:52:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] tcg/ppc: Sanitize immediate shifts
Date: Mon,  6 Jul 2020 11:52:47 -0700
Message-Id: <20200706185248.118447-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706185248.118447-1-richard.henderson@linaro.org>
References: <20200706185248.118447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, "Catherine A. Frederick" <chocola@animebitch.es>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Catherine A. Frederick" <chocola@animebitch.es>

Sanitize shift constants so that shift operations with
large constants don't generate invalid instructions.

Signed-off-by: Catherine A. Frederick <chocola@animebitch.es>
Message-Id: <20200607211100.22858-1-agrecascino123@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7da67086c6..c8d1e765d9 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2610,21 +2610,24 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_shl_i32:
         if (const_args[2]) {
-            tcg_out_shli32(s, args[0], args[1], args[2]);
+            /* Limit immediate shift count lest we create an illegal insn.  */
+            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
         } else {
             tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_shr_i32:
         if (const_args[2]) {
-            tcg_out_shri32(s, args[0], args[1], args[2]);
+            /* Limit immediate shift count lest we create an illegal insn.  */
+            tcg_out_shri32(s, args[0], args[1], args[2] & 31);
         } else {
             tcg_out32(s, SRW | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_sar_i32:
         if (const_args[2]) {
-            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2]));
+            /* Limit immediate shift count lest we create an illegal insn.  */
+            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2] & 31));
         } else {
             tcg_out32(s, SRAW | SAB(args[1], args[0], args[2]));
         }
@@ -2696,14 +2699,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_shl_i64:
         if (const_args[2]) {
-            tcg_out_shli64(s, args[0], args[1], args[2]);
+            /* Limit immediate shift count lest we create an illegal insn.  */
+            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
         } else {
             tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
         }
         break;
     case INDEX_op_shr_i64:
         if (const_args[2]) {
-            tcg_out_shri64(s, args[0], args[1], args[2]);
+            /* Limit immediate shift count lest we create an illegal insn.  */
+            tcg_out_shri64(s, args[0], args[1], args[2] & 63);
         } else {
             tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
         }
-- 
2.25.1


