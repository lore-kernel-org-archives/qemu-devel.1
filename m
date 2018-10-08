Received: from eggs.gnu.org ([2001:4830:134:3::10]:42865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g9Y0H-0000Cn-NL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g9Y0D-0007pI-7w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1g9Y0C-0007ih-7e
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:25 -0400
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 08 Oct 2018 19:05:34 +0300
Message-id: <20181008160536.6332-1-i.maximets@samsung.com>
MIME-version: 1.0
References: <CGME20181008160317eucas1p12156552c6876786bd3087d3922d49399@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/2] vhost+postcopy fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

Sending as RFC because it's not fully tested yet.

Ilya Maximets (2):
  migration: Stop postcopy fault thread before notifying
  vhost-user: Fix userfaultfd leak

 hw/virtio/vhost-user.c   |  7 +++++++
 migration/postcopy-ram.c | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

--=20
2.17.1
