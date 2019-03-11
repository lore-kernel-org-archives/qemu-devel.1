Received: from eggs.gnu.org ([209.51.188.92]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h3LND-0003bY-Er
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h3LL2-00054W-PE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:51:33 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h3LL2-000540-He
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:51:32 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 11 Mar 2019 14:51:25 +0100
Message-Id: <20190311135127.2229-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv3 0/2] curses: Add support for wide output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, pbonzini@redhat.com, kraxel@redhat.com, armbru@redhat.com, ekohler@gmail.com, eblake@redhat.com

Hello,

This adds support for wide output in the curses frontend

Difference with previous version:
- detect iconv from /usr/local before from /usr, in case a libiconv
  version is there in addition to the system-provided in /usr

Samuel Thibault (2):
  iconv: detect and make curses depend on it
  curses: add option to specify VGA font encoding

 configure        |  60 ++++++++-
 qapi/ui.json     |  14 +++
 qemu-options.hx  |   5 +-
 ui/Makefile.objs |   4 +-
 ui/curses.c      | 315 ++++++++++++++++++++++++++++++++++++++++-------
 vl.c             |   2 +-
 6 files changed, 348 insertions(+), 52 deletions(-)

--=20
2.20.1
