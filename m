Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK2Qj-0005rv-EY
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK2Qi-0005Yl-Jb
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:57:21 -0400
Date: Sun, 11 Jun 2017 20:57:04 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170611125704.GC18542@umbus>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<1497109365.4161.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <1497109365.4161.1.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv5 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2017 at 05:42:45PM +0200, Andrea Bolognani wrote:
> On Fri, 2017-06-02 at 13:15 +1000, David Gibson wrote:
> > This is a rebased and revised version of my patches revising CPU
> > compatiblity mode handling on ppc, last posted in November.=A0=A0Since
> > then, many of the patches have already been merged (some for 2.9, some
> > since).=A0=A0This is what's left.
>=20
> I've tested this the same way I had tested one of the
> previous respins, eg. for basic usage and general sanity
> of the interface. All the issues I pointed out last time
> seems to have been addressed.
>=20
>=20
> Tested-by: Andrea Bolognani <abologna@redhat.com>

Ok, I think have enough acks of various sorts now.  I've merged this
into ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPT4bAAoJEGw4ysog2bOSNtAQANa4GAHj9Z1GFnX5pO9RCfrX
16tfWJydbpTxZlwqv7iZ+9jTYU124Ivo3410eBw+7IZ2XhPjjUGz4lX6qZjql1Uy
tX48RpNz5n3dqAL6NDGennjKhNmWZBuY+i2K86/qMHbzgiNJN4c2D4907k5qm0wT
Jn7H7E7b8pF6wFIbJdnDqrBEWbtrZ7cBXvY+x7z9gy2RgPZtzvFixBgdcqUqEhUh
z+A0xry6QWjh8xelfzrnc+AtKDIz3W33gTU7utN4viwlf/GRI0P80GVlsFbD4mH9
JEsZM0BR1Cn3PG+DzMgll1Od/bppv/jZPxP5U6ysOVPBetjaurDKYNsECr1xGOXM
6RQKmnaXko/Z4eWjbbz2n8Db6KgxowfDfShHIAQEBJYPqcmUWBmWj6LbYj87DMM/
fz5QizWiOhbYUEEp37lMp/M3MFv+FfAUqy3HytJr0c+yCj9xaEJtY6d4u3QOQTNG
icRnM6QhcLn1MOJT/4nhME/s2HPA3Hte3BJi3j3LYlTBPjNAQXsjmao7KaJseioF
/1qqRVc2naxLjxLzpnbEA58m1WcPguRo5kp9le8Q+NI0kcOzO8Mgg+1WW4qR0UmL
gPb6HYEsM3lD2PHO3eW0hrxXpVgo6Qa6lXQCjPKtzVO51qqAPuBkYD5f2tMCEWKQ
nHwPjM4OJcky2e+yu3nX
=l77V
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
