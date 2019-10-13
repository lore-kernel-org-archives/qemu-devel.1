Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15863C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D370A206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRkFFzmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D370A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmOj-0003iT-EP
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJU-0006yT-SS
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJT-00010F-RJ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:08 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:40512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJT-0000zs-MU
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:07 -0400
Received: by mail-pg1-x533.google.com with SMTP id e13so725608pga.7
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oeW7tayprlItGgUIPuuSDkp5jBXbzTBuI3cJggBf824=;
 b=iRkFFzmxfrN5Tba9PDtDgK4IFVXLKCZPKmG8xdYRd+GiuLHpGAvd8gg7NPONxW3a5y
 cL0b/5ogdqDp0IAA/OzGP33x/yQP57fZQUmhcvwSQv4WoiyPctHkq+263sHadiQHo6bT
 QYM1pajLsIey9XcZUbFKcBoafN4KlowC4eQy7Ybp21Rz7HGad+ZAaA/NCKk05OlJk1yp
 3Ssfli2zxpYtkG7Y4UUK07+gjx3gmTLhRH7XhbtKEQgVlKTuuRPGb1aTnJcfdX/KeFkI
 Yp5wbrFGKhGbKPmNwTlrgYy1Fa269l2uSWqUBaP9sVOYvOutNgSj7pxKiYXY9FWkLLPX
 fs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oeW7tayprlItGgUIPuuSDkp5jBXbzTBuI3cJggBf824=;
 b=iURNWqSYtsWbDMbapW1Bw5yNy6EOvmLRXTJkBk41PgtbMrjoK4seQqg2R0qw8vlA24
 9XzNjUrWZBZ15Tew6y24zejyggxFr5kdF6dXmNd2xMHLgKt8CbDj6WFkw48OL7mHvKw2
 wtgi3vbIN1K3aS307pnHL7jh5LBTT44MygBfUXpS13gL/E4/LSLI+TJmGnHUA1ErB5pr
 dE9XXVfM1+48iP3MuMRJrgXXSQvwEOH/1tvRorvSW501Uvss0gqPM5MIRLi/cztZeD12
 Db2VwYHvhvNPsE8psi8u9xiMdX47uIEiJtl/Bgf9kEP5OP9ochcZc5ByoefkFj+jU7f7
 tLQQ==
X-Gm-Message-State: APjAAAWlQRDL2xE8Xa8qbhe/kgMDxwKw44bgPsIUjSPeR+Zl80nHwYfv
 Xwn2eJCCr/a1mSVPbc/q39eyQpG3TsA=
X-Google-Smtp-Source: APXvYqz5yUkyZcz1RlBGxMHuz3zJ1deTdJx+B3G2bdWz7wMsT+PTwRRm7CExjfJxnw4FULO4LkA8UA==
X-Received: by 2002:a65:538c:: with SMTP id x12mr8390274pgq.289.1571005566351; 
 Sun, 13 Oct 2019 15:26:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/23] tcg/ppc: Enable Altivec detection
Date: Sun, 13 Oct 2019 15:25:36 -0700
Message-Id: <20191013222544.3679-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have implemented the required tcg operations,
we can enable detection of host vector support.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (PPC32)
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8a508136ce..d739f4b605 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3528,6 +3528,10 @@ static void tcg_target_init(TCGContext *s)
     have_isel = have_isa_2_06;
 #endif
 
+    if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
+        have_altivec = true;
+    }
+
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
     if (have_altivec) {
-- 
2.17.1


