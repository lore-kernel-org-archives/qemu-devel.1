Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE78C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC38206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0w6Xxfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC38206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYlP-0002KZ-SW
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:27:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhH-0007N1-RS
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhG-0008Rl-Jm
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYYhG-0008Py-Ad
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id m3so4297671wrv.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=rcKOmyd4ZaJmv55WtxWWnJZ8WFn3ij4YBnIuaHka/0g=;
	b=H0w6XxfmZPjrAr6usSvL4nzgsJYDFQDo1HNicJwdUrCTSzThYkYoOQwRL/hjH5LMdC
	MchbzrqgG9IMEpW1JY7bpZKIt227RUl9r8bGdSImmfhIM+ec6T4veUN3sBd7R6xiE4FJ
	dDQWmwAGFz/8pVThvUkSiankXeVXrOLz54bxm7IeDo2tP89fDDZss2n1sEMfHaq0641F
	dg9QDdjUnQh8pBBY1wPdTb5THKkvnbVG2tuXva0ZF7Gnrhvr66nzfU+N87baNTVoHDZ5
	PpRcpzRbCi6P2kUIMLXUQQh0x7pfPGyyZlaq4EIndCo/os7syt01udm0ra7jQ/ARJ8fE
	uAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=rcKOmyd4ZaJmv55WtxWWnJZ8WFn3ij4YBnIuaHka/0g=;
	b=OUAZS5sj0u+h1EhWv2px5vAgLvV/JHpNVJqG01cCkyYbRY2oKtOKYXplkh/PbxtNbU
	O+upYZhKTQUKghXNj7J4N+r9efx/gcqOGwUaZ8iHI1qbmUuk8xo5qTNBw/PQHRoqHYhs
	qFWdjWEZoHHJ8S7VfD/HAYD5oQgHqtHqv6hdKccsdFwpKXp3VVhkOgOJCdxHSdH4GGEm
	Vh/wiQ9IPvW0/yApFSAvUzRmBCFJaehR+lJffRcFrvfiEHg6zUjN6haAYH2ecpJhZJnY
	JdcZXZzw1fQ4l9XA1/HNzWVRw19URot++rKWS23PVW9/dIHH8s1BFZDOzQAb7WiLl3UV
	JDJg==
X-Gm-Message-State: APjAAAVNJChzoMo8B6mGgIYmSfKdp2MgHUwq/jLbZBWif0NxKZZsAeHR
	CK98UoI4aG4ecD13jpGlD8D0cg==
X-Google-Smtp-Source: APXvYqxU4GLaBDSW9YYV1IqGchVaC/aFXCBvPzwBWyoZ091v6gqQvvWiz74Ycqxwx0QAMUrnOeWAng==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr4963637wrm.117.1559751809247; 
	Wed, 05 Jun 2019 09:23:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o1sm36394944wre.76.2019.06.05.09.23.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 09:23:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CE7D31FF90;
	Wed,  5 Jun 2019 17:23:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 17:23:25 +0100
Message-Id: <20190605162326.13896-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605162326.13896-1-alex.bennee@linaro.org>
References: <20190605162326.13896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 3/4] tests/tcg: clean-up VPATH/TESTS for i386
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we only run build the multiarch tests and we use a fully
resolved path for the crt object we don't need the wildcard or VPATH
messing about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.softmmu-target | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index e1f98177aa..e1d880f9b5 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -8,15 +8,10 @@
 
 I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
 X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-# Set search path for all sources
-VPATH+=$(I386_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-X86_TEST_SRCS=$(wildcard $(I386_SYSTEM_SRC)/*.c)
-X86_TESTS = $(patsubst $(I386_SYSTEM_SRC)/%.c, %, $(X86_TEST_SRCS))
-
 ifeq ($(TARGET_X86_64), y)
 CRT_PATH=$(X64_SYSTEM_SRC)
 LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
@@ -26,12 +21,12 @@ CRT_PATH=$(I386_SYSTEM_SRC)
 CFLAGS+=-m32
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-# FIXME: move to common once x86_64 is bootstrapped
-TESTS+=$(X86_TESTS) $(MULTIARCH_TESTS)
 endif
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
+TESTS+=$(MULTIARCH_TESTS)
+
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
 
-- 
2.20.1


