Received: from eggs.gnu.org ([2001:4830:134:3::10]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0qEB-0001qo-P3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0qE8-00063s-Cw
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:09:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Mar 2018 17:09:30 +0200
Message-Id: <1522163370-18544-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Add missing configure options to
 help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

We forgot to mention --with-git, --libexecdir and --with-pkgversion
so far.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 4d0e92c..a473609 100755
--- a/configure
+++ b/configure
@@ -1497,16 +1497,19 @@ Advanced options (experts only):
   --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
   --smbd=SMBD              use specified smbd [$smbd]
+  --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
   --mandir=PATH            install man pages in PATH
   --datadir=PATH           install firmware in PATH$confsuffix
   --docdir=PATH            install documentation in PATH$confsuffix
   --bindir=PATH            install binaries in PATH
   --libdir=PATH            install libraries in PATH
+  --libexecdir=PATH        install helper binaries in PATH
   --sysconfdir=PATH        install config in PATH$confsuffix
   --localstatedir=PATH     install local state in PATH (set at runtime on win32)
   --firmwarepath=PATH      search PATH for firmware files
   --with-confsuffix=SUFFIX suffix for QEMU data inside datadir/libdir/sysconfdir [$confsuffix]
+  --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
   --disable-strip          disable stripping binaries
-- 
1.8.3.1
