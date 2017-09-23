Received: from eggs.gnu.org ([2001:4830:134:3::10]:36249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0L-0007N0-UV
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0K-0002DE-Mk
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dvd0K-0002A0-Bl
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:28 -0400
Date: Sat, 23 Sep 2017 15:28:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923052849.GG4998@umbus.fritz.box>
References: <20170919213611.8988-1-jsnow@redhat.com>
	<20170919213611.8988-3-jsnow@redhat.com>
	<61dd1fd1-c3e7-2884-22bf-5856803c2a1b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rm5rkB9L8kG9H2n8"
Content-Disposition: inline
In-Reply-To: <61dd1fd1-c3e7-2884-22bf-5856803c2a1b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc: remove all unused CPU definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, agraf@suse.de


--Rm5rkB9L8kG9H2n8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 08:52:21PM +0200, Thomas Huth wrote:
> On 19.09.2017 23:36, John Snow wrote:
> > Remove *all* unused CPU definitions as indicated by compile-time
> > `#if 0` constructs.
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  target/ppc/cpu-models.h | 223 ----------------------------------------=
--------
> >  1 file changed, 223 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index b34b512..248f833 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> [...]
> > @@ -234,24 +105,11 @@ enum {
> >      CPU_POWERPC_440GXb             =3D 0x51B21851,
> >      CPU_POWERPC_440GXc             =3D 0x51B21892,
> >      CPU_POWERPC_440GXf             =3D 0x51B21894,
> > -#if 0
> > -    CPU_POWERPC_440S               =3D xxx,
> > -#endif
> >      CPU_POWERPC_440SP              =3D 0x53221850,
> >      CPU_POWERPC_440SP2             =3D 0x53221891,
> >      CPU_POWERPC_440SPE             =3D 0x53421890,
> >      /* PowerPC 460 family */
> > -#if 0
> > -    /* Generic PowerPC 464 */
> > -#define CPU_POWERPC_464              CPU_POWERPC_464H90
> > -#endif
> >      /* PowerPC 464 microcontrolers */
> > -#if 0
> > -    CPU_POWERPC_464H90             =3D xxx,
> > -#endif
> > -#if 0
> > -    CPU_POWERPC_464H90FP           =3D xxx,
> > -#endif
>=20
> I think you could also remove the "/* PowerPC 460 family */" and "/*
> PowerPC 464 microcontrolers */" lines now.
>=20
> Anyway:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Yes, I've made that extra change and applied.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rm5rkB9L8kG9H2n8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF8RAACgkQbDjKyiDZ
s5JmkRAA3MY/elWxO3dvgVpYbyGScf7MVgz+xdeLZGr021oLTPRnsGCcypgrxOtJ
fKtfFDSSh8VkuDN5lk7YgPtEMZgCzI47zIDo7d3rY8LpEqe9iWlmqCGr5LOb4PIp
/KoZ/nX28IpD6fajdYIyFjM+35h4+pKxrjVUBlqTDWK0NNEClMquk8HhPMmTNrEu
V4Y9usPNy6yIECF0Fv92u1fUvbPoVcMsFVQIx/oppi3UgL3kQDw/jX2qszwQB/1k
MaqMNBusjuWr2zLPdf5xNYGdWXflKeS1RbzK2odppEl22a5xAYXDXdwW8J3K4ZO0
8BfuirdnDi9WvVVVrs48eAgwh3BGjldrIubgO5iFSB2XEJbLvY4lTdqhUdIHExYH
FyT56lrc1RkQKHJTut51xbhGbLKbSwiulwkh36zokOQcZckIdVq/H9WgtKedtpGC
watIQQf/RSBCVk5sR0c6c9qjV3xig5WymCFI4Tmp/dEGwt50+S5qQqscfWEExuM/
oDwrhCrvtP7Ah3Qz+wd2SfGeIYC9bOLtl22va4VQWYIdRGm9Zw6fDUwYdusDZYW8
UBL0YlcYhQI5m8dTbTrxnut6rm/+t6jSmrDO8rH/Zvdmr5MQ4yPPgu20lyFpcb85
e99S60T7JZlaF5PgEYk82YoHWZhei2wNXYKDqADNz2wG0Jy03fY=
=6YEm
-----END PGP SIGNATURE-----

--Rm5rkB9L8kG9H2n8--
