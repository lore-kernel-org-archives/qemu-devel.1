Received: from eggs.gnu.org ([2001:4830:134:3::10]:44643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGW9-0004O8-AV
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGW8-0006Ey-Dc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cEGW8-0006EV-7C
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BE1A6834
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 14:14:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  6 Dec 2016 17:13:40 +0300
Message-Id: <20161206141343.28044-15-marcandre.lureau@redhat.com>
In-Reply-To: <20161206141343.28044-1-marcandre.lureau@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 14/17] build-sys: remove dvi doc generation
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

There is no clear reason to have rules to generate dvi format
documentation, pdf is generally better supported.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile   | 12 ++++--------
 .gitignore |  1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 0bc470d974..f2b9ef0784 100644
--- a/Makefile
+++ b/Makefile
@@ -80,7 +80,7 @@ GENERATED_HEADERS +=3D module_block.h
 Makefile: ;
 configure: ;
=20
-.PHONY: all clean cscope distclean dvi html info install install-doc \
+.PHONY: all clean cscope distclean html info install install-doc \
 	pdf recurse-all speed test dist msi FORCE
=20
 $(call set-vpath, $(SRC_PATH))
@@ -389,7 +389,7 @@ distclean: clean
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
-	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps qemu-doc.dvi
+	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr
@@ -531,9 +531,6 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 MAKEINFO=3Dmakeinfo
 MAKEINFOFLAGS=3D--no-split --number-sections
 TEXIFLAG=3D$(if $(V),,--quiet)
-%.dvi: %.texi
-	$(call quiet-command,texi2dvi $(TEXIFLAG) -I . $<,"GEN","$@")
-
 %.html: %.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
 	--html $< -o $@,"GEN","$@")
@@ -587,12 +584,11 @@ qemu-ga.8: qemu-ga.texi
 	  $(POD2MAN) --section=3D8 --center=3D" " --release=3D" " qemu-ga.pod >=
 $@, \
 	  "GEN","$@")
=20
-dvi: qemu-doc.dvi
 html: qemu-doc.html
 info: qemu-doc.info
 pdf: qemu-doc.pdf
=20
-qemu-doc.dvi qemu-doc.html qemu-doc.info qemu-doc.pdf: \
+qemu-doc.html qemu-doc.info qemu-doc.pdf: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi
@@ -689,7 +685,7 @@ help:
 	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
 	@echo  ''
 	@echo  'Documentation targets:'
-	@echo  '  dvi html info pdf'
+	@echo  '  html info pdf'
 	@echo  '                  - Build documentation in specified format'
 	@echo  ''
 ifdef CONFIG_WIN32
diff --git a/.gitignore b/.gitignore
index 3d7848cb7e..6f175b391e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,7 +60,6 @@
 *.a
 *.aux
 *.cp
-*.dvi
 *.exe
 *.msi
 *.dll
--=20
2.11.0
