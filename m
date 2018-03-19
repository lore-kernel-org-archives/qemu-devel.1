Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1ey2w6-0006qD-DG
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1ey2w1-0008DJ-E0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:07:22 -0400
Received: from sauhun.de ([88.99.104.3]:57330 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1ey2w1-0008Ce-7E
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:07:17 -0400
Date: Mon, 19 Mar 2018 23:07:15 +0100
From: Wolfram Sang <wsa@the-dreams.de>
Message-ID: <20180319220715.g2stcupst6ifsnrj@ninjato>
References: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
	<20180319213101.6100-4-wsa+renesas@sang-engineering.com>
	<2071e85f-72b9-9fa5-e5d7-7faa41fb9074@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dtcn2baqe4twlm7s"
Content-Disposition: inline
In-Reply-To: <2071e85f-72b9-9fa5-e5d7-7faa41fb9074@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] nvram: at24c: use standard error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


--dtcn2baqe4twlm7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -                ERR(TYPE_AT24C_EE
> > -                        " : failed to write backing file\n");
> > +                error_report("failed to write backing file\n");
>=20
> Drop the \n here and elsewhere in your patch; error_report() already does
> that for you.

Darn, I haven't installed my automatic-checkpatch-script for qemu yet :(
Sorry, will wait for more review comments and fix!


--dtcn2baqe4twlm7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqwNI8ACgkQFA3kzBSg
KbbfLA/+JuW2+64mmglCTSDvScUWt+IkemJLJcC6J0SowjZ5lHUdWVH57v/vnzGH
ihmoZWLPjbamcCjZLMbYKoKZigTbJoyHur6mcxUPMXdhI3qohvq+cAgB8jEKl+9J
xVrlUYH6hI6OYmqD0tNYkQlHe0bvQw6fwTHjjB01kTihy3W3t5hhUG0X9+w2G1bX
CTU7tpHZHXF+wM7VNwRmeCiZNhD44tHBBysK1dirjOQ24rGYdBIwJLylt5wqxjSb
wLJFUhDO0sOZd9rHxcP7hqicJ5KEd+mhj41d53qaIUMTc8Nu8i7VUoAUo9Xtz333
mzO7YAOVV16mBAunll70Auzx6UqCheuPSSF4At87g5l95OB6a0Qtfl2LNFge9Nro
6E2NE6cFXW7VTf+8ECzq0Kfx7/vY2d+nnRTl7yYlcfGUHXWkN9xL1dLUm0TWwea5
gQA5iqNd0ahvFTJ1qPuTTcdri5UsajCJKEEFiY2F8YUUucwNu6GYzFkuxeu5pTek
qOGKq8ZAS5NvP0L+ofBg7VrCSq/nAnO5eUW2eD9vWLb/1hYG1ySvroq0hEIJF6zf
A5YS4yziOsObEzhlsqhWYPLdSzMes+R1yKBGBYT4oIRm+s6goWfFyTqOKe63FKP/
k1nvRU44U5oa55QSb7/TYfVyHI1OyQ+2UA0RTbQqDBkQUplh/m0=
=IGpA
-----END PGP SIGNATURE-----

--dtcn2baqe4twlm7s--
