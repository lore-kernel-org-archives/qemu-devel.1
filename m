Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E9C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB7122B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEHSaFma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB7122B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48JR-0001Ri-FK
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48Fw-0004sT-V5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48Fv-0001kM-P9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:04 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48Fv-0001ip-Jo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:03 -0500
Received: by mail-pf1-x442.google.com with SMTP id k29so11103507pfp.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/9wXoDEsxSRqmYUkdBOvS37ZtLP9FiINAczvKHAmVVI=;
 b=aEHSaFmaqt9CFosgT/kRgfwaWvMLlgf5q66LGeQpwPZ5HnyvrtsdP4PSUY/eK+UwRW
 P+JG2oHhdfvb2Gmcrr1BjAMmtV8STZL9o3ulG10eNKdXLq1DYg8Vklo2chMa0bGln01Z
 07oT1VwpjM76KnjAy9OODZ8XpoBg2VzICDjTjVp3hzh7But+dFfk1ex/5SLhrwtSOL58
 UsSWjkJnMMJB7yVmbRPP9OV/dMwbTspDbcfh1HBbo6yBEgttNDktUdqyuPgHdG9nzZLi
 SYuxaf/Zd96gCUeB45PeX/pBHwtDYpjdwGLpeE3eijJfEosEbx0AvuHztjX45A2l6Bwd
 G75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/9wXoDEsxSRqmYUkdBOvS37ZtLP9FiINAczvKHAmVVI=;
 b=exHpOPpeAzFmus7h9XF21XXoS8z8mOURGbpixWf6TcBpLSUFaICtO2BY+2Aum7VaeN
 ZnOTvdNEEUl2Z24wc7iubfM5fdpRC/t6X3yH3Ds3Vg48bUTVR3ukrTnnZQawx6cWI9bT
 D30kfplgexpIfx+/dghnZR8Lm1zwEjlOio+U9f4oTV6lNb4lCN43FAGViIc3q2x7BZGj
 GuGxPFbmWfleq72zjy0tK1Xo1adWZwuzI4NROD1JAHQ2Dnl/0dJ9w2KDqOhYRbrHBHGC
 LZGMN71ri4skA8TNt6gzDYLKaovMPtrXRpckN6X69d/RUUONaaEnt1C7j3ygbmo4/wIb
 eGRw==
X-Gm-Message-State: APjAAAVtedhv+7RP4jBnn4DE4ehxZRd9dtrsCKnOKOyEurR4eGCIV8uE
 vtBrnt4C0t+/ISlOloOcQ7bQKupwfQc=
X-Google-Smtp-Source: APXvYqw78+9JNq5dLj/70koAtgEhQWjUo19WlAolc4YYqKQDmXz7fJEobq20fRNUZFpa14eAA1iVqg==
X-Received: by 2002:a62:6409:: with SMTP id y9mr22994459pfb.30.1582053002266; 
 Tue, 18 Feb 2020 11:10:02 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i68sm5139399pfe.173.2020.02.18.11.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:10:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] target/arm: Set ID_MMFR4.HPDS for aarch64_max_initfn
Date: Tue, 18 Feb 2020 11:09:52 -0800
Message-Id: <20200218190958.745-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218190958.745-1-richard.henderson@linaro.org>
References: <20200218190958.745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had set this for aarch32-only in arm_max_initfn, but
failed to set the same bit for aarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 32cf8ee98b..32c3e24a3d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -704,6 +704,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_mmfr3 = u;
 
         u = cpu->isar.id_mmfr4;
+        u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 implemented */
         cpu->isar.id_mmfr4 = u;
 
-- 
2.20.1


