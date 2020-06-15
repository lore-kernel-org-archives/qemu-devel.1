Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9796520739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaUWilzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9796520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpzw-0005bi-S8
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jkpxS-0002On-Sa
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:19:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jkpxQ-0004WK-Ai
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:19:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id c3so17280160wru.12
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K+SeFonBSOo3t0Z274huc5h9np0tWPZf1g8S9xiBi5M=;
 b=NaUWilzAVG4mTfjrG1zyAAxjJAL2UTyd/QGcxmnJ7mhlPiS4RB5y7xsSjvDaTlGwK0
 3ZFMSGqfRBNQXYKZcQ+5dtfRe+bPDKD7jXXCP0mqLB3AzbrWVt/zqAcyx7Y8lok5SSbs
 +ouwkbONitXNWMxjbenKri18tlGOkRQkW8rV2QcYEA1zkFlBXx0xkfuhw91mz0lTTIoz
 oIE5LMDLKaQACb1sIyHqo9QDctJ5A5Q/jMYvVZjSkF+Yox2UwcU7CK/dQtzdeNlHoOx/
 SV7L2CduzN/ncq19dBJFPCRbmMbPjcf8S00SNzq5SO9Zyg6rKJ3ac1KyN8cAiGwL/aZC
 yjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+SeFonBSOo3t0Z274huc5h9np0tWPZf1g8S9xiBi5M=;
 b=QDc8cP/29vCtR5o/EKjWD48mFpyapyo3l0vKtaqRiU5oXDc0LEeQNLthYgzPCudsRQ
 2T6mbvFEkUwGARpkVCY3zk+7ENGNQse0HP03Egl1EQXZOm/2zF1KhppbUIfFQkAv7RKs
 jD+9kROafgT4uHf5W3nkwqDP1jb4baUlxHtFjGa0clmBE+mc1DUBjFsEcpUxoCx6BR0K
 It0xe5tr7/GI7USRe8a/+nekPeMOgN7LOP0qCf1bEz1tyyv6lAx63Iz7koA0plcEiB/Z
 H6HO8O+Z/1P8ZMaNjyh9G0AU4sbLhLk97/9t7sEdQnzGf+SqB/F6Ob3YqbhVYPXYZN+0
 wK+g==
X-Gm-Message-State: AOAM530po5nmCAsuV/wDQ5/BltR4lF/mm2rk/FePLF5uhevrb20T7UA/
 6tmsN8p4ckZCnWhDkGvAdzG0Cg==
X-Google-Smtp-Source: ABdhPJx1SFZ7GFEfBzRfbe1+t423elR4hDOHni0IAR8YOQcXqR438uVbj/Y0wqikZyyAMTwnpeSyKQ==
X-Received: by 2002:adf:b198:: with SMTP id q24mr29107305wra.368.1592230766849; 
 Mon, 15 Jun 2020 07:19:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm23805858wrp.91.2020.06.15.07.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 07:19:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 077F91FF8C;
 Mon, 15 Jun 2020 15:19:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/2] tests/tcg: ensure -cpu max also used for plugin run
Date: Mon, 15 Jun 2020 15:19:22 +0100
Message-Id: <20200615141922.18829-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200615141922.18829-1-alex.bennee@linaro.org>
References: <20200615141922.18829-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The check-tcg plugins build was failing because some special case
tests that needed -cpu max failed because the plugin variant hadn't
carried across the QEMU_OPTS tweak.

Guests which globally set QEMU_OPTS=-cpu FOO where unaffected.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 3 ++-
 tests/tcg/i386/Makefile.target    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 6d60a2f2eed..b617f2ac7e0 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,8 +20,9 @@ run-fcvt: fcvt
 # Pauth Tests
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4
-run-pauth-%: QEMU_OPTS += -cpu max
 pauth-%: CFLAGS += -march=armv8.3-a
+run-pauth-%: QEMU_OPTS += -cpu max
+run-plugin-pauth-%: QEMU_OPTS += -cpu max
 endif
 
 # Semihosting smoke test for linux-user
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 53efec06683..1a6463a7dc1 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -12,6 +12,7 @@ X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
 
 test-i386-pcmpistri: CFLAGS += -msse4.2
 run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
+run-plugin-test-i386-pcmpistri-%: QEMU_OPTS += -cpu max
 
 #
 # hello-i386 is a barebones app
-- 
2.20.1


