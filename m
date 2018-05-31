Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9u-00043z-Pm
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9t-0008T1-NS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:50 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9t-0008SL-Fx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:49 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:28 +0200
Message-Id: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
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

The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a=
97:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80531-1' into staging (2018-05-31 17:00:55 +0100)

are available in the Git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 528e913612bf22661b169018780d8a6fc678c655:

  slirp/ncsi: add checksum support (2018-05-31 20:45:02 +0200)

----------------------------------------------------------------
slirp updates

Alexey Kardashevskiy
  slirp: Improve debugging messages

Andreas Gustafsson, Samuel Thibault, James Clarke
  slirp: Improve bandwidth in GDB remote debugging and FreeBSD guests

Benjamin Drung:
  slirp/dhcp: Add domainname option

C=C3=A9dric Le Goater (3):
  slirp/ncsi: fix "Get Version ID" payload length
  slirp/ncsi: add a "Get Parameters" response
  slirp/ncsi: add checksum support

Nia Alarie:
  net/slirp: Convert atoi to qemu_strtoi to allow error checking

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      slirp/debug: Print IP addresses in human readable form

Andreas Gustafsson (1):
      slirp: disable Nagle in outgoing connections

Benjamin Drung (1):
      slirp: Add domainname option to slirp's DHCP server

C=C3=A9dric Le Goater (3):
      slirp/ncsi: fix "Get Version ID" payload length
      slirp/ncsi: add a "Get Parameters" response
      slirp/ncsi: add checksum support

James Clarke (1):
      slirp: Send window updates to guest after window was closed

Nia Alarie (1):
      net/slirp: Convert atoi to qemu_strtoi to allow error checking

Samuel Thibault (1):
      slirp: disable Nagle in ingoing connections

 net/slirp.c       | 16 ++++++++++++----
 qapi/net.json     |  4 ++++
 qemu-options.hx   |  7 +++++--
 slirp/arp_table.c |  4 ++--
 slirp/bootp.c     |  8 ++++++++
 slirp/libslirp.h  |  2 +-
 slirp/ncsi.c      | 51 ++++++++++++++++++++++++++++++++++++++++++++-----=
--
 slirp/slirp.c     | 16 +++++++++-------
 slirp/slirp.h     |  1 +
 slirp/socket.c    |  6 ++++--
 slirp/tcp_subr.c  |  2 ++
 11 files changed, 92 insertions(+), 25 deletions(-)
