Received: from eggs.gnu.org ([2001:4830:134:3::10]:46610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN6zy-0006kV-TF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN6zx-0007Ww-Rw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eN6zx-0007WH-M2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C67AC883B6
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 00:58:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Dec 2017 01:58:16 +0100
Message-Id: <20171208005825.14587-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171208005825.14587-1-marcandre.lureau@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/12] build-sys: add a rule to print a variable
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

$ make print-CFLAGS
CFLAGS=3D-fsanitize=3Daddress -Og -g

Trick from various sources:
https://stackoverflow.com/questions/16467718/how-to-print-out-a-variable-=
in-makefile
https://www.cmcrossroads.com/article/printing-value-makefile-variable

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ab0354c153..80683e8c8b 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,10 @@ BUILD_DIR=3D$(CURDIR)
 # Before including a proper config-host.mak, assume we are in the source=
 tree
 SRC_PATH=3D.
=20
-UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help
+UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help print=
-%
+
+print-%:
+	@echo '$*=3D$($*)'
=20
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
--=20
2.15.1.355.g36791d7216
