Received: from eggs.gnu.org ([209.51.188.92]:40025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dK-0004KN-JH
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dJ-00074r-Dl
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hH6dH-0006x0-AR
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:17 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 18 Apr 2019 14:59:06 +0200
Message-Id: <20190418125908.11928-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Memory fixes for slirp tcp_emu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

See the following 2 patches fixing some memory issues in
tcp_emu(). Those are not regressions, consider it for 4.1.

Marc-Andr=C3=A9 Lureau (2):
  slirp: ensure there is enough space in mbuf to null-terminate
  slirp: don't manipulate so_rcv in tcp_emu()

 slirp/src/tcp_subr.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

--=20
2.21.0.313.ge35b8cb8e2
