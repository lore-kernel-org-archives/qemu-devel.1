Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31BC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0872182B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkgeUcLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0872182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkFK-0003q0-8q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDj-0005M8-HO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDi-0004ZG-3U
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDh-0004Yr-TC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id l2so22244366wmg.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uwej0osFkVecc1FOdZr4jnm39hj3PGH7mOMeiSpdwWM=;
 b=NkgeUcLd9uUdCX/FyNkApLdMESHm9tNZOxvrWMTdgEISNWBBNkShUayPe5gIRcnGOK
 hfb61tzDVlPzmL1vZc7D4vi90fksC+1Pbl4vQTVaKdfL9IViE7uqitVj/vhut9vTn8SN
 PiRaCK3UBvooNDLdAWZzB+IjAa1L2YU8vXmLexKwrnj+7wH/lRpcmIzODgj98nY/GBDO
 +w5LCsaRMZVm6s7qnLXx2tXKN6KR+7K3GfSwKC4y6OvYk7vI52RWRVQ4oWUScevIaaY0
 2cYMqTm5kexrdfMkPOeG79TZ61XgRXKPdSyqzR1Bc652++/PDkRT7rUwPdOehK4PqG9j
 7qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uwej0osFkVecc1FOdZr4jnm39hj3PGH7mOMeiSpdwWM=;
 b=RCA+jm/sfQyRycj1+e1Brz5EihB5UqPLvDDu9CR43y1MGQ168nU21dJNIBMofXgWTS
 e+NBGQofWJGu0PrlmrPa3nZNIK6WfWZ10ONn4RtGG7AQRVhJW6/1ZZC0g8OghFlNMA+R
 Mp4lCOS7Kd0bgOiqzEBLX65uMaD+Lg7C2MyeYtyXG/5kgre/Q3Sm3F0f6nbkbkEZ1uBi
 lwgqKG6o77FjWxqrvMxOMsJwXhXhMtzz9GnuDcb04jiqs9xDZmJNfbfURnYoMo1zT9Zs
 +++r5/htrl0Lt+k+q4Lw9E/iCli34E7pgOUtHSPzTvGfDh9TZZZYjjUNIsAfgWrWHCij
 vX2g==
X-Gm-Message-State: APjAAAW0pnA/Witr+so+ehRAEjVwcuZWav37eJeeo8zmcsxkzxioaaH6
 wmYOnTYiOEdx2QQytueYq3U6Gg==
X-Google-Smtp-Source: APXvYqy0QePNfFzRsN8E7WOpsIjIurvSx40reTgjHa7CgQR3EYVVWEQ/P2Tqzzlkzdo6r4Om6OdW4w==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr39064273wmh.115.1563371024740; 
 Wed, 17 Jul 2019 06:43:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e7sm23480488wmd.0.2019.07.17.06.43.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:40 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF2B31FF9A;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:22 +0100
Message-Id: <20190717134335.15351-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PATCH v2 10/23] tests/docker: Install the NSIS tools
 in the MinGW capable images
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
---
 tests/docker/dockerfiles/debian-win32-cross.docker | 3 +++
 tests/docker/dockerfiles/debian-win64-cross.docker | 3 +++
 tests/docker/dockerfiles/fedora.docker             | 1 +
 3 files changed, 7 insertions(+)

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


