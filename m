Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88073C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6841D20838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6841D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn56n-0000E7-DT
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn561-0005Zk-BA
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn55y-0007qG-8F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn55w-0007fs-4H; Mon, 15 Jul 2019 13:49:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A09385542;
 Mon, 15 Jul 2019 17:48:58 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 347075C225;
 Mon, 15 Jul 2019 17:48:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Date: Mon, 15 Jul 2019 19:48:10 +0200
Message-Id: <20190715174817.18981-4-philmd@redhat.com>
In-Reply-To: <20190715174817.18981-1-philmd@redhat.com>
References: <20190715174817.18981-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 15 Jul 2019 17:48:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v2 3/9] tests/docker: Install the NSIS
 tools in the MinGW capable images
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes:

  $ make installer
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=3D${i%.exe}; \
             arch=3D${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                  -DCONFIG_DOCUMENTATION=3D"y" \
                   \
                  -DBINDIR=3D"/tmp/qemu-nsis" \
                   \
                  -DSRCDIR=3D"/home/phil/source/qemu" \
                  -DOUTFILE=3D"qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION=3D"4.0.90" \
                  /home/phil/source/qemu/qemu.nsi
  /bin/sh: 1: makensis: not found
  Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
  make: *** [qemu-setup-4.0.90.exe] Error 127

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-win32-cross.docker | 3 +++
 tests/docker/dockerfiles/debian-win64-cross.docker | 3 +++
 tests/docker/dockerfiles/fedora.docker             | 1 +
 3 files changed, 7 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/d=
ocker/dockerfiles/debian-win32-cross.docker
index c787e43245..77f5cc45e9 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -9,6 +9,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=20
 ENV TARGET i686
=20
+ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
+
 RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
@@ -19,6 +21,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         mxe-$TARGET-w64-mingw32.shared-lzo \
         mxe-$TARGET-w64-mingw32.shared-nettle \
         mxe-$TARGET-w64-mingw32.shared-ncurses \
+        mxe-$TARGET-w64-mingw32.shared-nsis \
         mxe-$TARGET-w64-mingw32.shared-pixman \
         mxe-$TARGET-w64-mingw32.shared-pkgconf \
         mxe-$TARGET-w64-mingw32.shared-pthreads \
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/d=
ocker/dockerfiles/debian-win64-cross.docker
index a7068ed6ac..3908c5abc4 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -9,6 +9,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=20
 ENV TARGET x86-64
=20
+ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
+
 RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
@@ -19,6 +21,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         mxe-$TARGET-w64-mingw32.shared-lzo \
         mxe-$TARGET-w64-mingw32.shared-nettle \
         mxe-$TARGET-w64-mingw32.shared-ncurses \
+        mxe-$TARGET-w64-mingw32.shared-nsis \
         mxe-$TARGET-w64-mingw32.shared-pixman \
         mxe-$TARGET-w64-mingw32.shared-pkgconf \
         mxe-$TARGET-w64-mingw32.shared-pthreads \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index f6be5e2dd7..cc9bef189a 100644
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
--=20
2.20.1


