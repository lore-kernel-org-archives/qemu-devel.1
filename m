Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F0C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 02:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBBA20C01
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 02:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T0aJ06I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBBA20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOCO1-0007PN-ON
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 22:32:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOCMF-0006Tz-FL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 22:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOCMC-0007oP-Hf
	for qemu-devel@nongnu.org; Tue, 07 May 2019 22:30:59 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOCMA-0007Po-Sm; Tue, 07 May 2019 22:30:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44zL772dQjz9s55; Wed,  8 May 2019 12:30:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557282643;
	bh=yaHqmMI/W3Z0g5NSr9U3aaZH/oGMTRuAT0V3SYdJS8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0aJ06I7iU3IQHU0yF6NQHMafyk7aFb8i7sIi+XM3976uZE3b9l8kJQPGJeZq38VR
	YjgO/4awUxrxKbsQOac6F/xaplLes+L6SATH5Y4htBt/aVqHY417rQ/LSKvzXAYSdT
	YwOFlHwiqs3w9UkesWeDSfPAaoUyjcB11Km2H6Kk=
Date: Wed, 8 May 2019 12:11:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190508021101.GO7073@umbus.fritz.box>
References: <20190507062316.20916-1-david@gibson.dropbear.id.au>
	<20190507062316.20916-6-david@gibson.dropbear.id.au>
	<20190507122129.1667a456@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline
In-Reply-To: <20190507122129.1667a456@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 5/5] pci: Fold
 pci_get_bus_devfn() into its sole caller
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 12:21:29PM +0200, Greg Kurz wrote:
> On Tue,  7 May 2019 16:23:16 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > The only remaining caller of pci_get_bus_devfn() is pci_nic_init_nofail=
(),
> > itself an old compatibility function.  Fold the two together to avoid
> > re-using the stale interface.
> >=20
> > While we're there replace the explicit fprintf()s with error_report().
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci/pci.c | 61 +++++++++++++++++++++++++---------------------------
> >  1 file changed, 29 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 7e5f8d001b..90e2743185 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -723,37 +723,6 @@ static int pci_parse_devaddr(const char *addr, int=
 *domp, int *busp,
> >      return 0;
> >  }
> > =20
> > -static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
> > -                                 const char *devaddr)
> > -{
> > -    int dom, bus;
> > -    unsigned slot;
> > -
> > -    if (!root) {
> > -        fprintf(stderr, "No primary PCI bus\n");
> > -        return NULL;
> > -    }
> > -
> > -    assert(!root->parent_dev);
> > -
> > -    if (!devaddr) {
> > -        *devfnp =3D -1;
> > -        return pci_find_bus_nr(root, 0);
> > -    }
> > -
> > -    if (pci_parse_devaddr(devaddr, &dom, &bus, &slot, NULL) < 0) {
> > -        return NULL;
> > -    }
> > -
> > -    if (dom !=3D 0) {
> > -        fprintf(stderr, "No support for non-zero PCI domains\n");
> > -        return NULL;
> > -    }
> > -
> > -    *devfnp =3D PCI_DEVFN(slot, 0);
> > -    return pci_find_bus_nr(root, bus);
> > -}
> > -
> >  static void pci_init_cmask(PCIDevice *dev)
> >  {
> >      pci_set_word(dev->cmask + PCI_VENDOR_ID, 0xffff);
> > @@ -1895,6 +1864,8 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBu=
s *rootbus,
> >      DeviceState *dev;
> >      int devfn;
> >      int i;
> > +    int dom, busnr;
> > +    unsigned slot;
> > =20
> >      if (nd->model && !strcmp(nd->model, "virtio")) {
> >          g_free(nd->model);
> > @@ -1928,7 +1899,33 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIB=
us *rootbus,
> >          exit(1);
> >      }
> > =20
> > -    bus =3D pci_get_bus_devfn(&devfn, rootbus, devaddr);
> > +    if (!rootbus) {
> > +        error_report("No primary PCI bus");
> > +        exit(1);
> > +    }
> > +
> > +    assert(!rootbus->parent_dev);
> > +
> > +    if (!devaddr) {
> > +        devfn =3D -1;
> > +        busnr =3D 0;
> > +        bus =3D pci_find_bus_nr(rootbus, 0);
>=20
> This line isn't needed since it is done below...

Oops, missed that when I factored the find_bus_nr out of the if.
Fixed now.

> > +    } else {
> > +        if (pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0)=
 {
> > +            error_report("Invalid PCI device address %s for device %s",
> > +                         devaddr, nd->model);
> > +            exit(1);
> > +        }
> > +
> > +        if (dom !=3D 0) {
> > +            error_report("No support for non-zero PCI domains");
> > +            exit(1);
> > +        }
> > +
> > +        devfn =3D PCI_DEVFN(slot, 0);
> > +    }
> > +
> > +    bus =3D pci_find_bus_nr(rootbus, busnr);
>=20
> ... here.
>=20
> >      if (!bus) {
> >          error_report("Invalid PCI device address %s for device %s",
> >                       devaddr, nd->model);
>=20
> Maybe output a different message from the one for pci_parse_devaddr()
> failures ? Here, the address is supposed to be well formatted but we
> couldn't find the requested bus.

I thought about that, but couldn't think of a could way of expressing
it.  Since this is only for a legacy option and it was already
ambiguous, I'm not overly concerned by it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzSOrMACgkQbDjKyiDZ
s5KVMBAAxgg+gZuRRy+0E3C4ckMmPsVu+pREBZjelmRVUVkmdpEIYA45lwuP6ZGn
ifKyeoRXuCNdIhagCcN6aH7jZ7sOtiD+4wJAz4j8yQUwd3KY0lfv659L2AixxoQJ
K/8kUuDiuqh3VRmZr10MNn6abD9r0OEsgQ2Gz7tKWWl0aubEi52LWpXkyll3QfIt
7JQLuXlP0pBHpRedOJilFxfoE0PtO1qwBMPXuUSrVBZc6H/obZO7oAsaUcNUE0a5
C9W4z53w8BSkymOFw4f2C3SfDMZoUKlIoEIg+/IkoojzNjn+liZ/kYyWu9Mwmbf3
K60vXD3QBu5RdqP94ftiQtnA+Uo7wufNxTTmyx2vheo5ROhTAADcRHfZGE4pwMe1
0iqwuu7RCyqnHTLyPHOqVb658xPuVGZ95jLHyvKKockq/C1AnEjy1Ud+lzDaYkpN
aTfhI0vbbjvuZbglTtFrJlNj2bOD0wICpmM1xBdAVtZ1f5I4pxvytooMszXq4mjT
Ltw0u9h+C8Mk2HaKqetGGOtvxAUvF4XPY/je9PyB3VngGhIiO8yHEtPisc+sqOFX
EwpKhpXLsTlPUv0Hq6OFe8EB9GQic3K9GP2cX0ojE6M5POFASAx0fhoUPrAohzv3
D7lwJvMg7EEArbLLZ11+NlT4UjFDQLXcPvjM3/KrlqATa3+xRXY=
=BNdO
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--

