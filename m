Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED76C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AC120850
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVF3cbws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AC120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2IJO-0004u0-Sx
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2IGP-00031t-OQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2IGN-0004XC-T6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:54:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2IGN-0004W4-Nb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:54:39 -0400
Received: by mail-pl1-x644.google.com with SMTP id go14so10306072plb.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QBEV8mWos3eCOzNz0nMHx0iaJDhUfFvNFqhxEXTwuFQ=;
 b=GVF3cbwsj1YjsBVHVR/i5Fze9wS8ZiH/ipCMKni9MYkj7XCTF+t79idopSzvcQ5qi9
 qgJP4cyxjsiWO+sDJ1akGXB769RUNXA34t2/r+Z9Bs4r1PzQ1WDADuZ+5n7JS6DlUOwj
 8MS2eDLnRoGal6ER5bH4p/njEeAVA8YHuWT8ugFtWY07obO9X4MaUUz70ki0SkkaLNFo
 OMhXb6Tg/wrbVjg20T2x0RKeDC+ppzRB+dsHkJEb50sBD8YwxFrjYNQacNsq3BMqniKd
 h7RLcNq5gehlJ8hS0rz7KKMkeQ1qt8VKI/XDseh26udpbPK3yJ/pNL6CqhtMSmVvjjR7
 ytuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QBEV8mWos3eCOzNz0nMHx0iaJDhUfFvNFqhxEXTwuFQ=;
 b=MNUW0E5E5KBXIuWQLnGxQwlDgz2Ypi6RE8A/qOcmxLLLjpADQTRi00w5PUM8y6Bj7Q
 YEOVLs9Lqm6RRjCxiTn6jLftXOz3YcfsUl7Oam+nNFud0wR7KR48pAGMnByMfApOfD9u
 OBM3wimq6bAvlDGh1lc1K5/TpSXlFbhWiwkN3t5i/5HrBSdZektuePYqHu/ibxz9ftj6
 bwd65ZTfPbfUTWmiqLdjgbImBb+bSGgatlvndfgRUrIp32C8LAsswjqrFchSnsJOeSgY
 zWWXxm8JninuMpq19EXkwXl48ya+rzfKLdzRuPysEY8GKNyS2saaotbYNYNp+oi4uiix
 Pp7w==
X-Gm-Message-State: APjAAAX7vlSuPJkE3OwGw8sYjLLlkmxPBCTtJLX4kh1LqFwqNJ6/M7tF
 46ugPuzaD1On2XA5DOsMp7TK6UkwYQU=
X-Google-Smtp-Source: APXvYqxOLdFgkKH8TKuyNsyOeqH/t9OCf1Qs0oG+6Ho3laGfq3lpN5OZx5UsxAUKwPAotukA3Y2eCg==
X-Received: by 2002:a17:902:524:: with SMTP id
 33mr20236875plf.27.1566838477930; 
 Mon, 26 Aug 2019 09:54:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q8sm551374pje.2.2019.08.26.09.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 09:54:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 09:54:34 -0700
Message-Id: <20190826165434.18403-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826165434.18403-1-richard.henderson@linaro.org>
References: <20190826165434.18403-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 1/1] target/ppc: Fix do_float_check_status vs
 inexact
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
Cc: qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The underflow and inexact exceptions are not mutually exclusive.
Check for both of them.  Tidy the reset of FPSCR[FI].

Fixes: https://bugs.launchpad.net/bugs/1841442
Reported-by: Paul Clarke <pc@us.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 07bc9051b0..2e023c5204 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -630,19 +630,15 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
 {
     CPUState *cs = env_cpu(env);
     int status = get_float_exception_flags(&env->fp_status);
-    bool inexact_happened = false;
 
     if (status & float_flag_overflow) {
         float_overflow_excp(env);
     } else if (status & float_flag_underflow) {
         float_underflow_excp(env);
-    } else if (status & float_flag_inexact) {
-        float_inexact_excp(env);
-        inexact_happened = true;
     }
-
-    /* if the inexact flag was not set */
-    if (inexact_happened == false) {
+    if (status & float_flag_inexact) {
+        float_inexact_excp(env);
+    } else {
         env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
     }
 
-- 
2.17.1


