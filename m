Received: from eggs.gnu.org ([2001:4830:134:3::10]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh44-0007a4-4b
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh42-0007tQ-R2
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:40 -0400
Date: Tue, 13 Jun 2017 16:09:45 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613080945.GD30171@umbus>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<1497337300.27606.7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <1497337300.27606.7.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv5 0/4] Clean up compatibility
 mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbobroff@redhat.com


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 03:01:40PM +0800, Andrea Bolognani wrote:
> On Fri, 2017-06-02 at 13:15 +1000, David Gibson wrote:
> > This is a rebased and revised version of my patches revising CPU
> > compatiblity mode handling on ppc, last posted in November.=A0=A0Since
> > then, many of the patches have already been merged (some for 2.9, some
> > since).=A0=A0This is what's left.
>=20
> As discussed yesterday on libvir-list, the current
> implementation will abort() when the user attempts to use
> a compat mode that's not valid for the host CPU, eg. on
> a POWER8 host:
>=20
> =A0 $ qemu-system-ppc64 \
> =A0=A0=A0=A0-nodefaults \
> =A0=A0=A0=A0-M pseries,accel=3Dkvm \
> =A0=A0=A0=A0-cpu host,compat=3Dpower9
> =A0 Unexpected error in ppc_set_compat() at target/ppc/compat.c:135:
> =A0 qemu-system-ppc64: Compatibility PVR 0x0f000005 not valid for CPU
> =A0 Aborted
>=20
> We should probably report the error to the user in a slightly
> less destructive fashion :)

Good point.  As I suspected, this was just an &error_abort somewhere I
should have used an &error_fatal.  Fixed in the ppc-for-2.10 I just
pushed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP53JAAoJEGw4ysog2bOSuaMP/3WfNjmWfrwPg1T0USGAHziU
BFrNfPueHXDpj9T9GSdCceNFY8lEW/qWSxA0hVgzfSNuGtOjvnDe12Ikkw6B5E1Y
jzfwKNYeJCnNTf1dZSWDE9eAn7NwhIeMrcTzgSL2vIuhidudTDPs21g8A4j9tvX0
lDGzizskY9V7qUnhH0cXLWNX3XFh7v29hb3FJxlAb+1Nsq7O79P8HFPJ8J0yV5tF
+QihFhKSUrncsv6ndI1vgNZfqa3jPX21c0rMHBCq+/AsTUc1SORXuPy1lg5QY0e7
PWqvRIKmascQlnYq8UO5BrYvS6QRtnxtr51MMuXh/dU8URs22Len1jS8O9YapbtX
mNLHztOhmCiAf5eEMDfGd6uppeRdzNVa+K5Zgl7F0x5a7l1oMauAaQQq3cuLrFZS
DYcZKhxN1h/6QJSIJ9BpqhHCTg3OJG+aDbka3hOUKo+uektoTWhIp76WjRNl9bop
uNinDg7kQfPlNxdagYWP7i2K17fdvzUXWbtwIYkhCTSqGfamB4r+iALOzxINMn6o
bsR2njb+g8f4zzAcL09zQuchBnImnGBoBV9TTHsskgKrvNbzuWd4koEfClvm0TEZ
4g19iLOqDhhn+Rl8GpXpoLM0HkNySgWYt3HQVUEi1NAjwPb0kgjeQKWm9o9Iezdw
ub3EshxatYWwoKjvn7Bg
=sLK2
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
