Received: from eggs.gnu.org ([209.51.188.92]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4Pc-00064B-Gb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4Pa-0000VM-Ux
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hB4Pa-0000V1-Nb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:24:10 -0400
From: Bandan Das <bsd@redhat.com>
Date: Mon,  1 Apr 2019 17:17:09 -0400
Message-Id: <20190401211712.19012-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/3] misc usb-mtp fixes
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

v4:
  Added 1/3: <jpgva0nuddm.fsf@linux.bootlegged.copy> =20
v3:
  2/2: Fix indentation
       Add back sending RES_OK for success
v2:
  1/2: Add Reviewed-by tag
  2/2: remove extra vars and directly call usb_mtp_queue_result
 =20
The first patch removes a unnecessary function
and the second is just a code reorg of usb_mtp_write_data
to make it less confusing. Applies on top of
[PATCH v3] usb-mtp: fix return status of delete
Message-ID:=20

Bandan Das (3):
  usb-mtp: fix return status of delete
  usb-mtp: remove usb_mtp_object_free_one
  usb-mtp: refactor the flow of usb_mtp_write_data

 hw/usb/dev-mtp.c | 133 +++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

--=20
2.19.2
