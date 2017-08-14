Received: from eggs.gnu.org ([2001:4830:134:3::10]:53672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJA-0007QU-9s
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJ7-0007V7-4J
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:20 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:40 +0300
Message-Id: <88552b553b0f2d75f0f91a247f19c2e3b81ed5aa.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 3/7] qemu-doc: Fix "-net van" typo
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

While Andrew S. Tanenbaum has a point by saying "Never underestimate the
bandwidth of a station wagon full of tapes hurtling down the highway",
we don't support that way of transportation in QEMU yet, so replace the
typo with the correct word "vlan".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-doc.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index aeb7bc52f5..4fc6b6f077 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -3243,7 +3243,7 @@ the ``-netdev user,guestfwd=ARGS'' argument instead.
 
 @subsection -net vlan (since 2.9.0)
 
-The ``-net van=NN'' argument is partially replaced with the
+The ``-net vlan=NN'' argument is partially replaced with the
 new ``-netdev'' argument. The remaining use cases will no
 longer be directly supported in QEMU.
 
-- 
2.11.0
