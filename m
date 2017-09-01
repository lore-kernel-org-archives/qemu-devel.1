Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnjbJ-0005n7-O8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnjbF-0008TO-AQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:55:01 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  1 Sep 2017 11:54:32 +0100
Message-Id: <20170901105434.3288-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Two recently added iotests are currently breaking 'check -luks',
fix the easy one and disable the hard one.

Daniel P. Berrange (2):
  iotests: rewrite 192 to use _launch_qemu to fix LUKS support
  iotests: blacklist 194 with the luks driver

 tests/qemu-iotests/192        | 23 ++++++++++++++++-------
 tests/qemu-iotests/194        |  1 +
 tests/qemu-iotests/iotests.py |  4 +++-
 3 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.13.5
