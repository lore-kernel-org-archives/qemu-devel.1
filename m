Received: from eggs.gnu.org ([2001:4830:134:3::10]:51008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjRY-000244-La
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjRX-00080s-Sc
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:45:36 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Sep 2017 13:45:26 +0800
Message-Id: <20170915054526.20588-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Print full path of bad output if
 mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

So it is easier to copy paste the path.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index d504b6e455..4583a0c269 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -353,7 +353,7 @@ do
                 else
                     echo " - output mismatch (see $seq.out.bad)"
                     mv $tmp.out $seq.out.bad
-                    $diff -w "$reference" $seq.out.bad
+                    $diff -w "$reference" $(realpath $seq.out.bad)
                     err=true
                 fi
             fi
-- 
2.13.5
