Received: from eggs.gnu.org ([2001:4830:134:3::10]:47191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFQ-0002UY-9T
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFO-0006hb-Cc
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFO-0006h2-6J
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:02 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:34 +0200
Message-Id: <20170505101337.4650-19-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/21] get_maintainer: --r (list reviewer) is on
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brian Norris <computersforpeace@gmail.com>

From: Brian Norris <computersforpeace@gmail.com>

We don't consistenly document the default value next to the option
listing, but we do have a list of defaults here, so let's keep it up to
date.

Cherry picked from Linux commit 4f07510df2e8c47fd65b8ffaaf6c5d334d59d598.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 1f637ff076..c7cb197a27 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -748,7 +748,7 @@ Other options:
   --help => show this help information
 
 Default options:
-  [--email --nogit --git-fallback --m --n --l --multiline --pattern-depth=0
+  [--email --nogit --git-fallback --m --r --n --l --multiline --pattern-depth=0
    --remove-duplicates --rolestats]
 
 Notes:
-- 
2.12.2
