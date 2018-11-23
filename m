Received: from eggs.gnu.org ([2001:4830:134:3::10]:52415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4rX-0003BN-L1
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4rW-0002l7-Gg
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:47 -0500
Date: Fri, 23 Nov 2018 14:51:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123035112.GX10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-6-clg@kaod.org>
	<20181122044127.GE10448@umbus.fritz.box>
	<8e8f737a04e48673e40d3701a20346ac557a7ed7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PjLo8P/CG6vpADRe"
Content-Disposition: inline
In-Reply-To: <8e8f737a04e48673e40d3701a20346ac557a7ed7.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v5 05/36] ppc/xive: introduce the XIVE
 Event Notification Descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--PjLo8P/CG6vpADRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 05:49:09PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2018-11-22 at 15:41 +1100, David Gibson wrote:
> >=20
> > > +void xive_end_reset(XiveEND *end)
> > > +{
> > > +    memset(end, 0, sizeof(*end));
> > > +
> > > +    /* switch off the escalation and notification ESBs */
> > > +    end->w1 =3D END_W1_ESe_Q | END_W1_ESn_Q;
> >=20
> > It's not obvious to me what circumstances this would be called under.
> > Since the ENDs are in system memory, a memset() seems like an odd
> > thing for (virtual) hardware to be doing to it.
> >=20
> > > +}
>=20
> Not on PAPR ...

Right, so the memset() can go in PAPR specific code.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PjLo8P/CG6vpADRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3eTAACgkQbDjKyiDZ
s5Ln9RAA24gvve8UggV/zJg2lZnWiFOlYpncvvFLnU56Mp+4IhWplkQXWuYTN0Z5
2oR/1PiyFaNSWxow08q//T8WEOAaA1NlD0IngwoKf5MzcPawzqUmNRwca6la/1U2
vOosbyI+fr9kPn3IzJO6AfKwcGZvqlpD9Y3vyZ2sA97zGzbuKqfSszYbpLxvLpIL
b21qZ2gpOkeHpLKSgEOk3EAqrIXkNn7GBlBxKI8TF8bj2tzX7WGNk8BxVCXDtgvV
8c8PscCXuzI7b2Iq2mEOUDwm9SRbu3lWZzxysjMJQNw9EuXU4x4v09MMmKfJEZ2z
zK3VUXJ6XAQawSVmylmTfsPjsQBdg7HcoYnvZktX4OxTz3fUDDyCW7ekh2DrDO1e
cuEbsggI5Rybz3R0jIoRfYQASqZsVQR+lLHCloLACrFeXKbl5o7C39fr2M31Pcu1
FtmJnZ5NZ/lRsQmBzzh6cWh7GuI7LV3TG78T6aRizNi38GDxhm5xkaqUPbjku0Xv
Rlctpi7bNqQ6L2b3Z1opDoFQpRCCYftZy/FP3kh9D8QOJAchAJgA3mHvzB0Ie5mL
bl9H/qx2CtYVMfeMIU6zCC7sq9fOV02wU43kFG2flsDcUR0xwac/+N0DFGQxNnzq
YJ51lkgeZcLE4IsW7Yu6R3eQ16QOJi8pbA1DpM5XE2kbYUurImg=
=jDm3
-----END PGP SIGNATURE-----

--PjLo8P/CG6vpADRe--
