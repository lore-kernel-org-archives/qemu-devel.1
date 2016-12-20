Received: from eggs.gnu.org ([2001:4830:134:3::10]:35619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTVR-0003TJ-30
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTVQ-0006f0-2q
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:07:37 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:39497)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTVP-0006eo-TD
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:07:36 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 21 Dec 2016 00:07:30 +0100
Message-Id: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] slirp updates: MIN/MAX, tftp dynamic blocks
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

The following changes since commit 82ecffa8c050bf5bbc13329e9b65eac1caa5b5=
5c:

  Open 2.9 development tree (2016-12-20 16:20:16 +0000)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 9443598d7e2f2c0a6493d97b3f11dd04837b08e8:

  slirp: support dynamic block size for TFTP transfers (2016-12-21 00:02:=
15 +0100)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Herv=C3=A9 Poussineau (1):
      slirp: support dynamic block size for TFTP transfers

Yuval Shaia (1):
      slirp, disas: Replace min/max with MIN/MAX macros

 disas/m68k.c       |  8 ++------
 slirp/dhcpv6.c     |  2 +-
 slirp/ip6_icmp.c   |  2 +-
 slirp/slirp.c      |  2 +-
 slirp/slirp.h      |  5 -----
 slirp/tcp_input.c  | 16 ++++++++--------
 slirp/tcp_output.c |  6 +++---
 slirp/tcp_timer.c  |  2 +-
 slirp/tcpip.h      |  2 +-
 slirp/tftp.c       | 26 ++++++++++++++------------
 slirp/tftp.h       |  8 +++++---
 11 files changed, 37 insertions(+), 42 deletions(-)
