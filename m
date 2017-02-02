Received: from eggs.gnu.org ([2001:4830:134:3::10]:35531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZBYm-0006H9-RE
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 02:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZBYj-00087S-MR
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 02:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZBYj-00086t-Gn
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 02:11:57 -0500
Message-ID: <1486019510.20628.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 08:11:50 +0100
In-Reply-To: <alpine.GSO.2.00.1702012023540.5038@dmz.c-home.cz>
References: <alpine.GSO.2.00.1702012023540.5038@dmz.c-home.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] usb3 - xhci - Assertion `intr->er_full' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Cerveny <M.Cerveny@computer.org>
Cc: qemu-devel@nongnu.org

  Hi,
> - usb with usbredir 0.7.1

What kind of device do you assign to the guest?

> - guest windows 7 - renesas driver 2.1.36 or 2.1.39

ok.

> Where is the verfied windows driver that is compatible/tested with xhci c=
ode ?

Usually I test with the drivers shipped by the operating system, i.e.
linux kernel or windows 8 (or newer).

> I see some movement on xhci sources (https://www.kraxel.org/cgit/qemu/log=
/?h=3Dwork/qemu-xhci) -=20
> Is there some special driver for "PCI_DEVICE_ID_REDHAT_XHCI" "1b36:000c P=
CI xhci usb host adapter" for Windows Guests
> that is compatible with xhci qemu code ?

Generic xhci drivers should work with any xhci controller, no matter
what pci ids it has.

> ---------------------------------- USB keyboard + qemu-xen-4.8.0 + 2.1.39=
 driver + DEBUG_XHCI + DEBUG_DATA ---------------------------

Is the usb keyboard enough to trigger this?

enabling usb_xhci_* trace events would be more helpful than DEBUG_XHCI
(see qemu.git/docs/tracing.txt).

cheers,
  Gerd
