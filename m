Received: from eggs.gnu.org ([2001:4830:134:3::10]:33240)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd27h-0004aR-97
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd27g-0005ZG-Dm
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:28:13 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:55864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd27f-0005XT-Ut
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:28:12 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  3 Aug 2017 00:28:08 +0200
Message-Id: <20170802222810.605-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519=
c8:

  Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 413d463f43fbc4dd3a601e80a5724aa384a265a0:

  slirp: check len against dhcp options array end (2017-08-03 00:26:44 +0=
200)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Herv=C3=A9 Poussineau (1):
      slirp: fill error when failing to initialize user network

Prasad J Pandit (1):
      slirp: check len against dhcp options array end

 net/slirp.c   | 134 ++++++++++++++++++++++++++++++++++++++++------------=
------
 slirp/bootp.c |   3 ++
 2 files changed, 97 insertions(+), 40 deletions(-)
