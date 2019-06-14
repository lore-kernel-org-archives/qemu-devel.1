Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9015C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC0320665
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC0320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjH6-00040J-Sw
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbj8E-0004Rg-F9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbj8D-0000m1-Cb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:08:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbj8A-0000kC-LS; Fri, 14 Jun 2019 06:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1629308425B;
 Fri, 14 Jun 2019 10:08:21 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB301001DCD;
 Fri, 14 Jun 2019 10:08:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 12:07:16 +0200
Message-Id: <20190614100718.14019-8-philmd@redhat.com>
In-Reply-To: <20190614100718.14019-1-philmd@redhat.com>
References: <20190614100718.14019-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 14 Jun 2019 10:08:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/9] configure: Link test before
 auto-enabling GTK libraries
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

Similarly to commit a73e82ef912, test the libraries link correctly
before considering them as usable.

This fixes using ./configure --static on Ubuntu 18.04:

  $ make subdir-lm32-softmmu
  [...]
  LINK    lm32-softmmu/qemu-system-lm32
  /usr/bin/ld: cannot find -lgtk-3
  /usr/bin/ld: cannot find -latk-bridge-2.0
  /usr/bin/ld: cannot find -latspi
  /usr/bin/ld: cannot find -lsystemd
  /usr/bin/ld: cannot find -lgdk-3
  /usr/bin/ld: cannot find -lwayland-cursor
  /usr/bin/ld: cannot find -lwayland-egl
  /usr/bin/ld: cannot find -lwayland-client
  /usr/bin/ld: cannot find -lepoxy
  /usr/bin/ld: cannot find -lgraphite2
  collect2: error: ld returned 1 exit status
  Makefile:204: recipe for target 'qemu-system-lm32' failed
  make[1]: *** [qemu-system-lm32] Error 1

  $ fgrep gdk config-host.mak
  GTK_LIBS=3D-lgtk-3 -latk-bridge-2.0 -latspi -ldbus-1 -lpthread -lsystem=
d -lgdk-3 -lgio-2.0 -lXinerama -lXi -lXrandr -lXcursor -lXcomposite -lXda=
mage -lXfixes -lxkbcommon -lwayland-cursor -lwayland-egl -lwayland-client=
 -lepoxy -ldl -lpangocairo-1.0 -lpangoft2-1.0 -lharfbuzz -lm -lgraphite2 =
-lpango-1.0 -lm -latk-1.0 -lcairo-gobject -lcairo -lz -lpixman-1 -lfontco=
nfig -lexpat -lfreetype -lexpat -lfreetype -lpng16 -lm -lz -lm -lxcb-shm =
-lxcb-render -lXrender -lXext -lX11 -lpthread -lxcb -lXau -lXdmcp -lgdk_p=
ixbuf-2.0 -lm -lpng16 -lm -lz -lm -lz -lgio-2.0 -lz -lresolv -lselinux -l=
mount -lgmodule-2.0 -pthread -ldl -lgobject-2.0 -lffi -lglib-2.0 -pthread=
 -lpcre -pthread -lX11 -lpthread -lxcb -lXau -lXdmcp
VTE_CFLAGS=3D-pthread -I/usr/include/vte-2.91 -I/usr/include/gtk-3.0 -I/u=
sr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-=
1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gtk-3.0 -=
I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/u=
sr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/i=
nclude/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/i=
nclude/freetype2 -I/usr/include/libpng16 -I/usr/include/gdk-pixbuf-2.0 -I=
/usr/include/libpng16 -I/usr/include/gio-unix-2.0/ -I/usr/include/glib-2.=
0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/p11-kit-1

  $ lsb_release -cri
  Distributor ID: Ubuntu
  Release:        18.04
  Codename:       bionic

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index a3da5adf80..ffd269b34f 100755
--- a/configure
+++ b/configure
@@ -2782,7 +2782,17 @@ if test "$gtk" !=3D "no"; then
             gtk_cflags=3D"$gtk_cflags $x11_cflags"
             gtk_libs=3D"$gtk_libs $x11_libs"
         fi
-        gtk=3D"yes"
+        # Packaging for the static libraries is not always correct.
+        # At least ubuntu 18.04 ships only shared libraries.
+        write_c_skeleton
+        if ! compile_prog "$gtk_cflags" "$gtk_libs" ; then
+            if test "$gtk" =3D "yes" ; then
+              error_exit "gtk check failed."
+            fi
+            gtk=3D"no"
+        else
+            gtk=3D"yes"
+        fi
     elif test "$gtk" =3D "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
     else
--=20
2.20.1


