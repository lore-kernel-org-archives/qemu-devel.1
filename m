Received: from eggs.gnu.org ([208.118.235.92]:59453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTkFD-00071F-V9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTk4x-0002JA-IF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:59:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gTk4v-0002H6-Gy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:59:45 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Dec 2018 09:59:36 +0100
Message-Id: <20181203085938.10247-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v2 0/2] usb-mtp: two bugfixes (one
 security fix).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: public@hansmi.ch, Gerd Hoffmann <kraxel@redhat.com>

v2:
 - add comment about the (preexisting) issue noted by armbru.
 - change error code as suggested by bsd.
 - update reporter email address.

Gerd Hoffmann (2):
  usb-mtp: fix utf16_to_str
  usb-mtp: outlaw slashes in filenames

 hw/usb/dev-mtp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.9.3
