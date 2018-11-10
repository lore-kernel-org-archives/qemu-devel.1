Received: from eggs.gnu.org ([2001:4830:134:3::10]:45640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU96-0006lI-R4
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTxG-0000Qa-8n
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTxE-0000EO-EE
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:42 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 10 Nov 2018 15:09:21 +0100
Message-Id: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
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
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit 160e5c22e55b3f775c2003dfc626fa872ee4a7=
a1:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2018-11-09 10:54:10 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 5c75f3adbbfcdf8fae6e74875b44efb8d928974a:

  slirp: fork_exec(): create and connect child socket before fork() (2018=
-11-10 15:07:53 +0100)

----------------------------------------------------------------
slirp updates

Peter Maydell (4):
  slirp: Don't pass possibly -1 fd to send()
  slirp: Use g_new() to allocate sockets in socreate()
  slirp: Remove code that handles socreate() failure
  slirp: fork_exec(): create and connect child socket before fork()

----------------------------------------------------------------
Peter Maydell (4):
      slirp: Don't pass possibly -1 fd to send()
      slirp: Use g_new() to allocate sockets in socreate()
      slirp: Remove code that handles socreate() failure
      slirp: fork_exec(): create and connect child socket before fork()

 slirp/ip_icmp.c   |  2 +-
 slirp/misc.c      | 55 ++++++++++++++++++++++++++++++++++---------------=
------
 slirp/slirp.c     | 14 +++++++++++---
 slirp/socket.c    | 17 ++++++-----------
 slirp/tcp_input.c |  7 +++----
 slirp/tcp_subr.c  |  7 +------
 slirp/udp.c       |  6 ------
 slirp/udp6.c      |  3 ---
 8 files changed, 56 insertions(+), 55 deletions(-)
