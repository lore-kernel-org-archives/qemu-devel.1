Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72800C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0BB21473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0BB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVnT-0001oL-AS
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:02:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hDVmT-0001Kx-AP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hDVmR-0001vN-Qy
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:01:53 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:32796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hDVmR-0001o9-FL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:01:51 -0400
Received: from player729.ha.ovh.net (unknown [10.109.160.251])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id DD36EEE842
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 17:01:42 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player729.ha.ovh.net (Postfix) with ESMTPSA id 4262F4B118B7;
	Mon,  8 Apr 2019 15:01:38 +0000 (UTC)
Date: Mon, 8 Apr 2019 17:01:37 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190408170137.4c3f19f7@bahia.lan>
In-Reply-To: <20190408034054.GB16627@umbus.fritz.box>
References: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
	<155448184841.8446.13959787238854054119.stgit@bahia.lan>
	<20190408034054.GB16627@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/vMwjtwOcoop4do8gvwyuFJ6";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 7085851066718591462
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefgdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.172
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] spapr: Drop duplicate code in
 LSI mapping
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408150137.GKtv1jwXnlZk8mI-z1m0WHr3aJTnIwOF7yQoSTavZ6E@z>

--Sig_/vMwjtwOcoop4do8gvwyuFJ6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2019 13:40:54 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Apr 05, 2019 at 06:30:48PM +0200, Greg Kurz wrote:
> > LSI mapping in spapr currently open-codes standard PCI swizzling. It th=
us
> > duplicates the code of pci_swizzle_map_irq_fn().
> >=20
> > Expose the swizzling formula so that it can be used with a slot number
> > when building the device tree. Simply drop pci_spapr_map_irq() and call
> > pci_swizzle_map_irq_fn() instead.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied to ppc-for-4.1, thanks.
>=20

Thanks ! I just realize that I had come up with a better title, at least
from my POV, but I forgot to update before posting...

spapr: Drop duplicate PCI swizzle code

No big deal if you keep the current title of course :)


