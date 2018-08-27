Received: from eggs.gnu.org ([2001:4830:134:3::10]:51949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuIuP-000811-O8
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuIuO-0001q6-Mw
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuIuO-0001pw-GJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 27 Aug 2018 16:54:10 +0200
Message-Id: <1535381652-19870-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1535381652-19870-1-git-send-email-thuth@redhat.com>
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] Remove the deprecated -nodefconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, libvir-list@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

It's the same as -no-user-config and marked as deprecated since three
releases already. Time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/interop/live-block-operations.rst | 4 ++--
 qemu-deprecated.texi                   | 4 ----
 qemu-options.hx                        | 4 ++--
 vl.c                                   | 2 --
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 734252b..48afdc7 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -129,7 +129,7 @@ To show some example invocations of command-line, we will use the
 following invocation of QEMU, with a QMP server running over UNIX
 socket::
 
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
+    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=node-A,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./a.qcow2 \
         -device virtio-blk,drive=node-A,id=virtio0 \
@@ -694,7 +694,7 @@ instance, with the following invocation.  (As noted earlier, for
 simplicity's sake, the destination QEMU is started on the same host, but
 it could be located elsewhere)::
 
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
+    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=node-TargetDisk,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./target-disk.qcow2 \
         -device virtio-blk,drive=node-TargetDisk,id=virtio0 \
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 98f5062..19c8ae2 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -82,10 +82,6 @@ would automatically enable USB support on the machine type.
 If using the new syntax, USB support must be explicitly
 enabled via the ``-machine usb=on'' argument.
 
-@subsection -nodefconfig (since 2.11.0)
-
-The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
-
 @subsection -fsdev handle (since 2.12.0)
 
 The ``handle'' fsdev backend does not support symlinks and causes the 9p
diff --git a/qemu-options.hx b/qemu-options.hx
index ccf7155..d9be20b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3833,8 +3833,7 @@ Write device configuration to @var{file}. The @var{file} can be either filename
 command line and device configuration into file or dash @code{-}) character to print the
 output to stdout. This can be later used as input file for @code{-readconfig} option.
 ETEXI
-HXCOMM Deprecated, same as -no-user-config
-DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig, "", QEMU_ARCH_ALL)
+
 DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
     "-no-user-config\n"
     "                do not load default user-provided config files at startup\n",
@@ -3845,6 +3844,7 @@ STEXI
 The @code{-no-user-config} option makes QEMU not load any of the user-provided
 config files on @var{sysconfdir}.
 ETEXI
+
 DEF("trace", HAS_ARG, QEMU_OPTION_trace,
     "-trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
     "                specify tracing options\n",
diff --git a/vl.c b/vl.c
index 674c42f..386c71d 100644
--- a/vl.c
+++ b/vl.c
@@ -2999,7 +2999,6 @@ int main(int argc, char **argv, char **envp)
 
             popt = lookup_opt(argc, argv, &optarg, &optind);
             switch (popt->index) {
-            case QEMU_OPTION_nodefconfig:
             case QEMU_OPTION_nouserconfig:
                 userconfig = false;
                 break;
@@ -3927,7 +3926,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_enable_sync_profile:
                 qsp_enable();
                 break;
-            case QEMU_OPTION_nodefconfig:
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
-- 
1.8.3.1
