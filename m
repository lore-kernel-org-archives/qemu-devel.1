Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D530AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEB22133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOyjw/0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEB22133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl4Q-0005Rs-QG
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:35:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvK-0005uh-21
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvA-0001JN-LW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv4-0000zM-DN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id x64so5213265wmb.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HYpRsvHEmUYvBYy6wQQpwlcDtNoNBQtfcPxm0CQghqY=;
	b=VOyjw/0T4oebmx77bf0SHWLiR23yNN2todyLRTnN3phauS6u4en+7PF2TB9IzPZ4GF
	Ja8FU3oLAKB/5PPR3Q8GZJJWQ2Lmy2KYUh8X77guFGyL9KnqyWAf7rL08rH08kOoAp1b
	E2rSUGwtoEoDh9fHjcczOoWHV4ZhCcDJzzhRSe9RrK2Rref0FW5ltXm4dqM90MiWA68J
	KjXyzvxsSjMaaJNXbYHluD6NG6auM0bPK0K++9XdbnXtoThcKPupam++99sMExuQhpN0
	xh0NksEQl9CbuGu354AzfTCk21ThkkLHOI05OLPjF4ojvsBF4376Ntop8CezPCgBQech
	0NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HYpRsvHEmUYvBYy6wQQpwlcDtNoNBQtfcPxm0CQghqY=;
	b=KCZrbkIQCa3/E+eVBmTKqMiFS2YKvdMvAmzHPYNa07qeSGbmqUJ3VieiewIPkl3DlG
	9ymBzb0iHQKW5RIQQn1sAY0rgiJCSw65ogVIvk1EKTFYnFz8i6QFLJvE6joB+WSIjt2j
	Wf1ziZwKCp0lCN7G+HWqVLOAebQuxGDriZUY7geWgAZTLwn9+tOC12a9+I4ob8PAgItF
	eaGmoD7GKxs1Cg56KDeKeGq9wKcbeojMb7XJgesk2BWFvVEZUAj+7QIiDZCdNHh3Ey60
	s+ldCslfeI2MrjaRo3e+Uff484TeS6tRngMx3IAypJEJFX5+NUfo7JehBq/KbKxJL5aU
	ewSw==
X-Gm-Message-State: APjAAAVoX8t1BxM0+MP0FYzwvm51kalPqJijeYIkyMA+5ha7/+X1hT7W
	SuVuk6mMqhUzSt+j2A/geIkNYQ==
X-Google-Smtp-Source: APXvYqzLEMOJf1y5zQ8SwgV11AxQYs2hq2mQLAP4mDzDesjywV22L8JxCxf7dO1dhxBFkJQXsN9aKA==
X-Received: by 2002:a1c:be12:: with SMTP id o18mr10888052wmf.124.1558607142996;
	Thu, 23 May 2019 03:25:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x68sm8801239wmf.13.2019.05.23.03.25.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:40 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C21C71FF9E;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:19 +0100
Message-Id: <20190523102532.10486-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 15/28] tests/tcg/multiarch: add hello world
 system test
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not really i386 only, we can have the same test for all
architectures supporting system tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/i386/Makefile.softmmu-target       | 2 +-
 tests/tcg/{i386 => multiarch}/system/hello.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 53c9c5ece06..c31bbbf39a7 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -27,7 +27,7 @@ CFLAGS+=-m32
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
 # FIXME: move to common once x86_64 is bootstrapped
-TESTS+=$(X86_TESTS)
+TESTS+=$(X86_TESTS) $(MULTIARCH_TESTS)
 endif
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
diff --git a/tests/tcg/i386/system/hello.c b/tests/tcg/multiarch/system/hello.c
similarity index 100%
rename from tests/tcg/i386/system/hello.c
rename to tests/tcg/multiarch/system/hello.c
-- 
2.20.1


