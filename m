Received: from eggs.gnu.org ([209.51.188.92]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@janustech.com>) id 1goD9q-0003Xf-2z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@janustech.com>) id 1goD9c-0005DW-3C
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:05:16 -0500
Received: from mail-eopbgr790123.outbound.protection.outlook.com
	([40.107.79.123]:1377
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuri.benditovich@janustech.com>)
	id 1goD9b-0005Bz-Gp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:05:11 -0500
From: Yuri Benditovich <yuri.benditovich@janustech.com>
Date: Mon, 28 Jan 2019 20:05:05 +0000
Message-ID: <20190128200444.5128-1-yuri.benditovich@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/2] Fix XHCI errors with isochronous transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Dmitry Fleytman <dmitry.fleytman@janustech.com>

These patches fix errors causing isochronous transfer to stop
when XHCI works with redirected devices:
* avoid halt of isochronous endpoints
* implement underrun/overrun events

Note that checkpatch emits errors for patch 2 on usage by
'slotid-1' statement. I still leave it for readability
as this construction is used in this file everywhere.

Yuri Benditovich (2):
  usb: XHCI shall not halt isochronous endpoints
  usb: implement XHCI underrun/overrun events

 hw/usb/hcd-xhci.c | 22 ++++++++++++++++++++--
 hw/usb/hcd-xhci.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

--=20
2.9.5
