Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5Pb-0003Ze-R4
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5PW-0007c4-UL
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:27:19 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:52254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5PW-0007bo-Nh
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:27:14 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Feb 2017 21:27:04 +0100
Message-Id: <20170226202709.2114-1-samuel.thibault@ens-lyon.org>
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

The following changes since commit 685783c5b69c83c942d1fc21679311eeb8f79a=
b9:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2017-02-26 16:38:40 +0000)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to c363a5b7f9ca9e802665587900b7ea1aefcf26ea:

  slirp: VMStatify remaining except for loop (2017-02-26 21:16:38 +0100)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Dr. David Alan Gilbert (5):
      slirp: VMState conversion; tcpcb
      slirp: VMStatify sbuf
      slirp: Common lhost/fhost union
      slirp: VMStatify socket level
      slirp: VMStatify remaining except for loop

 slirp/sbuf.h    |   4 +-
 slirp/slirp.c   | 449 ++++++++++++++++++++++++++++----------------------=
------
 slirp/socket.h  |  24 ++-
 slirp/tcp_var.h |   6 +-
 4 files changed, 238 insertions(+), 245 deletions(-)
