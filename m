Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20614C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8928E20674
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjaG4u+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8928E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNps-0005Hs-9r
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:09:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfH-0004p0-Ox
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfF-0001KM-Re
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfE-0001Gi-0u
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id a184so25245569wma.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=bCGhrFJCaebvft5wSyxUMGmlJpa7UGyDkhV61Ort2ak=;
	b=qjaG4u+B8c572MSbsULByl5VX/0zRQ+L52wPypDWoh1Eot99rfJMr61cOKpUAK59QS
	bwjjitRG4nUQjKKpavAIdNay8oW9nJ5TiFZGhiNz9ysU6w7S4xoxPgQTPrMGIEqMdoWK
	fmErIhKS9Si8MDYGH5vgobYEVwBpw71GXF9OTnNCTioy/1X68id2BXNrhhUhjh00+QB1
	g/WN1IuJavxstMeU/A5mDHp3ri9XPvARlUYGyeKO6rn/LmauxuE/C1wG3z1Ms5V3IYhk
	OdnMH46OKDVsKsx1HI1OZgGlLlfAmjB3R/JhSQF0gv8uqAuBmbi+xKE9yyFRpwiPi1EI
	pusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bCGhrFJCaebvft5wSyxUMGmlJpa7UGyDkhV61Ort2ak=;
	b=aLqWW+WJ9wiq36rvKfIUblBiJwnFKbJAO2LaSn06AKQrfckiW7PUDWeyagnUzfOSie
	yWlgxxOz+sNHPU0GTI/04QlYECe/ne+xc7c4ue5Orvt6wf1WDTjMGwm/SNP4x3COkvGK
	aWSu74o3iAf7So1Rs7q96LnwHeINmxLKtwLzSryFbspLTkNUyOUuczGzNVrjoMuFzkCy
	BJP5qK/QbwPItUsBl8NziXJ8dVOF9G7PrkzgCECRWGvGb1oT4AcNrXtBMmjYoRQH6HpA
	FsljueztQuAAmsqBQPEr1mSUklPpze0ZhchjOopoYS1SPmB5GLn9nvo+H1ySszonWE01
	5Y1A==
X-Gm-Message-State: APjAAAXPoQ00j4OyQXt1oI8oUJG5qLn9nHdXXv1FDj+NHT840wmbEKbv
	csitrjFJnlxwHUARPjmt2WnquvFNP1g=
X-Google-Smtp-Source: APXvYqy9M8IsyDCKuaiXcryzNE3LeBIw8g6c652NhSYSHtV9qFSaKp7iFIp5aL0ddVRrYzNZ8hVhbg==
X-Received: by 2002:a1c:c8:: with SMTP id 191mr25804221wma.44.1555419493999;
	Tue, 16 Apr 2019 05:58:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:30 +0100
Message-Id: <20190416125744.27770-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 12/26] target/arm: Clear CONTROL.SFPA in BXNS
 and BLXNS
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125730.i5x_N0CYeY0lBoeQCJ-5AemjqBos9KUwhlXFq4mwrZw@z>

For v8M floating point support, transitions from Secure
to Non-secure state via BLNS and BLXNS must clear the
CONTROL.SFPA bit. (This corresponds to the pseudocode
BranchToNS() function.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7298f9de735..8e72e1097ce 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7824,6 +7824,9 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     /* translate.c should have made BXNS UNDEF unless we're secure */
     assert(env->v7m.secure);
 
+    if (!(dest & 1)) {
+        env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+    }
     switch_v7m_security_state(env, dest & 1);
     env->thumb = 1;
     env->regs[15] = dest & ~1;
@@ -7881,6 +7884,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
          */
         write_v7m_exception(env, 1);
     }
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
     switch_v7m_security_state(env, 0);
     env->thumb = 1;
     env->regs[15] = dest;
-- 
2.20.1


