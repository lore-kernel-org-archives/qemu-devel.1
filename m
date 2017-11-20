Received: from eggs.gnu.org ([2001:4830:134:3::10]:35060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eGmya-00007E-7f
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eGmyX-0001C0-Sc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:23:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eGmyX-0001Ba-JJ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:23:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 20 Nov 2017 14:22:48 +0000
Message-Id: <20171120142248.16432-3-stefanha@redhat.com>
In-Reply-To: <20171120142248.16432-1-stefanha@redhat.com>
References: <20171120142248.16432-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] Use HTTPS for qemu.org and other domains
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

qemu.org enabled HTTPS in 2017 and it should be used instead of HTTP.
There are also URLs to json.org, openvpn.net, and other domains that
support HTTPS.

This patch updates the qemu.org domains everywhere and also third-party
domains that I have checked.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                |  4 ++--
 docs/interop/qmp-intro.txt |  4 ++--
 docs/pcie.txt              |  4 ++--
 docs/rdma.txt              |  2 +-
 include/qemu-common.h      |  4 ++--
 Changelog                  |  2 +-
 README                     | 16 ++++++++--------
 qemu-doc.texi              | 18 +++++++++---------
 qemu.nsi                   |  2 +-
 scripts/qmp/qemu-ga-client |  2 +-
 version.rc                 |  2 +-
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffd77b461c..372afce813 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -61,7 +61,7 @@ F: */
 
 Responsible Disclosure, Reporting Security Issues
 ------------------------------
-W: http://wiki.qemu.org/SecurityProcess
+W: https://wiki.qemu.org/SecurityProcess
 M: Michael S. Tsirkin <mst@redhat.com>
 L: secalert@redhat.com
 
@@ -1666,7 +1666,7 @@ F: net/filter-mirror.c
 Record/replay
 M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
-W: http://wiki.qemu.org/Features/record-replay
+W: https://wiki.qemu.org/Features/record-replay
 S: Supported
 F: replay/*
 F: block/blkreplay.c
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index f1b60bcfa0..adbc94abb1 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -18,7 +18,7 @@ For detailed information on QMP's usage, please, refer to the following files:
 o qmp-spec.txt      QEMU Machine Protocol current specification
 o qemu-qmp-ref.html QEMU QMP commands and events (auto-generated at build-time)
 
-[1] http://www.json.org
+[1] https://www.json.org
 
 Usage
 -----
@@ -83,4 +83,4 @@ Please, refer to the qapi-schema.json file for a complete command reference.
 QMP wiki page
 -------------
 
-http://wiki.qemu.org/QMP
+https://wiki.qemu.org/QMP
diff --git a/docs/pcie.txt b/docs/pcie.txt
index 76b85ece32..8d3694970e 100644
--- a/docs/pcie.txt
+++ b/docs/pcie.txt
@@ -8,9 +8,9 @@ in PCI Express based machines and explains the reasoning behind them.
 
 The following presentations accompany this document:
  (1) Q35 overview.
-     http://wiki.qemu.org/images/4/4e/Q35.pdf
+     https://wiki.qemu.org/images/4/4e/Q35.pdf
  (2) A comparison between PCI and PCI Express technologies.
-     http://wiki.qemu.org/images/f/f6/PCIvsPCIe.pdf
+     https://wiki.qemu.org/images/f/f6/PCIvsPCIe.pdf
 
 Note: The usage examples are not intended to replace the full
 documentation, please use QEMU help to retrieve all options.
diff --git a/docs/rdma.txt b/docs/rdma.txt
index f3eaaa004c..e6f9902617 100644
--- a/docs/rdma.txt
+++ b/docs/rdma.txt
@@ -1,7 +1,7 @@
 (RDMA: Remote Direct Memory Access)
 RDMA Live Migration Specification, Version # 1
 ==============================================
-Wiki: http://wiki.qemu.org/Features/RDMALiveMigration
+Wiki: https://wiki.qemu.org/Features/RDMALiveMigration
 Github: git@github.com:hinesmr/qemu.git, 'rdma' branch
 
 Copyright (C) 2013 Michael R. Hines <mrhines@us.ibm.com>
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0456c79df4..05319b9ddc 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -24,8 +24,8 @@
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
 #define QEMU_HELP_BOTTOM \
-    "See <http://qemu.org/contribute/report-a-bug> for how to report bugs.\n" \
-    "More information on the QEMU project at <http://qemu.org>."
+    "See <https://qemu.org/contribute/report-a-bug> for how to report bugs.\n" \
+    "More information on the QEMU project at <https://qemu.org>."
 
 /* main function, renamed */
 #if defined(CONFIG_COCOA)
