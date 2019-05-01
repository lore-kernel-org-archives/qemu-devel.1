Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45369C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0582081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD5TVTu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0582081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhkj-0006Qm-A1
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:25:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRj-0006iz-Rr
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRg-00033l-R4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:19 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRf-00032O-Aj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:15 -0400
Received: by mail-pf1-x443.google.com with SMTP id b3so8157055pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=o7dnHbCu/TOAfn/7tUi0VRqfElXssoeZ/3G17tDL/UE=;
	b=rD5TVTu8vbSfOONYe6q+d/y+JZUCAh+eYDr1aZoENSAEpIjjVpMI40OxitBrozIGYD
	CcwmaFHMNMCcfZwzFAHO3TRgRsU1JSppr8y74wMvmMBNEQ7NyzfRyymVKdFT355xoBRL
	kiolSWCcvg7sh+N7PKfvtniwGHC6zAE+wQ98yVL49jecl55/j4u6xjul25sKUBnKnp++
	/5utHI4MG9km1+pl6W8b/L12riTDg8YVDNS0mvMIx4BQ2C+UjLrZ7ksl+4KVb38cpm/F
	6C+bCTgj2kUqZOiI9bZIvMMAZH76SIO93E1yromtPefBNmV89zkcHUBIIAr84qnXmRGX
	xhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=o7dnHbCu/TOAfn/7tUi0VRqfElXssoeZ/3G17tDL/UE=;
	b=KAhOJJmx70LBb5pobDLPRGUILhoY7wtTeNSrwUVLIm9DOE6BqTq/Qz8LquKGPQlQY9
	1IDzwolbC4Ecd37AgheESYUS/G2p+Vahdw/zedj+79DMV/D1ChCpWrcSjuwxQ4PmMQBe
	2yPX5nL8qWfdJ5EPPc4n40+1yGoh8/67yK0ewCy6qbVkaw88v5MzTE7d2YT1ETSa9atz
	MVZ8h5og0UHVpWgHMfiiXa34t873IBGwkjlxiA4pbUIS8zLVwr0mzK0NNrCmm9V12mmT
	oHjHY3ZzwjyYLlySaRgZ5dPLgpOfWfDH33FMMyWYpxY4v5IJi2lx8V+NQ1bGO1I1b1uH
	8/xg==
X-Gm-Message-State: APjAAAWa1CVHY++EnvzUlLD6TtRWDUNmRTe63ZUSbteAhi0Dc+UOaF8T
	COlh0HMpylFs1HeLiplGePG/rr1fjTE=
X-Google-Smtp-Source: APXvYqyda7pzqMf3rRzPQecQ7Af0zPENxC+Kr96RrjA2rTnXwvujbedMxNBEQJjOdZcwbtlp/qH61A==
X-Received: by 2002:aa7:82cb:: with SMTP id f11mr29661988pfn.0.1556687173985; 
	Tue, 30 Apr 2019 22:06:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:31 -0700
Message-Id: <20190501050536.15580-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 24/29] target/cris: Use tcg_gen_abs_tl
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050531.D3aVzarXPX9YmS02Pgr_j4eKgBvsH9XtedSPWjmEk2M@z>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b005a5c20e..31b40a57f9 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1686,18 +1686,11 @@ static int dec_cmp_r(CPUCRISState *env, DisasContext *dc)
 
 static int dec_abs_r(CPUCRISState *env, DisasContext *dc)
 {
-    TCGv t0;
-
     LOG_DIS("abs $r%u, $r%u\n",
             dc->op1, dc->op2);
     cris_cc_mask(dc, CC_MASK_NZ);
 
-    t0 = tcg_temp_new();
-    tcg_gen_sari_tl(t0, cpu_R[dc->op1], 31);
-    tcg_gen_xor_tl(cpu_R[dc->op2], cpu_R[dc->op1], t0);
-    tcg_gen_sub_tl(cpu_R[dc->op2], cpu_R[dc->op2], t0);
-    tcg_temp_free(t0);
-
+    tcg_gen_abs_tl(cpu_R[dc->op2], cpu_R[dc->op1]);
     cris_alu(dc, CC_OP_MOVE,
             cpu_R[dc->op2], cpu_R[dc->op2], cpu_R[dc->op2], 4);
     return 2;
-- 
2.17.1


