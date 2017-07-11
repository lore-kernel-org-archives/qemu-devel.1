Received: from eggs.gnu.org ([2001:4830:134:3::10]:45173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxji-0007qU-D0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxjh-000606-LJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:12 +0200
Message-Id: <20170711160814.20941-24-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 23/85] specs/qcow2: fix bitmap granularity
 qemu-specific note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 886a546..aee3553 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -575,8 +575,7 @@ Structure of a bitmap directory entry:
              17:    granularity_bits
                     Granularity bits. Valid values: 0 - 63.
 
-                    Note: Qemu currently doesn't support granularity_bits
-                    greater than 31.
+                    Note: Qemu currently supports only values 9 - 31.
 
                     Granularity is calculated as
                         granularity = 1 << granularity_bits
-- 
2.9.4
