Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B2AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DC520868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2QaYt45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DC520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlMa-0004XL-Eo
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:54:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2o-0004QX-HL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2k-0006dX-Pz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl2j-0006ac-Jk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id u16so1792046wrn.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=o3EFe5fyp8XJbHGSqeV6fhIY+jSWXjg9YliRj0HIozw=;
	b=u2QaYt45ZLMSPbitDi9ss52YxxnHdqX08kubEnrKqnKGdqFVxrQ2TA/lTYDr7g2jCs
	dBOBxjDMrcfNrFq2nhrvqQhDj9o1krRAcW0VPCpqJ7vFKbKb3SwpgaFv9a3XGAzS1wgx
	kCSSgvPNoPPCoFCG/03dKKPcIcSzHrmuV2aQo16u0hi8pZ/puer3XcSUv3j4QXqsWTUk
	YyUrzIsK3tLwfUoBKr0mEytVsER128hzvPFVtebv9L951dhuYzyqd0kKOPkTfOqsfWIS
	jvL5fIehrEzeLV0k8dA+bTPhjhbiVEMFPtyRpnnQ9grXYHPYBVDfyL5rApG6/ZT5yA+6
	t1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=o3EFe5fyp8XJbHGSqeV6fhIY+jSWXjg9YliRj0HIozw=;
	b=fZ54kTXBF7HMdi5wQYd4Pouk3Hb+KRszdEPweM02fsDCNjae8XyVmSyNByvVncD9It
	31QWXPsmD1JAmTs+OeF1lLI0KPk3pad8qvcf52QNo6GBreAaBPVn2g4gwvirvYy74m/g
	RokCy/EprqhKzDL1KZzCS9xivDzZLzv2jHL3giv5bpTl7p2ShEIZxaOmW8uVA4ktysz6
	kkg5U90Eg8SR0JKgk5L63li4+vI4jWJOkJzvrGOUNABLeFSRqhPrTA71gvOow6vRErX6
	fCArA8pD9UInfF5zgLgMMHPeKkIr4/xnBwBZ/9/1ZTwi6YuyqGg5JiY0VcMUXs7ZWX77
	zQtg==
X-Gm-Message-State: APjAAAWr2y+fXvtOhgeQQPvQ3SvHS2ewsKqlLsbyUtvKZWvp7A4c56RS
	y7XC0rT1UUxSKnDr1z3NS3i5hA==
X-Google-Smtp-Source: APXvYqzp0YTBGKL3OUmvT6BjE4abWRkhkLGaV0MuWOP4h05pos+tYA6sItCom2UCfWA8PK0fR0/0Xg==
X-Received: by 2002:adf:e301:: with SMTP id b1mr27663873wrj.304.1558607628195; 
	Thu, 23 May 2019 03:33:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s13sm9407861wmh.31.2019.05.23.03.33.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:33:45 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7BC1D1FFAB;
	Thu, 23 May 2019 11:25:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:27 +0100
Message-Id: <20190523102532.10486-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 23/28] Makefile: fix coverage-report
 reference to BUILD_DIR
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 337f2311f actually claimed to do this in the commit log but
didn't actually. Oops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 155f066a206..40561993c40 100644
--- a/Makefile
+++ b/Makefile
@@ -998,7 +998,7 @@ $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 %/coverage-report.html:
 	@mkdir -p $*
 	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(BUILD_PATH) \
+		gcovr -r $(SRC_PATH) --object-directory $(BUILD_DIR) \
 		-p --html --html-details -o $@, \
 		"GEN", "coverage-report.html")
 
-- 
2.20.1


