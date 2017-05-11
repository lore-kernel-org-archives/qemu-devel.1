Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9x-0001bT-Qh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9x-0006uV-2K
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:15 +0200
Message-Id: <1494513181-7900-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/58] iotests: 091: Quit QEMU before checking
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/091 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 32bbd56..10ac4a8 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -95,7 +95,9 @@ echo "vm2: qemu process running successfully"
 echo "vm2: flush io, and quit"
 _send_qemu_cmd $h2 'qemu-io disk flush' "(qemu)"
 _send_qemu_cmd $h2 'quit' ""
+_send_qemu_cmd $h1 'quit' ""
 
+wait
 echo "Check image pattern"
 ${QEMU_IO} -c "read -P 0x22 0 4M" "${TEST_IMG}" | _filter_testdir | _filter_qemu_io
 
-- 
1.8.3.1
