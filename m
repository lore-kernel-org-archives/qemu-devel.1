Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F5CC3A5A5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76B720820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APUR2qkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76B720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jgy-000084-Q1
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSp-0004ln-5y
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSm-0004Ik-2j
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSl-0004IL-TI
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id u16so13459746wrr.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aUxDkopVA0y1J5jcpRqMAlfZEeffukwY49gYt/BqlVw=;
 b=APUR2qkSjavQY9LrtTN+X9EBcWbCADcwA7dDu684VLIm8KOHB0o0CszT2e3igJg2H5
 KCtkmU1QHFbt+mCNBqjXeSIyKJk+Qpa7cz5yPuXZel0Ii7JMVqcG04p1X6I4TnJZorSu
 RYSw/9CZoxN19PoH1coug++kQATONXp7LsFXzkDow0ziK8A3kxl+Q4KjfdXldd5oAg7J
 tNT4Mby2GjHWygB7QNHIpWwxk4JkasqpOQJ5P6TZ/c/LEPPOKmsIpL1DpefpnJOoYKnX
 E5Garwl7Hq8YV8FuWvxZJTvJgpOG2mgdOr+Wk/eDK4nrrmmWGW+9R5+vW/GY1k5zOAah
 sQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aUxDkopVA0y1J5jcpRqMAlfZEeffukwY49gYt/BqlVw=;
 b=Kcl1CDaKnAdC/9bTqj5d3gZyVhDVfQusVXNE/c+HkyTy3i6VheQckM5gaGFqDc5U0H
 FO89iG1cJfQK+cQnIMVw67iCZAsw+pn4sAmL50Rl+ipBx9A2dmJkf2PPpce07DT3N3En
 UMnY03DvqIpNa7Mi/ZT7bWmUFDtTdEtoN4Lqd0slC/DigJ9sm0DlmJcb4LDufqtVTK7q
 HE8PfSvK/ME8OkOc3X7Zc8qYVW+0QMN1aHh74Zvb9jzNJRD+AZOr0N2qREkYWJZrh8Wm
 dm74hgZBgWcUOLhzGkdx8NxCEue2FVR5QdRyQsq5cTNrc6zJerygJ0ck4bMVxF8+cvJo
 3tPQ==
X-Gm-Message-State: APjAAAVEMpHqjYrOFbR8+Y1i2CkasOWu+CarMAMSzsOKDVQLwFCHALbo
 bhXCUCbl5YDRosM7BEkxh9ZaFw==
X-Google-Smtp-Source: APXvYqy28FTe87QkDHIB8SOWff46+x5+M3nIo2a9tP64nY+Emveptbs1c7wXJPqknn3lOBY5LFx5Pw==
X-Received: by 2002:adf:dd0c:: with SMTP id a12mr2875304wrm.289.1567419690813; 
 Mon, 02 Sep 2019 03:21:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u68sm21051837wmu.12.2019.09.02.03.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C5191FF9A;
 Mon,  2 Sep 2019 11:21:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:20 +0100
Message-Id: <20190902102122.1128-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 10/12] build-sys: build ui-spice-app as a module
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This reverts commit 45db1ac157 ("modules-test: ui-spice-app is not
built as module") and fixes commit d8aec9d9f1 ("display: add -display
spice-app launching a Spice client").

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190827140241.20818-1-marcandre.lureau@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/modules-test.c b/tests/modules-test.c
index f9de3afdb77..a8118e90427 100644
--- a/tests/modules-test.c
+++ b/tests/modules-test.c
@@ -52,6 +52,9 @@ int main(int argc, char *argv[])
 #endif
 #ifdef CONFIG_SDL
         "ui-", "sdl",
+#endif
+#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
+        "ui-", "spice-app",
 #endif
     };
     int i;
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index cc2bf5b180f..ba39080edb2 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -49,7 +49,9 @@ curses.mo-objs := curses.o
 curses.mo-cflags := $(CURSES_CFLAGS) $(ICONV_CFLAGS)
 curses.mo-libs := $(CURSES_LIBS) $(ICONV_LIBS)
 
-common-obj-$(call land,$(CONFIG_SPICE),$(CONFIG_GIO)) += spice-app.mo
+ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
+common-obj-$(if $(CONFIG_MODULES),m,y) += spice-app.mo
+endif
 spice-app.mo-objs := spice-app.o
 spice-app.mo-cflags := $(GIO_CFLAGS)
 spice-app.mo-libs := $(GIO_LIBS)
-- 
2.20.1


