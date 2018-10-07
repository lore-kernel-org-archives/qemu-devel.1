Received: from eggs.gnu.org ([2001:4830:134:3::10]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQp-0008VT-J9
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQo-00018D-CX
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:31 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1g9DQo-0000v6-27
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:30 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun,  7 Oct 2018 20:05:15 +0200
Message-Id: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Slirp updates
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

The following changes since commit 3c2d3042849686969add641bd38b08b9877b9e=
8f:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios.for-u=
pstream-20181005' into staging (2018-10-05 17:55:22 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 93a972f8548571d35c718ca3a94d5ab1507b2443:

  slirp: Propagate host TCP RST packet to the guest after socket disconne=
cted (2018-10-07 19:50:48 +0200)

----------------------------------------------------------------
slirp updates

Andrew Oates (1):
  slirp: fix ICMP handling on macOS hosts

Gavin Grant (1):
  slirp: Propagate host TCP RST packet to the guest after socket
    disconnected

Peter Maydell (1):
  slirp: document mbuf pointers and sizes

----------------------------------------------------------------
Andrew Oates (1):
      slirp: fix ICMP handling on macOS hosts

Gavin Grant (1):
      slirp: Propagate host TCP RST packet to the guest after socket disc=
onnected

Peter Maydell (1):
      slirp: document mbuf pointers and sizes

 slirp/ip_icmp.c | 27 ++++++++++++++++++++++++++-
 slirp/mbuf.c    | 14 +++++++-------
 slirp/mbuf.h    | 13 +++++++++++++
 slirp/socket.c  | 13 ++++++++++---
 4 files changed, 56 insertions(+), 11 deletions(-)
