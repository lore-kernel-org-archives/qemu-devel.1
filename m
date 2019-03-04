Received: from eggs.gnu.org ([209.51.188.92]:35273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0uuS-00036R-Di
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0ujB-00027n-F1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:02:26 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0ujB-0001yj-1L
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:02:25 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon,  4 Mar 2019 22:02:15 +0100
Message-Id: <20190304210217.7056-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv2 0/2] curses: Add support for wide output
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
- Add more rationale in commit message
- Move charset option to curses-only section.

Samuel Thibault (2):
  iconv: detect and make curses depend on it
  curses: add option to specify VGA font encoding

 configure       |  45 ++++++-
 qapi/ui.json    |  14 +++
 qemu-options.hx |   5 +-
 ui/curses.c     | 315 ++++++++++++++++++++++++++++++++++++++++--------
 vl.c            |   2 +-
 5 files changed, 331 insertions(+), 50 deletions(-)

--=20
2.20.1
