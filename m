Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ray.kinsella@intel.com>) id 1dXDuZ-0001HM-9S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ray.kinsella@intel.com>) id 1dXDuU-000462-9X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:50:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:22744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ray.kinsella@intel.com>)
	id 1dXDuT-00045I-V5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:50:34 -0400
From: "Kinsella, Ray" <ray.kinsella@intel.com>
Date: Mon, 17 Jul 2017 21:50:29 +0000
Message-ID: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] >256 Virtio-net-pci hotplug Devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>

Hi folks,

I am trying to create a VM that supports hot-plugging a large number of vir=
tio-net-pci device,=20
up to 1000 devices initially.

>From the docs (see below) and from playing with QEMU, it looks like there a=
re two options.
Both with limitations.

PCI Express switch

It looks like using a PCI Express switch hierarchy is not an option due to =
bus exhaustion.=20
Each downstream port creates a separate bus and each downstream port only s=
upports hot-plugging a single device.
So this gives us a max of 256-ish buses/devices pairs.

PCI Root Ports

The other option is use a flatter hierarchy, with a number of multi-functio=
n PCI Root Ports hanging off 'pcie.0'.
However each 'PCI Root Port' can support hot-plugging a single device.=20
So this method really becomes a function of how many free address we have o=
n 'pci.0'.
If we make room for say 16 multifunction devices, we get 16*8 ... 128
So ultimately, this will approach will give us a similar to number to using=
 a switch.=20

Is there another method?
( pxb-pcie doesn't support hotplug for instance, and only a single pcie dom=
ain is supported qemu )

Thanks,

Ray K

Pcie.txt,=20
( https://github.com/qemu/qemu/blob/master/docs/pcie.txt )
Q35 preso
( http://wiki.qemu.org/images/4/4e/Q35.pdf )

=20
