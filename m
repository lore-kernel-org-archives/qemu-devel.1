Received: from eggs.gnu.org ([2001:4830:134:3::10]:33209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cOscm-0002g3-44
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cOscj-0008Jw-1s
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:57:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cOsci-0008Jd-SF
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:57:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EF824E047
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 20:57:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  4 Jan 2017 21:57:22 +0100
Message-Id: <20170104205722.26492-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Revert "win32: don't run subprocess tests on
 Mingw32 platform"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This reverts commit 7ad9339e372fcd12d584684d7f52ac259604a4f4.

The error "Failed to execute helper program (No such file or directory)"
is due to broken glib installation, missing windows gspawn helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 218df87d21..54a222d5e7 100755
--- a/configure
+++ b/configure
@@ -3077,7 +3077,7 @@ fi
=20
 # g_test_trap_subprocess added in 2.38. Used by some tests.
 glib_subprocess=3Dyes
-if test "$mingw32" =3D "yes" || ! $pkg_config --atleast-version=3D2.38 g=
lib-2.0; then
+if ! $pkg_config --atleast-version=3D2.38 glib-2.0; then
     glib_subprocess=3Dno
 fi
=20
--=20
2.11.0
