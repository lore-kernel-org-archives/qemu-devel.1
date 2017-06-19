Received: from eggs.gnu.org ([2001:4830:134:3::10]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dMsnE-00054o-Tl
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dMsn9-0004Ya-TA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:16:20 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Jun 2017 11:16:11 +0200
Message-Id: <1497863771-24929-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Add missing "@c man end" statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-trivial@nongnu.org

Since commit 3f2ce724f1f1 ("Move the qemu-ga description into a
separate chapter"), the qemu.1 man page looks pretty much screwed
up, e.g. the title was "qemu-ga - QEMU Guest Agent" instead of
"qemu-doc - QEMU Emulator User Documentation". However, that movement
of the gemu-ga chapter is not the real problem, it just triggered
another bug in the qemu-doc.texi: There are some parts in the file
which introduce a "@c man begin OPTIONS" section, but never close
it again with "@c man end". After adding the proper end tags here,
the title of the man page is right again and the previously wrongly
tagged sections now also show up correctly in the man page, too.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 965ba59..d23c796 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2565,6 +2565,8 @@ so should only be used with trusted guest OS.
 
 @end table
 
+@c man end
+
 @node ColdFire System emulator
 @section ColdFire System emulator
 @cindex system emulation (ColdFire)
@@ -2609,6 +2611,8 @@ so should only be used with trusted guest OS.
 
 @end table
 
+@c man end
+
 @node Cris System emulator
 @section Cris System emulator
 @cindex system emulation (Cris)
@@ -2681,6 +2685,8 @@ so should only be used with trusted guest OS.
 
 @end table
 
+@c man end
+
 @node QEMU Guest Agent
 @chapter QEMU Guest Agent invocation
 
-- 
1.8.3.1
