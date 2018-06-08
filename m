Received: from eggs.gnu.org ([2001:4830:134:3::10]:45111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeM-0007dO-3G
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeK-0004JY-Uy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:53436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fRAeK-0004J8-OE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:24 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  8 Jun 2018 09:13:11 +0300
Message-Id: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit 9be4af13305f24d2dabf94bb53e6b65c76d08b=
b2:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2018-06-01 14:58:53 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to c22098c74a09164797fae6511c5eaf68f32c4dd8:

  slirp: reformat m_inc routine (2018-06-08 09:08:30 +0300)

----------------------------------------------------------------
slirp updates

Prasad J Pandit (2):
  slirp: Fix buffer overflow on packet reassembling

Samuel Thibault (3):
  slirp: Add Samuel Thibault's staging tree for slirp
  slirp: fix domainname version availability

----------------------------------------------------------------
Prasad J Pandit (2):
      slirp: correct size computation while concatenating mbuf
      slirp: reformat m_inc routine

Samuel Thibault (3):
      slirp: Fix spurious error report when sending directly
      slirp: Add Samuel Thibault's staging tree for slirp
      slirp: fix domainname version availability

 MAINTAINERS    |  1 +
 qapi/net.json  |  2 +-
 slirp/mbuf.c   | 39 ++++++++++++++++++---------------------
 slirp/mbuf.h   |  8 +++-----
 slirp/socket.c | 14 +++++++-------
 5 files changed, 30 insertions(+), 34 deletions(-)
