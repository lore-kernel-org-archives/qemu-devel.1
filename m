Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2CC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA17F21655
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwZQC+jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsBd-0005wU-Qh
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9g-00067V-LN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9f-0007SD-Dq
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9f-0007Qw-6C
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id g67so33921748wme.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JxhRJPthXwD0jkNCvy1f0oAonRtBCJFL3sFbTnWENEg=;
 b=qwZQC+jD3WCCDZp/CtYaOfnQcywI7fF7tjPXRv03YTpOsiEU61iRDuiXJP41oC9P2E
 en1ubnSWOGvK0rhuzydoECUPrwtMGcYDk9NIr5TS9ozbfG59cfL4mam01XE7F0nfaL9+
 oTGHa9OBIomRR39h+HSGpJ6vvnn4bVqQ4ZRvmQoJzdfvchijSryk0jHULWdbczXRfkhI
 AXp2U5M0pmDd+/nUiLJJIxCUpJDj81xZi/X56T3lz4YBKtw9EWb5Fsck+E6su+h5mOWR
 /iOEMyqLom7m860Fj5ROmp04+gFX2GLxEGyUWEQPdwdu7S7qNy+N/g0MHwnB6BvQXpli
 VTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JxhRJPthXwD0jkNCvy1f0oAonRtBCJFL3sFbTnWENEg=;
 b=W4p/jwOahZSfLT3n8tTMbmwxmYqTm/Gsvbing+GLZTLl6vAqTji3Lp+xaqFrK0y1I/
 naKOEnj2+7p/rS0Z0SBBxsgtIHBiJO56LMAXECBDcj8q0OOroxncTmowYFID2z05caeE
 9MNqnQgsVnowYtp5ILW/OQzkeKo4fmj2+JOt8334i1xlDylYUJKdkig/GJr9swgdG+Qh
 BkK+TIyWMp/0rw1urJZAisBOXJ5wtyAsYAHbzqo0uHcB+JQHBKeuZRyYrN76Lp+XmVtH
 YjZmAAAXjH4F9o8e/PI2ZcAzWT9jEo/oMR6XbLrbQhf4JumT4kdddiLOlamddPaueLaU
 yAHw==
X-Gm-Message-State: APjAAAXTDyJC5OUzswkEYSaqqTfgfIIZ71nM5wkeZpp5w20IB8QS9nUv
 xeu7GIr1ewL0QAiSZgk4aBVZKg==
X-Google-Smtp-Source: APXvYqxG2zCzCVPQsNcxcPRcmgh1J1rYaB8ys7yyBVxLoapTcElt+BOaTxiAs9EG+7NJGFoGwBHj0Q==
X-Received: by 2002:a1c:a7c6:: with SMTP id
 q189mr69553043wme.146.1563878182086; 
 Tue, 23 Jul 2019 03:36:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k9sm30856009wmi.33.2019.07.23.03.36.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 468861FF9A;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:59 +0100
Message-Id: <20190723103612.5600-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 10/23] tests/docker: Install the NSIS tools in
 the MinGW capable images
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This fixes:

  $ make installer
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=${i%.exe}; \
             arch=${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                  -DCONFIG_DOCUMENTATION="y" \
                   \
                  -DBINDIR="/tmp/qemu-nsis" \
                   \
                  -DSRCDIR="/home/phil/source/qemu" \
                  -DOUTFILE="qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION="4.0.90" \
                  /home/phil/source/qemu/qemu.nsi
  /bin/sh: 1: makensis: not found
  Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
  make: *** [qemu-setup-4.0.90.exe] Error 127

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-4-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
index c787e432454..77f5cc45e92 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -9,6 +9,8 @@ MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 ENV TARGET i686
 
+ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
+
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
@@ -19,6 +21,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         mxe-$TARGET-w64-mingw32.shared-lzo \
         mxe-$TARGET-w64-mingw32.shared-nettle \
         mxe-$TARGET-w64-mingw32.shared-ncurses \
+        mxe-$TARGET-w64-mingw32.shared-nsis \
         mxe-$TARGET-w64-mingw32.shared-pixman \
         mxe-$TARGET-w64-mingw32.shared-pkgconf \
         mxe-$TARGET-w64-mingw32.shared-pthreads \
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
index a7068ed6ac6..3908c5abc42 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -9,6 +9,8 @@ MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 ENV TARGET x86-64
 
+ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
+
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
@@ -19,6 +21,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         mxe-$TARGET-w64-mingw32.shared-lzo \
         mxe-$TARGET-w64-mingw32.shared-nettle \
         mxe-$TARGET-w64-mingw32.shared-ncurses \
+        mxe-$TARGET-w64-mingw32.shared-nsis \
         mxe-$TARGET-w64-mingw32.shared-pixman \
         mxe-$TARGET-w64-mingw32.shared-pkgconf \
         mxe-$TARGET-w64-mingw32.shared-pthreads \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 2350d494d9a..226ac1026fa 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -52,6 +52,7 @@ ENV PACKAGES \
     mingw32-libpng \
     mingw32-libtasn1 \
     mingw32-nettle \
+    mingw32-nsis \
     mingw32-pixman \
     mingw32-pkg-config \
     mingw32-SDL2 \
-- 
2.20.1


