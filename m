Received: from eggs.gnu.org ([2001:4830:134:3::10]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yR-0007pX-So
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yG-0005K0-Uh
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX0yG-0005JW-OH
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:20 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D00D4274862
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:29:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jan 2017 08:29:15 +0100
Message-Id: <1485502157-25445-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1485502157-25445-1-git-send-email-armbru@redhat.com>
References: <1485502157-25445-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] build-sys: Minor qapi doc generation target
 cleanups
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

Move makeinfo flags from MAKEINFO to MAKEINFOFLAGS.  Fix the call of
quiet-command for target qemu-ga-qapi.texi.  Both messed up in commit
56e8bdd.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1484816804-12598-1-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index c166d2d..1e5cb19 100644
--- a/Makefile
+++ b/Makefile
@@ -542,8 +542,8 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 	ui/shader/texture-blit-vert.h ui/shader/texture-blit-frag.h
=20
 # documentation
-MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'
-MAKEINFOFLAGS=3D--no-split --number-sections
+MAKEINFO=3Dmakeinfo
+MAKEINFOFLAGS=3D--no-split --number-sections -D 'VERSION $(VERSION)'
 TEXIFLAG=3D$(if $(V),,--quiet) --command=3D'@set VERSION $(VERSION)'
=20
 %.html: %.texi
@@ -573,7 +573,7 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SR=
C_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
=20
 qemu-qapi.texi: $(qapi-modules) $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN" "$@")
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
=20
 qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
--=20
2.7.4
