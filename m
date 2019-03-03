Received: from eggs.gnu.org ([209.51.188.92]:39962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0Obl-0005Ac-Fj
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0Obk-0000j5-QF
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:44:37 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0Obk-0000hk-IS
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:44:36 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun,  3 Mar 2019 11:44:28 +0100
Message-Id: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] curses: Add support for wide output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kraxel@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, Eddie Kohler <ekohler@gmail.com>

Hello,

This adds support for wide output in the curses frontend

Samuel Thibault (2):
  iconv: detect and make curses depend on it
  curses: add option to specify VGA font encoding

 configure       |  45 ++++++-
 qapi/ui.json    |   4 +-
 qemu-options.hx |   5 +-
 ui/curses.c     | 315 ++++++++++++++++++++++++++++++++++++++++--------
 vl.c            |   2 +-
 5 files changed, 320 insertions(+), 51 deletions(-)

--=20
2.20.1
