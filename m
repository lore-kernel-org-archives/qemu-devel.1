Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E948BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43B2206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKRfFCH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43B2206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyMk-00021I-3d
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxP-0003Vp-Si
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxO-0000RB-E4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:31 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxO-0000PL-70
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:30 -0500
Received: by mail-pj1-x1044.google.com with SMTP id n96so827612pjc.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u63gqALS75nKLyBBgFxH9YCXnhD2J6j4ZQ6v9GcNUx4=;
 b=QKRfFCH/7LRf3OLHS7U5cg6JJEOvd1qGoiwEkrkNI6YXjyjGHVfKasmnCbzuPF2/Vl
 I28BdiB53bjLj2f6vDrPQprcP3zOG8V7kuAkKer/ohY8cZQXgy8kj5jNQsdGnvdueiS1
 Y9bF7x+j3uPw+meszc9eNR8/rAJZ/5zlCd9UhnyXvesRs/xrgrl4T6A4zfacCrz9Eexa
 dFhrm7667UgAfyHZOxY/d7cTRvvSwG1itiSs3HfRkzxaICaNTxuRmI7tt8lbwkucMtGR
 2cvom6roIPoq4sLv6P+bTa+mdwN2cFRfdTfMvdxCsB9Kd8CbQwkekqYJ0zZgD3Pl8V5l
 UKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u63gqALS75nKLyBBgFxH9YCXnhD2J6j4ZQ6v9GcNUx4=;
 b=CAQqDWOVCCNcrYxPWbtz0nNWamgpycguqLt6UOsAkyQMTIkiFHujFKcQrTBSFQgwUp
 ybVQ/Ts6Re94fKCaaIb5SJsavWzDMGkUTTLWCmsMcUtVhoyGqm+CcCtENpKQPntKUAgH
 tuplujUpQP69n7hI9DV4xakzqd8Or/1Pg/VVedz6t4NdcL4t6C7Re8ksEeyTEroHaglY
 iRJqCrIAmADTPYctd0so2n/GPi311fJeu1BH9dZPndA41+++xbiaAPjo94ztV/yAW2+h
 fmYNsyCfyry2uSPFjWuiGRD07OdEJVe9SKMEjCrVxAMuAcFdtL5v5nOUEgjrnSAwJhN1
 G9kg==
X-Gm-Message-State: APjAAAXAfcPSv6Stvl5ILe4EDLnZTZMWzB99daLcf4Qshb4N+sjb7sWC
 w9gu3NgmGBLz4WuxgwHIMIA2dcIybvI=
X-Google-Smtp-Source: APXvYqyOFHAwJN2L1PYdxXcavKM4QpKVPJ0O8oQ4jqkkKKGvyzdxpRj52dXpSXfIdATSV6OygMJgqQ==
X-Received: by 2002:a17:90b:3007:: with SMTP id
 hg7mr2964339pjb.73.1575340228735; 
 Mon, 02 Dec 2019 18:30:28 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 39/40] target/arm: Use bool for unmasked in
 arm_excp_unmasked
Date: Mon,  2 Dec 2019 18:29:36 -0800
Message-Id: <20191203022937.1474-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The value computed is fully boolean; using int8_t is odd.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a1177b883..a366448c6d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -417,7 +417,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 {
     CPUARMState *env = cs->env_ptr;
     bool pstate_unmasked;
-    int8_t unmasked = 0;
+    bool unmasked = false;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -468,7 +468,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
              * don't affect the masking logic, only the interrupt routing.
              */
             if (target_el == 3 || !secure) {
-                unmasked = 1;
+                unmasked = true;
             }
         } else {
             /*
@@ -514,7 +514,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
             }
 
             if ((scr || hcr) && !secure) {
-                unmasked = 1;
+                unmasked = true;
             }
         }
     }
-- 
2.17.1


