Received: from eggs.gnu.org ([209.51.188.92]:45291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEUW5-0004sP-PD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEUW3-0000HP-VX
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:53:01 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hEUW3-0000FP-FD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:52:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id l203so4132220oia.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 00:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <5CADFEB7.01C57B.25694@m12-14.163.com>
	<e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
	<CAKXe6S+w4A6YubgQib5H2QXE=eLFLWFQE-mOHYBM5PTXKaYAOA@mail.gmail.com>
	<e5f15cd9-c34c-737d-4fa2-2aee7c5f0ad9@redhat.com>
In-Reply-To: <e5f15cd9-c34c-737d-4fa2-2aee7c5f0ad9@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 11 Apr 2019 15:52:22 +0800
Message-ID: <CAKXe6SLRaxmRy-sraaee-Z04KLgwB8_rRz7ejSu_vDm+7RETPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:44=E5=86=99=E9=81=93=EF=BC=9A

> On 11/04/19 02:57, Li Qiang wrote:
> >
> >
> > Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>> =E4=BA=
=8E2019
> > =E5=B9=B44=E6=9C=8810=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:5=
5=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     On 10/04/19 16:33, Li Qiang wrote:
> >     > Hi all,
> >     >
> >     >
> >     >
> >     > I see the link device =E2=80=98_PRS=E2=80=99  uses irq line 5, 10=
, 11 in
> >     > =E2=80=98build_link_dev=E2=80=99 function.
> >     >
> >     > But I never see the 5 lines uses in the guest, just uses 10 and 1=
1.
> >     >
> >     > Why this happen?  Maybe related with the guest?
> >
> >     Because the MADT table tells the guest to only use lines 10 and 11.
> The
> >     BIOS configures the chipset that way.
> >
> >
> > Hi Paolo,
> >
> > I read the MADT spec, and found that it may related with 'Entry Type 2 =
:
> > Interrupt Source Override'.
> > However, in build_madt function, I found following code when fill
> > interrupt source overide.
> >
> > #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> >         if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> >             /* No need for a INT source override structure. */
> >             continue;
> >         }
> >
> > Seems the madt doesn't play a role?
> >
> > Also in the seabios code, I see the pci interrupt linking device is
> > routed hard-coded by pci_irqs.
> > So this means the seabios doesn't use the madt/dsdt table to configure
> > PCI interrupt routing?
>
> Yeah, the MADT doesn't matter, I got confused.  It's just the firmware's
> definition of pci_irqs that affects the behavior you're seeing.
>
>
Hello Paolo,

Thanks so much for your confirmation! I appreciate it.
I'm confused by the massive acpi table/concepts recently.

Thanks,
Li Qiang






> Paolo
>
