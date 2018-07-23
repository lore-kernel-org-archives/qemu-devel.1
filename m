Received: from eggs.gnu.org ([2001:4830:134:3::10]:51146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdy0-0002L5-TZ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxv-0005EP-SG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:29 +0200
Message-Id: <20180723164530.26599-7-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] iotests: Disallow compat=0.10 in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Max Reitz <mreitz@redhat.com>

223 tests persistent dirty bitmaps which are not supported in
compat=0.10, so that option is unsupported for this test.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/223 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index b63b7a4f9e..8b1859c2dd 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file # uses NBD as well
 _supported_os Linux
+# Persistent dirty bitmaps require compat=1.1
+_unsupported_imgopts 'compat=0.10'
 
 function do_run_qemu()
 {
-- 
2.13.6
