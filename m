Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D1C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD8120656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFg8fjAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD8120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmn0-0003sP-P1
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:25:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU5-0003ne-Ul
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008Bk-D1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU4-000890-4N
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so4064055wre.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lgZfPbopRUJXrj/AngwFpop/a9mtHOqlBcsdu25DOWg=;
	b=NFg8fjAvpDRy2r5DC+OveaTtXK+YXnZFT5NHQizoJWoqnFBAxtGPtOLJwuGXNhuonX
	ql1WyRUMnN0vSlpUUYSqGCudMeDOC+E9tc33wPMbsFGqQpuprDhIVpf7fB2nIMTsn8qQ
	Pqx6FdK9D/keacrqxX9PuDY8w+dpwM8QOYcx2tjnH3CxEnRMTo5FoR0GCW3VgBgDYpX5
	n5dkWEwsW90GufyewAe1H9P4l73V6I5Nprz/FWralka9Iz6Uua0fxQTqneP3d9Eim7sb
	1GdjHp7OVw05ZrWGugAD34eHd9FqDP/j6L+SdzH3JC4SX/bIfcD0uvgPPcR0ICDWWNjy
	UhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lgZfPbopRUJXrj/AngwFpop/a9mtHOqlBcsdu25DOWg=;
	b=g4dwqU134Fbm7h2zg2//iSZ9d+zia1Ftnw7E3n8z3FfHTcRpVOjvbiXTzVvtb8dvPe
	JnNNheFFQJwwoBOWWWBf4su3hLggVsmZHYffz9buiMYb+wWL9IxyhTxR3a2RnqaNyTZc
	cAPU5zHlGs6YTEFSY+wVc/wyDX3mOONwOSzJZs/VFQxM3TG6b3t5e4zLlxTkFDb6u1Q4
	2OKBf0xxNECI+84JCCZTxVYGW4BaylGU6ENXfzw2bqtmGq3D5e0m4bDpeN322pI0M4MZ
	59Q91OoBykz5QLXNODIAamuR97fqFyOw38JQoFPLSjsz4cWTOkKysbqCHSPIk64cNHUg
	UCFw==
X-Gm-Message-State: APjAAAUD9uS8kHyj+lEn3optXpn5JRWL4u8/1czMReHV6G3G6PkcmUi8
	GtsfIk68SYIdx5kNJ1tc2jlgUA==
X-Google-Smtp-Source: APXvYqyM1luflISmoum1Nje49YAak4VMBUcU4vwKcubmOizv+naa9HSW+j/4MXIHyGLgClZLnsZP0A==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr3894461wrw.210.1557421525366; 
	Thu, 09 May 2019 10:05:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id v5sm5463369wra.83.2019.05.09.10.05.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4C1221FF9F;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:03 +0100
Message-Id: <20190509165912.10512-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 15/23] Makefile.target: support per-target
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
index ae02495951d..aa5d9d6ba66 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -238,3 +238,19 @@ endif
 
 GENERATED_FILES += config-target.h
 Makefile: $(GENERATED_FILES)
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


