Received: from eggs.gnu.org ([2001:4830:134:3::10]:40474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dwYlt-0001gN-R0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dwYls-0000tK-H6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:10:25 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Mon, 25 Sep 2017 19:10:11 +0000
Message-ID: <AM5P194MB0132C46F9FCCF1DCF2FFC7D0C87A0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ppce500 usb-ehci-pci issue on last uboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

Hi all,

the last uboot git mainstream gave the opportunity to made usb ehci-pci wor=
k and gave to the vm the opportunity to load from

usb pendrive files, configurations, use a use mouse and keyboard.

i build the uboot with qemu-ppce500_defconfig  machine this feature was con=
figured without problem and uboot build without issue.

just adding to the  .config

CONFIG_CMD_USB=3Dy

CONFIG_USB=3Dy

CONFIG_USB_EHCI_HCD=3Dy

CONFIG_USB_EHCI_PCI=3Dy




here the new uboot console working on ppce500 -cpu e5500

U-Boot 2017.09-00322-g1f6049e (Sep 25 2017 - 20:50:48 +0200)


BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.01.00   0x8086     0x24cd     Serial bus controller   0x03
00.02.00   0x8086     0x2922     Mass storage controller 0x06
00.03.00   0x1234     0x1111     Display controller      0x00
00.06.00   0x1af4     0x1000     Network controller      0x00


when i  run the command usb start inside the uboot console:

=3D> usb start
starting USB...
USB0:   EHCI fail to reset
lowlevel init failed
USB error: all controllers failed lowlevel init


I been meet uboot developers and after one afternoon in drilling inside the=
 code of uboot they assume the issue was come in qemu and not in uboot.


from an uboot dev:
"actually, I tried it yesterday and it seems to be a bug in qemu in case yo=
u reset the EHCI controller, it doesn't come out of reset for whatever reas=
on ... so you probably want to talk to the qemu guys, it's when U-Boot sets=
 USBCMD RESET bit and then does handshake, the controller is stuck with res=
et bit asserted"


i ask if possible to fix it?

here some past&bin of drilling inside uboot

https://pastebin.com/93DRFGcM

https://pastebin.com/g5j2XN6R

https://pastebin.com/KDMCU7C5

https://pastebin.com/ndLtNQxS<https://pastebin.com/i3TkejfT>


Thanks

Luigi
