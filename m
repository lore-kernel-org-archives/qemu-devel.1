Received: from eggs.gnu.org ([2001:4830:134:3::10]:44233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEEE-0006il-Bg
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEED-0002RB-B4
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:47:06 -0500
Date: Thu, 29 Nov 2018 15:46:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129044654.GK14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-6-clg@kaod.org>
	<20181122044127.GE10448@umbus.fritz.box>
	<3095c0b4-ebcd-907b-360d-d5e7cdfd3b7d@kaod.org>
	<20181123043508.GY10448@umbus.fritz.box>
	<7f687a1f-0783-ba21-dfb6-7963c0a0480c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline
In-Reply-To: <7f687a1f-0783-ba21-dfb6-7963c0a0480c@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:01:27PM +0100, C=E9dric Le Goater wrote:
> On 11/23/18 5:35 AM, David Gibson wrote:
> > On Thu, Nov 22, 2018 at 10:47:44PM +0100, C=E9dric Le Goater wrote:
> >> On 11/22/18 5:41 AM, David Gibson wrote:
> >>> On Fri, Nov 16, 2018 at 11:56:58AM +0100, C=E9dric Le Goater
> wrote:
[snip]
> >>>> +/*
> >>>> + * XiveEND helpers
> >>>> + */
> >>>> +
> >>>> +void xive_end_reset(XiveEND *end)
> >>>> +{
> >>>> +    memset(end, 0, sizeof(*end));
> >>>> +
> >>>> +    /* switch off the escalation and notification ESBs */
> >>>> +    end->w1 =3D END_W1_ESe_Q | END_W1_ESn_Q;
> >>>
> >>> It's not obvious to me what circumstances this would be called under.
> >>> Since the ENDs are in system memory, a memset() seems like an odd
> >>> thing for (virtual) hardware to be doing to it.
> >>
> >> It makes sense on sPAPR if one day some OS starts using the END ESBs f=
or=20
> >> further coalescing of the events. None does for now but I have added t=
he=20
> >> model though.
> >=20
> > Hrm, I think that belongs in PAPR specific code.  It's not really part
> > of the router model - it's the PAPR stuff configuring the router at
> > reset time (much as firmware would configure it at reset time for bare
> > metal).
>=20
> This is true this routine is only used by the H_INT_RESET hcall and by=20
> the reset handler of the sPAPR controller model. But it made sense to put=
=20
> this END helper routine with the other END routines. Don't you think so ?=
=20

Actually, no.  In real hardware this would be handled by a different
component - the system firmware would do this setup of the ENDs as it
configures the XIVE.  So it makes sense to do this in a separate
component for PAPR as well.  In this case that's another piece of qemu
(the spapr stuff) rather than being within the VM, but the difference
isn't important to the END handling itself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/bzsACgkQbDjKyiDZ
s5LShg/8D1+vxKxi4mivrkjBaXzZ28gY6FDPu7j3LcU7prlcod+Y+Tw8pK9WqOt9
diDGKbo2DDoAGtfxM1erd6v5ZAZqAYJsuKGBbbIIi32CeqWW99JBXsBl/B7sqSOw
HtuXNMnk8NwuNl/qLG3qr1Qr2kfI+/i5fwPG+PSakNibZLuCyu+1Zw9j9FbtBt/H
Y0/RZF3SdJLRBc7x2wPy4jLUngTkbI3FhbrToQaV4C7zPGv0thuqBI2gJ0tt8PSj
4THQ6Ne51qXw6q7fHAGr7ceqQiJdp34JLnDpbXM129OYrjQvuGnSpSSr/GKYsmaS
Rou2fksDwdrkxi71L7+vPBs+2ix0D8iwDYaJpJE6tUtQPuIoNYD8LkDTnSirExEC
yMPJFJgHnsuurbw39PHtb8MKkONqfctV+vbsYyg7iBk8q0GNLgOhx753l472V003
aBsLLhz2f8i0jcd9cM1CvvakPS9fP+KH2otwI+uynypXzND8MjYDRwYR+AwEMkIx
LFokAqUIGsFysdUgqzAS+M/x9Nq8ukziTqsJs6AQRZeCZNeh2awQlgUuvYPBPzgh
oCnVKjgTxaDWJwaDjF1Tt3XJzf3gAk5y/ECmgILs00XRTN0buTNX2T5xUHCpHrnz
04Eifa4YcJCZt+jpozv1gxnfkzq4Pbyj4w4vOuweQH4ZhqkdTSw=
=74R9
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
