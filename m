Received: from eggs.gnu.org ([2001:4830:134:3::10]:44577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFh-00084B-G4
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFf-0003Qm-PK
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:33 -0400
Date: Thu, 18 May 2017 14:51:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170518045103.GT15596@umbus.fritz.box>
References: <20170517063547.23876-1-david@gibson.dropbear.id.au>
	<1495011125.4663.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ayym4vmyMU9P4uDb"
Content-Disposition: inline
In-Reply-To: <1495011125.4663.5.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/2] pseries: Correct behaviour change for
 older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Ayym4vmyMU9P4uDb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 10:52:05AM +0200, Andrea Bolognani wrote:
> On Wed, 2017-05-17 at 16:35 +1000, David Gibson wrote:
> > 152ef80 "pseries: Rewrite CAS PVR compatibility logic" incorrectly
> > introduced a guest-visible behaviour change into existing versioned
> > machine type.=A0=A0Patch 2/2 corrects this change, while 1/2 is a
> > preliminary clean up to make that easier.
> >=A0
> > Unfortunately, this bug is already in the released qemu-2.9.0.=A0=A0Once
> > this is ready to merge for master, I'll make a backport to apply for
> > 2.9.1 as well.
> >=A0
> > David Gibson (2):
> >=A0=A0=A0pseries: Split CAS PVR negotiation out into a separate function
> >=A0=A0=A0pseries: Restore PVR negotiation logic for pre-2.9 machine types
> >=A0
> >=A0=A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A03 ++
> >=A0=A0hw/ppc/spapr_hcall.c=A0=A0=A0| 131 +++++++++++++++++++++++++++++++=
++++++++++++------
> >=A0=A0include/hw/ppc/spapr.h |=A0=A0=A01 +
> >=A0=A03 files changed, 119 insertions(+), 16 deletions(-)
>=20
> I gave it a spin and I can no longer reproduce the issue,
> so for the entire series:
>=20
> Tested-by: Andrea Bolognani <abologna@redhat.com>

I'm actually kind of astonished it worked at all given the bug that
Laurent pointed out.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ayym4vmyMU9P4uDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHSg1AAoJEGw4ysog2bOSdeQP/RsvHyqVGF+t4iuJQAUt6CZ5
Ldr7HP+J1X6aqViAexCmDL1NTX56OvOGanjcb4zWxRNyEsOmaeAZDMq3Eoza1c3C
6IoJbsNSYtlLiUHxbaIqId5Gwb2qqdI3sq3mMagwTdPa/v7mcxZa+Pb0kDZPwcNe
BEnJUYiTw85GPEz2SNJC7wWkWMpJmoMuOE9rsuwBTYX0hgoKLqfGf9WBlFfhnU5J
JT0wXa6bxIiGg88UBPAh+2PGE95ovC6mJJs5dYEQQe3M1mqCWw8L9/d5kVxIAYCf
ByN8T5WiSmbFuMECSf9DS6oaRHjdrsaniOQ0xIghNaSoFXRJWtrq64XN6o8GP0cK
1G6+Yv8XH1VHjtJnyF2H6sRWik7Xef3Z/V4OMtVXFj8tm3BRLkj7qtojomMTkk95
adsw9T9nTAQMKz69GVuohkSmzcK+qoRgvilrBQ7lRVbPNNjDfds96yMHD3fSnI/W
sHZdSbbakTW7xZxDZtdEEkjMESjdkfkC5nZYMPEElhNwFTnJs9merZjJhV+q82Qv
RODzZeAKL4bTobr2dylngljnlYWUaz5ia2vUVJK27cz8BAo4VYfTF3pkdk6x8kNm
KVRMDVOJJWHD6MKnpYbC85WPIf+OkgyTEfmyL+crBhe0x083sSXg9JsAUgoEySy0
FzpL+rMqrJOXr4x8Vm2+
=wRXV
-----END PGP SIGNATURE-----

--Ayym4vmyMU9P4uDb--
