Received: from eggs.gnu.org ([2001:4830:134:3::10]:41466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1k-00066U-21
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1j-0008OH-As
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  2 May 2017 16:18:22 +0800
Message-Id: <20170502081832.9546-13-famz@redhat.com>
In-Reply-To: <20170502081832.9546-1-famz@redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v16 12/22] iotests: 091: Quit QEMU before
 checking image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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
2.9.3
