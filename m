Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E6C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00F9208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWJtlj4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00F9208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkEe-0000m4-Li
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDc-0004w7-Ns
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDb-0004Tr-PI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDb-0004T2-Go
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id x1so9890747wrr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xLl357brlwo9X3ByorEBvzzqm7sZXYPRIFxQ86t1ckM=;
 b=aWJtlj4wopaXjm1M/W/X6lI5ZOzDcPhsm21UqkmhbqGGdlkT5zxWlXXEktCF8uUTPU
 EAQqEA67mJ1/OhJW7pAvMkDowGJVIUycjD5Adwm+LqUmWPeTpvaEBvrR5jUfT5NNdguy
 5oh2elUKX+njaK18MWX2oOWS7erpBlWB2e1MfdxsC3CbxjdVwvxZILBJQi1/s0kjyJFP
 gJDdD4KtK64sQUty3Cfv8KbLT09jqpyOw93I9mTnK9OqgkenM45jjiXm6zlEolcUyheb
 cbVwH1+U7TaI8vYolINkZneti8it1kpVjytBO6k1UiiVJZ5uSd0i/wTt2qF4NlQIsOj6
 Wpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xLl357brlwo9X3ByorEBvzzqm7sZXYPRIFxQ86t1ckM=;
 b=RIYEOEYy2NBKUjTYrV90KdMYXPdsT2pGP/aLR5IqJM4xVclOobwP1perNS7+qRmLqL
 EHi2IRtC1KGRW7M5st2jBxoGRndIA4bsq93iRx13ohW1x4p/sqsHS45wqv8QlfJ6n7ym
 hgmZYLCSxubH++fdq8anmpzTNnBzAncJfoZykWdP85xXbmafY5WdrSo3RfdgJdKxd5I9
 OnL0Ad7KOLxUA3uE/Jg+YDm7YKVsWU1+NF8YUf1gRhc5BDJ0GR6V34H1Gu+W0W54IIIw
 qERvOXPJpSVYX+64FrYmYoH0mIhsduQ9ZDLaF8DUZi4Jq+CfhFgGrfk5KTXM7HRTUC9d
 UABw==
X-Gm-Message-State: APjAAAXMrIX8OhDyHjXw0kipHMm7yzvvztpeiiY6Y7b63TOHn6hvYCDy
 XRAkquXebaAqxuv/fH9O4qfboQ==
X-Google-Smtp-Source: APXvYqzW56UkReIWdwvLiwioo06bUC7qNE/iCinb5FSSu8XRZCw5CJ9OTRd3VSBtWifDGzPmI+Bacg==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr28264608wru.246.1563371018336; 
 Wed, 17 Jul 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u13sm29073077wrq.62.2019.07.17.06.43.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0CAA41FF8F;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:14 +0100
Message-Id: <20190717134335.15351-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 02/23] tests/docker: add test-misc for
 building tools & docs
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add yet another test type so we cna quickly exercise the miscellaneous
build products of the build system under various docer configurations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/docker/test-misc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tests/docker/test-misc

diff --git a/tests/docker/test-misc b/tests/docker/test-misc
new file mode 100755
index 00000000000..d480afedca7
--- /dev/null
+++ b/tests/docker/test-misc
@@ -0,0 +1,22 @@
+#!/bin/bash -e
+#
+# Build the miscellaneous components
+#
+# Copyright (c) 2019 Linaro Ltd.
+#
+# Authors:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+. common.rc
+
+cd "$BUILD_DIR"
+
+# build everything else but QEMU
+configure_qemu --disable-user --disable-system --enable-docs --enable-tools
+build_qemu
+install_qemu
-- 
2.20.1


