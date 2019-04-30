Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4CDC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A472C2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMilLvXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A472C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50341 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWCr-0004nX-Qp
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:06:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2I-000490-NJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzh-0000bx-Sh
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzh-0000Y1-KD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id k16so21859501wrn.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jqIW+C//ILq0mPvR3tHEO6y3NilaIZi0x1cwBliIiU4=;
	b=YMilLvXFW+VGXCXfzig8+SpsUAk77R9SzLcDWqXChV1mJVk8u6hkjAP9p0R4sC05DN
	3nWZd/zZYyTH4eo2KMmSbTkSpSRDGnZjTDDB33Jq9b1TyJ8mNckAUqF8v0lElX6afYTV
	/hL2x2snu/iNM/nD5uf8G72aBFesw+3GLy8Ufk19wLbi4rOv8iFooaUQgaU2Z+kpy+mc
	LXL1c1PPJdScWoFyWd+0BZpQrckgkFQp9BTWksmroXwx5K/IAlwuH0Z+FuijbxXe75DM
	p2NXMQTZ2UugBmNcJG2GlByv63lfnEM6Gk2XGIf/vwEV3SUtzak3PWXimlAHeqvIC59z
	6UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jqIW+C//ILq0mPvR3tHEO6y3NilaIZi0x1cwBliIiU4=;
	b=WxAfRcjSCqKKF4pWpzl1zRlNrO4c7BIjxznptF/BdzfgrMIXeUFZ97PqUwmm3oUBjk
	xdhMIbcDxCLMypcHgMQUXpw8S8WBrOgWe13vOE9yPOKsMVtbw/GEgCofN/oaMZPaaMPn
	smd/pbhxzLrO1+BjXbmqewwVPEAHlu0QI/8DAM7dHLo7TUllCWTWAIY17eQBzOKDCXFg
	pI33wyH51vOM3ieobE+xQ7M90m2nBmqR6xPLQnduMQ7HiiH7N0Hz/CKEtQIfH9oYoyeP
	uUgX/k2qBlceeXnDHpelFgtHtA1h2R+AMkOT+tIZpWigWkKJGwEWYvJZJgweSzgky6JY
	CMSw==
X-Gm-Message-State: APjAAAWyVJSW6gNrxUhB6IQvI8xGk20UQDvTeSJXt75nDrGUdFNzD4ww
	dAkBUvLLejoDQPKpRWN0Yn3uFA==
X-Google-Smtp-Source: APXvYqwTTbjRQ7ofVZPa4oi4LYoLoyzXKFeDZ+8+8/yle1ZAQ0RYGBsu82aZAblJTfFSxZpJu86lXQ==
X-Received: by 2002:adf:ba93:: with SMTP id p19mr16401378wrg.195.1556643156546;
	Tue, 30 Apr 2019 09:52:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s17sm8463236wra.94.2019.04.30.09.52.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 8C6CE1FF8C;
	Tue, 30 Apr 2019 17:52:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:20 +0100
Message-Id: <20190430165234.32272-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v5 01/15] tests/tcg/multiarch: add support for
 multiarch system tests
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165220.SGc5qiE6Y0vtRdCHVpGKePreyiDmufi_qTvEhed9qBk@z>

We can certainly support some common tests for system emulation that
make use of our minimal defined boot.S support. It will still be up to
individual architectures to ensure they build so we provide a
MULTIARCH_TESTS variable that they can tack onto TESTS themselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile                                 |  1 +
 tests/tcg/multiarch/system/Makefile.softmmu-target | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 1cdd628e96..6fa63cc8d5 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -96,6 +96,7 @@ else
 # build options for bare programs are usually pretty different. They
 # are expected to provide their own build recipes.
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
+-include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
 -include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.softmmu-target
 ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
new file mode 100644
index 0000000000..db4bbeda44
--- /dev/null
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -0,0 +1,14 @@
+# -*- Mode: makefile -*-
+#
+# Multiarch system tests
+#
+# We just collect the tests together here and rely on the actual guest
+# architecture to add to the test dependancies and deal with the
+# complications of building.
+#
+
+MULTIARCH_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/multiarch/system
+VPATH+=$(MULTIARCH_SYSTEM_SRC)
+
+MULTIARCH_TEST_SRCS=$(wildcard $(MULTIARCH_SYSTEM_SRC)/*.c)
+MULTIARCH_TESTS = $(patsubst $(MULTIARCH_SYSTEM_SRC)/%.c, %, $(MULTIARCH_TEST_SRCS))
-- 
2.20.1


