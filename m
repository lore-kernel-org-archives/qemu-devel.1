Received: from eggs.gnu.org ([2001:4830:134:3::10]:43266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV5cf-0004Nf-Rt
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV5cZ-0002OR-5L
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:12:09 -0500
Date: Fri, 7 Dec 2018 13:05:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207020527.GX768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-7-clg@kaod.org>
	<20181206040914.GO768@umbus.fritz.box>
	<16ae54d9-2bad-ea77-30be-fff2cf3dea89@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FhxWStFQ84VXWhXs"
Content-Disposition: inline
In-Reply-To: <16ae54d9-2bad-ea77-30be-fff2cf3dea89@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 06/37] ppc/xive: add support for the END
 Event State buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--FhxWStFQ84VXWhXs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 07:30:34AM +0100, C=E9dric Le Goater wrote:
> On 12/6/18 5:09 AM, David Gibson wrote:
> > On Thu, Dec 06, 2018 at 12:22:20AM +0100, C=E9dric Le Goater wrote:
[snip]
> >> +/*
> >> + * END ESB MMIO loads
> >> + */
> >> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, unsig=
ned size)
> >> +{
> >> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
> >> +    XiveRouter *xrtr =3D xsrc->xrtr;
> >> +    uint32_t offset =3D addr & 0xFFF;
> >> +    uint8_t end_blk;
> >> +    uint32_t end_idx;
> >> +    XiveEND end;
> >> +    uint32_t end_esmask;
> >> +    uint8_t pq;
> >> +    uint64_t ret =3D -1;
> >> +
> >> +    end_blk =3D xrtr->chip_id;
> >=20
> > .. instead I think it makes more sense to just configure the end_blk
> > directly on the end_source, rather than reaching into another object
> > to=20
>=20
> Ah. That's what I was asking in an email. I missed the answer maybe.
> Let's drop it and sPAPRXive block will be 0.

Actually, I think I might not have answered earlier, because it was
far enough into the thread that I'd forgotten the original context too
much to answer easily.

Anyway, proposed course of action sounds fine.

[snip]
> >> +static void xive_source_end_reset(void *dev)
> >> +{
> >> +    /* TODO: Loop on all ENDs and mask off the ESn and ESe */
> >=20
> > IIUC you're talking about actually writing the (potentially in memory)
> > END structures.  I don't think that makes sense for the END source
> > hardware model.  I'm guessing you want this for PAPR, where the ENDs
> > are in virtual hardware=20
>=20
> That's done already.
>=20
> > rather than guest memory, but in that case I
> > think the reset handling should be in the PAPR specific Xive object,
> > not the end_source itself.
>=20
> I will remove the TODO, it's obsolete.

Ok, and the whole function with it, yes?  Or is there something else
that will really belong here?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FhxWStFQ84VXWhXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ1WcACgkQbDjKyiDZ
s5KPpRAAvNDhn9Bsuh2mGrovm9evcd/4QFgP0M1LJb/6YVACZPghdExeSDNMINKa
C7PX0WiFxALMz2dXWmifld944DcSVz01bFqmBp8KZg6utjhKKCSWxonrww476Sqn
CUyOsk2cX6I4IBrfhSiGIfjkd30cMk0KLg+TOUxUh1r0PTSMCSjsHMa+GI7YyCGE
lNf1cMWwWGzgSuBwwc/tDk4TYRgp8Y/wLkurZggSwK7Jf/ZF1m3XF8GJOhczZURf
SMl7IWDb2GEqocdmbITAfaLmd+C8awzbQ98yC/yGdIt60xPMtfHzFuXpWHuUXfV4
vgSaUOg119fgZjjMK35Urz0txyqt1JXtQcwrjJXjvH9yABbSydvHbunyHYeUTiGe
xEReVSUvjD8m+4m6wxnzO0LcgTBOoVweM9PMJbLu4OWqB6NnZCHHuV5RlkzXc1HT
r9MorofkApcHClN9dQzGkEiGmVMDTdYrE3kdp3+9/YDRyyX2TAPKHq1PFoCh9qXb
KrVLDCZPsIvwpONMw5JExdU4YcVTrA5CleVMaaUD4iQ/nnkY9reczNjZ3toNgPTA
81mBn+O18Zt0MHLOVncPb9ApWgSSCuakygE/q4t+lEougCW3I8IV8YcTgPxgPcga
nCzZLoCcPfMu62S+K1Kq9b0kG/guggJ7cVnwNoynoCBrk4yIgxc=
=qasN
-----END PGP SIGNATURE-----

--FhxWStFQ84VXWhXs--
