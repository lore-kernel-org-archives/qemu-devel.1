Received: from eggs.gnu.org ([2001:4830:134:3::10]:50958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLSt-0003ts-Ll
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLSt-0007gf-0E
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLSs-0007gV-R1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:46 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:35:28 +0000
Message-Id: <20170227133531.31874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 0/3] Merge qio 2017/02/27
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

The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236=
ff:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' =
into staging (2017-02-26 22:40:23 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-02-27-1

for you to fetch changes up to acd22400d1dce27bffc94be7663e1ff1c716abe8:

  tests: fix leaks in test-io-channel-command (2017-02-27 12:42:21 +0000)

----------------------------------------------------------------
Merge qio 2017/02/27 v1

----------------------------------------------------------------

Anton Nefedov (1):
  io: ignore case in WebSocket HTTP header

Daniel P. Berrange (1):
  io: fix decoding when multiple websockets frames arrive at once

Marc-Andr=C3=A9 Lureau (1):
  tests: fix leaks in test-io-channel-command

 io/channel-websock.c            | 53 ++++++++++++++++++++++-------------=
------
 tests/test-io-channel-command.c |  6 ++---
 2 files changed, 30 insertions(+), 29 deletions(-)

--=20
2.9.3
