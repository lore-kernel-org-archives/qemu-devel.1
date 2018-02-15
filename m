Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgU-00022v-5d
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-0003M0-Bq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgT-0003Ln-6d
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:37 +0000
Message-Id: <20180215175044.8159-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Qio next patches
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

The following changes since commit 8c5e7bddc22dac9d4dc3526996babce4c7242d=
9d:

  Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-02-14=
' into staging (2018-02-15 13:00:44 +0000)

are available in the Git repository at:

  ssh://git@github.com/berrange/qemu tags/qio-next-pull-request

for you to fetch changes up to 6809df1df036840d41a0cc9ca77cc6a0214fb1b5:

  allow to build with older sed (2018-02-15 16:54:57 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Edgar Kaziakhmedov (1):
  io/channel-websock: handle continuous reads without any data

Jan Beulich (1):
  allow to build with older sed

Paolo Bonzini (1):
  io: fix QIONetListener memory leak

Ross Lagerwall (3):
  io: Fix QIOChannelFile when creating and opening read-write
  io: Don't call close multiple times in QIOChannelFile
  io: Add /dev/fdset/ support to QIOChannelFile

Thomas Huth (1):
  io/channel-command: Do not kill the child process after closing the
    pipe

 Makefile                     |  3 +--
 include/io/channel-file.h    |  2 +-
 io/channel-command.c         | 12 +++++++++++-
 io/channel-file.c            | 11 ++++-------
 io/channel-websock.c         |  7 +++++--
 io/net-listener.c            |  1 +
 tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
 7 files changed, 48 insertions(+), 17 deletions(-)

--=20
2.14.3
