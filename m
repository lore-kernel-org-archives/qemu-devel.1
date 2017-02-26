Received: from eggs.gnu.org ([2001:4830:134:3::10]:56117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03P-0005f0-8p
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03M-000265-6S
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:03 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:51262)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03L-00025C-WD
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Feb 2017 15:43:50 +0100
Message-Id: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] slirp updates
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

The following changes since commit 6528a4c1f20c1ba5a22ab84bec6788a574ac04=
c8:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2017-02-26 11:47:00 +0000)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to bd5d2353aa69e68e45d8a89787bab17c155e9e24:

  slirp: tcp_listen(): Don't try to close() an fd we never opened (2017-0=
2-26 15:39:29 +0100)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Peter Maydell (3):
      slirp: Check qemu_socket() return value in udp_listen()
      slirp: Convert mbufs to use g_malloc() and g_free()
      slirp: tcp_listen(): Don't try to close() an fd we never opened

 slirp/mbuf.c   | 30 ++++++++++++++----------------
 slirp/socket.c |  4 +++-
 slirp/udp.c    |  4 ++++
 3 files changed, 21 insertions(+), 17 deletions(-)
