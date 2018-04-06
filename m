Received: from eggs.gnu.org ([2001:4830:134:3::10]:36295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utm-0007r8-4j
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utl-0007ca-8I
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:38 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:51236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utl-0007bZ-16
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:37 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u189so4843101wmd.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:09 +0200
Message-Id: <1523034681-33787-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/20] configure: Add missing configure options
 to help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We forgot to mention --with-git, --libexecdir and --with-pkgversion
so far.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1522163370-18544-1-git-send-email-thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index a2301dd..752dd9e 100755
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
