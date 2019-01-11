Received: from eggs.gnu.org ([209.51.188.92]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1ghs3t-0005t4-Ev
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1ghs3s-0001D8-RE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:21:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1ghs3s-0001CZ-L9
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:21:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9AB6C056794
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:21:03 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri, 11 Jan 2019 03:20:41 -0500
Message-Id: <20190111082043.31412-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2 v2] Break down the MTP write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

v2:
  Rebased on top of master and retested

For larger files, not only do we keep reallocating to increase the mtp bu=
ffer
size, the write also happens in one go. This does two things:

Write to file upto a certain data size we have received so far and second=
,
reuse the buffer again instead of reallocating to a larger buffer size.

Tested with different file sizes on a Linux guest.

Bandan Das (2):
  usb-mtp: Reallocate buffer in multiples of MTP_WRITE_BUF_SZ
  usb-mtp: breakup MTP write into smaller chunks

 hw/usb/dev-mtp.c | 154 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 54 deletions(-)

--=20
2.19.2
