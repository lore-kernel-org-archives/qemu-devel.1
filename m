Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC5C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A35520868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYzBIefg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A35520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33543 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlLZ-0003g2-8D
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:53:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2n-0004P6-Gm
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2i-0006b4-RL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl2g-0006Z0-V7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id f8so5699494wrt.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=taVCGQXYe9mSal2L1Nl6ndCabOIar1+JnkxJyTbWwQY=;
	b=VYzBIefgOt3hxUUJStj0ZuIbzWDXCdvafworTfnTNKHONkJIIi/Bl5S3pR5o3E2W2p
	nN95Z2MgEEaOnNDte0OFZyF8qRvZ5dLHAa26QBjpWmoWxm/7R/KW/XRodsRfSKwYh9Ay
	yhfnDKVhUfIJC+w/SbeRwcKe+kQ6PwQz2LQEMp6d6WOirFjknkpofkBq9zkh9PlihZ9o
	F1o0Jhvw6p6pxkqNjKO/r1NThlgnqus6Ts5267aulvbIkH2sVPufxt73Z9igFc7h+Y7A
	aPcdkfzn7PmdDH9BOYlb15EVmZ6Gw3hcAOhOqJkMjda+FIdUqBobky4FEBLDNHKvaBR0
	GiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=taVCGQXYe9mSal2L1Nl6ndCabOIar1+JnkxJyTbWwQY=;
	b=gfDMtNnEktVeV05W83//2+PPS7JUVG4HvjRE3wXaz3GTqrJ7X8vrt8amGOXjFhKDzX
	CS1d5f7SJm26kARh2vE4AlkfgT4JIch8pBYQxdVRgEAdlurvkhHclWibTtzsCZ/vwhjA
	fkSZmr5ri8R8yFlYE82X+IF0PMltMVXFn8rlub/QdL20hK1sHybvV1znY6DgX0jsLBSc
	p98LxgCdussxVWIqHIlbuW6/waMzQNm8Pb5nRVqhRo5dQ/ym58Z0LwhvC/wHbaKP2yA3
	JEytF2VcdY4JYACjXpkNAdEN64Bx1rD1oFBLcQm3ihiut/7ArFvCyJPky6u7sR2jp3PS
	l2zQ==
X-Gm-Message-State: APjAAAU5Wq9YyStYOSKjVsO6tQLimwJhW4OPrQdvOdV2PTg9jKu5aMuS
	ig4+lyGwVusGTZalpYJa4sNggg==
X-Google-Smtp-Source: APXvYqxRll6HOKlPb/10GNJYeIxNr8p6kC5UQdWFBkjfuaOjtxJXPyIiabcUj+7SILEIXkLEDOXaxQ==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr134299wru.238.1558607625140;
	Thu, 23 May 2019 03:33:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d17sm23214216wrw.18.2019.05.23.03.33.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:33:43 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A48B31FFAC;
	Thu, 23 May 2019 11:25:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:29 +0100
Message-Id: <20190523102532.10486-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 25/28] Makefile.target: support per-target
 coverage reports
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

Add support for generating a single targets coverage report. Execute:

  make coverage-report

In the target build directory. This coverage report only cares about
target specific blobs so only searches the target build subdirectory.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index fdbe7c89f4a..328c37902ea 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -238,3 +238,19 @@ endif
 
 generated-files-y += config-target.h
 Makefile: $(generated-files-y)
+
+# Reports/Analysis
+#
+# The target specific coverage report only cares about target specific
+# blobs and not the shared code.
+#
+
+%/coverage-report.html:
+	@mkdir -p $*
+	$(call quiet-command,\
+		gcovr -r $(SRC_PATH) --object-directory $(CURDIR) \
+		-p --html --html-details -o $@, \
+		"GEN", "coverage-report.html")
+
+.PHONY: coverage-report
+coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-- 
2.20.1


