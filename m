Received: from eggs.gnu.org ([209.51.188.92]:44520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw81w-0007gR-7v
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw81s-0002pk-1K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:00 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 19 Feb 2019 16:13:19 +0000
Message-Id: <20190219161321.15012-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Fix NBD TLS iotests on RHEL-7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This fixes a failure of iotest 233 due to certtool problesm in RHEL7 wrt
to SIGPIPE

Daniel P. Berrang=C3=A9 (2):
  iotests: ensure we print nbd server log on error
  iotests: avoid broken pipe with certtool

 tests/qemu-iotests/233        |  3 +++
 tests/qemu-iotests/common.tls | 48 +++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 16 deletions(-)

--=20
2.20.1
