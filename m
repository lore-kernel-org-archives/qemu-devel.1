Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7036EC10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 00:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FA821741
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 00:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B8CaB+5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FA821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51295 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE1MX-0000Hq-Bg
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 20:45:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hE1Lf-0008La-5b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hE1Ld-0001IN-OR
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:44:19 -0400
Received: from ozlabs.org ([203.11.71.1]:49785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hE1Lc-00019M-Vi; Tue, 09 Apr 2019 20:44:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44f55775Jcz9sTl; Wed, 10 Apr 2019 10:44:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554857051;
	bh=d957Fa7H38knudC/pkCD+mCxw6MZt0dlUnuWIDs4fBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8CaB+5dxLANfohMhW1R9reGIqg8WIMYPYXNyvOYkCrJL5TCAWAd8LquAWjlvmvNH
	vcNzAhjyJaLUV7pVjboUOECzW21Ka7Q0Wfc4BYg9AmEDH+FKUHj8jdHP7QHufBMfFm
	HycI20KxFd0Qe3NyV5w8RT4b0Mbf1IE8rxu5A2QI=
Date: Wed, 10 Apr 2019 10:40:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190410004016.GN16627@umbus.fritz.box>
References: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
	<155448184841.8446.13959787238854054119.stgit@bahia.lan>
	<20190408034054.GB16627@umbus.fritz.box>
	<20190408170137.4c3f19f7@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dZihrQ6eCIduWT38"
Content-Disposition: inline
In-Reply-To: <20190408170137.4c3f19f7@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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
Message-ID: <20190410004016.AlVtTWP8SxmP9uj1n0ygwxorzKM42PcaMFTC1lscHeM@z>


--dZihrQ6eCIduWT38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:01:37PM +0200, Greg Kurz wrote:
> On Mon, 8 Apr 2019 13:40:54 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Apr 05, 2019 at 06:30:48PM +0200, Greg Kurz wrote:
> > > LSI mapping in spapr currently open-codes standard PCI swizzling. It =
thus
> > > duplicates the code of pci_swizzle_map_irq_fn().
> > >=20
> > > Expose the swizzling formula so that it can be used with a slot number
> > > when building the device tree. Simply drop pci_spapr_map_irq() and ca=
ll
> > > pci_swizzle_map_irq_fn() instead.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Applied to ppc-for-4.1, thanks.
> >=20
>=20
> Thanks ! I just realize that I had come up with a better title, at least
> from my POV, but I forgot to update before posting...
>=20
> spapr: Drop duplicate PCI swizzle code

Sure, that is a better title and the 4.1 queue won't be sent off for a
bit, so I've updated that.

> No big deal if you keep the current title of course :)



