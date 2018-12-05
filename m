Received: from eggs.gnu.org ([2001:4830:134:3::10]:52763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gUYsk-0002hk-4N
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gUYrY-0006T8-Vy
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:13:24 -0500
Received: from m12-11.163.com ([220.181.12.11]:42139)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gUYrY-0006PK-1s
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:13:20 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Wed, 5 Dec 2018 23:13:07 +0800
Message-Id: <5C07EB0A.0934FA.23346@m12-11.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Question about piix3's PIRQC register set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, Alex Williamson <alex.l.williamson@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello Paolo Alex, and all,

I have a question when reading the =E2=80=98vfio_intx_enable=E2=80=99 funct=
ion.

There calls =E2=80=98pci_device_route_intx_to_irq=E2=80=99 to get the =E2=
=80=98irq number=E2=80=99 from=20
a device intx info.

It is read from =E2=80=98piix3->dev.config[PIIX_PIRQC + pin];=E2=80=99 in =
=E2=80=98piix3_route_intx_pin_to_irq=E2=80=99.

Here my question when the piix3=E2=80=99s PIRQx route control registers is =
set and by who?
I mean when this =E2=80=98=E2=80=98piix3->dev.config[PIIX_PIRQC + pin];=E2=
=80=99=E2=80=99 is set?

Once I think this is set by seabios.=20
But seems it is not as this function is called in vfio_realize, the guest d=
ones=E2=80=99t begin.

Thanks,
Li Qiang=20
