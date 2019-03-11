Received: from eggs.gnu.org ([209.51.188.92]:51250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSa-0008Sq-53
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSZ-0000SO-EL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1h3LSY-0000PJ-IF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20190311135912euoutp015ef5af75bfd265fe5fc9a0380a53b541~K7Dk-H98p1038110381euoutp011
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:59:12 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 11 Mar 2019 16:58:46 +0300
Message-Id: <20190311135850.6537-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <CGME20190311135911eucas1p2612665dccba27cc8b5d81b67a70480c6@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] memfd fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

Version 3:
    * Rebase on top of current master.

Version 2:
    * First patch changed to just drop the memfd backend
      if seals are not supported.

Ilya Maximets (4):
  hostmem-memfd: disable for systems wihtout sealing support
  memfd: always check for MFD_CLOEXEC
  memfd: set up correct errno if not supported
  memfd: improve error messages

 backends/hostmem-memfd.c | 18 ++++++++----------
 tests/vhost-user-test.c  |  5 +++--
 util/memfd.c             | 10 ++++++++--
 3 files changed, 19 insertions(+), 14 deletions(-)

--=20
2.17.1
