Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKy-0006ex-R3
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKv-0000ht-NL
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:36 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:16 +0300
Message-Id: <68935a65e66ead7fda58beb51191beaea3995ab4.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 13/23] qemu-doc: Fix broken URLs of amnhltm.zip
 and dosidle210.zip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

There are some broken URLs in the qemu-doc which reference tools that
are not available at their original location anymore. Fortunately, they
have been mirrored to archive.org, so point to that location instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-doc.texi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 794ab4a080..50411bc0ff 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1878,8 +1878,8 @@ resolution modes which the Cirrus Logic BIOS does not support (i.e. >=
 Windows 9x does not correctly use the CPU HLT
 instruction. The result is that it takes host CPU cycles even when
 idle. You can install the utility from
-@url{http://www.user.cityline.ru/~maxamn/amnhltm.zip} to solve this
-problem. Note that no such tool is needed for NT, 2000 or XP.
+@url{http://web.archive.org/web/20060212132151/http://www.user.cityline.ru/~maxamn/amnhltm.zip}
+to solve this problem. Note that no such tool is needed for NT, 2000 or XP.
 
 @subsubsection Windows 2000 disk full problem
 
@@ -1927,9 +1927,9 @@ vvfat block device ("-hdb fat:directory_which_holds_the_SP").
 @subsubsection CPU usage reduction
 
 DOS does not correctly use the CPU HLT instruction. The result is that
-it takes host CPU cycles even when idle. You can install the utility
-from @url{http://www.vmware.com/software/dosidle210.zip} to solve this
-problem.
+it takes host CPU cycles even when idle. You can install the utility from
+@url{http://web.archive.org/web/20051222085335/http://www.vmware.com/software/dosidle210.zip}
+to solve this problem.
 
 @node QEMU System emulator for non PC targets
 @chapter QEMU System emulator for non PC targets
-- 
2.11.0
