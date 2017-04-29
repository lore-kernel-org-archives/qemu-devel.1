Received: from eggs.gnu.org ([2001:4830:134:3::10]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXH-0006ru-Ly
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXG-0001Ko-MP
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:55 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:55392)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXG-0001KM-FP
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:54 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 29 Apr 2017 18:47:41 +0200
Message-Id: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] slirp updates
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

The following changes since commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cd=
a9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into =
staging (2017-04-26 20:50:49 +0100)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to eb5d4f5329df83ea15244b47f7fbca21adaae41b:

  slirp: VMStatify remaining except for loop (2017-04-29 18:44:16 +0200)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Dr. David Alan Gilbert (6):
      slirp/smb: Replace constant strings by glib string
      slirp: VMState conversion; tcpcb
      slirp: VMStatify sbuf
      slirp: Common lhost/fhost union
      slirp: VMStatify socket level
      slirp: VMStatify remaining except for loop

Marc-Andr=C3=A9 Lureau (1):
      slirp: tftp, copy sockaddr_size

Samuel Thibault (1):
      slirp: fix pinging the virtual ipv4 DNS server

Vincent Bernat (1):
      slirp: allow host port 0 for hostfwd

 net/slirp.c     |  32 ++--
 slirp/ip_icmp.c |   5 +-
 slirp/sbuf.h    |   4 +-
 slirp/slirp.c   | 494 +++++++++++++++++++++++++++++++-------------------=
------
 slirp/socket.h  |  24 ++-
 slirp/tcp_var.h |   6 +-
 slirp/tftp.c    |   2 +-
 7 files changed, 310 insertions(+), 257 deletions(-)
