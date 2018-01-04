Received: from eggs.gnu.org ([2001:4830:134:3::10]:36954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX82M-0006nx-Ib
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX82I-00020P-UZ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:06:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX82I-0001yX-O8
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:06:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E66965F160
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:06:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:07 +0100
Message-Id: <20180104160523.22995-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/18] build-sys: silence make by default or
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
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu speci=
fic).

Use --quiet to silence make 'is up to date' message.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 2 +-
 rules.mak | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d86ecd2dd4..1671db3bdd 100644
--- a/Makefile
+++ b/Makefile
@@ -277,7 +277,7 @@ else
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
