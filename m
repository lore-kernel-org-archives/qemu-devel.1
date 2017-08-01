Received: from eggs.gnu.org ([2001:4830:134:3::10]:35634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dceqm-0000ka-4F
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dceql-0004KF-Hg
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:12 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  1 Aug 2017 17:31:26 -0400
Message-Id: <20170801213127.15036-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] qemu-iotests/109: Fix lock race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

A race condition is currently present between the clean up attempt of
the QEMU process and the execution of qemu-img.

Cleber Rosa(1):
   qemu-iotests/109: Fix lock/race condition

 tests/qemu-iotests/109     |  3 ++-
 tests/qemu-iotests/109.out | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)
