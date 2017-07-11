Received: from eggs.gnu.org ([2001:4830:134:3::10]:34221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuWh-0005ZT-RS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuWd-0005P0-Uh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUuWd-0005OD-OU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:44:23 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 11 Jul 2017 13:44:06 +0100
Message-Id: <20170711124411.10499-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/07/11
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

The following changes since commit 3d0bf8dfdfebd7f2ae41b6f220444b8047d6b1=
ee:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2017=
0710a' into staging (2017-07-10 18:13:03 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-sockets-2017-07-11-1

for you to fetch changes up to 4d1b104fb3c68ba004e82da67d684cb031722b37:

  tests: add functional test validating ipv4/ipv6 address flag handling (=
2017-07-11 10:58:19 +0100)

----------------------------------------------------------------
Merge sockets 2017/07/11 v1

----------------------------------------------------------------

Daniel P. Berrange (5):
  sockets: ensure we can bind to both ipv4 & ipv6 separately
  sockets: don't block IPv4 clients when listening on "::"
  sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
  io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
  tests: add functional test validating ipv4/ipv6 address flag handling

 io/dns-resolver.c          |   6 +-
 tests/.gitignore           |   1 +
 tests/Makefile.include     |   3 +
 tests/test-sockets-proto.c | 924 +++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-sockets.c        |  71 +++-
 5 files changed, 984 insertions(+), 21 deletions(-)
 create mode 100644 tests/test-sockets-proto.c

--=20
2.9.4
