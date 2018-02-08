Received: from eggs.gnu.org ([2001:4830:134:3::10]:35451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejozJ-0006fk-Pp
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejozE-0005JF-RJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ejozE-0005Is-N6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C62347D824
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 16:23:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Feb 2018 17:23:41 +0100
Message-Id: <20180208162343.30809-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] build-sys: remove useless extra*flags
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Only EXTRA_LDFLAGS seems to be used during configure Xen checks.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configure b/configure
index 831ebf248f..41d8a2666c 100755
--- a/configure
+++ b/configure
@@ -471,10 +471,8 @@ for opt do
   --cpu=3D*) cpu=3D"$optarg"
   ;;
   --extra-cflags=3D*) QEMU_CFLAGS=3D"$QEMU_CFLAGS $optarg"
-                    EXTRA_CFLAGS=3D"$optarg"
   ;;
   --extra-cxxflags=3D*) QEMU_CXXFLAGS=3D"$QEMU_CXXFLAGS $optarg"
-                      EXTRA_CXXFLAGS=3D"$optarg"
   ;;
   --extra-ldflags=3D*) LDFLAGS=3D"$LDFLAGS $optarg"
                      EXTRA_LDFLAGS=3D"$optarg"
@@ -1424,7 +1422,6 @@ case "$cpu" in
 esac
=20
 QEMU_CFLAGS=3D"$CPU_CFLAGS $QEMU_CFLAGS"
-EXTRA_CFLAGS=3D"$CPU_CFLAGS $EXTRA_CFLAGS"
=20
 # For user-mode emulation the host arch has to be one we explicitly
 # support, even if we're using TCI.
@@ -5817,9 +5814,6 @@ if test "$mingw32" =3D "no" ; then
   echo "qemu_localstatedir=3D$local_statedir" >> $config_host_mak
 fi
 echo "qemu_helperdir=3D$libexecdir" >> $config_host_mak
-echo "extra_cflags=3D$EXTRA_CFLAGS" >> $config_host_mak
-echo "extra_cxxflags=3D$EXTRA_CXXFLAGS" >> $config_host_mak
-echo "extra_ldflags=3D$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=3D$libs_softmmu" >> $config_host_mak
 echo "GIT=3D$git" >> $config_host_mak
--=20
2.16.1.73.g5832b7e9f2
