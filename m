Received: from eggs.gnu.org ([2001:4830:134:3::10]:49073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTJQ-00063b-LC
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTJO-0008QG-0Q
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjTJN-0008Pp-Qs
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:37 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  2 Mar 2017 16:10:30 +0000
Message-Id: <20170302161033.4787-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe=
51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-0=
2-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-02-27-2

for you to fetch changes up to 07e95cd529af345fdeea230913f68eff5b925bb6:

  io: fully parse & validate HTTP headers for websocket protocol handshak=
e (2017-02-28 11:51:16 +0000)

----------------------------------------------------------------
Merge qio 2017/02/27 v2

----------------------------------------------------------------

Daniel P. Berrange (2):
  io: fix decoding when multiple websockets frames arrive at once
  io: fully parse & validate HTTP headers for websocket protocol
    handshake

Marc-Andr=C3=A9 Lureau (1):
  tests: fix leaks in test-io-channel-command

 io/channel-websock.c            | 264 +++++++++++++++++++++++++++++++---=
------
 tests/test-io-channel-command.c |   6 +-
 2 files changed, 210 insertions(+), 60 deletions(-)

--=20
2.9.3
