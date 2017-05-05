Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFQ-0002UZ-9S
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFN-0006gy-5r
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFM-0006gj-VU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:01 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:33 +0200
Message-Id: <20170505101337.4650-18-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/21] get_maintainer: it's '--pattern-depth',
 not '-pattern-depth'
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

Though it appears that Perl's GetOptions will take either, the latter is
not documented in the options listing.

Cherry picked from Linux commit cc7ff0ef6eca3deeea4a424ca47a67c8450d5424.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1146ca194..1f637ff076 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -748,7 +748,7 @@ Other options:
   --help => show this help information
 
 Default options:
-  [--email --nogit --git-fallback --m --n --l --multiline -pattern-depth=0
+  [--email --nogit --git-fallback --m --n --l --multiline --pattern-depth=0
    --remove-duplicates --rolestats]
 
 Notes:
-- 
2.12.2
