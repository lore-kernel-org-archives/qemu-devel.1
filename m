Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A96C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C121F217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0ujSz4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121F217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtbe-00072F-SG
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSU-0002Py-Om
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSR-00086m-BA
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:32831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSQ-00086S-U5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id b9so3162130wrs.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JFBxNhwZUB6CHbayrqGeU/qxAXPua6XejRKVwrJmAkw=;
 b=k0ujSz4T+r/9rGFRU7tZqyhrrySKGbhZ8oDmdjtuxzhbKP6qhsEwbDnCxIUBgTCkNd
 EXf6xiVNWPb+0/Z8g8r/uPZ61xnsWcmnbNQcv0RKLKd0wUO32+1RsxP62/ykQCmU6f26
 eIllnl37/+eZ9wwSvLgcBSnXkzfT+12Y5HmuPJ/NRzpD+KixBWxc0Ofz6nAH9QhAWlVI
 J1cRmteFAFTSgO6gQL9ujHDszuPZl/7TCeRjKXewmYAz3G2XBI95b3vhXnObk4qXrYdV
 uM2IZGI3MWqnCKRE6V6/nciv+0y94HzIFXsfJOeUqmf/cbPCWRHsytCE8RPWm6SJVahV
 C+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JFBxNhwZUB6CHbayrqGeU/qxAXPua6XejRKVwrJmAkw=;
 b=FbGM+qIU+53V8A5nC7u8r6J/H/5rpq4+6W9eZECSi56LrxwwamYEua+NcW15wnBga7
 0yJHlMSXzwhuwVApQXrqk0P1m0iaqHkpOCinBhT052oqtm21eI7iQOuW2lLoDAyKhuHQ
 yt/xqAPJzEVJSjR9N112RAjakOUTJzuNTRsBJhsQkAwgihK5dTmabVb4MfkIOfejHWDb
 p4mRfl0u7VYzLNfi5ZDTbasqmfeO4elICDdQwJ20q5JpcV+95FZ2OlWoeqHVk2Md//vY
 ofNM3uAhLkasvP7tFGdcS/tK2mwh5VQSX6w1oDJh67kBTzOmkp3JhV/c2GeqSzHLxjlA
 BXHQ==
X-Gm-Message-State: APjAAAUX1PR0kKVHpOF32YyCFCc8FSo34uR6Hp8b0RN0nuMvzY3UK0xu
 /OsBNM5o67rgDi8V+4Maraeo0vBidGBLCA==
X-Google-Smtp-Source: APXvYqx1MxnrW+Pn8pMVLQKqbxClMNAbvimSKg6SgDhUx/cGHLmFhDfCFYMfuY6kE8xL9t4bY6qeAg==
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr7757161wme.96.1569595373669; 
 Fri, 27 Sep 2019 07:42:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] tests/tcg: clean-up some comments after the de-tangling
Date: Fri, 27 Sep 2019 15:42:42 +0100
Message-Id: <20190927144249.29999-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
References: <20190927144249.29999-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

These were missed in the recent de-tangling so have been updated to be
more actuate. I've also built up ARM_TESTS in a manner similar to
AARCH64_TESTS for better consistency.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190913151845.12582-2-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/Makefile.target         |  7 +++++--
 tests/tcg/aarch64/Makefile.target |  3 ++-
 tests/tcg/arm/Makefile.target     | 15 ++++++++-------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8808beaf74b..679eb56bd37 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -74,8 +74,11 @@ TIMEOUT=15
 endif
 
 ifdef CONFIG_USER_ONLY
-# The order we include is important. We include multiarch, base arch
-# and finally arch if it's not the same as base arch.
+# The order we include is important. We include multiarch first and
+# then the target. If there are common tests shared between
+# sub-targets (e.g. ARM & AArch64) then it is up to
+# $(TARGET_NAME)/Makefile.target to include the common parent
+# architecture in its VPATH.
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index e763dd9da37..9758f89f905 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -8,7 +8,7 @@ VPATH 		+= $(ARM_SRC)
 AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
-# we don't build any other ARM test
+# Float-convert Tests
 AARCH64_TESTS=fcvt
 
 fcvt: LDFLAGS+=-lm
@@ -17,6 +17,7 @@ run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
+# Pauth Tests
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU_OPTS += -cpu max
 
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index aa4e4e3782c..7347d3d0adb 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,25 +8,26 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
-ARM_TESTS=hello-arm test-arm-iwmmxt
-
-TESTS += $(ARM_TESTS) fcvt
-
+# Basic Hello World
+ARM_TESTS = hello-arm
 hello-arm: CFLAGS+=-marm -ffreestanding
 hello-arm: LDFLAGS+=-nostdlib
 
+# IWMXT floating point extensions
+ARM_TESTS += test-arm-iwmmxt
 test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
 test-arm-iwmmxt: test-arm-iwmmxt.S
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
-ifeq ($(TARGET_NAME), arm)
+# Float-convert Tests
+ARM_TESTS += fcvt
 fcvt: LDFLAGS+=-lm
 # fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
-
 run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-endif
+
+TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
 EXTRA_RUNS+=run-test-mmap-4096
-- 
2.20.1


