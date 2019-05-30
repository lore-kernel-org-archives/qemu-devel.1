Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B6EC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53C125733
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D03hb4mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53C125733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIIQ-0003vR-Pg
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:28:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFG-0001Ek-At
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFE-0000JA-07
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWIFD-00008r-F3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id w13so3810123wru.11
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ULMYDzDhsSMCX4YzAm5KDo0Ff4IgPy209ucg+FKeKHM=;
	b=D03hb4mjDfpx448Oph86YwD6jxyYp+jxB2vt3SOVA7eoNHOMFlMfG92dAMqv2dQ0V/
	aX7VPgrmUwLDABImVrGqIn/LsTqQP5MUb9bdP9fXtO5EhcQBT89lWC/LpRDNlKLW8zM1
	RJQ1DKWuvUiar7JFNIl6lnWSLab2ajSUjKh7PIoC7B8IDyi4O0nkStmsXfnTTR4PyPF8
	fRifYyrp7480MZOwUkwOjVhiVxBQJC3qzhj8ILyCtiV94t1C3alknzwsBcKLr61ZQ5P9
	o6E9OK6xQtV/m2fQaaaau8jYCmIQzXljLZvylpvdkEnMHcx7EDNczQZN4I8HkDpJ38dB
	G4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ULMYDzDhsSMCX4YzAm5KDo0Ff4IgPy209ucg+FKeKHM=;
	b=T+uGeRZRDd+zLecSES8mj1ijWdv5E6CyjNP0pxyGLPHRcBkT/bv1BUQlpbVlcEPKGF
	QkuZRLECin+a7D/w/qBju0qEh9WIwp1hEPpBZ3MgQEFfg6L4tkdU6xnTmnv8AartHs/j
	gE6sUJxjneEjmQZN0KTEfBfg1NQCJLmIKAn0TOtw9dzH26ApssgT2Z0Z1L5PICJuzPat
	12g4xj1tDfY6u0vvKWcDkNDcb6F1rLW3o1Z0/JJ1MccbwdoxzoRrtGceU8GeKP9MMAdd
	F5qV2J84+NRsWhl5y/Sw56I/IGOnFPK2iH/2x+hXy4eUPWH6o5R5nSm9KuTm+4O5Tzqq
	5Jkw==
X-Gm-Message-State: APjAAAWkEvBFBapGaIJdckjCiPKeMVJept72prg0WKgGMX03iuS8vI5e
	gMpNvaZL7rL1uJSF459tEOunEBY7hTM=
X-Google-Smtp-Source: APXvYqwY1y9nJKAF9CrdAhZ32M7rNLKM3C9crXbvP+RVHCBBYfp+QZzxjG2eTUww4MfSZ7ljKKfU1A==
X-Received: by 2002:adf:f951:: with SMTP id q17mr2033922wrr.173.1559211906831; 
	Thu, 30 May 2019 03:25:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id j9sm2297440wrr.90.2019.05.30.03.25.02
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:25:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AE5B31FF87;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:57 +0100
Message-Id: <20190530101603.22254-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH  v1 20/26] tests/vm: add DEBUG=1 to help text
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190520124716.30472-9-kraxel@redhat.com>
[AJB: fix minor conflict]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index e329129bd65..628eecade78 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -25,6 +25,8 @@ vm-test:
 	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
 	@echo
 	@echo "Special variables:"
+	@echo "    DEBUG=1                       - be verbose, also start interactive"
+	@echo "	                                   shell on build failures"
 	@echo "    BUILD_TARGET=foo		 - Override the build target"
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
-- 
2.20.1


