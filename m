Received: from eggs.gnu.org ([2001:4830:134:3::10]:33684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYViv-0006bk-Ac
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYViq-0007nh-RM
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYViq-0007my-Mc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:24 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 28 Jun 2018 13:08:19 +0100
Message-Id: <20180628120821.10967-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/2] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1=
f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80626' into staging (2018-06-26 18:23:49 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qio-next-pull-request

for you to fetch changes up to 10aef3e986b4ae3fd909308bdd41c4e7ee1d1d04:

  Delete AF_UNIX socket after close (2018-06-28 13:06:44 +0100)

----------------------------------------------------------------
Merge qio 2018-06-28 v2

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
