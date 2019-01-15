Received: from eggs.gnu.org ([209.51.188.92]:55959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gjMcD-0002TT-93
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gjMcC-000355-Kw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:10:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 15 Jan 2019 11:10:05 +0000
Message-Id: <20190115111007.27159-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] qcow2: include LUKS payload overhead in
 qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The LUKS payload has a significant size (>1 MB).  It must be included in =
the
qemu-img measure calculation so we arrive at the correct minimum image si=
ze.

Stefan Hajnoczi (2):
  qcow2: include LUKS payload overhead in qemu-img measure
  iotests: add LUKS payload overhead to 178 qemu-img measure test

 block/qcow2.c                    | 51 +++++++++++++++++++++++++++++++-
 tests/qemu-iotests/178           |  8 +++++
 tests/qemu-iotests/178.out.qcow2 | 24 +++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

--=20
2.20.1
