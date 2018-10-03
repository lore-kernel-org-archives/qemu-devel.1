Received: from eggs.gnu.org ([2001:4830:134:3::10]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7h5H-00012F-Mj
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7h5D-0006A9-Q0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:20:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7h5D-00069b-Ip
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:20:55 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5C174E33A
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 13:20:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 17:20:41 +0400
Message-Id: <20181003132041.10075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: remove glib_subprocess check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This should have been removed as part of commit
692fbdf9f4c6f6bafd0b3a4d4f94973effd3bbae.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configure b/configure
index a7368044cc..4f6d6e03b1 100755
--- a/configure
+++ b/configure
@@ -3557,12 +3557,6 @@ if ! compile_prog "$CFLAGS" "$LIBS" ; then
 	       "build target"
 fi
=20
-# g_test_trap_subprocess added in 2.38. Used by some tests.
-glib_subprocess=3Dyes
-if ! $pkg_config --atleast-version=3D2.38 glib-2.0; then
-    glib_subprocess=3Dno
-fi
-
 # Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usage
 cat > $TMPC << EOF
 #include <glib.h>
--=20
2.19.0.271.gfe8321ec05
