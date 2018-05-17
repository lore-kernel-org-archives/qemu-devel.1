Received: from eggs.gnu.org ([2001:4830:134:3::10]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9R-0006vD-W2
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9R-00072S-6n
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 17 May 2018 18:52:53 +0200
Message-Id: <20180517165253.19958-4-kwolf@redhat.com>
In-Reply-To: <20180517165253.19958-1-kwolf@redhat.com>
References: <20180517165253.19958-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-iotests: 086 doesn't work with NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The reference output file only works for file. 'qemu-img convert -p'
makes a lot more progress updates for NFS than for file, so disable the
test for NFS.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/086 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index cd4494a660..84e3835071 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2 raw
-_supported_proto file nfs
+_supported_proto file
 _supported_os Linux
 
 function run_qemu_img()
-- 
2.13.6
