Received: from eggs.gnu.org ([2001:4830:134:3::10]:42359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKRQ9-0002Bf-Uk
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKRQ6-0007Kb-VS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:25 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKRQ6-0007KJ-LR
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:22 -0400
Received: by mail-wr0-x241.google.com with SMTP id e23so22871710wre.3
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 08:38:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jun 2017 17:38:15 +0200
Message-Id: <20170612153816.15266-2-pbonzini@redhat.com>
In-Reply-To: <20170612153816.15266-1-pbonzini@redhat.com>
References: <20170612153816.15266-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] docs: create interop/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com

This is for the future interoperability & management guide.  It includes
the QAPI docs, including the automatically generated ones, other socket
protocols (vhost-user, VNC), and the qcow2 file format.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                                         | 16 ++---
 Makefile                                           | 69 +++++++++++++---------
 configure                                          |  2 +-
 docs/{specs => interop}/parallels.txt              |  0
 docs/{specs => interop}/qcow2.txt                  |  0
 docs/{specs => interop}/qed_spec.txt               |  0
 docs/{ => interop}/qemu-ga-ref.texi                |  0
 docs/{ => interop}/qemu-qmp-ref.texi               |  0
 docs/{ => interop}/qmp-intro.txt                   |  0
 docs/{ => interop}/qmp-spec.txt                    |  0
 docs/{specs => interop}/vhost-user.txt             |  0
 .../{ => interop}/vnc-ledstate-Pseudo-encoding.txt |  0
 rules.mak                                          |  2 +-
 13 files changed, 50 insertions(+), 39 deletions(-)
 rename docs/{specs => interop}/parallels.txt (100%)
 rename docs/{specs => interop}/qcow2.txt (100%)
 rename docs/{specs => interop}/qed_spec.txt (100%)
 rename docs/{ => interop}/qemu-ga-ref.texi (100%)
 rename docs/{ => interop}/qemu-qmp-ref.texi (100%)
 rename docs/{ => interop}/qmp-intro.txt (100%)
 rename docs/{ => interop}/qmp-spec.txt (100%)
 rename docs/{specs => interop}/vhost-user.txt (100%)
 rename docs/{ => interop}/vnc-ledstate-Pseudo-encoding.txt (100%)

diff --git a/.gitignore b/.gitignore
index 55a001e3b8..11bb1b12da 100644
--- a/.gitignore
+++ b/.gitignore
@@ -99,14 +99,14 @@
 /pc-bios/optionrom/kvmvapic.img
 /pc-bios/s390-ccw/s390-ccw.elf
 /pc-bios/s390-ccw/s390-ccw.img
-/docs/qemu-ga-qapi.texi
-/docs/qemu-ga-ref.html
-/docs/qemu-ga-ref.info*
-/docs/qemu-ga-ref.txt
-/docs/qemu-qmp-qapi.texi
-/docs/qemu-qmp-ref.html
-/docs/qemu-qmp-ref.info*
-/docs/qemu-qmp-ref.txt
+/docs/interop/qemu-ga-qapi.texi
+/docs/interop/qemu-ga-ref.html
+/docs/interop/qemu-ga-ref.info*
+/docs/interop/qemu-ga-ref.txt
+/docs/interop/qemu-qmp-qapi.texi
+/docs/interop/qemu-qmp-ref.html
+/docs/interop/qemu-qmp-ref.info*
+/docs/interop/qemu-qmp-ref.txt
 /docs/version.texi
 *.tps
 .stgit-*
diff --git a/Makefile b/Makefile
index 32d4441697..c27389af28 100644
--- a/Makefile
+++ b/Makefile
@@ -207,8 +207,8 @@ HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
-DOCS+=docs/qemu-qmp-ref.html docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7
-DOCS+=docs/qemu-ga-ref.html docs/qemu-ga-ref.txt docs/qemu-ga-ref.7
+DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
+DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 ifdef CONFIG_VIRTFS
 DOCS+=fsdev/virtfs-proxy-helper.1
 endif
@@ -519,11 +519,12 @@ distclean: clean
 	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f docs/qemu-ga-qapi.texi docs/qemu-qmp-qapi.texi docs/version.texi
-	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
-	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
-	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
-	rm -f docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
+	rm -f docs/version.texi
+	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
+	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
+	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
+	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
+	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -562,13 +563,13 @@ install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 ifneq ($(TOOLS),)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -576,9 +577,9 @@ ifneq ($(TOOLS),)
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) docs/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
 endif
 endif
 ifdef CONFIG_VIRTFS
@@ -666,8 +667,10 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 
 # documentation
 MAKEINFO=makeinfo
