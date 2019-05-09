Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFBC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD64121019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QO/9ph0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD64121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmkE-0001WK-1k
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:22:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU8-0003pm-G8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU5-0008Ef-J2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU5-0008C2-99
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id d12so4053897wrm.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MBe7Kc2gJyZ/SuxEH+RJihcvFjAFUPDJsCo1R8ybthc=;
	b=QO/9ph0A12agL9W5ZQrEfa2lomWMpn6I9o25/epjdrOlgqacqHlS4HT4lk6rKAsOqj
	M+EHTAM5QJJMdzXETT8bo7oh1z26kH7HC1i+Usak6pcImy1DCCLTMZmjdBw9cjAGHpwh
	20DLkTW7KapaVQ3HwPB8+1U2L/DFpVhAcoi83wiZymWmtTdkXUSkpThXtc7bNlYVQz32
	+ZWz/L5ymPzC/eJKOyE2jTdfzCals+SaOmwS5KIGWsDC1/2FYEAzjRiYWLHe2dwpGtvs
	mALgrbjIjARAnCgOojfm8alZKwjIq0FeZYAipl9IqwsTT0ZXsZruL1r4gD9GAmtCwsc9
	DA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MBe7Kc2gJyZ/SuxEH+RJihcvFjAFUPDJsCo1R8ybthc=;
	b=oAcsFDxANv0IbydNem5qhn+yG1kAIL5WXxHQD4h8ZB4qPPyAa67/xPLHymtC+zwBtq
	rerAXsEpQw0lKrHYgkzqA7ayoiYFtDCl0SfwkjzTIhzfr0Mr2GKB3eDGArvLSzy1cB4b
	EH3YIykiVRA8SZTYo/WmpJhgmwZeQghH6DouiIkXz/NDFhdGOLK8tCst8ICDQK1H7SB8
	MD5V9dawG/cy+LE+Nz8DwUP4Nzwof3j9h2su0GZE5ZrBkQ3U/p0nZ9DjLpSU1mYI+U+w
	Rr2bz5uyTwAk7b6QTlesYdYK/T7+fTJ5+WdxgEuxkigCnszR+c9tMggD+zCkzDORzzI/
	yiQg==
X-Gm-Message-State: APjAAAWskH4Y6X2k8QOZjwR5qMdPe/6CdWzvGSsYPBSM2zRe0FoYGQ25
	7zC8L6Owevb0bpU5iBMCS/N3LA==
X-Google-Smtp-Source: APXvYqzHgn4Hw4hALcSZSKLytSbCgfLVW8TmluKd5dJal2H45CNl1x2u1kYpsDPMCbLxFaXqj1pCEA==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr4034064wro.121.1557421528049; 
	Thu, 09 May 2019 10:05:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	g10sm3400523wrw.80.2019.05.09.10.05.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:24 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 8F13C1FFA5;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:06 +0100
Message-Id: <20190509165912.10512-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 18/23] tests/qemu-iotests: Do not hard-code
 the path to bash
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

bash is installed in a different directory on non-Linux systems like
FreeBSD. Do not hard-code /bin/bash here so that the tests can run
there, too.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190502084506.8009-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/239 | 2 +-
 tests/qemu-iotests/240 | 2 +-
 tests/qemu-iotests/241 | 2 +-
 tests/qemu-iotests/243 | 2 +-
 tests/qemu-iotests/244 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
index 6f085d573da..b0991ffe594 100755
--- a/tests/qemu-iotests/239
+++ b/tests/qemu-iotests/239
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test case for dmg
 #
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 65cc3b39b13..d3e663ed65c 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test hot plugging and unplugging with iothreads
 #
diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 017a736aaba..58b64ebf41f 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test qemu-nbd vs. unaligned images
 #
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index 5838c6e89cb..e563761307d 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test qcow2 preallocation
 #
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index d8e71223058..13978f93d24 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test qcow2 with external data files
 #
-- 
2.20.1


