Received: from eggs.gnu.org ([2001:4830:134:3::10]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dW2Fn-0004v3-Dx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dW2Fj-00016q-Dl
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dW2Fj-00015t-88
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:11:35 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 14 Jul 2017 16:11:17 +0100
Message-Id: <20170714151121.18447-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 0/4] Merge sockets 2017/07/11
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

The following changes since commit 6c6076662d98c068059983d411cb2a8987ba56=
70:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-07-14 12:16:09 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-sockets-2017-07-11-3

for you to fetch changes up to 563a3987b980a36e6941720a99d5cf36960f78ea:

  io: preserve ipv4/ipv6 flags when resolving InetSocketAddress (2017-07-=
14 14:28:29 +0100)

----------------------------------------------------------------
Merge sockets 2017/07/11 v3

----------------------------------------------------------------

Daniel P. Berrange (4):
  sockets: ensure we can bind to both ipv4 & ipv6 separately
  sockets: don't block IPv4 clients when listening on "::"
  sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
  io: preserve ipv4/ipv6 flags when resolving InetSocketAddress

 io/dns-resolver.c   |  6 +++--
 util/qemu-sockets.c | 71 +++++++++++++++++++++++++++++++++++++++--------=
------
 2 files changed, 56 insertions(+), 21 deletions(-)

--=20
2.13.0
