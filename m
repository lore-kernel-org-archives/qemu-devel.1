Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B4C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A5120851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYP46Kqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A5120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33337 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlC8-000421-Jh
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:43:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvO-0005zp-E7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvM-0001WS-D4
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkvM-0000yj-4X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1126426wma.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fv7yjgipiPIa0iKuBxA7WsxKljcgZAsZBYR7nSKLcJ0=;
	b=oYP46KqnsGKZxyofy6qTfPkl95SddVnioUefAwX/iBSZxtWeE599gY1vwK6vEbecmp
	abFcOpYtLhjWrt+tI23Yh6V0p7z2GzE6ngxGpheOJFrlr8+ZaPrTxdgrs4Q8whv4hVvk
	3TM+QbuJn+k28CqP96Ll9xEFKsn5TIfzu75/SP9C42GuzTDIKWzFcY1KjSk3NMgRbNrg
	vnLknKtDCJEbd4vorkQhU9FLn51rtTqvCNTokPaRAcJqDFbW542Rv37iCjTCctBLr2Ps
	onuWjwNXGkwLioSi0AQUEv9n+utxbIJvr4Oy7YfduhrWzAjy9MIlVaLyJXIXZ+6wDjg8
	CxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fv7yjgipiPIa0iKuBxA7WsxKljcgZAsZBYR7nSKLcJ0=;
	b=TJBLLlRvwY3/mOpw9BJOPTWO0AwrOWn1A7j0a8MAFBIEilg30az3RVHyVh18h6AuzJ
	mDMKE8aKKgEmn8U1I84PFDu8Uc3Yz3pg0BhdKKThQVFaRCbQ0P+GEtmU3gxMCeCtg3uC
	WI71/zjU2H3l08ygzfq4DBoilMpznWhKMo3Q4m1QpFFUPHlGJSo/Ua27VNTFx1w+ZMHr
	eskMVeeM5BxFAdPzegKjNxffAgKCll1PoXu9A4U7E9mioTK1ohqWOt0m+wVrKwsT40EK
	TfztvpmdsPn0SYxFOeN66KUD7qfnbyvUy2dQDfrCo93VE+luS/w8zedXx4vEBECOBi1v
	wo5g==
X-Gm-Message-State: APjAAAVu2BEFVcspXBT+Ar9KdSzUpQs6VSiSkXHn88nQnSShaW82NVkD
	8A54GKmlwnRZ1qChgibztJwVXw==
X-Google-Smtp-Source: APXvYqyjuWv+zcr8wmpex7JhqyOizPdYqdIlAwuXXFES5XA624FYONJl9BdwtRINmqtI+yrrdQPcpA==
X-Received: by 2002:a1c:2dd2:: with SMTP id
	t201mr11012074wmt.136.1558607142564; 
	Thu, 23 May 2019 03:25:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a10sm31509345wrm.94.2019.05.23.03.25.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:40 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AFD191FF9D;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:18 +0100
Message-Id: <20190523102532.10486-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 14/28] tests/tcg/multiarch: add support for
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


