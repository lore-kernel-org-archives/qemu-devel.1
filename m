Received: from eggs.gnu.org ([2001:4830:134:3::10]:35452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejozJ-0006fm-Pu
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejozF-0005Jg-Sx
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ejozF-0005JY-NZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53F4D4023141
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 16:23:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Feb 2018 17:23:42 +0100
Message-Id: <20180208162343.30809-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180208162343.30809-1-marcandre.lureau@redhat.com>
References: <20180208162343.30809-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] build-sys: check static linking of UBSAN
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 41d8a2666c..beb0de6a77 100755
--- a/configure
+++ b/configure
@@ -5247,7 +5247,15 @@ fi
 ##########################################
 # checks for sanitizers
=20
-write_c_skeleton
+# we could use a simple skeleton for flags chekcs, but this also
+# detect the static linking issue of ubsan, see also:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285
+cat > $TMPC << EOF
+#include <stdint.h>
+int main(void) {
+  return INT32_MIN / -1;
+}
+EOF
=20
 have_asan=3Dno
 have_ubsan=3Dno
--=20
2.16.1.73.g5832b7e9f2
