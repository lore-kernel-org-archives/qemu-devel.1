Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ip-0001Ss-NX
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ih-0008Tz-4a
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eH7Ig-0008Te-Ss
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Nov 2017 12:04:34 +0000
Message-Id: <20171121120435.28728-2-stefanha@redhat.com>
In-Reply-To: <20171121120435.28728-1-stefanha@redhat.com>
References: <20171121120435.28728-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 1/2] Use qemu.org domain name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, ehabkost@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

The owner of qemu.org has delegated authority to modify DNS records to
the QEMU Project.  This has allowed us to use the domain name without
worries about IP address changes or technical issues disrupting service.
The issues described in commit 859389810910f232188675d2f10b15f1aad77660
("Use qemu-project.org domain name") have therefore been mitigated.

This patch switches back to consistently using qemu.org instead of
qemu-project.org in documentation, version.rc, and the Windows installer
script.

The git submodules and SeaBIOS still use qemu-project.org for the time
being.  This will be fixed in the QEMU 2.12 release cycle.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/qmp-intro.txt |  2 +-
 docs/rdma.txt              |  2 +-
 Changelog                  |  2 +-
 README                     | 16 ++++++++--------
 pc-bios/README             |  4 ++--
 qemu.nsi                   |  2 +-
 scripts/get_maintainer.pl  |  2 +-
 scripts/qmp/qemu-ga-client |  2 +-
 version.rc                 |  2 +-
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index 60deafbae6..f1b60bcfa0 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -83,4 +83,4 @@ Please, refer to the qapi-schema.json file for a complete command reference.
 QMP wiki page
 -------------
 
-http://wiki.qemu-project.org/QMP
+http://wiki.qemu.org/QMP
diff --git a/docs/rdma.txt b/docs/rdma.txt
index 2bdd0a5be0..f3eaaa004c 100644
--- a/docs/rdma.txt
+++ b/docs/rdma.txt
@@ -1,7 +1,7 @@
 (RDMA: Remote Direct Memory Access)
 RDMA Live Migration Specification, Version # 1
 ==============================================
-Wiki: http://wiki.qemu-project.org/Features/RDMALiveMigration
+Wiki: http://wiki.qemu.org/Features/RDMALiveMigration
 Github: git@github.com:hinesmr/qemu.git, 'rdma' branch
 
 Copyright (C) 2013 Michael R. Hines <mrhines@us.ibm.com>
diff --git a/Changelog b/Changelog
index 1249b8aac5..13eebefb74 100644
--- a/Changelog
+++ b/Changelog
@@ -1,6 +1,6 @@
 This file documents changes for QEMU releases 0.12 and earlier.
 For changelog information for later releases, see
-http://wiki.qemu-project.org/ChangeLog or look at the git history for
+http://wiki.qemu.org/ChangeLog or look at the git history for
 more detailed information.
 
 
diff --git a/README b/README
index cb60d05bee..34ee588cd8 100644
--- a/README
+++ b/README
@@ -44,9 +44,9 @@ of other UNIX targets. The simple steps to build QEMU are:
 
 Additional information can also be found online via the QEMU website:
 
-  http://qemu-project.org/Hosts/Linux
-  http://qemu-project.org/Hosts/Mac
-  http://qemu-project.org/Hosts/W32
+  http://qemu.org/Hosts/Linux
+  http://qemu.org/Hosts/Mac
+  http://qemu.org/Hosts/W32
 
 
 Submitting patches
@@ -54,7 +54,7 @@ Submitting patches
 
 The QEMU source code is maintained under the GIT version control system.
 
-   git clone git://git.qemu-project.org/qemu.git
+   git clone git://git.qemu.org/qemu.git
 
 When submitting patches, the preferred approach is to use 'git
 format-patch' and/or 'git send-email' to format & send the mail to the
@@ -65,8 +65,8 @@ guidelines set out in the HACKING and CODING_STYLE files.
 Additional information on submitting patches can be found online via
 the QEMU website
 
