Received: from eggs.gnu.org ([2001:4830:134:3::10]:53837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjI39-0003bA-MM
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjI34-00077K-PA
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:09:07 -0500
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:34073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cjI34-000772-KI
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:09:02 -0500
Received: by mail-io0-x229.google.com with SMTP id 90so45635689ios.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 20:09:01 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Wed, 1 Mar 2017 23:08:58 -0500
Message-Id: <38265DF9-8C55-4B4E-9222-F75C5E675ABB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] Patch causes Mac OS X to print dead controller messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liqiang6-s@360.cn>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

commit 95ed56939eb2eaa4e2f349fe6dcd13ca4edfd8fb
usb: ohci: limit the number of link eds

This patch causes Mac OS X to continuously print this message:
USBF: 35.508 AppleUSBOHCI[0x1187000] Watchdog detected dead controller =
(hcca #: 0, hc#: 863)

I used git bisect to find this patch. None of the USB devices work when =
connected to the OHCI USB controller.=