diff --git a/Changelog b/Changelog
index 13eebefb74..4a90bb9e8b 100644
--- a/Changelog
+++ b/Changelog
@@ -1,6 +1,6 @@
 This file documents changes for QEMU releases 0.12 and earlier.
 For changelog information for later releases, see
-http://wiki.qemu.org/ChangeLog or look at the git history for
+https://wiki.qemu.org/ChangeLog or look at the git history for
 more detailed information.
 
 
diff --git a/README b/README
index 34ee588cd8..b92a07a61a 100644
--- a/README
+++ b/README
@@ -44,9 +44,9 @@ of other UNIX targets. The simple steps to build QEMU are:
 
 Additional information can also be found online via the QEMU website:
 
-  http://qemu.org/Hosts/Linux
-  http://qemu.org/Hosts/Mac
-  http://qemu.org/Hosts/W32
+  https://qemu.org/Hosts/Linux
+  https://qemu.org/Hosts/Mac
+  https://qemu.org/Hosts/W32
 
 
 Submitting patches
@@ -65,8 +65,8 @@ guidelines set out in the HACKING and CODING_STYLE files.
 Additional information on submitting patches can be found online via
 the QEMU website
 
-  http://qemu.org/Contribute/SubmitAPatch
-  http://qemu.org/Contribute/TrivialPatches
+  https://qemu.org/Contribute/SubmitAPatch
+  https://qemu.org/Contribute/TrivialPatches
 
 
 Bug reporting
@@ -85,7 +85,7 @@ reported via launchpad.
 
 For additional information on bug reporting consult:
 
-  http://qemu.org/Contribute/ReportABug
+  https://qemu.org/Contribute/ReportABug
 
 
 Contact
@@ -95,12 +95,12 @@ The QEMU community can be contacted in a number of ways, with the two
 main methods being email and IRC
 
  - qemu-devel@nongnu.org
-   http://lists.nongnu.org/mailman/listinfo/qemu-devel
+   https://lists.nongnu.org/mailman/listinfo/qemu-devel
  - #qemu on irc.oftc.net
 
 Information on additional methods of contacting the community can be
 found online via the QEMU website:
 
-  http://qemu.org/Contribute/StartHere
+  https://qemu.org/Contribute/StartHere
 
 -- End
diff --git a/qemu-doc.texi b/qemu-doc.texi
index d383ac44d4..617254917d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -72,7 +72,7 @@ without rebooting the PC or to debug system code.
 @cindex user mode emulation
 @item User mode emulation. In this mode, QEMU can launch
 processes compiled for one CPU on another CPU. It can be used to
