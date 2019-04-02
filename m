Received: from eggs.gnu.org ([209.51.188.92]:50020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hB9P8-00039x-2f
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hB9Ar-0001wh-P1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:29:19 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com
	([40.107.68.128]:24899
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tjin@wavecomp.com>) id 1hB9Aj-0001jO-CP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:29:17 -0400
From: Tommy Jin <tjin@wavecomp.com>
Date: Tue, 2 Apr 2019 02:29:05 +0000
Message-ID: <MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>,
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
In-Reply-To: <CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pburton.wavecomp.com@gmail.com" <pburton.wavecomp.com@gmail.com>

Hi Peter,


Thank you very much for you comments,I sent a wrong patch out by mistake.



If always creating virtio-net-pci device is not a good idea, is it feasible=
 to make virtio-net-pci as an option for boston without using libvirt? we c=
an only create this device when the user specify "model=3Dvirtio".


Actually, Botson board can have an Intel GBE network card in it, compared t=
o mips malta, it also has a pcnet network card created in its machine, is i=
t acceptable to create a pch_gbe network card if the user specify like "mod=
el=3Dpch_gbe"?


Best regards,

Tommy

________________________________
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Sent: Tuesday, April 2, 2019 10:25 AM
To: Peter Maydell
Cc: Tommy Jin; qemu-devel@nongnu.org; pburton.wavecomp.com@gmail.com
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard fo=
r mips boston board.


On Apr 1, 2019 11:39 AM, "Peter Maydell" <peter.maydell@linaro.org<mailto:p=
eter.maydell@linaro.org>> wrote:
>
> On Mon, 1 Apr 2019 at 16:23, Tommy Jin <tjin@wavecomp.com<mailto:tjin@wav=
ecomp.com>> wrote:
> >
> > Boston didn't bring up any netcard by default, this is not so convenien=
t for users who are verifying network related functionalities on this board=
.
> > As the linux kernel has already supported virtio_net, now add a virtio =
netcard for boston, to make virtio work properly, please:
> > 1. set virtio net options in linux kernel, saying CONFIG_VIRTIO && CONF=
IG_VIRTIO_PCI && CONFIG_VIRTIO_NET
> > 2. specify model=3Dvirtio when you start boston in qemu.
> >
> > Signed-off-by: tjin <tjin@wavecomp.com<mailto:tjin@wavecomp.com>>
> > ---
> >  hw/mips/boston.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> > index cac0e22..5d3239e 100644
> > --- a/hw/mips/boston.c
> > +++ b/hw/mips/boston.c
> > @@ -428,10 +428,10 @@ static void network_init(PCIBus *bus)
> >  {
> >      PCIDevice *eth;
> >
> > -    /*Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_N=
ET
> > -        of Linux kernel.*/
> > +    /* Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_=
NET */
> > +    /* of Linux kernel. */
>
> This sort of thing should go in documentation, not as a comment
> in the code.
>
> >      eth =3D pci_create(bus,
> > -                                        PCI_DEVFN(0, 1), "virtio-net-p=
ci");
> > +                     PCI_DEVFN(0, 1), "virtio-net-pci");
>
>
> Am I missing something, or is this patch not actually changing
> any code? Maybe you made a mistake somehow when creating it?
>
> I'm not sure if we want to create a default network card
> for this board -- the user (or more usually the management
> layer like libvirt) can create it on the command line, and
> if we always create a virtio-net-pci device in the code then
> the user has no way to say they *don't* want the device.
>
> Also, this board is a model of a real piece of hardware, and
> the real hardware doesn't have a virtio-net device in it.
>
> >
> >      qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
> >      qdev_init_nofail(&eth->qdev);
> > --
>
> thanks
> -- PMM
>

Just adding Paul Burton, the Boston card emulation maintainer.

Aleksandar
