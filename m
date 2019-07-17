Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B0C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0186208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZgYiQbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0186208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkEJ-0007Pn-19
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDk-0005RQ-FU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDj-0004Zx-7N
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDj-0004ZR-0s
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id p17so24863663wrf.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RNRpRS7GbIkrH2qr5hQXrUti2KQ5HOwEYc9CN8AzWzo=;
 b=sZgYiQbUfXR5qX9VSd8I1yoHryR7pgYk+5TpCtwbeDutLRkXyGicmElSCx4k2ClZPQ
 +cqAmfh7hkowjGIhM5yvujBDpUj+qeRKLAWDTNa/AhZXUMN2UCIxcdYmbwMazH8iFj3z
 4AmJQdsaX4SAEL4qimcQ/TX5eeytHN5LLW7QYsvSO1bLv7yr0LJj7KVuEpnlF5Xj+Dad
 ioI3MehAMxi/+lxq9llCss8Urf2NU2wbARhzoE+IjhT1HdrxqbjUJjeDhs2ewvhc1d+y
 s7N6eTXjou5YjpZz93qKpPpApFkPAnqpOLa8FtZjPCsttvttEpE21b2/EMbTEJDSne2H
 dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RNRpRS7GbIkrH2qr5hQXrUti2KQ5HOwEYc9CN8AzWzo=;
 b=dHADBUVRuUMQCQnY4EjuiSJysgMwPIjPwJJRma1QQukNY5P/tRMTxhnEUbrXsAS4UJ
 z7tPepAVUIgRi8VqFJ2AF3G8yLhPR+vC1M19Yu65roZ/JtDeZ0lKOFb8VnWx48lm3Mm8
 1J5ytbKh2iYJGZHnLsSGqd6VJq6kuhbadXAUZPcJf7QnybLshHYcmUOum75nm/VZRFVM
 mYgHUrSFJelPpvFADlcT6XIC4UIHUPbi8IpMsaMeM27bdFkY4Sou3h5soCvLMJrJiHBM
 oH8KVcxxIDadNVKeWpNXMlZZfCGCdTZkKgA2S3WRRFhCr7EiTQ4ooQMPmVDt7NMB1WS5
 TBuw==
X-Gm-Message-State: APjAAAUYoUsq8mwYqiltyuzMvz/ec/lqDYgybCoioyZdgPbPhHMrj2GV
 Ys4JGPiibsNaGP0U5l70JzE6cg==
X-Google-Smtp-Source: APXvYqz/zNc/kdj/rVjMcZZiV7a+XXX0pgbMoCFttHaKQXSTCLvvskLw3YDwzDJOu03LKgTyzCuQpA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr13868384wrp.38.1563371025858; 
 Wed, 17 Jul 2019 06:43:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e5sm25397187wro.41.2019.07.17.06.43.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D42C41FF9B;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:23 +0100
Message-Id: <20190717134335.15351-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PATCH v2 11/23] tests/docker: Set the correct
 cross-PKG_CONFIG_PATH in the MXE images
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This silents a bunch of warnings while compiling the Slirp objects:

 $ make
 [...]
   CC      slirp/src/tftp.o
 Package glib-2.0 was not found in the pkg-config search path.
 Perhaps you should add the directory containing `glib-2.0.pc'
 to the PKG_CONFIG_PATH environment variable
 No package 'glib-2.0' found
   CC      slirp/src/udp6.o
 Package glib-2.0 was not found in the pkg-config search path.
 Perhaps you should add the directory containing `glib-2.0.pc'
 to the PKG_CONFIG_PATH environment variable
 No package 'glib-2.0' found
 [...]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-5-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-win32-cross.docker | 3 +++
 tests/docker/dockerfiles/debian-win64-cross.docker | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
index 77f5cc45e92..dc74ce7e0e0 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -11,6 +11,9 @@ ENV TARGET i686
 
 ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
 
+ENV PKG_CONFIG_PATH \
+    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
+
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
index 3908c5abc42..df7bfce7eab 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -11,6 +11,9 @@ ENV TARGET x86-64
 
 ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
 
+ENV PKG_CONFIG_PATH \
+    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
+
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
-- 
2.20.1


