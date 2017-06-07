Received: from eggs.gnu.org ([2001:4830:134:3::10]:55151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dIfAA-0005LH-EG
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dIfA6-0007sm-Di
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dIfA6-0007sJ-7e
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:30 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  7 Jun 2017 18:54:14 +0100
Message-Id: <20170607175419.13558-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/06/07
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

The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376=
af:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-re=
quest' into staging (2017-06-07 11:56:00 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-sockets-2017-06-07-1

for you to fetch changes up to 8dd2c27927b93aa352c43e8f0b9437f85d2f5f55:

  tests: add functional test validating ipv4/ipv6 address flag handling (=
2017-06-07 17:15:08 +0100)

----------------------------------------------------------------
Merge sockets 2017/06/07 v1

----------------------------------------------------------------

Daniel P. Berrange (5):
  sockets: ensure we can bind to both ipv4 & ipv6 separately
  sockets: don't block IPv4 clients when listening on "::"
  sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
  io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
  tests: add functional test validating ipv4/ipv6 address flag handling

 io/dns-resolver.c          |   6 +-
 tests/.gitignore           |   1 +
 tests/Makefile.include     |   4 +
 tests/test-sockets-proto.c | 857 +++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-sockets.c        |  71 +++-
 5 files changed, 918 insertions(+), 21 deletions(-)
 create mode 100644 tests/test-sockets-proto.c

--=20
2.9.3
