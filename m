Received: from eggs.gnu.org ([2001:4830:134:3::10]:51247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbGr-0003Kk-Hj
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbGo-0004pC-AK
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRbGn-0004nh-SP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127111105euoutp0124a7fa7551797106b2b575ae7f506b3b~q9rHG-4yQ3177731777euoutp01Y
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 11:11:05 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 14:10:46 +0300
Message-Id: <20181127111050.18453-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <CGME20181127111104eucas1p14b6fefcf6246707eb6ac728d8dccb29c@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] memfd fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

Ilya Maximets (4):
  hostmem-memfd: enable seals only if supported
  memfd: always check for MFD_CLOEXEC
  memfd: set up correct errno if not supported
  memfd: improve error messages

 backends/hostmem-memfd.c |  4 ++--
 util/memfd.c             | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--=20
2.17.1
