Received: from eggs.gnu.org ([2001:4830:134:3::10]:54205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRL-0002JJ-Pq
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRE-0000b2-A1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:49 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 16 Nov 2018 15:53:19 +0000
Message-Id: <20181116155325.22428-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] Misc fixes to NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This does two minor fixes to the NBD code and adds significant coverage
of the NBD TLS support to detect future problems.

The first two patches should be for 3.1.

The tests can wait till 4.0 if desired.

Daniel P. Berrang=C3=A9 (6):
  nbd: fix whitespace in server error message
  nbd: stop waiting for a NBD response with NBD_CMD_DISC
  tests: pull qemu-nbd iotest helpers into common.nbd file
  tests: check if qemu-nbd is still alive before waiting
  tests: add iotests helpers for dealing with TLS certificates
  tests: exercise NBD server in TLS mode

 block/nbd-client.c            |   1 +
 nbd/server.c                  |   2 +-
 tests/qemu-iotests/058        |  47 ++----------
 tests/qemu-iotests/233        |  99 ++++++++++++++++++++++++
 tests/qemu-iotests/233.out    |  33 ++++++++
 tests/qemu-iotests/common.nbd | 111 +++++++++++++++++++++++++++
 tests/qemu-iotests/common.tls | 139 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 8 files changed, 393 insertions(+), 40 deletions(-)
 create mode 100755 tests/qemu-iotests/233
 create mode 100644 tests/qemu-iotests/233.out
 create mode 100644 tests/qemu-iotests/common.nbd
 create mode 100644 tests/qemu-iotests/common.tls

--=20
2.19.1
