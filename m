Received: from eggs.gnu.org ([2001:4830:134:3::10]:42411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePraD-0004JQ-BO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePra7-00017j-AA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePra7-00016r-3F
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51A172D5A0E
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:07:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:49 +0100
Message-Id: <20171215150659.1811-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/13] build-sys: add a rule to print a
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

$ make print-CFLAGS
CFLAGS=3D-fsanitize=3Daddress -Og -g

Trick from various sources:
https://stackoverflow.com/questions/16467718/how-to-print-out-a-variable-=
in-makefile
https://www.cmcrossroads.com/article/printing-value-makefile-variable

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 Makefile                    |  5 ++++-
 docs/devel/build-system.txt | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 199f39fde1..46bc61004d 100644
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
diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 386ef36ee3..52501f2ad9 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -510,3 +510,16 @@ default-configs/$TARGET-NAME file as input.
 This is the entrypoint used when make recurses to build a single system
 or userspace emulator target. It is merely a symlink back to the
 Makefile.target in the top level.
+
+
+Useful make targets
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- help
+
+  Print a help message for the most common build targets.
+
+- print-VAR
+
+  Print the value of the variable VAR. Useful for debugging the build
+  system.
--=20
2.15.1.355.g36791d7216
