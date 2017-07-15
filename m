Received: from eggs.gnu.org ([2001:4830:134:3::10]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDt-00059E-S0
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDs-00063N-V0
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:01 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:52254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDs-00062t-N7
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:00 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 15 Jul 2017 14:30:53 +0200
Message-Id: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] slirp updates
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
The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:

  vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 75cb298d905030fca897ea1d80e409c7f7e3e5ea:

  slirp: Handle error returns from sosendoob() (2017-07-15 14:28:25 +0200=
)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      slirp: use DIV_ROUND_UP

Peter Maydell (3):
      slirp: fork_exec(): Don't close() a negative number in fork_exec()
      slirp: Handle error returns from slirp_send() in sosendoob()
      slirp: Handle error returns from sosendoob()

 slirp/ip6.h    |  6 +++---
 slirp/misc.c   |  4 +++-
 slirp/sbuf.c   |  2 +-
 slirp/socket.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 4 files changed, 42 insertions(+), 22 deletions(-)
