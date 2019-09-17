Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F2EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A4E20578
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNW72x08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A4E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIWR-0000n1-Fi
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPe-0003BB-Ki
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPd-0000D4-BB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAIPd-0000CI-4U
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so4271546wro.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rlSvkcXczqc1cNe9s/EmLRGBxbkZT67vdQCCwyIuOR0=;
 b=mNW72x08U3Vy52QeYIVjXyesNxtKxcSzs+spBUEgCwkjn/WmMegu90e8AMDmF09gEx
 oUdX/Eo0Aokc/N4D5nNMlRKSSz4D/cWyRWmUDuONcjWbn3CX17kmb6hwMb18WZkwRw6F
 G8/8zFNnaG2K4J+gYOadhsI1J7JJnckiRcfsqAX452UvnwbsXJpwpLX1rjqBCt4u05GZ
 xuv+mK9ESHcrrIKBEOZFYx9QMEbvGyIGEFs+dDGI9poGTH1o4hevjp7tyTNhKvcnMCOL
 AtxzwW78fEzCYJvPCdxeAx/HntO4cv8PoLMCk5m6ydd5zQsi1E0FkzkTVGgC2YMOm8HC
 CQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rlSvkcXczqc1cNe9s/EmLRGBxbkZT67vdQCCwyIuOR0=;
 b=DQhsA+RkRd0MZ9BFWVUxJOpNWA0qTtGGMSKy4hKpApH4+4DyV6Ky/KzCvVAysvgIvn
 Pqx2r/G9kVn4KK2vobS6kjiX2parVbEoW3eE8cgZy2ZDk9L3sJIhpJyyEQGlcblLrtWx
 20RT8aJJwvYhlF0FzgVi3MBNY7QT68HLOvGM1B0/nWFd2J3r+Hn40m0+7qdGAup5LVOz
 N9ht65RE4f4O7axVO/zCPg7j65LANerKPsyXFLyJAvp69uclJ3JaSjkdDnpSPxa9iJqc
 fzRYtMUs6d5oMrzQvW0j0NH9Cz0/m/JhfI6tlv3ndy8IIQV0TOmiloZOO7lyNJdumMWk
 e3Eg==
X-Gm-Message-State: APjAAAXWchRaC88CpabDlNdXLjtCmxr6cxc6J5S+WkoVGXPd1FyCS50X
 V5P1ameHCpnBkoGa18zUUWuA+A==
X-Google-Smtp-Source: APXvYqxwsgTQjIZPSpQPwiO4n8htmpTRCPOxJoWtx6yvrSs3N3muVgnk7+6XUBwnB2tRc+W+p57tmw==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr61703wrv.240.1568745675965;
 Tue, 17 Sep 2019 11:41:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q22sm2243959wmj.5.2019.09.17.11.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 11:41:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EDA071FF93;
 Tue, 17 Sep 2019 19:41:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 17 Sep 2019 19:41:06 +0100
Message-Id: <20190917184109.12564-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917184109.12564-1-alex.bennee@linaro.org>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 6/9] tests/tcg: re-enable linux-test for
 ppc64abi32
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have fixed the signal delivary bug we can remove this horrible
hack from the system.

Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/configure.sh              |  1 +
 tests/tcg/multiarch/Makefile.target | 11 +++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 6c4a471aeae..e8a1a1495fc 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -54,6 +54,7 @@ fi
 : ${cross_cc_cflags_ppc="-m32"}
 : ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
 : ${cross_cc_cflags_ppc64="-m64"}
+: ${cross_cc_cflags_ppc64abi32="-mcpu=power8"}
 : ${cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"}
 : ${cross_cc_cflags_s390x="-m64"}
 : ${cross_cc_cflags_sparc="-m32 -mv8plus -mcpu=ultrasparc"}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 6b1e30e2fec..657a04f802d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -12,14 +12,6 @@ VPATH 		+= $(MULTIARCH_SRC)
 MULTIARCH_SRCS   =$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
 MULTIARCH_TESTS  =$(MULTIARCH_SRCS:.c=)
 
-# FIXME: ppc64abi32 linux-test seems to have issues but the other basic tests work
-ifeq ($(TARGET_NAME),ppc64abi32)
-BROKEN_TESTS = linux-test
-endif
-
-# Update TESTS
-TESTS		+= $(filter-out $(BROKEN_TESTS), $(MULTIARCH_TESTS))
-
 #
 # The following are any additional rules needed to build things
 #
@@ -39,3 +31,6 @@ run-test-mmap: test-mmap
 run-test-mmap-%: test-mmap
 	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
 		"$< ($* byte pages) on $(TARGET_NAME)")
+
+# Update TESTS
+TESTS += $(MULTIARCH_TESTS)
-- 
2.20.1


