Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A16C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28A920767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7YtAW7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28A920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofS7-0006SS-6N
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6N-0000mA-9G
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:31 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6L-00021M-QI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:30 -0400
Received: by mail-pl1-x644.google.com with SMTP id k1so3764549pls.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9LzeT+j4mcl6UlyhLk8GVYAGtKomNKvCxMaED/b1Hos=;
 b=J7YtAW7qF1VsEZExvvp5jN4ZlYHBPiPrxFQ+gaFm+Q2HhsfAL7+wZwigQJNwUTMYcm
 mjiokOTpyq4Sj7FOtl74sj899oPzQkpvy2RyvO8UPr+1f8X0+9hRelggShosBFYMIzHu
 fzKi3aPDpCTARVWIzhGQUloxQOlQIuVN1CLdoblJRyGkK5I/VEVmo0qrMSkTcWeF8crm
 HiJ0w+vfI1s47JCFCx9pvYGGbULimZwQqj0c9+66H/FgJg5Te/+raV3WoTK0Lv+3eQra
 82A56vtKW/68GO5LEwy8Q+ZFPtvDn4FHp9FAvYdQgkn7aEIXbrdqKamhWS0z3/qWo0nS
 ylXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9LzeT+j4mcl6UlyhLk8GVYAGtKomNKvCxMaED/b1Hos=;
 b=dDTTOTH7FnVu8tL1teB0VJKlDUGk/JLAtFZz/QlNZkPqKhwNxRiENaxF7cNUlpUByD
 JxcPcMAXvy5Z90FEcLYG8zLWA7Si+XuBrsdINMZ0bSnehddjOrjLR1XYiU0kCqTJZ2aw
 u4tdVFrcJLQ64xwSsEAg8wIpEynJw/JLzl1q9r59g2wIQGZKxM29qZY/QeX25k+LS54T
 CBHlcJKGOhCiqdDWvdvClg/OOpcwUYZUk2pOndy6oRlWHMY9g8AdpMbtwWcS0mRYu73b
 obu0DqAYrXqJjo2vE/+9H9GJWrF+fE22bIVgYyrcI8srGzepiiee2T7DDebeNJeQmjl7
 QzvA==
X-Gm-Message-State: AOAM531nGxir5WQnR4V0zOAITFrvPIXesOuVw+mKH0Cuj3giQfY9QujM
 +1FRwu3JoMBJXLmhJ7TLc0scLIUB3Co=
X-Google-Smtp-Source: ABdhPJw+CotNJ7DX/3O/qm8Uo1VZSqN/X52NF85N2TfvwifGGwHm2BKSKNjpZJdIT3jOLMkJ3h4a4w==
X-Received: by 2002:a17:902:7208:: with SMTP id
 ba8mr876083plb.217.1593142348217; 
 Thu, 25 Jun 2020 20:32:28 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 31/46] target/arm: Tidy trans_LD1R_zpri
Date: Thu, 25 Jun 2020 20:31:29 -0700
Message-Id: <20200626033144.790098-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the variable declarations to the top of the function,
but do not create a new label before sve_access_check.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v8: Split out from previous patch (pmm).
---
 target/arm/translate-sve.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4fa521989d..a3a0b98fbc 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4883,17 +4883,19 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
 /* Load and broadcast element.  */
 static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    if (!sve_access_check(s)) {
-        return true;
-    }
-
     unsigned vsz = vec_full_reg_size(s);
     unsigned psz = pred_full_reg_size(s);
     unsigned esz = dtype_esz[a->dtype];
     unsigned msz = dtype_msz(a->dtype);
-    TCGLabel *over = gen_new_label();
+    TCGLabel *over;
     TCGv_i64 temp, clean_addr;
 
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    over = gen_new_label();
+
     /* If the guarding predicate has no bits set, no load occurs.  */
     if (psz <= 8) {
         /* Reduce the pred_esz_masks value simply to reduce the
-- 
2.25.1


