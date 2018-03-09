Received: from eggs.gnu.org ([2001:4830:134:3::10]:46298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu8Ly-0007QH-LO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu8Lx-0008Ir-9h
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:05:54 -0500
Date: Fri, 9 Mar 2018 14:05:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180309030541.GU3083@umbus.fritz.box>
References: <20180308111305.C9F56745707@zero.eik.bme.hu>
	<20180308144845.0D7647456CD@zero.eik.bme.hu>
	<20180308234446.GQ3083@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNjIDde0W37E3OQP"
Content-Disposition: inline
In-Reply-To: <20180308234446.GQ3083@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v2] ppc440_pcix: Change some error_report
 to qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>


--eNjIDde0W37E3OQP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 10:44:46AM +1100, David Gibson wrote:
> On Thu, Mar 08, 2018 at 12:08:08PM +0100, BALATON Zoltan wrote:
> > Using log unimp is more appropriate for these messages and this also
> > silences them by default so they won't clobber make check output when
> > tests are added for this board.
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
> Applied, thanks.

Wait.. I've taken it out again.  Under some configurations (exercised
by Travis) qemu_log_mask() is undeclared here you're using it.  See
https://travis-ci.org/dgibson/qemu/jobs/351093986 for some more
information.

>=20
> > ---
> > v2: Use defined format string for printing hwaddr instead of casting.
> > I guess this does not invalidate the R-b tag of v1 so I've added that t=
oo.
> >=20
> >  hw/ppc/ppc440_pcix.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> > index ab2626a..1dc5d7f 100644
> > --- a/hw/ppc/ppc440_pcix.c
> > +++ b/hw/ppc/ppc440_pcix.c
> > @@ -286,8 +286,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hw=
addr addr,
> >          break;
> > =20
> >      default:
> > -        error_report("%s: unhandled PCI internal register 0x%lx", __fu=
nc__,
> > -                     (unsigned long)addr);
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: unhandled PCI internal register 0x%"HWADDR_=
PRIx"\n",
> > +                      __func__, addr);
> >          break;
> >      }
> >  }
> > @@ -377,8 +378,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque,=
 hwaddr addr,
> >          break;
> > =20
> >      default:
> > -        error_report("%s: invalid PCI internal register 0x%lx", __func=
__,
> > -                     (unsigned long)addr);
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: invalid PCI internal register 0x%" HWADDR_P=
RIx "\n",
> > +                      __func__, addr);
> >          val =3D 0;
> >      }
> > =20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eNjIDde0W37E3OQP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqh+gIACgkQbDjKyiDZ
s5Iwcg//ZvYtxh159b2zzlEZwJa9Y30mx7bYPGFPH/U3SMErvZ+aT85hvSglvigP
LVylFLS5M01uuhYaJmyGlSwYZx4UrjGe39Q/P/y5ouap1JU66spxLq8n6+nvIeqy
JKftphTLU98QZ88DhgfwSP1kdyI3lWCESLFI5tc3ez/14wwDMSrRnMSFbxxbV5Cf
ygyWrfgR3X1k9faAqjhVGceWcuuFNNS4H47kH0YoEL278cxm6R6lzb+i5e/8kILA
0sT5vWikJyq5IvoBy+g7Zv3vvpbA9B0kVpCJLm5JCESKeiMNvREbnH9K/mYlyvuP
k5n6XW/PkwkV4xOGthuemw83pknGHOoYSz9Z5knBmHl1tP4n/Oc62Ua7jLfL0n5m
NwKjfuUO3AwQJszMX909oamjgZNtYLTphymyUJw+6+IXi62stOiT8VQJOBs3Hm29
0QHDd2WQvPydAFW1hQ2gx7BrSUUXoiOSBHL2tXfPwEVUPCDFlqsvECT+/oS1BXOT
ZfEBrxyTPSqEXPbUCjzj6sedmsZ7ulDeTsKXJPLrCQEJLlPJ7WvvTzIOlp3NexPd
LhtZE4fiWUSoOxOnF3o49qJjB9ONOwhSKYsFNcXC+/QRzq9JzMGzMZ+gBYEXnLSD
Yy3QnIaBbqmMhGWs5a71UMGf6yEiC7/yAEDsH3fMER8N1goHl0Q=
=p0kJ
-----END PGP SIGNATURE-----

--eNjIDde0W37E3OQP--
