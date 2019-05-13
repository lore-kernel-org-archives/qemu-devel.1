Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F31C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35DC20989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UypcDcY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35DC20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51785 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4Od-00075J-Tp
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:25:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ4Jl-0002xX-IB
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ4Jk-0004VZ-7n
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:09 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQ4Jj-0004Uh-Hr; Mon, 13 May 2019 02:20:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 452VzT0nvPz9sN1; Mon, 13 May 2019 16:20:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557728405;
	bh=6wS1lCZIQMuYZznUmvyFK4FnfOxqM5hHsR8n0isUCWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UypcDcY5WNnI4G/F4WK+S+0qJwoyOdfFZSTUKenv3Xsp09H/ztOR2QVy/2GRtmqFT
	YM0QAd9ak0KQh+akgzb9ebQPx2s4HfEQxq/T9ehU7KVNwipVxVu+C00BVnLVeLbZ7f
	JzXq1suvB0mQmoFyhhSknSNEwm4sFj08LDSbfga0=
Date: Mon, 13 May 2019 16:20:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190513062000.GD12044@umbus.fritz.box>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-4-david@gibson.dropbear.id.au>
	<0890a0ab-e176-5549-1ec9-98c00a9c8026@ozlabs.ru>
	<20190507044837.GC7073@umbus.fritz.box>
	<20190512141309-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <20190512141309-mutt-send-email-mst@kernel.org>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
	Greg Kurz <groug@kaod.org>, Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2019 at 02:13:30PM -0400, Michael S. Tsirkin wrote:
> On Tue, May 07, 2019 at 02:48:38PM +1000, David Gibson wrote:
> > On Fri, Apr 26, 2019 at 04:40:17PM +1000, Alexey Kardashevskiy wrote:
> > >=20
> > >=20
> > > On 24/04/2019 14:19, David Gibson wrote:
> > > > Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
> > > > pci_adjust_config_limit() has been used in the config space read an=
d write
> > > > paths to only permit access to extended config space on buses which=
 permit
> > > > it.  Specifically it prevents access on devices below a vanilla-PCI=
 bus via
> > > > some combination of bridges, even if both the host bridge and the d=
evice
> > > > itself are PCI-E.
> > > >=20
> > > > It accomplishes this with a somewhat complex call up the chain of b=
ridges
> > > > to see if any of them prohibit extended config space access.  This =
is
> > > > overly complex, since we can always know if the bus will support su=
ch
> > > > access at the point it is constructed.
> > > >=20
> > > > This patch simplifies the test by using a flag in the PCIBus instan=
ce
> > > > indicating whether extended configuration space is accessible.  It =
is
> > > > false for vanilla PCI buses.  For PCI-E buses, it is true for root
> > > > buses and equal to the parent bus's's capability otherwise.
> > > >=20
> > > > For the special case of sPAPR's paravirtualized PCI root bus, which
> > > > acts mostly like vanilla PCI, but does allow extended config space
> > > > access, we override the default value of the flag from the host bri=
dge
> > > > code.
> > > >=20
> > > > This should cause no behavioural change.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>cd
> > > > ---
> > > >  hw/pci/pci.c             | 41 ++++++++++++++++++++++--------------=
----
> > > >  hw/pci/pci_host.c        | 13 +++----------
> > > >  hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
> > > >  include/hw/pci/pci.h     |  1 -
> > > >  include/hw/pci/pci_bus.h |  9 ++++++++-
> > > >  5 files changed, 44 insertions(+), 54 deletions(-)
> > > >=20
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index ea5941fb22..59ee034331 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -120,6 +120,27 @@ static void pci_bus_realize(BusState *qbus, Er=
ror **errp)
> > > >      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
> > > >  }
> > > > =20
> > > > +static void pcie_bus_realize(BusState *qbus, Error **errp)
> > > > +{
> > > > +    PCIBus *bus =3D PCI_BUS(qbus);
> > > > +
> > > > +    pci_bus_realize(qbus, errp);
> > > > +
> > > > +    /*
> > > > +     * A PCI-E bus can support extended config space if it's the r=
oot
> > > > +     * bus, or if the bus/bridge above it does as well
> > > > +     */
> > > > +    if (pci_bus_is_root(bus)) {
> > > > +        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > > > +    } else {
> > > > +        PCIBus *parent_bus =3D pci_get_bus(bus->parent_dev);
> > >=20
> > >=20
> > > g_assert(bus->parent_dev) ?
> > >=20
> > > Slightly confusingly bus->parent_dev is not the same as bus->qbus.par=
ent
> > > and can be NULL, I'd even look into ditching parent_dev and using
> > > bus->qbus.parent instead (if possible).
> >=20
> > Oh boy, the can of worms I reached into following up that simple
> > comment.  Yes, they're subtly different, and yes it's confusing.  In
> > practice parent_dev is NULL when on a root bus, that's not a PXB bus,
> > and otherwise equal to qbus.parent.
> >=20
> > After a *lot* of thinking about this, I think parent_dev is actually
> > correct here - we're explicitly looking at the parent as a P2P bridge,
> > not anything else.
> >=20
> > But, I'll try to do some later cleanups making the parent_dev /
> > qbus.parent confusion a bit better.
> > > > +static inline bool pci_bus_allows_extended_config_space(PCIBus *bu=
s)
> > > > +{
> > > > +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> > > > +}
> > > > +
> > > > +
> > >=20
> > > An extra empty line.
> > >=20
> > > Anyway, these are minor comments, so
> > >=20
> > > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > >=20
> > >=20
> > >=20
> > >=20
> > > >  #endif /* QEMU_PCI_BUS_H */
> > > >=20
> > >=20
>=20
> Pls address comments and repost ok?

Done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzZDI4ACgkQbDjKyiDZ
s5JU1g/9GfBW+P79Hr9b6vDiT7Rc1j3VIEBGwk6D7HJRx5wzYDcIwWjqQqOi+phD
grX4JYdWpO3SxMhF7kntFn+JLZOQztJsK2nQTC2OjGPZPYFc9/Pw+05Rikj/LIFk
OzzCkzoL8cNrXdPOnPgooAZ59Cphg6w9ANtC21rudLyPYTpWMtW88hwJwVmhdWO4
zTqCMuCgp9sCR5OLLf0sh5XtMTZ6UrK9UHD7LgcjS6B0ikSpWDebVigfYBaVAsbi
HVLMAOG9lHCVZXMrID9egvpvba+I1774BcDTG8cJg5GYArsPS8uucityvU3h7gLi
XkaUJ+5QAGWg+9QSC9rTZ/zE+B7FLII9TcPDOtbpMGUAN2F0O/xPyX1t/LomCAE5
1UWyMd767CBe2bRmEwpTu5Supkd6FPVG9ujyhQiQDshxuW/jjgZ7+ouBrQMrEouU
sIE2CIW6iXXykIiDaP8MtsTITyMDkZW0dnnlZFnTKfLft9fXaPUhL3Eq455g5zsD
sn1v1lgjDwTS9RgxEMckQZdlC7lnNAzaHiv7SiIkHhNHATRXpM0SBR4zbR9w6y6z
WDh7xU4CnL3w1SO6LYwp80A5W1eqmnoYorQsXcsNHOv/IKeT5RHIuQPsMKJhP/Ou
k8TcMmUkX+toT5OUGuLB9WklXnP0udmSJJQQURaGIsD+SsHWVqk=
=4E07
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--

