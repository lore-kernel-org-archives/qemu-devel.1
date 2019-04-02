Received: from eggs.gnu.org ([209.51.188.92]:50659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hB9PP-0003bM-4h
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hB9PE-0005hd-3W
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:44:13 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hB9P7-0005aE-H8
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:44:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id i21so9166306oib.11
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 19:44:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
	<MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 2 Apr 2019 04:43:59 +0200
Message-ID: <CAL1e-=gL43P8aj+PYgLN6qFK8wUK=6VFreFvkUyvM+FX_SW_vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 mips boston board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tommy Jin <tjin@wavecomp.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pburton@wavecomp.com

On Apr 2, 2019 4:29 AM, "Tommy Jin" <tjin@wavecomp.com> wrote:
>
> Hi Peter,
>
>
> Thank you very much for you comments,I sent a wrong patch out by mistake.
>
>
>
> If always creating virtio-net-pci device is not a good idea, is it
feasible to make virtio-net-pci as an option for boston without using
libvirt? we can only create this device when the user specify
"model=3Dvirtio".
>
>
> Actually, Botson board can have an Intel GBE network card in it, compared
to mips malta, it also has a pcnet network card created in its machine, is
it acceptable to create a pch_gbe network card if the user specify like
"model=3Dpch_gbe"?
>
>
> Best regards,
>
> Tommy
>
>

Hello, Tommy.

Thanks for your efforts in this area. However, your patches will have
greater chances of serious considering and accepting if you follow the
rules of submitting them to this list. There is a page on contributing
called =E2=80=9CHow to submit a patch=E2=80=9C on QEMU website. Please read=
 it carefully
and follow each step.

Welcome to qemu-devel! I wish you continue to contribute to QEMU many
improvements.

Aleksandar
________________________________
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Sent: Tuesday, April 2, 2019 10:25 AM
> To: Peter Maydell
> Cc: Tommy Jin; qemu-devel@nongnu.org; pburton.wavecomp.com@gmail.com
> Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard
for mips boston board.
>
>
>
> On Apr 1, 2019 11:39 AM, "Peter Maydell" <peter.maydell@linaro.org> wrote=
:
> >
> > On Mon, 1 Apr 2019 at 16:23, Tommy Jin <tjin@wavecomp.com> wrote:
> > >
> > > Boston didn't bring up any netcard by default, this is not so
convenient for users who are verifying network related functionalities on
this board.
> > > As the linux kernel has already supported virtio_net, now add a
virtio netcard for boston, to make virtio work properly, please:
> > > 1. set virtio net options in linux kernel, saying CONFIG_VIRTIO &&
CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET
> > > 2. specify model=3Dvirtio when you start boston in qemu.
> > >
> > > Signed-off-by: tjin <tjin@wavecomp.com>
> > > ---
> > >  hw/mips/boston.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> > > index cac0e22..5d3239e 100644
> > > --- a/hw/mips/boston.c
> > > +++ b/hw/mips/boston.c
> > > @@ -428,10 +428,10 @@ static void network_init(PCIBus *bus)
> > >  {
> > >      PCIDevice *eth;
> > >
> > > -    /*Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI &&
CONFIG_VIRTIO_NET
> > > -        of Linux kernel.*/
> > > +    /* Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI &&
CONFIG_VIRTIO_NET */
> > > +    /* of Linux kernel. */
> >
> > This sort of thing should go in documentation, not as a comment
> > in the code.
> >
> > >      eth =3D pci_create(bus,
> > > -                                        PCI_DEVFN(0, 1),
"virtio-net-pci");
> > > +                     PCI_DEVFN(0, 1), "virtio-net-pci");
> >
> >
> > Am I missing something, or is this patch not actually changing
> > any code? Maybe you made a mistake somehow when creating it?
> >
> > I'm not sure if we want to create a default network card
> > for this board -- the user (or more usually the management
> > layer like libvirt) can create it on the command line, and
> > if we always create a virtio-net-pci device in the code then
> > the user has no way to say they *don't* want the device.
> >
> > Also, this board is a model of a real piece of hardware, and
> > the real hardware doesn't have a virtio-net device in it.
> >
> > >
> > >      qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
> > >      qdev_init_nofail(&eth->qdev);
> > > --
> >
> > thanks
> > -- PMM
> >
>
> Just adding Paul Burton, the Boston card emulation maintainer.
>
> Aleksandar
