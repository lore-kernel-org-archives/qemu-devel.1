Received: from eggs.gnu.org ([2001:4830:134:3::10]:47884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYUhc-0000Sj-QO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYUhZ-0003g4-05
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYUhY-0003fD-S4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:00 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 28 Jun 2018 12:02:52 +0100
Message-Id: <20180628110254.6725-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1=
f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80626' into staging (2018-06-26 18:23:49 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qio-next-pull-request

for you to fetch changes up to 39321d9ed89eccdde73bb7b20cb834506c3bd750:

  Delete AF_UNIX socket after close (2018-06-28 11:59:51 +0100)

----------------------------------------------------------------
Merge qio 2018-06-28

Misc bug fixes for sockets channels

----------------------------------------------------------------

Pavel Balaev (1):
  Delete AF_UNIX socket after close

linzhecheng (1):
  socket: dont't free msgfds if error equals EAGAIN

 chardev/char-socket.c |  4 ++--
 io/channel-socket.c   | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

--=20
2.17.1
