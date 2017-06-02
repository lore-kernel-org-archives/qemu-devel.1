Received: from eggs.gnu.org ([2001:4830:134:3::10]:37269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcn-0008D7-8d
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcm-0000ru-4j
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:57 -0400
Date: Fri, 2 Jun 2017 13:31:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602033103.GL13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-4-david@gibson.dropbear.id.au>
	<149633145975.3207.486309081928645378@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline
In-Reply-To: <149633145975.3207.486309081928645378@loki>
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: Abolish DRC set_configured
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 10:37:39AM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-05-31 20:52:17)
> > DRConnectorClass has a set_configured method, however:
> >   * There is only one implementation, and only ever likely to be one
> >   * There's exactly one caller, and that's (now) local
> >   * The implementation is very straightforward
> >=20
> > So abolish the method entirely, and just open-code what we need.  We al=
so
> > remove the tracepoints associated with it, since they don't look to be
> > terribly useful.
>=20
> Dropping the method makes sense, but the 'configured' state affects a
> lot of the state-transitions throughout the code so I think it may
> be useful to keep the traces.

Fair point, I'll put the traces back in.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMNv3AAoJEGw4ysog2bOSh6QQAMiD4uyIGXMGrnqWYkrbcqhT
LbIq333qMihWzDlfcv2Wn4D1f2YoDTUUxSa3YTo/uwxSuumNgKqudPyc8KoEe+ey
AUIMek/MHWULzXKK+hZAeVeyq+FirJtEWo8Hk+Ry2EwxSObx0eSucrif+LI03re1
WO85HCqU6QInZtMXfakEQRf+oXOzmYR7Z4VIM7kvhhn1bkYCl44vyAX0/ggDnDXl
Ww/19I8D8Xlf09SR03LSGiVhDaPo8H5gCUrB9BKqKj84eM1PxhTbm7dI8xiSrkdh
6tx7VSAr5OIJS+4PGN/cuBvroakvK+buXoDRoRL8QMg1y9BaByzGdfLI4QGKJYdA
STQ/GXLtR2/3JJYITbhxYGqMfkfXm+8C2IdjVmwRLYCja9lqYYUDdsy0AET2rR15
UnZM4kB+M12Kpd72Cnl8qvwOra7IDahkpcNBfDs8XUGpgTJP1TfP3wGFcl6WeQmh
mbzU7FkOkNbQESBqMvVwGE50CLhiqzrP4FnHYiNl7TbFtFKXbJpyhejbfE92j9/w
XJaYCFxLcRCxFCc3IYSVT5pFruezovLosPloNrmXBvoQNjO6mxUuEIHNLoojQvE1
Xjb1y91DZycXhpAmqIDRDvtxqVGxKZxu7vXReLpd903SRLJnNUVb0xyPb4d3Z0Wz
SPw9kQqtuGmzSEMP+glP
=7LTv
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--
