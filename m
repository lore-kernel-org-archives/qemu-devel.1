Received: from eggs.gnu.org ([209.51.188.92]:47347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wih-0003tK-EF
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0000WM-4Q
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wif-0000Nx-7j
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id o17so23668688wrw.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:59 +0100
Message-Id: <1552117698-12355-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/25] configure: Enable werror for git worktrees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The configure script checks multiple times whether it works in a git
repository and it does this by "test -e "${source_path}/.git" in 4 cases
but in one case where it tries to enable werror "-d" is used there which
fails on git worktrees as .git is a file then and not a directory.

This changes the test to "-e" as other occurrences.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190228043503.68494-1-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 79453a6..c9a260c 100755
--- a/configure
+++ b/configure
@@ -1836,7 +1836,7 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test -d "$source_path/.git" && \
+    if test -e "$source_path/.git" && \
         { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
         werror="yes"
     else
-- 
1.8.3.1