>=20
>=20
> > > ---
> > >  hw/pci/pci.c         |    2 +-
> > >  hw/ppc/spapr_pci.c   |   24 ++++--------------------
> > >  include/hw/pci/pci.h |    4 ++++
> > >  3 files changed, 9 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 35451c1e9987..bb52bafd8d1c 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -1532,7 +1532,7 @@ void pci_device_set_intx_routing_notifier(PCIDe=
vice *dev,
> > >   */
> > >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
> > >  {
> > > -    return (pin + PCI_SLOT(pci_dev->devfn)) % PCI_NUM_PINS;
> > > +    return pci_swizzle(PCI_SLOT(pci_dev->devfn), pin);
> > >  }
> > > =20
> > >  /***********************************************************/
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index c70688a0dc23..26850d0b94f4 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -719,26 +719,10 @@ param_error_exit:
> > >      rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > >  }
> > > =20
> > > -static int pci_spapr_swizzle(int slot, int pin)
> > > -{
> > > -    return (slot + pin) % PCI_NUM_PINS;
> > > -}
> > > -
> > > -static int pci_spapr_map_irq(PCIDevice *pci_dev, int irq_num)
> > > -{
> > > -    /*
> > > -     * Here we need to convert pci_dev + irq_num to some unique value
> > > -     * which is less than number of IRQs on the specific bus (4).  We
> > > -     * use standard PCI swizzling, that is (slot number + pin number)
> > > -     * % 4.
> > > -     */
> > > -    return pci_spapr_swizzle(PCI_SLOT(pci_dev->devfn), irq_num);
> > > -}
> > > -
> > >  static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
> > >  {
> > >      /*
> > > -     * Here we use the number returned by pci_spapr_map_irq to find a
> > > +     * Here we use the number returned by pci_swizzle_map_irq_fn to =
find a
> > >       * corresponding qemu_irq.
> > >       */
> > >      SpaprPhbState *phb =3D opaque;
> > > @@ -1744,7 +1728,7 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> > >                                  &sphb->iowindow);
> > > =20
> > >      bus =3D pci_register_root_bus(dev, NULL,
> > > -                                pci_spapr_set_irq, pci_spapr_map_irq=
, sphb,
> > > +                                pci_spapr_set_irq, pci_swizzle_map_i=
rq_fn, sphb,
> > >                                  &sphb->memspace, &sphb->iospace,
> > >                                  PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_=
PCI_BUS);
> > >      phb->bus =3D bus;
> > > @@ -2236,14 +2220,14 @@ int spapr_populate_pci_dt(SpaprPhbState *phb,=
 uint32_t intc_phandle, void *fdt,
> > >      }
> > > =20
> > >      /* Build the interrupt-map, this must matches what is done
> > > -     * in pci_spapr_map_irq
> > > +     * in pci_swizzle_map_irq_fn
> > >       */
> > >      _FDT(fdt_setprop(fdt, bus_off, "interrupt-map-mask",
> > >                       &interrupt_map_mask, sizeof(interrupt_map_mask)=
));
> > >      for (i =3D 0; i < PCI_SLOT_MAX; i++) {
> > >          for (j =3D 0; j < PCI_NUM_PINS; j++) {
> > >              uint32_t *irqmap =3D interrupt_map[i*PCI_NUM_PINS + j];
> > > -            int lsi_num =3D pci_spapr_swizzle(i, j);
> > > +            int lsi_num =3D pci_swizzle(i, j);
> > > =20
> > >              irqmap[0] =3D cpu_to_be32(b_ddddd(i)|b_fff(0));
> > >              irqmap[1] =3D 0;
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index d87f5f93e9cd..033b2145d98c 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -411,6 +411,10 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn se=
t_irq, pci_map_irq_fn map_irq,
> > >  void pci_bus_irqs_cleanup(PCIBus *bus);
> > >  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
> > >  /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD =
*/
> > > +static inline int pci_swizzle(int slot, int pin)
> > > +{
> > > +    return (slot + pin) % PCI_NUM_PINS;
> > > +}
> > >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> > >  PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
> > >                                pci_set_irq_fn set_irq, pci_map_irq_fn=
 map_irq,
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dZihrQ6eCIduWT38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlytO20ACgkQbDjKyiDZ
s5LvYA//VdoQIYEN93xDa/KHCFeid6IYy1SrOMqcJvlTS/EqeUSV85nYl6zPGrE9
rV3kq3Yko7QN24OykGPS+azGYHFs7lpzh/jiF1zQDi5Sol3rRs3pL3TbGMUtdi5D
uRqVznFJZqj59Hyex5lCVnklY00DYPaiZWZkcwLkNlf8ZU7IrdlOwxOx9fLLhiKP
ulxP7oPZ8vH/GL0RygRdfdF5WCgo4PC3oNkYgUhDRJ6zR5Lp1LAkdXhvLCFXuNkh
6D++LYk7O6K2b0etGc/1XAuQSBtTK4p+yjn5nGJnC/1LVp0bJgjiKDOix6NbBR9o
wP3pQ94eu5RBN5vVzaReoCKktNessOuCcd5x5dxk+MlYwOG4MrEzFFRDPrETO6VY
/GNAtXgyhbIFpWvt+fZ/y8H0e/bYYzaSAkiDOpvoDRocAcSoO2LvwAWZqFTmId0K
nYXZlnhusWqX067p+wtuhfi2kERRLFP/MqpnLJIHQew+mhs8JQ9To06OvjmRs2KZ
kQKFac+hed+XAorbOpSJNit4Zy8hM/t+GdXQSJlz7b05l4vqQCbt6jFTvT9H3M0E
OXfG0U3OoPcmVSjYzdnhQryaZrE3iGIb9+6L+ujI2ESkdHwTTw7tmRbOJUWey4UY
CpSQ4Spr0w9sON2mhqTMm2eJrLjvO4U2uOpDyFrvQp/luvuLjCA=
=wpaN
-----END PGP SIGNATURE-----

--dZihrQ6eCIduWT38--

