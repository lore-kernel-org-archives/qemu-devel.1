Received: from eggs.gnu.org ([2001:4830:134:3::10]:39811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dOOS3-0001k0-OG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dOOS0-0007no-K1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:16:43 -0400
Date: Fri, 23 Jun 2017 17:21:24 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170623092124.GG12089@umbus>
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/cpu-models: set POWER9_v1.0 as
 POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote:
> On 22.06.2017 13:26, Laurent Vivier wrote:
> > CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
> >=20
> > When we run qemu on a POWER9 DD1 host, we must use either
> > "-cpu host" or "-cpu POWER9", but in the latter case it fails with
> >=20
> >     Unable to find sPAPR CPU Core definition
> >=20
> > because POWER9 DD1 doesn't appear in the list of known CPUs.
> >=20
> > This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> > PVR instead of CPU_POWERPC_POWER9_BASE.
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  target/ppc/cpu-models.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > index 4d3e635..a22363c 100644
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c
> > @@ -1144,7 +1144,7 @@
> >      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                9=
70,
> >                  "PowerPC 970 v2.2")
> > =20
> > -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,            P=
OWER9,
> > +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,             P=
OWER9,
> >                  "POWER9 v1.0")
> > =20
> >      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              9=
70,
> >=20
>=20
> I think this also makes sense for running in TCG mode to get a valid
> real PVR there.

I'm not so convinced.

IIUC, this will make TCG default (for now) to a DD1 POWER9.  That's a)
probably not what anyone wants - who'd select a buggy prototype and b)
not accurate - TCG does not implement DD1's bugs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZTN2RAAoJEGw4ysog2bOS9v0P/RytfemhK/TjiwnWC8hrza7S
KaW2HHsSLs5QGiRYo67InPhOpBU+HxmrPtRWpMtMH6mQEK/l4uxptNXSSkHM5yO8
E7pfR1L6DbAgwCOG69U3ueqbJ9/euy+xRUd68w8/iwoCdeXfQPDpB3/duM1RWyyq
zR6xoIk7OG+x5xuBby9dS1rOOo6dPWb6P5mfW3XkF63KBCEzkuv9jSXqYYB+tiIi
RxZtO9682LWmFh48wzNICReOEOBWG25As85TMAiXqv1PCiVD0eoVztFgn36HfOeE
ivH2LtH+NFg9uOH5fHjCx/rxYggsPhn4jY41qrYMIcb9BMWhoL0Ut+lmI2SwZv+C
QQbsx2mK7heBGwq75rPmWGPrgTVAwEsBuTbRqOapj/nyQENLc3omO2ZyRigMQC7/
bK0FnDfu0uJLCIERlLI7LQgcovgT8A9eaRAbqyCggVBrw6sJ42nM4Ip/NxIp99v1
9pPnQ2TRyhkWSfgrFfE+UTZiRp/nXDFH8sr5jUkrT8ZzfkbscEiu/p5W5pMCgrXG
IhxcTaqQNvQ7NfJ3wAMFiedBZAojsETRU0z02ASY79mT5aOCUpZIADD6Kej8HW3w
8W7AFC0DJiHgR7cEMc4BNlZhWnpBP8GlHNHbqkcF5apBi76cLgyEodwGMT37UWaa
T4pcLkNJh+a4GU7uBapC
=VAlh
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
