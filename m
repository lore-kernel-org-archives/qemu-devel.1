Received: from eggs.gnu.org ([2001:4830:134:3::10]:36019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ccBxM-0006xf-Uf
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ccBxI-00047I-1K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:13:48 -0500
Received: from greensocs.com ([193.104.36.180]:57935)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ccBxH-000468-J2
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:13:43 -0500
References: <CAPasb5WKwx0kqsG+XUAENAxgUqL8YnJ7ha=qBfnWA8dde5Lvfw@mail.gmail.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <0b570f0b-66dd-351f-1a4c-cb82b9716ebb@greensocs.com>
Date: Fri, 10 Feb 2017 15:13:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAPasb5WKwx0kqsG+XUAENAxgUqL8YnJ7ha=qBfnWA8dde5Lvfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Asking about USB for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wojciech Zebrowski <wojciechzeb@gmail.com>
Cc: qemu-devel@nongnu.org

Hi,

If I understand right:
You want to run a zynq qemu on a centos host?

On 02/09/2017 09:25 AM, Wojciech Zebrowski wrote:
> Hi
>=20
> I try connect my host linux centos USB to Qemu for Xilinx Zynq solution=
.
> I do following step :
> 1.Check usb vendor id , product id: lsusb
>=20
>=20
>=20
>=20
> *Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hubBus 002
> Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hubBus 003 Device 00=
1:
> ID 1d6b:0002 Linux Foundation 2.0 root hubBus 004 Device 001: ID 1d6b:0=
003
> Linux Foundation 3.0 root hub*
>=20
> 2. I start Qemu with switch :
>=20
> *-usbdevice host:<VendorID>:<ProductID>*
>=20
> *-usbdevice host:1d6b:0002*
>=20
>  3. On Centos Host computer where Xilinx Qemu is started , i've error a=
s :
>=20
> *No 'PCI' bus found for device 'usb-ehci'*

It is highly probable that the --usbdevice command try to create a
usb-ehci device and it doesn't find any PCI bus on the machine you
choose.

>=20
> What is incorrect with my command or system configuration ?
>=20
> 4. I check my motherboard bridge as following:
>=20
> *qemu-system-x86_64 -device help |& grep usb.*hci*

Then here I don't get it. Why are you using qemu-system-x86_64?
It will be approximately the same for qemu-system-arm though.
Only there is probably no PCI bus where to connect them.

Can you give the complete command you are using?

Fred

>=20
> *name "ich9-usb-ehci1", bus PCI name *
>=20
> *"ich9-usb-ehci2", bus PCI name *
>=20
> *"ich9-usb-uhci1", bus PCI name *
>=20
> *"ich9-usb-uhci2", bus PCI name *
>=20
> *"ich9-usb-uhci3", bus PCI name *
>=20
> *"ich9-usb-uhci4", bus PCI name *
>=20
> *"ich9-usb-uhci5", bus PCI name *
>=20
> *"ich9-usb-uhci6", bus PCI name *
>=20
> *"nec-usb-xhci", bus PCI name *
>=20
> *"piix3-usb-uhci", bus PCI name *
>=20
> *"piix4-usb-uhci", bus PCI name *
>=20
> *"usb-ehci", bus PCI name *
>=20
> *"vt82c686b-usb-uhci", bus PCI*
>=20
>=20
> *Any advice for check ?*
>=20
>=20
> Best regards :
>=20
> Wojciech Zebrowski
>=20
