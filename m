Received: from eggs.gnu.org ([2001:4830:134:3::10]:44185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFG-0002YV-8S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFD-0004ZG-52
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:30 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Dec 2017 18:30:14 +0100
Message-Id: <20171218173023.21417-2-armbru@redhat.com>
In-Reply-To: <20171218173023.21417-1-armbru@redhat.com>
References: <20171218173023.21417-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/10] qemu-options: Remove stray colons from
 output of --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

Commit 43f187a broke --help: it put colons into blank lines.  It
removed the colon from DEFHEADING(TITLE:) and added it back in the
macro expansion of DEFHEADING(TITLE), so hxtool can emit "@subsection
TITLE" more easily.  Trouble is it's added back even for the blank
lines made with DEFHEADING().

Put the colons back where they were before commit 43f187a, and strip
them in hxtool instead.

Cc: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options-wrapper.h |  2 +-
 qemu-options.hx        | 27 ++++++++++++++-------------
 scripts/hxtool         |  3 ++-
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 4d7aeb1352..13bfea0294 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -14,7 +14,7 @@
=20
 #define ARCHHEADING(text, arch_mask) \
     if ((arch_mask) & arch_type)    \
-        puts(stringify(text) ":");
+        puts(stringify(text));
=20
 #define DEFHEADING(text) ARCHHEADING(text, QEMU_ARCH_ALL)
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index fe0c29271f..7ac8ade9f9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6,7 +6,7 @@ HXCOMM construct option structures, enums and help messag=
e for specified
 HXCOMM architectures.
 HXCOMM HXCOMM can be used for comments, discarded from both texi and C
=20
-DEFHEADING(Standard options)
+DEFHEADING(Standard options:)
 STEXI
 @table @option
 ETEXI
@@ -584,7 +584,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Block device options)
+DEFHEADING(Block device options:)
 STEXI
 @table @option
 ETEXI
@@ -1187,7 +1187,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(USB options)
+DEFHEADING(USB options:)
 STEXI
 @table @option
 ETEXI
@@ -1252,7 +1252,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Display options)
+DEFHEADING(Display options:)
 STEXI
 @table @option
 ETEXI
@@ -1789,7 +1789,7 @@ STEXI
 ETEXI
 ARCHHEADING(, QEMU_ARCH_I386)
=20
-ARCHHEADING(i386 target only, QEMU_ARCH_I386)
+ARCHHEADING(i386 target only:, QEMU_ARCH_I386)
 STEXI
 @table @option
 ETEXI
@@ -1905,7 +1905,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Network options)
+DEFHEADING(Network options:)
 STEXI
 @table @option
 ETEXI
@@ -2486,7 +2486,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Character device options)
+DEFHEADING(Character device options:)
 STEXI
=20
 The general form of a character device option is:
@@ -2819,7 +2819,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Device URL Syntax)
+DEFHEADING(Device URL Syntax:)
 STEXI
=20
 In addition to using normal file images for the emulated storage devices=
,
@@ -3049,7 +3049,7 @@ STEXI
 @end table
 ETEXI
=20
-DEFHEADING(Bluetooth(R) options)
+DEFHEADING(Bluetooth(R) options:)
 STEXI
 @table @option
 ETEXI
@@ -3125,7 +3125,7 @@ ETEXI
 DEFHEADING()
=20
 #ifdef CONFIG_TPM
-DEFHEADING(TPM device options)
+DEFHEADING(TPM device options:)
=20
 DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
     "-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]\n"
@@ -3215,7 +3215,7 @@ DEFHEADING()
=20
 #endif
=20
-DEFHEADING(Linux/Multiboot boot specific)
+DEFHEADING(Linux/Multiboot boot specific:)
 STEXI
=20
 When using these options, you can use a given Linux or Multiboot
@@ -3271,7 +3271,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Debug/Expert options)
+DEFHEADING(Debug/Expert options:)
 STEXI
 @table @option
 ETEXI
@@ -4177,7 +4177,8 @@ STEXI
 @end table
 ETEXI
 DEFHEADING()
-DEFHEADING(Generic object creation)
+
+DEFHEADING(Generic object creation:)
 STEXI
 @table @option
 ETEXI
diff --git a/scripts/hxtool b/scripts/hxtool
index 1e2c97c5e6..7d7c4289e3 100644
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -19,7 +19,8 @@ hxtoh()
 print_texi_heading()
 {
     if test "$*" !=3D ""; then
-        printf "@subsection %s\n" "$*"
+        title=3D"$*"
+        printf "@subsection %s\n" "${title%:}"
     fi
 }
=20
--=20
2.13.6
