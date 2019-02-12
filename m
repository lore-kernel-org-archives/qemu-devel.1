Received: from eggs.gnu.org ([209.51.188.92]:59271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtaj3-0005X3-Sa
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtaj1-0005CF-3x
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:16:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtaiz-00056P-Ui
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:15:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:09:51 +0100
Message-Id: <20190212160953.29051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Fix slirp regression on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, hsp.cat7@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

QEMU wraps the socket functions in os-win32.h, but in commit
a9d8b3ec4385793815d71217857304, the header inclusion was dropped,
breaking slirp on Windows. Fix the regression by wrapping all the
socket functions.

thanks

Marc-Andr=C3=A9 Lureau (2):
  slirp: remove slirp_ prefix for socket wrappers
  slirp: wrap the remaining socket functions

 slirp/util.h     |  75 ++++++++++++++++++----
 slirp/ip_icmp.c  |   4 +-
 slirp/misc.c     |  14 ++--
 slirp/slirp.c    |   2 +-
 slirp/socket.c   |  14 ++--
 slirp/tcp_subr.c |  10 +--
 slirp/udp.c      |   2 +-
 slirp/util.c     | 164 ++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 246 insertions(+), 39 deletions(-)

--=20
2.21.0.rc0.1.g036caf7885
