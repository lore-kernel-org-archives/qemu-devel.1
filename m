Received: from eggs.gnu.org ([2001:4830:134:3::10]:38290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5vmZ-0002Tm-49
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5vmU-0003vM-Vg
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:06:07 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 10 Apr 2018 18:05:04 +0200
Message-Id: <74552e1d6e858d3159cb0c0e188e80bc9248e337.1523376013.git.berto@igalia.com>
In-Reply-To: <cover.1523376013.git.berto@igalia.com>
References: <cover.1523376013.git.berto@igalia.com>
In-Reply-To: <cover.1523376013.git.berto@igalia.com>
References: <cover.1523376013.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/2] specs/qcow2: Clarify that compressed
 clusters have the COPIED bit reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Compressed clusters are not supposed to have the COPIED bit set, but
this is not made explicit in the specs, so let's document it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 docs/interop/qcow2.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index feb711fb6a..8e1547ded2 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -400,10 +400,10 @@ L2 table entry:
               62:   0 for standard clusters
                     1 for compressed clusters
 
-              63:   0 for a cluster that is unused or requires COW, 1 if its
-                    refcount is exactly one. This information is only accurate
-                    in L2 tables that are reachable from the active L1
-                    table.
+              63:   0 for clusters that are unused, compressed or require COW.
+                    1 for standard clusters whose refcount is exactly one.
+                    This information is only accurate in L2 tables
+                    that are reachable from the active L1 table.
 
 Standard Cluster Descriptor:
 
-- 
2.11.0
