Received: from eggs.gnu.org ([2001:4830:134:3::10]:55539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqzC-0000WC-Iw
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqzB-0002Ox-R4
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:54:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 17 Jan 2018 10:54:18 -0600
Message-Id: <20180117165420.15946-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] iotests compat=0.10 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

As requested here:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03984.html

Eric Blake (1):
  iotests: Split 177 into two parts for compat=0.10

Max Reitz (1):
  iotests: Disable some tests for compat=0.10

 tests/qemu-iotests/080     |   5 +-
 tests/qemu-iotests/130     |   2 +
 tests/qemu-iotests/137     |   2 +
 tests/qemu-iotests/176     |   2 +
 tests/qemu-iotests/177     |  20 +++-----
 tests/qemu-iotests/177.out |  22 ++-------
 tests/qemu-iotests/204     | 119 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/204.out |  63 ++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 9 files changed, 202 insertions(+), 34 deletions(-)
 create mode 100755 tests/qemu-iotests/204
 create mode 100644 tests/qemu-iotests/204.out

-- 
2.14.3
