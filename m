Received: from eggs.gnu.org ([209.51.188.92]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmFqt-0007pU-JE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmFqs-00087o-Ov
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:33:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 10:33:21 +0000
Message-Id: <20190123103323.4516-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] qcow2: include LUKS payload overhead in
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Take into account all "encrypt." image creation options since the LUKS
   payload size varies depending on the cipher [Max]

The LUKS payload has a significant size (>1 MB).  It must be included in =
the
qemu-img measure calculation so we arrive at the correct minimum image si=
ze.

Stefan Hajnoczi (2):
  qcow2: include LUKS payload overhead in qemu-img measure
  iotests: add LUKS payload overhead to 178 qemu-img measure test

 block/qcow2.c                    | 72 +++++++++++++++++++++++++++++++-
 tests/qemu-iotests/178           |  8 ++++
 tests/qemu-iotests/178.out.qcow2 | 24 +++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

--=20
2.20.1
