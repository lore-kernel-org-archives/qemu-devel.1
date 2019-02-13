Received: from eggs.gnu.org ([209.51.188.92]:44655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtzKE-00058C-2b
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtzKC-0000Yd-6l
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:32:02 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gtzKB-0000QX-CF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:31:59 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 13 Feb 2019 19:31:51 +0100
Message-Id: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Fix slirp on windows
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

The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc=
06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-12 10:53:37 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to adf1add2927c7bb652a168f5be627102921cf35f:

  slirp: wrap the remaining socket functions (2019-02-12 20:49:13 +0100)

----------------------------------------------------------------
Fix slirp on windows

Marc-Andr=C3=A9 Lureau (2):
  slirp: remove slirp_ prefix for socket wrappers
  slirp: wrap the remaining socket functions

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      slirp: remove slirp_ prefix for socket wrappers
      slirp: wrap the remaining socket functions

 slirp/ip_icmp.c  |   4 +-
 slirp/misc.c     |  14 ++---
 slirp/slirp.c    |   2 +-
 slirp/socket.c   |  14 ++---
 slirp/tcp_subr.c |  10 ++--
 slirp/udp.c      |   2 +-
 slirp/util.c     | 164 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 slirp/util.h     |  75 ++++++++++++++++++++-----
 8 files changed, 246 insertions(+), 39 deletions(-)
