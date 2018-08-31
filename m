Received: from eggs.gnu.org ([2001:4830:134:3::10]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvf3j-0001A2-PO
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvexT-0007JE-9E
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvexT-0007J6-3z
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:11 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 31 Aug 2018 10:38:51 +0200
Message-Id: <1535704738-8986-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1535704738-8986-1-git-send-email-thuth@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] Remove the deprecated -nodefconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It's the same as -no-user-config and marked as deprecated since three
releases already. Time to remove it now.

Acked-by: Peter Krempa <pkrempa@redhat.com>
Acked-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/interop/live-block-operations.rst | 4 ++--
 qemu-deprecated.texi                   | 4 ----
 qemu-options.hx                        | 4 ++--
 vl.c                                   | 2 --
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-b=
lock-operations.rst
index 734252b..48afdc7 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -129,7 +129,7 @@ To show some example invocations of command-line, we =
will use the
 following invocation of QEMU, with a QMP server running over UNIX
 socket::
=20
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
+    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config =
\
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=3Dnode-A,driver=3Dqcow2,file.driver=3Dfile,f=
ile.node-name=3Dfile,file.filename=3D./a.qcow2 \
         -device virtio-blk,drive=3Dnode-A,id=3Dvirtio0 \
@@ -694,7 +694,7 @@ instance, with the following invocation.  (As noted e=
arlier, for
 simplicity's sake, the destination QEMU is started on the same host, but
 it could be located elsewhere)::
=20
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
+    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config =
\
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=3Dnode-TargetDisk,driver=3Dqcow2,file.driver=
=3Dfile,file.node-name=3Dfile,file.filename=3D./target-disk.qcow2 \
         -device virtio-blk,drive=3Dnode-TargetDisk,id=3Dvirtio0 \
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 98f5062..19c8ae2 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -82,10 +82,6 @@ would automatically enable USB support on the machine =
type.
 If using the new syntax, USB support must be explicitly
 enabled via the ``-machine usb=3Don'' argument.
=20
-@subsection -nodefconfig (since 2.11.0)
-
-The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
-
 @subsection -fsdev handle (since 2.12.0)
=20
 The ``handle'' fsdev backend does not support symlinks and causes the 9p
diff --git a/qemu-options.hx b/qemu-options.hx
index ccf7155..d9be20b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3833,8 +3833,7 @@ Write device configuration to @var{file}. The @var{=
file} can be either filename
 command line and device configuration into file or dash @code{-}) charac=
ter to print the
 output to stdout. This can be later used as input file for @code{-readco=
nfig} option.
 ETEXI
-HXCOMM Deprecated, same as -no-user-config
-DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig, "", QEMU_ARCH_ALL)
+
 DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
     "-no-user-config\n"
     "                do not load default user-provided config files at s=
tartup\n",
@@ -3845,6 +3844,7 @@ STEXI
 The @code{-no-user-config} option makes QEMU not load any of the user-pr=
ovided
 config files on @var{sysconfdir}.
 ETEXI
+
 DEF("trace", HAS_ARG, QEMU_OPTION_trace,
     "-trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\n"
     "                specify tracing options\n",
diff --git a/vl.c b/vl.c
index 674c42f..386c71d 100644
--- a/vl.c
+++ b/vl.c
@@ -2999,7 +2999,6 @@ int main(int argc, char **argv, char **envp)
=20
             popt =3D lookup_opt(argc, argv, &optarg, &optind);
             switch (popt->index) {
-            case QEMU_OPTION_nodefconfig:
             case QEMU_OPTION_nouserconfig:
                 userconfig =3D false;
                 break;
@@ -3927,7 +3926,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_enable_sync_profile:
                 qsp_enable();
                 break;
-            case QEMU_OPTION_nodefconfig:
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error o=
ut below. */
                 break;
--=20
1.8.3.1
