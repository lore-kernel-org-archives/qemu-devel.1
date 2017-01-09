Received: from eggs.gnu.org ([2001:4830:134:3::10]:46514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb2R-0002BG-LM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb2N-0003GO-Sd
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:35:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cQb2N-0003Fr-N9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:35:03 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAF1E811A9
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:35:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  9 Jan 2017 15:34:33 +0100
Message-Id: <20170109143437.30554-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170109143437.30554-1-marcandre.lureau@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 17/21] build-sys: use --no-split for info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Splitting the info files doesn't bring much benefits these days.
This fixes also untracked generated info files from git ignore.

Let's use MAKEINFOFLAGS for common flags, --number-sections is already
the default anyway, so adding it doesn't change the info output.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 361773634d..0bc470d974 100644
--- a/Makefile
+++ b/Makefile
@@ -529,17 +529,17 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
=20
 # documentation
 MAKEINFO=3Dmakeinfo
-MAKEINFOFLAGS=3D--no-headers --no-split --number-sections
+MAKEINFOFLAGS=3D--no-split --number-sections
 TEXIFLAG=3D$(if $(V),,--quiet)
 %.dvi: %.texi
 	$(call quiet-command,texi2dvi $(TEXIFLAG) -I . $<,"GEN","$@")
=20
 %.html: %.texi
-	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --html $< =
-o $@, \
-	"GEN","$@")
+	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
+	--html $< -o $@,"GEN","$@")
=20
 %.info: %.texi
-	$(call quiet-command,$(MAKEINFO) $< -o $@,"GEN","$@")
+	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
=20
 %.pdf: %.texi
 	$(call quiet-command,texi2pdf $(TEXIFLAG) -I . $<,"GEN","$@")
--=20
2.11.0