> > ---
> >  hw/pci/pci.c         |    2 +-
> >  hw/ppc/spapr_pci.c   |   24 ++++--------------------
> >  include/hw/pci/pci.h |    4 ++++
> >  3 files changed, 9 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 35451c1e9987..bb52bafd8d1c 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1532,7 +1532,7 @@ void pci_device_set_intx_routing_notifier(PCIDevi=
ce *dev,
> >   */
> >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
> >  {
> > -    return (pin + PCI_SLOT(pci_dev->devfn)) % PCI_NUM_PINS;
> > +    return pci_swizzle(PCI_SLOT(pci_dev->devfn), pin);
> >  }
> > =20
> >  /***********************************************************/
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index c70688a0dc23..26850d0b94f4 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -719,26 +719,10 @@ param_error_exit:
> >      rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >  }
> > =20
> > -static int pci_spapr_swizzle(int slot, int pin)
> > -{
> > -    return (slot + pin) % PCI_NUM_PINS;
> > -}
> > -
> > -static int pci_spapr_map_irq(PCIDevice *pci_dev, int irq_num)
> > -{
> > -    /*
> > -     * Here we need to convert pci_dev + irq_num to some unique value
> > -     * which is less than number of IRQs on the specific bus (4).  We
> > -     * use standard PCI swizzling, that is (slot number + pin number)
> > -     * % 4.
> > -     */
> > -    return pci_spapr_swizzle(PCI_SLOT(pci_dev->devfn), irq_num);
> > -}
> > -
> >  static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
> >  {
> >      /*
> > -     * Here we use the number returned by pci_spapr_map_irq to find a
> > +     * Here we use the number returned by pci_swizzle_map_irq_fn to fi=
nd a
> >       * corresponding qemu_irq.
> >       */
> >      SpaprPhbState *phb =3D opaque;
> > @@ -1744,7 +1728,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >                                  &sphb->iowindow);
> > =20
> >      bus =3D pci_register_root_bus(dev, NULL,
> > -                                pci_spapr_set_irq, pci_spapr_map_irq, =
sphb,
> > +                                pci_spapr_set_irq, pci_swizzle_map_irq=
_fn, sphb,
> >                                  &sphb->memspace, &sphb->iospace,
> >                                  PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PC=
I_BUS);
> >      phb->bus =3D bus;
> > @@ -2236,14 +2220,14 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, u=
int32_t intc_phandle, void *fdt,
> >      }
> > =20
> >      /* Build the interrupt-map, this must matches what is done
> > -     * in pci_spapr_map_irq
> > +     * in pci_swizzle_map_irq_fn
> >       */
> >      _FDT(fdt_setprop(fdt, bus_off, "interrupt-map-mask",
> >                       &interrupt_map_mask, sizeof(interrupt_map_mask)));
> >      for (i =3D 0; i < PCI_SLOT_MAX; i++) {
> >          for (j =3D 0; j < PCI_NUM_PINS; j++) {
> >              uint32_t *irqmap =3D interrupt_map[i*PCI_NUM_PINS + j];
> > -            int lsi_num =3D pci_spapr_swizzle(i, j);
> > +            int lsi_num =3D pci_swizzle(i, j);
> > =20
> >              irqmap[0] =3D cpu_to_be32(b_ddddd(i)|b_fff(0));
> >              irqmap[1] =3D 0;
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index d87f5f93e9cd..033b2145d98c 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -411,6 +411,10 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_=
irq, pci_map_irq_fn map_irq,
> >  void pci_bus_irqs_cleanup(PCIBus *bus);
> >  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
> >  /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD */
> > +static inline int pci_swizzle(int slot, int pin)
> > +{
> > +    return (slot + pin) % PCI_NUM_PINS;
> > +}
> >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> >  PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
> >                                pci_set_irq_fn set_irq, pci_map_irq_fn m=
ap_irq,
> >  =20
>=20


--Sig_/vMwjtwOcoop4do8gvwyuFJ6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlyrYlEACgkQcdTV5YIv
c9ZxtRAAna0PpLtGxlThr3mW8nPtSQP8wef5oGZuUgDOYZjT/jdyH/nfylHvBvPT
tG4Tvujc4y2O007XJIBspltxeBE7AXSaQp/1DufEsGStbxnScD2eEilaGHp55dJv
vHTyNkYFbAbtJ1SI65egzmKCbim4N3TnXtnl9EQN4d526MRPPDlis9VBieLbsASJ
lQzBXnTowrgULnqRz2Ew93EghICZk6Tt3LIFIAbkVw1kdypu1/Y6T9cTCU+VY0Cx
SSAZturAD7KrLXNDAnebbpHANaKNqfsVCIzGYFyvW+oO+d/Jbu14Fjw2x4BkS9jW
4sfvZgdFpvOtF35ruVZ3YTA/7ds5U1t6YcYzqQCS1YWVLUDFJapkxoTb9MpQloMf
ubkEvBZcIkuDQy2cdTvmdqklhIK/lTxTLow4lH1NpegRWC+1uI0/TuyrpHs9c0iv
vTEN2BqsWGClLBzfjb89uXbEbs00RpD0dFCSTLKMUDxV0gZnLInBm+6HPJqO0Y6i
do4th1m6qR4W8iHs56ikMxkqD3lKQpEMYx6GIhU0bW4DG1b5jmMxUAV8fCX09AWH
FhxswCOElrsLdoGcvuTw6X5PmUqaHnljzQZywPunUJe8bTJl0p9y10i63OzdpI3K
LLH+iYQ6hxHtqnMNDXjPVMtKTWONQ0O7F7rQ0429k48+A3ZCHfM=
=F3b7
-----END PGP SIGNATURE-----

--Sig_/vMwjtwOcoop4do8gvwyuFJ6--

