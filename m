Received: from eggs.gnu.org ([209.51.188.92]:37300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gme5Q-0001B6-T4
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gme5O-0005Eh-Uw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gme5M-00058a-OX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:22 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 24 Jan 2019 12:26:13 +0000
Message-Id: <20190124122614.16624-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The following changes since commit 6d809e7da943bb4b95b408fbf3d80d097c0f7d=
38:

  Merge remote-tracking branch 'remotes/xtensa/tags/20190122-xtensa' into=
 staging (2019-01-23 21:50:49 +0000)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qio-next-pull-request

for you to fetch changes up to 73564c407caedf992a1c688b5fea776a8b56ba2a:

  io: ensure UNIX client doesn't unlink server socket (2019-01-24 12:23:3=
5 +0000)

----------------------------------------------------------------
Merge qio 2019/01/24

Fixes accidental deletion of VNC server UNIX listener socket

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  io: ensure UNIX client doesn't unlink server socket

 io/channel-socket.c            | 19 ++------
 tests/test-io-channel-socket.c | 86 ++++++++++++++++++++++++++++++----
 2 files changed, 80 insertions(+), 25 deletions(-)

--=20
2.20.1
