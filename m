Received: from eggs.gnu.org ([2001:4830:134:3::10]:36303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTaK-00049G-Bv
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTaF-0006Lg-E5
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTaF-0006Il-8c
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:45:55 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:35 +0400
Message-Id: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 00/13] slirp: cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Here is a bunch of slirp cleanups for 3.2.

Marc-Andr=C3=A9 Lureau (13):
  slirp: associate slirp_output callback with the Slirp context
  slirp: remove do_pty from fork_exec()
  slirp: replace ex_pty with ex_chardev
  slirp: use a dedicated field for chardev pointer
  slirp: remove unused EMU_RSH
  slirp: rename /extra/chardev
  slirp: move internal function declarations
  slirp: remove Monitor dependency, return a string for info
  slirp: fix slirp_add_exec() leaks
  slirp: improve subprocess socket creation
  slirp: replace the poor-man string split with g_strsplit()
  glib-compat: add g_spawn_async_with_fds() fallback
  slirp: simplify fork_exec()

 include/glib-compat.h |  56 ++++++++++
 slirp/libslirp.h      |  14 ++-
 slirp/misc.h          |   9 +-
 slirp/slirp.h         |   4 +
 slirp/socket.h        |   2 +-
 net/slirp.c           |  20 ++--
 slirp/misc.c          | 240 +++++++++++++++++++-----------------------
 slirp/ncsi.c          |   2 +-
 slirp/slirp.c         |  34 +++---
 slirp/socket.c        |   4 -
 slirp/tcp_subr.c      |   9 +-
 11 files changed, 216 insertions(+), 178 deletions(-)

--=20
2.19.1.708.g4ede3d42df
