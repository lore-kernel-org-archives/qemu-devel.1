Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F14C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C801D217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOROu8NW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C801D217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmUT-0004Fy-27
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAo-0006QJ-Mw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:10 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAn-0002qZ-7K
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id j4so1915315plk.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DqAByG6Aq/FTPC8bU0bVrVUTlxxWzIP4uXMQ1SMSVBE=;
 b=jOROu8NWeWerNVNR/2k+iKIUJS9VOR3rB0WNXhfvbn71cUlAOtoZfmLLoVekujjkGg
 KHSj1vYNpLg4OXxwlfE+n5d86UqWPKBKr0WC7gASdpfnP771I0C78B7lS67ryBH9gfMD
 4uMBpXaNAhtIprfopeyf+f+KJ1Z9nA4gpaaFkMBQ1IZE4sasi6Y+cNtQku3O+7Al9/sC
 Wz+jFRWX+p/7LB1CSt8Bmp5M6wTD3th/v51MYppt6V+NYt6U2b9pr67iJN9+WuKtU9sR
 CZOFziCWhAzThmMgGQZhswtzOp2kiEL42Mr+PjyfuqYQFoVzCyRizWT0C0Cf40BZlMZY
 4D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DqAByG6Aq/FTPC8bU0bVrVUTlxxWzIP4uXMQ1SMSVBE=;
 b=gBsDioxuFe1G6B5/J0RQ2PSm/gx23w2z7KUCrBIOfEls2iTSgci1CkYrT3OyJDFA1V
 e+0wGoPAqagAOkIgAtmaK6JKMGQz//y4y7dsMJH3RqqDVLP6BBaGC9Lb6L4IXNHZRCcJ
 c6kBocYkyO+5W1sNTSkmokIiGyr6+y6p3B87ngEw1JfpN/DPRcPETsP7vZ1V7754a39l
 Feio6xWwZYFO0yGywSZBFaLik81CkHDiR2+mn8K36jgDPW0C5cpVQ5q0pZPjM1ut7nfO
 nGUo7pUbHW+XXJ1xcQ95r8YsRGeVAUKFLCJak+w67SQ5w2cEGclJjC67ukikPg8kSN6R
 vb1A==
X-Gm-Message-State: AOAM531BcYwW/TNcWaKUHeovf0JzQsDrIcQfWLnA2ze0dSTYKL/w6AjL
 6EmganxDxY5o6uu/SxJXFnKjykxOjbo=
X-Google-Smtp-Source: ABdhPJxZpUYr88/Ai2K8F6iIq/4R/WLSIowY0a2FL4FVxK8r+er5UxUUy5v1ZMXt9u30RI2baN6/Xg==
X-Received: by 2002:a17:902:ed49:: with SMTP id
 y9mr2135879plb.284.1592454547533; 
 Wed, 17 Jun 2020 21:29:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id mu17sm972324pjb.53.2020.06.17.21.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 037/100] target/arm: Implement SVE2 bitwise shift and insert
Date: Wed, 17 Jun 2020 21:25:41 -0700
Message-Id: <20200618042644.1685561-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  5 +++++
 target/arm/translate-sve.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 7783e9f0d3..90a9d6552a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1261,3 +1261,8 @@ SSRA            01000101 .. 0 ..... 1110 00 ..... .....  @rd_rn_tszimm_shr
 USRA            01000101 .. 0 ..... 1110 01 ..... .....  @rd_rn_tszimm_shr
 SRSRA           01000101 .. 0 ..... 1110 10 ..... .....  @rd_rn_tszimm_shr
 URSRA           01000101 .. 0 ..... 1110 11 ..... .....  @rd_rn_tszimm_shr
+
+## SVE2 bitwise shift and insert
+
+SRI             01000101 .. 0 ..... 11110 0 ..... .....  @rd_rn_tszimm_shr
+SLI             01000101 .. 0 ..... 11110 1 ..... .....  @rd_rn_tszimm_shl
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 3dcc67740f..2bc20503e7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5994,3 +5994,13 @@ static bool trans_URSRA(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_fn2i(s, a, gen_gvec_ursra);
 }
+
+static bool trans_SRI(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_sri);
+}
+
+static bool trans_SLI(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_sli);
+}
-- 
2.25.1


