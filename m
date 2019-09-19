Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD458C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:02:20 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6FC21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6FC21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuCY-0003Qz-Pp
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuA6-0001wR-3L
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuA4-0005P6-Rj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuA4-0005On-Mp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E19CE309BF06;
 Thu, 19 Sep 2019 10:59:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-74.brq.redhat.com [10.40.204.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 430A8608A5;
 Thu, 19 Sep 2019 10:59:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 12:59:30 +0200
Message-Id: <20190919105932.19412-2-philmd@redhat.com>
In-Reply-To: <20190919105932.19412-1-philmd@redhat.com>
References: <20190919105932.19412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 19 Sep 2019 10:59:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] tests/docker: Add fedora-win10sdk-cross
 image
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Justin Terry <juterry@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/Makefile.include                 |  1 +
 .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 50a400b573..0df72a810b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,6 +125,7 @@ docker-image-debian-ppc64-cross: docker-image-debian1=
0
 docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
+docker-image-fedora-win10sdk-cross: docker-image-fedora
=20
 docker-image-travis: NOUSER=3D1
=20
diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/test=
s/docker/dockerfiles/fedora-win10sdk-cross.docker
new file mode 100644
index 0000000000..1aafdad483
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
@@ -0,0 +1,21 @@
+#
+# Docker MinGW64 cross-compiler target with WHPX header installed
+#
+# This docker target builds on the Fedora 30 base image.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM qemu:fedora
+
+# Install headers extracted by the Android folks from the win10sdk.iso:
+# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
+ENV WIN10SDK_INCDIR /usr/local/include/win10sdk
+RUN mkdir ${WIN10SDK_INCDIR} && \
+    for hdr in WinHvEmulation.h WinHvPlatformDefs.h WinHvPlatform.h; do =
\
+        curl -s "https://android.googlesource.com/platform/prebuilts/gcc=
/linux-x86/host/x86_64-w64-mingw32-4.8/+/1bde9c3b14f3a3b081ada6e32da9f287=
0671b46f/x86_64-w64-mingw32/include/${hdr}?format=3DTEXT" | base64 --deco=
de > ${WIN10SDK_INCDIR}/${hdr}; \
+    done
+
+ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
+    --cross-prefix=3Dx86_64-w64-mingw32- \
+    --extra-cflags=3D"-I ${WIN10SDK_INCDIR}" --disable-werror \
+    --enable-hax --enable-whpx
--=20
2.20.1