-  http://qemu-project.org/Contribute/SubmitAPatch
-  http://qemu-project.org/Contribute/TrivialPatches
+  http://qemu.org/Contribute/SubmitAPatch
+  http://qemu.org/Contribute/TrivialPatches
 
 
 Bug reporting
@@ -85,7 +85,7 @@ reported via launchpad.
 
 For additional information on bug reporting consult:
 
-  http://qemu-project.org/Contribute/ReportABug
+  http://qemu.org/Contribute/ReportABug
 
 
 Contact
@@ -101,6 +101,6 @@ main methods being email and IRC
 Information on additional methods of contacting the community can be
 found online via the QEMU website:
 
-  http://qemu-project.org/Contribute/StartHere
+  http://qemu.org/Contribute/StartHere
 
 -- End
diff --git a/pc-bios/README b/pc-bios/README
index 5b6bb133d2..25fc6ce63f 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -23,7 +23,7 @@
   legacy x86 software to communicate with an attached serial console as
   if a video card were attached.  The master sources reside in a subversion
   repository at http://sgabios.googlecode.com/svn/trunk.  A git mirror is
-  available at git://git.qemu-project.org/sgabios.git.
+  available at git://git.qemu.org/sgabios.git.
 
 - The PXE roms come from the iPXE project. Built with BANNER_TIME 0.
   Sources available at http://ipxe.org.  Vendor:Device ID -> ROM mapping:
@@ -40,7 +40,7 @@
 
 - The u-boot binary for e500 comes from the upstream denx u-boot project where
   it was compiled using the qemu-ppce500 target.
-  A git mirror is available at: git://git.qemu-project.org/u-boot.git
+  A git mirror is available at: git://git.qemu.org/u-boot.git
   The hash used to compile the current version is: 2072e72
 
 - Skiboot (https://github.com/open-power/skiboot/) is an OPAL
diff --git a/qemu.nsi b/qemu.nsi
index 1a2d7d18a8..5ee0e6e5e1 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -20,7 +20,7 @@
 ; NSIS_WIN32_MAKENSIS
 
 !define PRODUCT "QEMU"
-!define URL     "http://www.qemu-project.org/"
+!define URL     "http://www.qemu.org/"
 
 !define UNINST_EXE "$INSTDIR\qemu-uninstall.exe"
 !define UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}"
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 711a9a6bd0..07369aa8ea 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1376,7 +1376,7 @@ sub vcs_exists {
 	warn("$P: No supported VCS found.  Add --nogit to options?\n");
 	warn("Using a git repository produces better results.\n");
 	warn("Try latest git repository using:\n");
-	warn("git clone git://git.qemu-project.org/qemu.git\n");
+	warn("git clone git://git.qemu.org/qemu.git\n");
 	$printed_novcs = 1;
     }
     return 0;
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index fd056056ff..bc8803234f 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -33,7 +33,7 @@
 # $ qemu-ga-client fsfreeze freeze
 # 2 filesystems frozen
 #
-# See also: http://wiki.qemu-project.org/Features/QAPI/GuestAgent
+# See also: http://wiki.qemu.org/Features/QAPI/GuestAgent
 #
 
 import base64
diff --git a/version.rc b/version.rc
index d42ef62962..a50d62fa0c 100644
--- a/version.rc
+++ b/version.rc
@@ -13,7 +13,7 @@ FILESUBTYPE VFT2_UNKNOWN
   {
     BLOCK "040904E4"
     {
-      VALUE "CompanyName", "http://www.qemu-project.org"
+      VALUE "CompanyName", "http://www.qemu.org"
       VALUE "FileDescription", "QEMU machine emulators and tools"
       VALUE "FileVersion", QEMU_VERSION
       VALUE "LegalCopyright", "Copyright various authors. Released under the GNU General Public License."
-- 
2.14.3
