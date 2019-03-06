Received: from eggs.gnu.org ([209.51.188.92]:51772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1dne-0004hq-Ka
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1dnd-0005e2-V2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:10:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h1dnd-0005cu-No
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:10:01 -0500
From: Bandan Das <bsd@redhat.com>
Date: Wed,  6 Mar 2019 16:04:06 -0500
Message-Id: <20190306210409.14842-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] usb-mtp coverity fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org

v2:
  Rebase
  Prevent a null dereference when deleting objects
Fix some coverity issues and a few others pointed out by Peter

Bandan Das (3):
  usb-mtp: return incomplete transfer on a lstat failure
  usb-mtp: fix some usb_mtp_write_data return paths
  usb-mtp: prevent null dereference while deleting objects

 hw/usb/dev-mtp.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

--=20
2.19.2
