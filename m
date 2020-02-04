Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCDC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBE7217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Glsj5X5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBE7217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3AZ-0007fr-Fm
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37t-0002Oh-3V
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37s-0003MD-0Y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:45 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37r-0003I9-P8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id c84so4947190wme.4
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L9HvZyNljZHrK9e1hH9vtDVXa3gENY0R3TzqxIQy+mE=;
 b=Glsj5X5B3HpHfSssSUXc+gB+PTp8p24Veify96KAXbRnkMnHESWFa0UqU1THIKfNCG
 TLuIK8fQRp2VX//JDNw1LrOuc0w+5c6ZKtzwmbJWdnnZtjF4WF+d9VwKCxxg4k2PfWkB
 dhtFU9vuouxGIVuQOudqCCb7YYXlNj6P63DGANN4E1Zhogss/Rd1WTd82idiCqwk8Xst
 15Doe6eCtLCD250dAFa0cO39/n6IV05nBVFFHsZO04OdU8FrupqIQed1BXRJKwiAkimi
 2RShcwzxBiajP6qGom8L+fCibCJnUriiJp6XAHEWU08M17/E/3odZPw8A9dV6/MC+MvN
 uXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9HvZyNljZHrK9e1hH9vtDVXa3gENY0R3TzqxIQy+mE=;
 b=j9cTZYXCya9NQjH8gzqcICDpwoTX6hOjL5yktwIb0WwWxF1Syw3piXSkg9wi8uU6ZE
 i2lJLcqkO9wHoCqONXlS4L56gZMPnWFG9+L4XHj+ZE9I6KXs3aZJOJuldIE+FXlzbFXh
 vHS/IHlO2hYnJdqskLynt2vf8A2WsBeYUWmYEkSkfM5+nDZfIPdG0tMJUhANXbExRV4w
 oAd1PclOBKKcD3gH31BAVl+W6ugqCPPsJ79ycD+3snSz5oAD0xzjAl9Rntunjd5gG0ZE
 8u/vICt49i0Xf1UAEMc2T6WmRjOtS5eRSN72Z41CV5ktaHL85ECOZcgOoQt1AU4IHZyM
 eFJA==
X-Gm-Message-State: APjAAAUXqBVEP/pbHWSnvfmBFIBCTY+ejXNHhA/fqDgXSPgaIa2ilghD
 7yLT+p2bYEUwe8GTh6NvIFDgmQ==
X-Google-Smtp-Source: APXvYqwoArh4Q4wL7zmW/NG3TgJwq0J0UgwmdxV4+IgkkFYqel4v0VA6Cd2Kq8K3cnAV7SWtIdtHUA==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr324659wml.173.1580841642687; 
 Tue, 04 Feb 2020 10:40:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm4712061wmc.47.2020.02.04.10.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 60E371FF9B;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/16] tests/tcg: gate pauth-% tests on having compiler support
Date: Tue,  4 Feb 2020 18:40:23 +0000
Message-Id: <20200204184028.13708-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise we end up failing to build our tests on CI which may have
older compilers that the user expects. We can get rid of this once we
can fallback to multiarch containers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200203090932.19147-14-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index f6b5121f5ce..d2299b98b76 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -61,7 +61,13 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-run-pauth-3: pauth-3
-pauth-3: CFLAGS += -march=armv8.3-a
+EXTRA_TESTS+=memory-record memory-replay
 
-EXTRA_TESTS+=memory-record memory-replay pauth-3
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
+pauth-3: CFLAGS += -march=armv8.3-a
+else
+pauth-3:
+	$(call skip-test, "BUILD of $@", "missing compiler support")
+run-pauth-3:
+	$(call skip-test, "RUN of pauth-3", "not built")
+endif
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index efa67cf1e9e..8ed477d0d51 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -18,9 +18,11 @@ run-fcvt: fcvt
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 # Pauth Tests
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4
 run-pauth-%: QEMU_OPTS += -cpu max
 pauth-%: CFLAGS += -march=armv8.3-a
+endif
 
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index e0d1fbb182f..9eb6ba3b7ea 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -227,6 +227,10 @@ for target in $target_list; do
                -march=armv8.1-a+sve -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
             fi
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -march=-march=armv8.3-a -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
+            fi
         ;;
     esac
 
-- 
2.20.1


