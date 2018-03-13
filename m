Received: from eggs.gnu.org ([2001:4830:134:3::10]:52209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evkn7-0004jJ-0x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evkn4-000344-0J
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:20:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 13 Mar 2018 22:20:01 +0800
Message-Id: <20180313142003.12124-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] block: Fix permission during reopen
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

v3: Fix test case. [Max]

v2: Use update_flags_from_options. [Kevin]

We write open the whole backing chain during reopen. It is not necessary and
will cause image locking problems if the backing image is shared.

Fam Zheng (2):
  block: Fix flags in reopen queue
  iotests: Add regression test for commit base locking

 block.c                    |  7 +++++++
 tests/qemu-iotests/153     | 12 ++++++++++++
 tests/qemu-iotests/153.out |  5 +++++
 3 files changed, 24 insertions(+)

-- 
2.14.3
