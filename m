Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19987C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB58C21473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojcGZmQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB58C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrLs-0004OA-5i
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0c-0007IV-53
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0V-0004KO-AZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0S-0003tr-CC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so3158303wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nfJr9+Ou2ey8h7VCuPmwWUBSybcXHQgAvYfUsvi+vzc=;
 b=ojcGZmQ+xqKKoIbm3N9OkM+GzwOxmfHhXXVr3vxm3+vCLGlUfmGebdPQucdzl1qkYP
 7W4mB9d4CxMUdtYs5iyn7RacFKmYHpd2qO9P6WKycnIwmW36ZUMVKJa3OSSpeauO+4+o
 DlhA6J4jhmsneB2Rl0BJhSWEkiUo85VPRUc/F5dO94KZfzI4EbKh3Dbvj9s7fsPZ7YVe
 wUkxY+vRk18/WzUS2UK/2IUHGWJs0RZUJUV0g3TWq0WpHpu+hXitlY44cDKo3Acfs3il
 c6QWU87U6CY+g0pdfl6DIeaTHnTbS96L8kA5GgT1MKZZIRivydezYdsr0NfbCYpCNNJ/
 rEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nfJr9+Ou2ey8h7VCuPmwWUBSybcXHQgAvYfUsvi+vzc=;
 b=LEn4rvJr3sueAi0mLLDYB80KX2kWvEQNv4ixjpDHRT1aikuLL9PdcN1aws3OIPwW8x
 WhOcaZxwP6UbMicSE7rBH/yDh68N9sgjnXAyxUG75lOyjePbVEoTmBhJ6ZVMVsBEtGmE
 obQzIQmcHzqeEkb6WwDT/TnzCzsBWEddr1OWH9YycRgqGcXvqAVlKBIS49rNHzeb5uFy
 UFlsyLzQSDDrio4R4PsjhfqdjbcQfTKjZnceGZMb6xxHtCp/+WPDQ7EhquLOd0UgcSaS
 QIso6cYyB5Qm2bo9pY+QX09rdkaGbI95I6wvHaFCPDehimk/nGcIugn9/ABifzOq6YsW
 ciFw==
X-Gm-Message-State: APjAAAWqFH1y79Z9CCIOVVNko7aJmjFPgoP7g+GirmVrq2OdhEqdxEr1
 GztFc+6D66lYReq3tYGu06GAMPzI1Ao=
X-Google-Smtp-Source: APXvYqxxiV0ayX1I1rzd0LpLB+cwEgtfOWrsymBAUYDB6e0iBPMhXmhzTY10DuM1eEjDnWBBm2+twA==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr8760124wmf.19.1560533315485; 
 Fri, 14 Jun 2019 10:28:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v4sm2752307wmg.22.2019.06.14.10.28.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 415EB1FFB5;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:41 +0100
Message-Id: <20190614171200.21078-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 31/50] target/m68k: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2ae537461f..dc05c0d2ad 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -378,7 +378,7 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
     uint16_t im;
-    im = cpu_lduw_code(env, s->pc);
+    im = translator_lduw(env, s->pc);
     s->pc += 2;
     return im;
 }
-- 
2.20.1


