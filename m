Received: from eggs.gnu.org ([2001:4830:134:3::10]:60962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkK-0001Lz-AP
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkI-0005JF-6V
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:21:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:17 +0200
Message-Id: <20170926142133.2498-9-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/24] iotests: Print full path of bad output if
 mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

So it is easier to copy paste the path.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
