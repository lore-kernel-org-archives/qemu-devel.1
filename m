Received: from eggs.gnu.org ([2001:4830:134:3::10]:48874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ckofE-0000Mw-CX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ckofA-0000R5-EL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:10:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ckofA-0000Qw-8n
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:10:40 -0500
Message-ID: <1488791436.18653.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Mar 2017 10:10:36 +0100
In-Reply-To: <38265DF9-8C55-4B4E-9222-F75C5E675ABB@gmail.com>
References: <38265DF9-8C55-4B4E-9222-F75C5E675ABB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] Patch causes Mac OS X to print dead controller
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Li Qiang <liqiang6-s@360.cn>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Mi, 2017-03-01 at 23:08 -0500, Programmingkid wrote:
> commit 95ed56939eb2eaa4e2f349fe6dcd13ca4edfd8fb
> usb: ohci: limit the number of link eds
>=20
> This patch causes Mac OS X to continuously print this message:
> USBF: 35.508 AppleUSBOHCI[0x1187000] Watchdog detected dead controller (h=
cca #: 0, hc#: 863)
>=20
> I used git bisect to find this patch. None of the USB devices work when c=
onnected to the OHCI USB controller.

Hmm, ok, appearently the limit is too strict for macos.  Can you try to
increase ED_LINK_LIMIT ?

thanks,
  Gerd
