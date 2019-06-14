Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA6C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3ED120665
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ED120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjFM-0001Px-RI
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbj8K-0004eR-2a
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbj8J-0000p4-11
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbj8G-0000no-MF; Fri, 14 Jun 2019 06:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2FD081DF1;
 Fri, 14 Jun 2019 10:08:27 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ADD41001B0F;
 Fri, 14 Jun 2019 10:08:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 12:07:17 +0200
Message-Id: <20190614100718.14019-9-philmd@redhat.com>
In-Reply-To: <20190614100718.14019-1-philmd@redhat.com>
References: <20190614100718.14019-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 14 Jun 2019 10:08:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 8/9] tests/docker: Kludge for missing
 libunistring.so symlink on Ubuntu 18.04
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When linking statically on Ubuntu 18.04 we get:

  $ make subdir-x86_64-softmmu
  [...]
     LINK    x86_64-softmmu/qemu-system-x86_64
  c++: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or =
directory

This library is pulled in by GTK:

  $ pkg-config --libs --static gtk+-3.0
  -lgtk-3 -latk-bridge-2.0 -latspi -ldbus-1 -lpthread -lsystemd -lgdk-3 -=
lgio-2.0 -lXinerama -lXi -lXrandr -lXcursor -lXcomposite -lXdamage -lXfix=
es -lxkbcommon -lwayland-cursor -lwayland-egl -lwayland-client -lepoxy -l=
dl -lpangocairo-1.0 -lpangoft2-1.0 -lharfbuzz -lm -lgraphite2 -lpango-1.0=
 -lm -latk-1.0 -lcairo-gobject -lcairo -lz -lpixman-1 -lfontconfig -lexpa=
t -lfreetype -lexpat -lfreetype -lpng16 -lm -lz -lm -lxcb-shm -lxcb-rende=
r -lXrender -lXext -lX11 -lpthread -lxcb -lXau -lXdmcp -lgdk_pixbuf-2.0 -=
lm -lpng16 -lm -lz -lm -lz -lgio-2.0 -lz -lresolv -lselinux -lmount -lgmo=
dule-2.0 -pthread -ldl -lgobject-2.0 -lffi -lglib-2.0 -pthread -lpcre -pt=
hread

However, while the library is presentm, its symlink is missing:

  $ ls -ld /usr/lib/x86_64-linux-gnu/libunistring.so
  ls: cannot access '/usr/lib/x86_64-linux-gnu/libunistring.so': No such =
file or directory

  $ ls -ld /usr/lib/x86_64-linux-gnu/libunistring.so*
  lrwxrwxrwx. 1 root root      21 Mar  3  2018 /usr/lib/x86_64-linux-gnu/=
libunistring.so.2 -> libunistring.so.2.1.0
  -rw-r--r--. 1 root root 1562664 Mar  3  2018 /usr/lib/x86_64-linux-gnu/=
libunistring.so.2.1.0

Fix the issue by creating the missing symlink manually.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/ubuntu1804.docker | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
index 2e2900150b..7e45c52166 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -54,4 +54,8 @@ ENV PACKAGES flex bison \
 RUN apt-get update && \
     apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
+# The libunistring2 package does not create a symlink to libunistring.so
+# Create it manually to fix:
+# error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or dire=
ctory
+RUN ln -s libunistring.so.2 /usr/lib/x86_64-linux-gnu/libunistring.so
 ENV FEATURES clang pyyaml sdl2
--=20
2.20.1