-MAKEINFOFLAGS=--no-split --number-sections -I docs
-TEXIFLAG=$(if $(V),,--quiet)
+MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
+MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
+TEXI2PODFLAGS=$(MAKEINFOINCLUDES)
+TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
 
 docs/version.texi: $(SRC_PATH)/VERSION
 	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
@@ -684,10 +687,14 @@ docs/version.texi: $(SRC_PATH)/VERSION
 	--plaintext $< -o $@,"GEN","$@")
 
 %.pdf: %.texi
-	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I docs $< -o $@,"GEN","$@")
+	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
-docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.txt docs/qemu-ga-ref.pdf docs/qemu-ga-ref.7.pod: docs/version.texi
-docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.pod: docs/version.texi
+docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.info \
+    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.pdf \
+    docs/interop/qemu-ga-ref.7.pod: docs/version.texi
+docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.info \
+    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.pdf \
+    docs/interop/qemu-qmp-ref.pod: docs/version.texi
 
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
@@ -701,12 +708,12 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-docs/qemu-qmp-qapi.texi docs/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
+docs/interop/qemu-qmp-qapi.texi docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
 
-docs/qemu-qmp-qapi.texi: $(qapi-modules)
+docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
-docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
+docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
@@ -716,21 +723,25 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 
-html: qemu-doc.html docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
-info: qemu-doc.info docs/qemu-qmp-ref.info docs/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
+html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
+info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
+pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
+txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi
 
-docs/qemu-ga-ref.dvi docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.pdf docs/qemu-ga-ref.txt docs/qemu-ga-ref.7: \
-docs/qemu-ga-ref.texi docs/qemu-ga-qapi.texi
+docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
+    docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
+    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
+	docs/interop/qemu-ga-ref.texi docs/interop/qemu-ga-qapi.texi
 
-docs/qemu-qmp-ref.dvi docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7: \
-docs/qemu-qmp-ref.texi docs/qemu-qmp-qapi.texi
+docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
+    docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
+    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
+	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
 
 
 ifdef CONFIG_WIN32
diff --git a/configure b/configure
index f438525db8..f4c5d7f6d2 100755
--- a/configure
+++ b/configure
@@ -6365,7 +6365,7 @@ fi
 
 # build tree in object directory in case the source is not in the current directory
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
-DIRS="$DIRS docs fsdev"
+DIRS="$DIRS docs docs/interop fsdev"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 DIRS="$DIRS qapi-generated"
diff --git a/docs/specs/parallels.txt b/docs/interop/parallels.txt
similarity index 100%
rename from docs/specs/parallels.txt
rename to docs/interop/parallels.txt
diff --git a/docs/specs/qcow2.txt b/docs/interop/qcow2.txt
similarity index 100%
rename from docs/specs/qcow2.txt
rename to docs/interop/qcow2.txt
diff --git a/docs/specs/qed_spec.txt b/docs/interop/qed_spec.txt
similarity index 100%
rename from docs/specs/qed_spec.txt
rename to docs/interop/qed_spec.txt
diff --git a/docs/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
similarity index 100%
rename from docs/qemu-ga-ref.texi
rename to docs/interop/qemu-ga-ref.texi
diff --git a/docs/qemu-qmp-ref.texi b/docs/interop/qemu-qmp-ref.texi
similarity index 100%
rename from docs/qemu-qmp-ref.texi
rename to docs/interop/qemu-qmp-ref.texi
diff --git a/docs/qmp-intro.txt b/docs/interop/qmp-intro.txt
similarity index 100%
rename from docs/qmp-intro.txt
rename to docs/interop/qmp-intro.txt
diff --git a/docs/qmp-spec.txt b/docs/interop/qmp-spec.txt
similarity index 100%
rename from docs/qmp-spec.txt
rename to docs/interop/qmp-spec.txt
diff --git a/docs/specs/vhost-user.txt b/docs/interop/vhost-user.txt
similarity index 100%
rename from docs/specs/vhost-user.txt
rename to docs/interop/vhost-user.txt
diff --git a/docs/vnc-ledstate-Pseudo-encoding.txt b/docs/interop/vnc-ledstate-Pseudo-encoding.txt
similarity index 100%
rename from docs/vnc-ledstate-Pseudo-encoding.txt
rename to docs/interop/vnc-ledstate-Pseudo-encoding.txt
diff --git a/rules.mak b/rules.mak
index 1c0eabb367..f95195b569 100644
--- a/rules.mak
+++ b/rules.mak
@@ -380,7 +380,7 @@ define unnest-vars
 endef
 
 TEXI2MAN = $(call quiet-command, \
-	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl -I docs $< $@.pod && \
+	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod && \
 	$(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
 	"GEN","$@")
 
-- 
2.13.0
