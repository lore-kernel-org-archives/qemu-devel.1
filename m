Received: from eggs.gnu.org ([209.51.188.92]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEUNY-00029w-Hx
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEUNX-0002S9-KJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEUNX-0002Ri-9j
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:44:11 -0400
References: <5CADFEB7.01C57B.25694@m12-14.163.com>
	<e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
	<CAKXe6S+w4A6YubgQib5H2QXE=eLFLWFQE-mOHYBM5PTXKaYAOA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5f15cd9-c34c-737d-4fa2-2aee7c5f0ad9@redhat.com>
Date: Thu, 11 Apr 2019 09:44:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+w4A6YubgQib5H2QXE=eLFLWFQE-mOHYBM5PTXKaYAOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?Questions_about_acpi_interrupt_link_devic?=
 =?utf-8?b?ZSdzIOKAmF9QUlMnIGZpZWxk?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Li Qiang <liq3ea@163.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 11/04/19 02:57, Li Qiang wrote:
>=20
>=20
> Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>> =E4=BA=
=8E2019
> =E5=B9=B44=E6=9C=8810=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:5=
5=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     On 10/04/19 16:33, Li Qiang wrote:
>     > Hi all,
>     >
>     > =C2=A0
>     >
>     > I see the link device =E2=80=98_PRS=E2=80=99=C2=A0 uses irq line =
5, 10, 11 in
>     > =E2=80=98build_link_dev=E2=80=99 function.
>     >
>     > But I never see the 5 lines uses in the guest, just uses 10 and 1=
1.
>     >
>     > Why this happen?=C2=A0 Maybe related with the guest?
>=20
>     Because the MADT table tells the guest to only use lines 10 and 11.=
=C2=A0 The
>     BIOS configures the chipset that way.
>=20
>=20
> Hi Paolo,
>=20
> I read the MADT spec, and found that it may related with 'Entry Type 2 =
:
> Interrupt Source Override'.
> However, in build_madt function, I found following code when fill
> interrupt source overide.
>=20
> #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No need for a INT source o=
verride structure. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
> Seems the madt doesn't play a role?
>=20
> Also in the seabios code, I see the pci interrupt linking device is
> routed hard-coded by pci_irqs.
> So this means the seabios doesn't use the madt/dsdt table to configure
> PCI interrupt routing?

Yeah, the MADT doesn't matter, I got confused.  It's just the firmware's
definition of pci_irqs that affects the behavior you're seeing.

Paolo
