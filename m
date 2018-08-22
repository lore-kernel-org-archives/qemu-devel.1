Received: from eggs.gnu.org ([2001:4830:134:3::10]:43057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsWgA-0004YL-Gz
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsWXI-0005Ru-Ga
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:03:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsWXI-0005RZ-Bd
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:03:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CE00804BAAD
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 17:03:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 19:02:49 +0200
Message-Id: <20180822170250.29573-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180822170250.29573-1-marcandre.lureau@redhat.com>
References: <20180822170250.29573-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/4] configure: require libseccomp 2.2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pmoore@redhat.com, berrange@redhat.com, eblake@redhat.com, Eduardo Otubo <otubo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patch is going to require TSYNC, which is only available
since libseccomp 2.2.0.

libseccomp 2.2.0 was released February 12, 2015.

According to repology, libseccomp version in different distros:

  RHEL-7: 2.3.1
  Debian (Stretch): 2.3.1
  OpenSUSE Leap 15: 2.3.2
  Ubuntu (Xenial):  2.3.1

This will drop support for -sandbox on:

  Debian (Jessie): 2.1.1 (but 2.2.3 in backports)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index e7bddc04b0..5fc2915096 100755
--- a/configure
+++ b/configure
@@ -2228,13 +2228,10 @@ fi
 ##########################################
 # libseccomp check
=20
+libseccomp_minver=3D"2.2.0"
 if test "$seccomp" !=3D "no" ; then
     case "$cpu" in
-    i386|x86_64)
-        libseccomp_minver=3D"2.1.0"
-        ;;
-    mips)
-        libseccomp_minver=3D"2.2.0"
+    i386|x86_64|mips)
         ;;
     arm|aarch64)
         libseccomp_minver=3D"2.2.3"
--=20
2.18.0.547.g1d89318c48
