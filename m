Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F9C04AB3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C84C217D8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfLiTxHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C84C217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmTT-0002wX-HO
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:04:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO6-0006wy-4y
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO5-0004qt-1g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO4-0004q2-Qm
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id 198so4145961wme.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fv7yjgipiPIa0iKuBxA7WsxKljcgZAsZBYR7nSKLcJ0=;
	b=CfLiTxHXQS09fZyR7C18+yYYk7t5LmtKTh/UDGhqLIdUJ/BB6YYVC6OgQNXHxchFqE
	u4c7EFzDLFEFMIC9G9jXA+kbK6O0nb3WLFkyGeIX1LHTW79BR1CpC2NHUndW6lVUb3p3
	SYi4asNN4xGO6zgLK+i1KR3j2VZOgKWFWJSXjJCGQQkfxEyg3pG/ksj6kLfNRsBwvCoU
	b2teNuLGwy61PHFjMkLDigxgjqaUqyfJbQGUM1zIc3xYV/KNq0eUF7tPVSkCV2XMoqdd
	hyOiob5TaIcqvbz0QJLSQdNwRnUJbk/E8I1Z1+pbAxZZ2iQQWRUzQOJHf8hmeKZ9JOS0
	K4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fv7yjgipiPIa0iKuBxA7WsxKljcgZAsZBYR7nSKLcJ0=;
	b=q2g4YYT1ycFFzdeQIiO1yUNb8fBxdYwwMwNbVsuFuWmwz6MUK0A+uqkl7awitFT/co
	WeLCeQ59ZZkyOTr9FeFSyVRJiQY3aIc50HrvUF+s78sbQhv4DraIQDNHqiXB9kBkjaeV
	dstMe9ENhoZRgyIIleF1m2lhdXbcpw59cXEJ/33FRoZA305PWbFEOnBg6B/wcRnm4W2S
	fnagyVlxymqBQBMvA+KDpJraOUJw4h2xSvQzzuEaQNq91njXPPqa/wbefJzXj3zaq+fN
	VxgxOCHiovxkyZSI5CuHewUNRHqKyJpIzunNiiaDb/D24OrfKCrFNnCgockLMghAxm8a
	nGgQ==
X-Gm-Message-State: APjAAAUqusazccLqmXrwAwkb6ptglOYJzkNv/GqmbhKqb364cklnSlU3
	yb72i6o5ANOQ272WwWZat4YHB2qeW08=
X-Google-Smtp-Source: APXvYqxbA5awgEXPLUAnSTKabfDEQBdWeITQ8ka7MNBu2YvpbgZeMNOdA4GUIMWBb/7CadZrGrmcIw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr3808663wmc.137.1557421155677; 
	Thu, 09 May 2019 09:59:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id a9sm3360785wmm.48.2019.05.09.09.59.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 49CCF1FF90;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:51 +0100
Message-Id: <20190509165912.10512-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 03/23] tests/tcg/multiarch: add support for
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can certainly support some common tests for system emulation that
make use of our minimal defined boot.S support. It will still be up to
individual architectures to ensure they build so we provide a
MULTIARCH_TESTS variable that they can tack onto TESTS themselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/Makefile                                 |  1 +
 tests/tcg/multiarch/system/Makefile.softmmu-target | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 1cdd628e96f..6fa63cc8d53 100644
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
index 00000000000..db4bbeda44c
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


