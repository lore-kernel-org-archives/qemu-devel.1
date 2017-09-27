Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxAc9-0001ug-F6
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxAc6-0007uT-DM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:34:53 -0400
Message-ID: <1506512087.25036.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Sep 2017 13:34:47 +0200
In-Reply-To: <AM5P194MB0132C46F9FCCF1DCF2FFC7D0C87A0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <AM5P194MB0132C46F9FCCF1DCF2FFC7D0C87A0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ppce500 usb-ehci-pci issue on last uboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

  Hi,

> "actually, I tried it yesterday and it seems to be a bug in qemu in
> case you reset the EHCI controller, it doesn't come out of reset for
> whatever reason ... so you probably want to talk to the qemu guys,
> it's when U-Boot sets USBCMD RESET bit and then does handshake, the
> controller is stuck with reset bit asserted"
> 
> 
> i ask if possible to fix it?

Nothing obvious in the ehci reset code.  Needs someone debugging it ...

Is this on a bigendian host?  If so this could be endian bugs in the
ehci emulation.

You could also try xhci or ohci instead, these are known-working on
bigendian hosts (used by ppc64 pseries).

cheers,
  Gerd
