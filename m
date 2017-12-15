Received: from eggs.gnu.org ([2001:4830:134:3::10]:42382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePra9-0004HV-2K
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePra5-00015e-0f
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePra4-00015E-Qm
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E8D7272A6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:07:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:48 +0100
Message-Id: <20171215150659.1811-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/13] build-sys: silence make by default or
 V=0
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

Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu speci=
fic).

Use --quiet to silence make 'is up to date' message.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile  | 2 +-
 rules.mak | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0331c182ed..199f39fde1 100644
--- a/Makefile
+++ b/Makefile
@@ -274,7 +274,7 @@ else
 DOCS=3D
 endif
=20
-SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory) BUILD_DIR=3D$(BUILD_=
DIR)
+SUBDIR_MAKEFLAGS=3DBUILD_DIR=3D$(BUILD_DIR)
 SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
 SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGET_=
DIRS))
=20
diff --git a/rules.mak b/rules.mak
index 6e943335f3..5fb4951561 100644
--- a/rules.mak
+++ b/rules.mak
@@ -131,6 +131,8 @@ modules:
 # If called with only a single argument, will print nothing in quiet mod=
e.
 quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && =
$1, @$1))
=20
+MAKEFLAGS +=3D $(if $(V),,--no-print-directory --quiet)
+
 # cc-option
 # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0, -malign-func=
tions=3D0)
=20
--=20
2.15.1.355.g36791d7216
