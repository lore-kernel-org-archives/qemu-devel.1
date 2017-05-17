Received: from eggs.gnu.org ([2001:4830:134:3::10]:34432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQI-0003Vl-6l
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQF-0002t9-1X
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:54 -0400
Date: Wed, 17 May 2017 14:17:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517041723.GF15596@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
	<adcf8e71-65c0-2952-6d01-cdaddb81d0f9@kaod.org>
	<20170515182006.5748aaa2@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20170515182006.5748aaa2@bahia>
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 06:20:06PM +0200, Greg Kurz wrote:
> On Mon, 15 May 2017 18:09:04 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 05/15/2017 03:16 PM, Greg Kurz wrote:
> > > On Mon, 15 May 2017 14:22:32 +0200
> > > C=E9dric Le Goater <clg@kaod.org> wrote:
> > >  =20
> > >> On 05/15/2017 01:40 PM, Greg Kurz wrote: =20
> > >>> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> > >>> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> > >>> is an improvement since we no longer allocate ICP objects that will
> > >>> never be used. But it has the side-effect of breaking migration of
> > >>> older machine types from older QEMU versions.
> > >>>
> > >>> This patch introduces a compat flag in the sPAPR machine class so
> > >>> that all pseries machine up to 2.9 go on with the previous behavior
> > >>> of pre-allocating ICP objects.   =20
> > >>
> > >> I think this is a quite elegant way to a handle the migration=20
> > >> regression. Thanks for taking care of it.
> > >>
> > >> Have you tried to simply reparent the ICPs objects to OBJECT(spapr)=
=20
> > >> instead of the OBJECT(cpu)  ?=20
> > >> =20
> > >=20
> > > Do you mean to reparent unconditionally to OBJECT(spapr) for all
> > > machine versions ?  =20
> >=20
> > only in the case of smc->must_pre_allocate_icps
> >=20
> > > I'm not sure this would be beneficial, but I might be missing=20
> > > something... =20
> >=20
> > I think that we would not need to allocate the legacy_icps array.=20
> > Parenting the icp object to the spapr machine should be enough.=20
> > I might be wrong. my expertise on the migration stream is very=20
> > basic.
> >=20
>=20
> I don't think this would work because an older QEMU would still
> send state for objects that don't exist in the destination.

Right.  We could create "dummy" objects that receive the ICP data,
then discard it.  But it's probably more trouble than it's worty.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG87SAAoJEGw4ysog2bOSuIoP/A1IIKbBXyNc9gYsoJFSYLOW
f2jfR/jDoP4yxWfAIQGymWjz4KwbRSTy6haAa3JvI6TthdOu5O3mv9z9OGnioDlr
sdPPQDMJanP9MGhUpvfG5XK6p0bamEHVT6ADEauCU7JWph/s3fKXUtU8x4TISvy+
pVMfwfREuUFccJn9ZnHUOw36ELzthmvh7wKKxuvPafyNgaNjaU1QAy60lS4jImN0
JG5C+93WEM6BZkKvHCmHVST9Z1wHP/ZglLhBGkrDq26aQAHf58D5H0WU2A9qLQ3r
XEXhcFQy1/dLapzkRG4L8dEx26Nke7dPndJYSq0bqhob1Hv8fWeIO+Qo/vL7Jp+A
BhETh9M7k9squAHSAnhmqN5C/8fUkNgFnWteRuCPfCOX0PqDa/8ll+zF4516qrNK
rbb1lJPM6mbDVdBkHmjt96qCDWY/kp6pqR0AMT2FevyMTnZhXVJAhmkhkb/x8H8j
s8n2q2GW7OyGPl0GXkIlFJMVpxqOp3g43XVCV/BzK5Vku3lhB985qpfEfqtVKBQO
sgOkOvX3cOrnea/5ECJM+yC2mUXCbdWyGDtxIXYDtFc9ZUiW8T9dw13PcQRN5i9+
1en7KK4QgIeRIbObt0kx98LhbLd41SjKg16Gnhwu8vGsYDe3sb26sn20/mvyLWLc
G9AwKrApl/ShNjBrrPRc
=uFqW
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
