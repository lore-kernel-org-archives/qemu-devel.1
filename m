Received: from eggs.gnu.org ([2001:4830:134:3::10]:36690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzUZO-0000YT-Qh
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzUZN-0007Vp-ON
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzUZN-0007U3-EW
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:17:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  3 Oct 2017 18:17:30 -0300
Message-Id: <20171003211730.31843-3-ehabkost@redhat.com>
In-Reply-To: <20171003211730.31843-1-ehabkost@redhat.com>
References: <20171003211730.31843-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qemu-options: Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
have no default config files that would be disabled using
-nodefconfig.  Update documentation and document -nodefconfig as
deprecated.

Cc: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Document at "Deprecated features" section in qemu-doc.texi
  (Daniel)
* Remove documentation for the option from qemu-options.hx
  (Markus)
---
 qemu-doc.texi   |  4 ++++
 qemu-options.hx | 17 ++++-------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index ecd186a159..039abe0cfe 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2533,6 +2533,10 @@ or ``ivshmem-doorbell`` device types.
 The ``spapr-pci-vfio-host-bridge'' device type is replaced by
 the ``spapr-pci-host-bridge'' device type.
 
+@subsection -nodefconfig (since 2.11.0)
+
+The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
+
 @node License
 @appendix License
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 39225ae6c3..981742d191 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4067,26 +4067,17 @@ Write device configuration to @var{file}. The @var{file} can be either filename
 command line and device configuration into file or dash @code{-}) character to print the
 output to stdout. This can be later used as input file for @code{-readconfig} option.
 ETEXI
-DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig,
-    "-nodefconfig\n"
-    "                do not load default config files at startup\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -nodefconfig
-@findex -nodefconfig
-Normally QEMU loads configuration files from @var{sysconfdir} and @var{datadir} at startup.
-The @code{-nodefconfig} option will prevent QEMU from loading any of those config files.
-ETEXI
+HXCOMM Deprecated, same as -no-user-config
+DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig, "", QEMU_ARCH_ALL)
 DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
     "-no-user-config\n"
-    "                do not load user-provided config files at startup\n",
+    "                do not load default user-provided config files at startup\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -no-user-config
 @findex -no-user-config
 The @code{-no-user-config} option makes QEMU not load any of the user-provided
-config files on @var{sysconfdir}, but won't make it skip the QEMU-provided config
-files from @var{datadir}.
+config files on @var{sysconfdir}.
 ETEXI
 DEF("trace", HAS_ARG, QEMU_OPTION_trace,
     "-trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
-- 
2.13.5
