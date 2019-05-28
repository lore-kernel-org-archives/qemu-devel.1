Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D56C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E488208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrtZMIu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E488208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYy2-0001Eh-7m
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:04:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkC-0006KE-7G
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkB-0000Ct-7j
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYkB-0000B5-29
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so19473519wrs.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=c6ckUXNY8YtrdJt2PGJuuiNEz2jhFg33XnClUpP+3OA=;
	b=BrtZMIu9sFhJAYg545BYs5wwNpO7LfqWqewPdAQNceOYrQY4SpIusyiNi9JPsxxlIR
	CaYvHOZc7Egmk2HXqnM+WT5G3kSEPF65tIuVPDodgg5llVCxDFS43xu6uCUWMmNVR7Ef
	kP0NnEQygsejb14fGnAaQTWvw0QFdByxwXPgM4Ewf2eBnF6SKzVg1GgpTO9z+7LZNe4m
	R/AbIe3fiYoFYsGu+48+mtNgeKZNl4UXvtjPj+IF3dJ94A0hCUyND2T6/ZWx1n6dpFfd
	aflgwa8ywIdo5wHv5BPDd7Jn1FTt+SnEGewhEeZ16oNntPxAgl1TGijWM0inSloKJS84
	7J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=c6ckUXNY8YtrdJt2PGJuuiNEz2jhFg33XnClUpP+3OA=;
	b=t/itnYYWwvZqtktZNIU81YRab3LqEE9SP07u7GAEho4NjHpD4fd2fxvjMl/Bk8Plck
	jg0+ZM7Xf2MSgzZBH6nWudS3JkD3X8vrZU9/v/YD0VfNuYngVJuy4HJ+cPzgmCeU7o0z
	qXStSXiWpRGOpLqyXyvDATF9qIELE+b5ZMPN4zM7B+NUvzsFTRS34xG94dkHrXOSZ5nU
	crCR+5HPBb0yWnBdKiEwG25XL55E60lR+6yx8mP9qyhYx0K3N8mSzjWaQ8IpSHOxx7Wk
	VVPm908khnbKQ2Ul87zIIRBHz4gjSz9EvFWclRYmUIvFNLPt665wNou+pF9MIFxRWGaA
	pwVg==
X-Gm-Message-State: APjAAAVqxnnGXx5Z061P1ckax6ykWDgIPOfO7x0bSRF4BLXNTYFlJn0S
	nii5QXSYpVdaSq2dCSp4qrqywA==
X-Google-Smtp-Source: APXvYqzpr+4zvpxTeM/cWq4A6UZU8YWJToqgcY/I6FvjtH+VryCz2F8l5Q7vZnHhkhR3d/66HL0UFg==
X-Received: by 2002:adf:e80a:: with SMTP id o10mr17022177wrm.79.1559037005360; 
	Tue, 28 May 2019 02:50:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id a2sm7731931wrg.69.2019.05.28.02.49.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:50:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AA09F1FF9D;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:39 +0100
Message-Id: <20190528094953.14898-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 14/28] tests/tcg/multiarch: add support for
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org,
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


