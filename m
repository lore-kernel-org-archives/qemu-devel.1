Received: from eggs.gnu.org ([2001:4830:134:3::10]:49338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlF-0002JS-7s
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlB-000862-8D
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRdlA-000834-OL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:41 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127135038euoutp023174ad2240ea892c7d89e75a39cbc999~q-2ab1R4C2313823138euoutp02F
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:50:38 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 16:50:26 +0300
Message-Id: <20181127135030.1671-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <CGME20181127135037eucas1p18867a9ae8b1f2731ad4ce8d79fddae33@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] memfd fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

Version 2:
    * First patch changed to just drop the memfd backend
      if seals are not supported.

Ilya Maximets (4):
  hostmem-memfd: disable for systems wihtout sealing support
  memfd: always check for MFD_CLOEXEC
  memfd: set up correct errno if not supported
  memfd: improve error messages

 backends/hostmem-memfd.c | 18 ++++++++----------
 tests/vhost-user-test.c  |  6 +++---
 util/memfd.c             | 10 ++++++++--
 3 files changed, 19 insertions(+), 15 deletions(-)

--=20
2.17.1
