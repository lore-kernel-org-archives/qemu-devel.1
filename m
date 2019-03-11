Received: from eggs.gnu.org ([209.51.188.92]:60667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODS-0006yR-Hs
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODQ-0002xV-Eu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODM-0002tR-SY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id c13so210224wmb.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:12 +0100
Message-Id: <1552323335-46779-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/31] configure: Enable werror for git
 worktrees
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
index b354e74..fa83e21 100755
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