-launch the Wine Windows API emulator (@url{http://www.winehq.org}) or
+launch the Wine Windows API emulator (@url{https://www.winehq.org}) or
 to ease cross-compilation and cross-debugging.
 
 @end itemize
@@ -533,7 +533,7 @@ TAP network interfaces.
 There is a virtual ethernet driver for Windows 2000/XP systems, called
 TAP-Win32. But it is not included in standard QEMU for Windows,
 so you will need to get it separately. It is part of OpenVPN package,
-so download OpenVPN from : @url{http://openvpn.net/}.
+so download OpenVPN from : @url{https://openvpn.net/}.
 
 @subsection Using the user mode network stack
 
@@ -707,11 +707,11 @@ to grab the mouse.  Also overrides the PS/2 mouse emulation when activated.
 Mass storage device backed by @var{drive_id} (@pxref{disk_images})
 @item usb-uas
 USB attached SCSI device, see
-@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
+@url{https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
 for details
 @item usb-bot
 Bulk-only transport storage device, see
-@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
+@url{https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
 for details here, too
 @item usb-mtp,x-root=@var{dir}
 Media transfer protocol device, using @var{dir} as root of the file tree
@@ -1221,7 +1221,7 @@ resolution modes which the Cirrus Logic BIOS does not support (i.e. >=
 Windows 9x does not correctly use the CPU HLT
 instruction. The result is that it takes host CPU cycles even when
 idle. You can install the utility from
-@url{http://web.archive.org/web/20060212132151/http://www.user.cityline.ru/~maxamn/amnhltm.zip}
+@url{https://web.archive.org/web/20060212132151/http://www.user.cityline.ru/~maxamn/amnhltm.zip}
 to solve this problem. Note that no such tool is needed for NT, 2000 or XP.
 
 @subsubsection Windows 2000 disk full problem
@@ -1271,7 +1271,7 @@ vvfat block device ("-hdb fat:directory_which_holds_the_SP").
 
 DOS does not correctly use the CPU HLT instruction. The result is that
 it takes host CPU cycles even when idle. You can install the utility from
-@url{http://web.archive.org/web/20051222085335/http://www.vmware.com/software/dosidle210.zip}
+@url{https://web.archive.org/web/20051222085335/http://www.vmware.com/software/dosidle210.zip}
 to solve this problem.
 
 @node QEMU System emulator for non PC targets
@@ -1342,7 +1342,7 @@ PC compatible keyboard and mouse.
 QEMU uses the Open Hack'Ware Open Firmware Compatible BIOS available at
 @url{http://perso.magic.fr/l_indien/OpenHackWare/index.htm}.
 
-Since version 0.9.1, QEMU uses OpenBIOS @url{http://www.openbios.org/}
+Since version 0.9.1, QEMU uses OpenBIOS @url{https://www.openbios.org/}
 for the g3beige and mac99 PowerMac machines. OpenBIOS is a free (GPL
 v2) portable firmware implementation. The goal is to implement a 100%
 IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
@@ -1434,7 +1434,7 @@ memory size depends on the machine type, for SS-5 it is 256MB and for
 others 2047MB.
 
 Since version 0.8.2, QEMU uses OpenBIOS
-@url{http://www.openbios.org/}. OpenBIOS is a free (GPL v2) portable
+@url{https://www.openbios.org/}. OpenBIOS is a free (GPL v2) portable
 firmware implementation. The goal is to implement a 100% IEEE
 1275-1994 (referred to as Open Firmware) compliant firmware.
 
@@ -2552,7 +2552,7 @@ QEMU is a trademark of Fabrice Bellard.
 QEMU is released under the
 @url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public License},
 version 2. Parts of QEMU have specific licenses, see file
-@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE,LICENSE}.
+@url{https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE,LICENSE}.
 
 @node Index
 @appendix Index
diff --git a/qemu.nsi b/qemu.nsi
index 5ee0e6e5e1..75f1608b9e 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -20,7 +20,7 @@
 ; NSIS_WIN32_MAKENSIS
 
 !define PRODUCT "QEMU"
-!define URL     "http://www.qemu.org/"
+!define URL     "https://www.qemu.org/"
 
 !define UNINST_EXE "$INSTDIR\qemu-uninstall.exe"
 !define UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}"
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index bc8803234f..7d2a472094 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -33,7 +33,7 @@
 # $ qemu-ga-client fsfreeze freeze
 # 2 filesystems frozen
 #
-# See also: http://wiki.qemu.org/Features/QAPI/GuestAgent
+# See also: https://wiki.qemu.org/Features/QAPI/GuestAgent
 #
 
 import base64
diff --git a/version.rc b/version.rc
index a50d62fa0c..d8e1569991 100644
--- a/version.rc
+++ b/version.rc
@@ -13,7 +13,7 @@ FILESUBTYPE VFT2_UNKNOWN
   {
     BLOCK "040904E4"
     {
-      VALUE "CompanyName", "http://www.qemu.org"
+      VALUE "CompanyName", "https://www.qemu.org"
       VALUE "FileDescription", "QEMU machine emulators and tools"
       VALUE "FileVersion", QEMU_VERSION
       VALUE "LegalCopyright", "Copyright various authors. Released under the GNU General Public License."
-- 
2.14.3
