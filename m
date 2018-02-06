Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j9-0005l5-Hc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iy-0008FC-3V
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34340
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ix-0008Eb-QS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEKpv126689
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhwn1fmj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:10 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:09 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:25 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-5-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/54] qemu-options: Remove stray colons from
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
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

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
Message-Id: <20171002140307.5292-2-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit de6b4f908c300c7e7e0dc057310f5cbdcf1aed78)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
index f11c4ac960..57f2c6a75f 100644
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
@@ -578,7 +578,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Block device options)
+DEFHEADING(Block device options:)
 STEXI
 @table @option
 ETEXI
@@ -1181,7 +1181,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(USB options)
+DEFHEADING(USB options:)
 STEXI
 @table @option
 ETEXI
@@ -1246,7 +1246,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Display options)
+DEFHEADING(Display options:)
 STEXI
 @table @option
 ETEXI
@@ -1783,7 +1783,7 @@ STEXI
 ETEXI
 ARCHHEADING(, QEMU_ARCH_I386)
=20
-ARCHHEADING(i386 target only, QEMU_ARCH_I386)
+ARCHHEADING(i386 target only:, QEMU_ARCH_I386)
 STEXI
 @table @option
 ETEXI
@@ -1899,7 +1899,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Network options)
+DEFHEADING(Network options:)
 STEXI
 @table @option
 ETEXI
@@ -2480,7 +2480,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Character device options)
+DEFHEADING(Character device options:)
 STEXI
=20
 The general form of a character device option is:
@@ -2813,7 +2813,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Device URL Syntax)
+DEFHEADING(Device URL Syntax:)
 STEXI
=20
 In addition to using normal file images for the emulated storage devices=
,
@@ -3043,7 +3043,7 @@ STEXI
 @end table
 ETEXI
=20
-DEFHEADING(Bluetooth(R) options)
+DEFHEADING(Bluetooth(R) options:)
 STEXI
 @table @option
 ETEXI
@@ -3119,7 +3119,7 @@ ETEXI
 DEFHEADING()
=20
 #ifdef CONFIG_TPM
-DEFHEADING(TPM device options)
+DEFHEADING(TPM device options:)
=20
 DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
     "-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]\n"
@@ -3209,7 +3209,7 @@ DEFHEADING()
=20
 #endif
=20
-DEFHEADING(Linux/Multiboot boot specific)
+DEFHEADING(Linux/Multiboot boot specific:)
 STEXI
=20
 When using these options, you can use a given Linux or Multiboot
@@ -3265,7 +3265,7 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Debug/Expert options)
+DEFHEADING(Debug/Expert options:)
 STEXI
 @table @option
 ETEXI
@@ -4171,7 +4171,8 @@ STEXI
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
2.11.0
