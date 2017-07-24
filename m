Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZX1P-0003Au-R6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZX1O-00089J-PK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:39:15 -0400
Date: Mon, 24 Jul 2017 16:39:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724063905.GN17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-10-git-send-email-clg@kaod.org>
	<20170724044948.GF17228@umbus.fritz.box>
	<1500876571.10674.58.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aIbcA3MSwnGacr4f"
Content-Disposition: inline
In-Reply-To: <1500876571.10674.58.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 09/26] ppc/xive: add an overall memory
 region for the ESBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--aIbcA3MSwnGacr4f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 04:09:31PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-24 at 14:49 +1000, David Gibson wrote:
> > On Wed, Jul 05, 2017 at 07:13:22PM +0200, C=E9dric Le Goater wrote:
> > > Each source adds its own ESB mempry region to the overall ESB memory
> > > region of the controller. It will be mapped in the CPU address space
> > > when XIVE is activated.
> > >=20
> > > The default mapping address for the ESB memory region is the same one
> > > used on baremetal.
> > >=20
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> > >  hw/intc/xive-internal.h |  5 +++++
> > >  hw/intc/xive.c          | 44 +++++++++++++++++++++++++++++++++++++++=
++++-
> > >  2 files changed, 48 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> > > index 8e755aa88a14..c06be823aad0 100644
> > > --- a/hw/intc/xive-internal.h
> > > +++ b/hw/intc/xive-internal.h
> > > @@ -98,6 +98,7 @@ struct XIVE {
> > >      SysBusDevice parent;
> > > =20
> > >      /* Properties */
> > > +    uint32_t     chip_id;
> >=20
> > So there is a XIVE object per chip.  How does this work on PAPR?  One
> > logical chip/XIVE, or something more complex?
>=20
> One global XIVE for PAPR. For the MMIOs, the way it works is that:
>=20
>  - For MMIOs pertaining to a specific interrupt or queue, there's an H-
> call that will return the proper "guest physical" address. For qemu
> with KVM we'll have to probably create a single chunk of qemu address
> space (a single mem region) that contains individual pages mapped with
> MAP_FIXED originating from the different HW bits, we still need to sort
> out how exactly we'll do that in practice.
>=20
>  - For the TIMA (the presentation MMIOs), those are always at the same
> physical address for everybody (so for a guest it's a single memory
> region we'll map to that physical address), the HW "knows" which HW
> thread is talking to it (and the hypervisor tells the HW which vcpu is
> running on a given HW thread at a given point in time). That address is
> obtained from the device-tree

Ok.  That leaves "chip_id" as a rather surprising thing to see in an
object which will appear on PAPR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aIbcA3MSwnGacr4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1lgkACgkQbDjKyiDZ
s5LxIxAA0X/gcJVTMBeqcXuux5gZ2spfz4gLNGcTwE6Fv4ONoRSCNY1XVmIyYgSX
GMOrMIPOmbG3OIIwwR13zGnWfCThurDYt9QsuMofsspgpbaD/rUkCttomp6qrHHg
dD1+kk5fADSui0Wzwn/zC0XoqRvxA3cmsh76wKpxo8A8RNycvI/O+1pwuEbwuijb
xsRkY2lMX2Bzmme57K5VZPpraDjMuKgq+8wufMpX3qEKacAknA3jGpF0GKA6SASE
kJjHwGJxwiPoHYQz+KSe8uKxomxlpQ/lGawxdMUg0eBAyQGjAvA3HZT38WPR1fkY
LdojeIO3vGoULVJ5pDiY+oGBKsrPw20UKMmtAjw0YPSX6l01fm7tipjdS7qnm578
COOZBpS/PxhW2NlBZw30s/RPOb30yjBGsobY7II50864w28MD1NFvGtezhWCjI5c
rmhMxYtWPAp5sxdeZ5UAZPAZv7lhEkSiCqK60FfFtJWTR7qXcMSBPR7/Og/9fGg+
cwfM1Bif2nZE5vUtkARlnVruzpPrcSi/ioSIMjgQLB541s8+gs8nxvBdkTZHQaIP
Yxe6pwtblvIjt91cGIg9L2RqpBTg9MIqjWHsZc7vo8heC/Gv8VOtykO9R44lhzR6
ji7FmREOWyiS3HirHMAZCAVcrNa2jEIX3HcyuUPf2mVNDfnI5c4=
=y+kr
-----END PGP SIGNATURE-----

--aIbcA3MSwnGacr4f--
