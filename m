Received: from eggs.gnu.org ([209.51.188.92]:51406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4rU-0005wu-Qu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4rT-00084w-Pz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:00 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 19 Feb 2019 12:50:42 +0000
Message-Id: <20190219125044.5416-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] qcow2: improve error handling when luks
 creation fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

If qemu is built without crypto support luks creation will fail. The 188
iotest however still carried on using the partially created file. This
showed a few flaws in error handling, one during creation and one during
opening of the image.

Daniel P. Berrang=C3=A9 (2):
  qcow2: fail if encryption opts are provided to non-encrypted image
  qcow2: mark image as corrupt if failing during create

 block/qcow2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--=20
2.20.1
