Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAF020825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IotDzS9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAF020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsNo-0006yx-HW
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:11:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNsMx-00063M-0z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNsMv-0007T9-G4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:10:23 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNsMu-0007P0-92; Tue, 07 May 2019 01:10:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44ynjb1LFcz9s00; Tue,  7 May 2019 15:10:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557205811;
	bh=8nlE++t1GSIcZ3W2doFUFWvcLhlAsg5jr3G7tNMmfBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IotDzS9KZ2ecUSm69akkuIOxjl48L8BoKMCHeFz95c3A7pg/s6eXD/8PyXzHQASej
	uV4o7slvUb+QnL2QH+OiY0H/VvL/GW91DtWVeOnOyrr6lIk04G00s5/7hIabYkSEz2
	xXxWmFSzkmijXgH9scuKyXw4HzB3hSYz5kkZqWF4=
Date: Tue, 7 May 2019 14:48:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190507044837.GC7073@umbus.fritz.box>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-4-david@gibson.dropbear.id.au>
	<0890a0ab-e176-5549-1ec9-98c00a9c8026@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <0890a0ab-e176-5549-1ec9-98c00a9c8026@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/3] pcie: Simplify
 pci_adjust_config_limit()
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
	qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 04:40:17PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 24/04/2019 14:19, David Gibson wrote:
> > Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
> > pci_adjust_config_limit() has been used in the config space read and wr=
ite
> > paths to only permit access to extended config space on buses which per=
mit
> > it.  Specifically it prevents access on devices below a vanilla-PCI bus=
 via
> > some combination of bridges, even if both the host bridge and the device
> > itself are PCI-E.
> >=20
> > It accomplishes this with a somewhat complex call up the chain of bridg=
es
> > to see if any of them prohibit extended config space access.  This is
> > overly complex, since we can always know if the bus will support such
> > access at the point it is constructed.
> >=20
> > This patch simplifies the test by using a flag in the PCIBus instance
> > indicating whether extended configuration space is accessible.  It is
> > false for vanilla PCI buses.  For PCI-E buses, it is true for root
> > buses and equal to the parent bus's's capability otherwise.
> >=20
> > For the special case of sPAPR's paravirtualized PCI root bus, which
> > acts mostly like vanilla PCI, but does allow extended config space
> > access, we override the default value of the flag from the host bridge
> > code.
> >=20
> > This should cause no behavioural change.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>cd
> > ---
> >  hw/pci/pci.c             | 41 ++++++++++++++++++++++------------------
> >  hw/pci/pci_host.c        | 13 +++----------
> >  hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
> >  include/hw/pci/pci.h     |  1 -
> >  include/hw/pci/pci_bus.h |  9 ++++++++-
> >  5 files changed, 44 insertions(+), 54 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index ea5941fb22..59ee034331 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -120,6 +120,27 @@ static void pci_bus_realize(BusState *qbus, Error =
**errp)
> >      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
> >  }
> > =20
> > +static void pcie_bus_realize(BusState *qbus, Error **errp)
> > +{
> > +    PCIBus *bus =3D PCI_BUS(qbus);
> > +
> > +    pci_bus_realize(qbus, errp);
> > +
> > +    /*
> > +     * A PCI-E bus can support extended config space if it's the root
> > +     * bus, or if the bus/bridge above it does as well
> > +     */
> > +    if (pci_bus_is_root(bus)) {
> > +        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > +    } else {
> > +        PCIBus *parent_bus =3D pci_get_bus(bus->parent_dev);
>=20
>=20
> g_assert(bus->parent_dev) ?
>=20
> Slightly confusingly bus->parent_dev is not the same as bus->qbus.parent
> and can be NULL, I'd even look into ditching parent_dev and using
> bus->qbus.parent instead (if possible).

Oh boy, the can of worms I reached into following up that simple
comment.  Yes, they're subtly different, and yes it's confusing.  In
practice parent_dev is NULL when on a root bus, that's not a PXB bus,
and otherwise equal to qbus.parent.

After a *lot* of thinking about this, I think parent_dev is actually
correct here - we're explicitly looking at the parent as a P2P bridge,
not anything else.

But, I'll try to do some later cleanups making the parent_dev /
qbus.parent confusion a bit better.
> > +static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
> > +{
> > +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> > +}
> > +
> > +
>=20
> An extra empty line.
>=20
> Anyway, these are minor comments, so
>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
>=20
>=20
>=20
> >  #endif /* QEMU_PCI_BUS_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRDiEACgkQbDjKyiDZ
s5LtChAA2OPycNXTe7lkgKZsiD8v+Vl4CV6O5Fn4K0C8hpgEvFChWZwYPpXyk3jr
ljj7PvddNTdOi1a1iQz3mvbveC992rYjLeHMags9U74CHyMbx1s7pv54OMRRiHaC
BkkUCohub2fj/DQhpXdZSy2lbS3fcnINeUmQlA3Ze+XhOtZwOTKv8PkrjeZlKbFu
hOTFXuy0ULGHyGwT9pinWYc0aXRoPGKVd/iWX+ji/y5GlilSS53UGh6ezn/QV4o+
5XWR2e2Yb+7rM28Lg8IXC7ry/aOvxo+MJQ7jyqUft1MWZPFk2czc/aRZ7amcwYOl
HxgZ3KomtWF0LuvvdA2ycB9YdMqTNt/ufvt1LcDtnAM7s69QyY2TUPWP+3SxOl6N
S6Fio26H7jGhN7nOrTc+A2icJqR36zy0E6weguzhi4v9wGFFLqo4ushBeVtZ25z1
v+qGN/bK2aPdmozXQaGiOJSbRwGJ5Pw6igL2hPbYhISsGBTBggnYpIBPl7q95oYs
jRFi1p5CRCgK434qe3x+QQF7kwWHsRpWfG20hUgeu5Sf77J6AAEAYCw/97M0hgOj
vE4QudjypQ+m5qEacJ0eQSdxGL49HXOKAG2235YRmQ/U+AkWWG/koDj+J2cVJWJr
kQBn7obAbcEwwCwHsy88ZDdQzxVbyPEfLvBrnjvbzD8VuvHrEOs=
=tsX6
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

