Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5607C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8071B217D9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5QXXnuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8071B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58103 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmWs-0006Qp-D8
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:08:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO6-0006xQ-QK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO5-0004rd-OK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO5-0004qd-HZ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:17 -0400
Received: by mail-wm1-x344.google.com with SMTP id n25so4038279wmk.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HYpRsvHEmUYvBYy6wQQpwlcDtNoNBQtfcPxm0CQghqY=;
	b=K5QXXnuqpMpsblN5MWXxlJdH7hUHKZE0RVI1U+xGNC4t1l4uHqqElDSlYwJVQlB1mO
	7wxQEoj8jDclS5b8s2iecgoFqTD8aPOI+/rWlZktKLu0XYJ1jVXcw1HPJEFhbuJPWwJq
	e7gy9q3vQdzQGDNIv8b6sSLGbzKRxD8IWibgKIEzjqwxjG9xNaLDnF6oAGhbX2vbn7mg
	Lu0ObcVlR6HVstFEp+Lzw9+xN8U+RpA3dRuKIxIZeErX6hDKf/2fiFeckwQmxxo7cHIJ
	fawt5lJC70NRSr9+7NeEqxEqSbHerxSIRkNywNci3+VXITNK2D+cWvTtYMeBk7vfg3GH
	c0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HYpRsvHEmUYvBYy6wQQpwlcDtNoNBQtfcPxm0CQghqY=;
	b=Yb3AFfw3ud6yPmWQHh3bZP0nGib6vWGJ6RGnTu8toMY8jkZiOOh1jgG5QGoKZqVYZi
	vgj5bZ0tv60xPZ5uyNGAJbwZsyp/7mUWXqmbdp7qpe4fuS4Vi9VSHzrzu4KXzKa/NQlc
	VtlJJ5TJ47oarkF9jSRGToCfOe77gdNBUfEyZBS55sLe32vu2ZqXfMrcHMqgVxVcYWcx
	sxzNnREEM7V+Dg5zDwRDjtVtNKexlkSZGfby0GcaBYiBNlmK9YLpwer0EYHCRPWHVtk6
	ewQUBVX7sQtQL0S0z1ORYFykuv+Aobihs5ZFxElranpej336RaIho2ez/7XhBM0ESXLo
	OTKw==
X-Gm-Message-State: APjAAAVLkeV6VtgudG6KLhwvMvC2OzQgE0LKnc/L5CzXtEEpF5JnclXt
	B4LEokZxR8082QvbIE0BwEKMCw==
X-Google-Smtp-Source: APXvYqwtbGlwC2h6I39wmwXZBhsVv4tKK1qk1WOlcMoD7bnpv7V5o7AOPcYT/c0ehSkh09yENwVAvw==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr3511639wmc.130.1557421156454; 
	Thu, 09 May 2019 09:59:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o130sm1684973wmo.43.2019.05.09.09.59.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5DD361FF91;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:52 +0100
Message-Id: <20190509165912.10512-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 04/23] tests/tcg/multiarch: add hello world
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


