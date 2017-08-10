Received: from eggs.gnu.org ([2001:4830:134:3::10]:34582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfltB-0004lH-98
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dflt8-0000am-3P
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:44:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 10 Aug 2017 13:44:26 +0200
Message-Id: <1502365466-19432-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Fix "-net van" typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-trivial@nongnu.org

While Andrew S. Tanenbaum has a point by saying "Never underestimate the
bandwidth of a station wagon full of tapes hurtling down the highway",
we don't support that way of transportation in QEMU yet, so replace the
typo with the correct word "vlan".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 92d50f1..9811476 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -3243,7 +3243,7 @@ the ``-netdev user,guestfwd=ARGS'' argument instead.
 
 @subsection -net vlan (since 2.9.0)
 
-The ``-net van=NN'' argument is partially replaced with the
+The ``-net vlan=NN'' argument is partially replaced with the
 new ``-netdev'' argument. The remaining use cases will no
 longer be directly supported in QEMU.
 
-- 
1.8.3.1
