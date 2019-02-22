Received: from eggs.gnu.org ([209.51.188.92]:59733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gxJld-0006O2-9h
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 17:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gxJlc-0004zD-Fj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 17:58:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gxJlc-0004tn-8j
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 17:58:04 -0500
From: Bandan Das <bsd@redhat.com>
Date: Fri, 22 Feb 2019 17:49:32 -0500
Message-Id: <20190222224934.5822-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] usb-mtp coverity fixes
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

Fix some coverity issues and a few others pointed out by Peter

Bandan Das (2):
  usb-mtp: return incomplete transfer on a lstat failure
  usb-mtp: fix some usb_mtp_write_data return paths

 hw/usb/dev-mtp.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

--=20
2.19.2
