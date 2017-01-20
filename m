Received: from eggs.gnu.org ([2001:4830:134:3::10]:53712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIk-0004LQ-5z
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIj-0006d6-E4
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIj-0006cE-7L
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68CED3A7683
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:32:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:37 +0100
Message-Id: <20170120133139.31080-34-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/35] Revert "win32: don't run subprocess tests
 on Mingw32 platform"
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This reverts commit 7ad9339e372fcd12d584684d7f52ac259604a4f4.

The error "Failed to execute helper program (No such file or directory)"
is due to broken glib installation, missing windows gspawn helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170104205722.26492-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 091ae05..1f2ee71 100755
--- a/configure
+++ b/configure
@@ -3079,7 +3079,7 @@ fi
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
2.9.3
