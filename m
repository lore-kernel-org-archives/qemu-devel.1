Received: from eggs.gnu.org ([2001:4830:134:3::10]:51012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fY4so-0006Pu-0l
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fY4sm-000163-UT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:28:54 -0400
Date: Wed, 27 Jun 2018 17:28:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180627072825.GH14434@umbus.fritz.box>
References: <20180626135928.23950-1-clg@kaod.org>
	<20180627033321-mutt-send-email-mst@kernel.org>
	<1d70c0f9179990cd33d7c82c5190179e60ae4ce3.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <1d70c0f9179990cd33d7c82c5190179e60ae4ce3.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 11:38:17AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-06-27 at 03:35 +0300, Michael S. Tsirkin wrote:
> >=20
> > > +
> > > +/* Extract field fname from val */
> > > +#define GETFIELD(fname, val)                    \
> > > +        (((val) & fname##_MASK) >> fname##_LSH)
> > > +
> > > +/* Set field fname of oval to fval
> > > + * NOTE: oval isn't modified, the combined result is returned
> > > + */
> > > +#define SETFIELD(fname, oval, fval)                     \
> > > +        (((oval) & ~fname##_MASK) | \
> > > +         ((((typeof(oval))(fval)) << fname##_LSH) & fname##_MASK))
> > > +
> >=20
> > Pls don't make up macros like these. We can't have each device do it.
>=20
> So what ? We move the macros in a generic place ? These are MUCH better
> than open-coding the masks & shifts and much less error prone.

There are already deposit32 and deposit64() functions which I think
would cover this.

>=20
> > > @@ -1031,6 +1110,7 @@ static Property pnv_chip_properties[] =3D {
> > >      DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
> > >      DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
> > >      DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
> > > +    DEFINE_PROP_UINT32("num-phbs", PnvChip, num_phbs, 1),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> >=20
> > How about instanciating each extra phb using -device?
> > Seems better than teaching everyone about platform-specific
> > options.
>=20
> It's about which PHBs are enabled, not which are instanciated, if I
> understand Cedric changes ...
>=20
> This aims are implementing the POWER8 chip correctly, it has a fixed
> number of PHBs per-chip at very specific XSCOM addresses, that the
> firwmare knows about.

Yeah, this is a recurring design conflict, which I'm not sure how to
address.  Usually instantiating things with -device works better, but
when do we do when that allows more flexibility with hardware
arrangement than is actually possible in the hardware.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlszPJcACgkQbDjKyiDZ
s5I2nA/6A1Hw6r+HK+gr09TdBdRoRv52pu8AL+A/tg/yc5e+vMWLdTk6fUSqDes0
lKqpwNZb5uYz7nGf5QlGT8FF2P5YaHZSiIm0r38a4NonoCnVddUyCHrn3SNQ/AN9
RRhcA0t36OrRWgffXty6Nep+hBN9hwZfBe9JXHQs7tlyKWnRdl6cvizYovphsLxB
MCa2ce8/XG9OU1NAx0DtB5mbo1H2BM4tSQMVTCMzQKEaEUpwg17ssmxx9HCaAtrF
tj4PaTQ1KwiH2nDrtAHF15W+6AAg+8xDssMwfrlwuXoIwU9dDjqQG7AbVDhtEyFe
7aVao/6TyQtWg3D+yUlKYsL6K8iGTFK/Tfh4LgNb/vrR3lDinR+I93JLDvlvrqnN
XEMQdDbP0hQDa+zJHYlhUx4xaHRmBGlYjFWjHesQTdxLLKCykCKg+n9b2oVVXaoe
Lz5dB4i/3aTus0aSDqlbCxZD3jSloTespyc0UscQ+spuqr80QhXFI0zwAtSIlMdp
Js5mRs19t4CGXbGFRfjvcgynGcMFU0eXIOnbiHMb+N2n5Eig/mCYyzDfMpUlC6xf
7PGEmUTVdpCxD2u08kZhfvwTf8SBHQtJqPlwmE7F4aFSFacQN/UlZksvGYScz2ag
7rSWC24wfLpoRBa201NcFTiQpzdp2+3dIAchdkQGVGQcD39x4Aw=
=KdbC
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
