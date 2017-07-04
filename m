Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSK73-0003hg-K2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSK6z-0003KL-FL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:17 -0400
Date: Tue, 4 Jul 2017 19:25:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704092549.GC2180@umbus.fritz.box>
References: <20170703131455.25424-1-lvivier@redhat.com>
	<20170703131455.25424-2-lvivier@redhat.com>
	<b11aa61c-ff73-3568-f924-e10828c0e92c@redhat.com>
	<20170704105146.6ef17b9f@bahia.lan>
	<4f7f7d4d-4d07-9595-8fdf-e44360ea9870@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <4f7f7d4d-4d07-9595-8fdf-e44360ea9870@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v3 1/2] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Suraj Singh <sursingh@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 10:56:56AM +0200, Laurent Vivier wrote:
> On 04/07/2017 10:51, Greg Kurz wrote:
> > On Tue, 4 Jul 2017 09:42:33 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >=20
> >> On 03.07.2017 15:14, Laurent Vivier wrote:
> >>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
> >>>
> >>> When we run qemu on a POWER9 DD1 host, we must use either
> >>> "-cpu host" or "-cpu POWER9", but in the latter case it fails with
> >>>
> >>>     Unable to find sPAPR CPU Core definition
> >>>
> >>> because POWER9 DD1 doesn't appear in the list of known CPUs.
> >>>
> >>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> >>> PVR instead of CPU_POWERPC_POWER9_BASE. It also adds POWER_v2.0
> >>> with POWER9 DD2 PVR to avoid to trigger kernel POWER9 DD1 workaround
> >>> in TCG mode.
> >>>
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>> ---
> >>>  hw/ppc/spapr_cpu_core.c | 5 ++++-
> >>>  target/ppc/cpu-models.c | 6 ++++--
> >>>  target/ppc/cpu-models.h | 1 +
> >>>  3 files changed, 9 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> >>> index 9fb896b..00918a5 100644
> >>> --- a/hw/ppc/spapr_cpu_core.c
> >>> +++ b/hw/ppc/spapr_cpu_core.c
> >>> @@ -249,8 +249,11 @@ static const char *spapr_core_models[] =3D {
> >>>      /* POWER8NVL */
> >>>      "POWER8NVL_v1.0",
> >>> =20
> >>> -    /* POWER9 */
> >>> +    /* POWER9 DD1 */
> >>>      "POWER9_v1.0",
> >>> +
> >>> +    /* POWER9 DD2 */
> >>> +    "POWER9_v2.0", =20
> >>
> >> In case you re-spin, what about a more compact listing:
> >>
> >>     /* POWER9 */
> >>     "POWER9_v1.0",
> >>     "POWER9_v2.0",
> >>
> >> ?
> >>
> >=20
> > I second that but anyway:
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> >> Anyway, patch looks good to me, so:
> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >=20
>=20
> I agree, but as I was focused on the problem with "-cpu POWER9" I forgot
> to update the first patch.

Ok, we can do that as a follow up.

I think it would also be good to add a comment saying which of the DD2
variants that PVR is for.  Optionally, we could add PVRs for the other
variants.  I don't think it matters which variant we point the POWER9
alias at.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW18dAAoJEGw4ysog2bOSP30P/1z7BFuCRtYFAzg3sidkxchj
00R/UPrq8wVJmcx25WQgos/p4zVKiS0kR7ieZYyq8OuNu7yAa2qowZjUXTaBE1oG
uoZAMWn4Tz25G3cssrCGHtaRz/t1KpLGDkGYg+kcAEoPMO4j4RP3WNWa3p13X+6L
UVP9V5YmEgGKFVPTCzit02gng4uNQC3daV4ajA4uhCPnf5P2UJRIiM2G/4WlOd84
WNkrQlNUg3FxGy5b6P66zC50HoKP1hu1cJiEfMEQd3gvi990L6lx7g4aYbOgKXxH
TpGIsdNaJdniHjWN/0LSUIJ/HwejVCxPhxlneUGkOX7CO2adEUZJEG64jgYDa5HL
5RrKiIsv4xDpurIjTLwlH1cSZb0RlyHTRNlFx33IPm48UmMXuc/qFyqiPNB7gf1g
4zAaNdF2tLXW1CBWORS6aP7nXpTwrdARKheG/+AzmYMl64QRaJuqpCwcJeWU8ZPN
euqnNQOmMYiWNJDyCoZTxrepW3voioQzBTDm0w1ePTxsSVoJkUEuf4PpKkETHrOY
hh1tXqtUiAtowPOdksQJibXcQ6BZMdQ4PPgRL/8W/qEX+BKfNk2tawBfOa9CoV4i
xNGYDskioSdrxTrSX/Yp8SOJnYhh/Gz3jOJqR599AWQmC3JRmavqPr3RlLAv0go1
NGcs7LdLfOm/f843s6sX
=p1ge
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
