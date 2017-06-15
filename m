Received: from eggs.gnu.org ([2001:4830:134:3::10]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLP2w-0002Ux-I2
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLP2v-0001Ly-1T
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:18:25 -0400
Date: Thu, 15 Jun 2017 08:18:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170615071808.GA27346@stefanha-x1.localdomain>
References: <20170613172006.19685-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20170613172006.19685-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block: Fix gcc 7 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 07:20:04PM +0200, Max Reitz wrote:
> blkdebug and blkverify use snprintf() to generate a filename; however,
> that may not fit into the target buffer (BDS.exact_filename). If so,
> they generate a truncated and thus pretty much unusable filename. In
> this case it's better to just not generate a filename at all (until we
> have better infrastructure which is not bound by a static buffer size).
>=20
> Also, gcc 7 warns about these snprintf() instances and these patches fix
> these warnings. There is another one in hw/usb/bus.c which is not
> addressed by this series.
>=20
> Max Reitz (2):
>   blkdebug: Catch bs->exact_filename overflow
>   blkverify: Catch bs->exact_filename overflow
>=20
>  block/blkdebug.c  | 10 +++++++---
>  block/blkverify.c | 12 ++++++++----
>  2 files changed, 15 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.9.4
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQjSwAAoJEJykq7OBq3PI/VkH/3kXiDO5phEpknKvsDz8b4iu
xYksOQLIwZR3nWS8hFS0d8A7aW8bXiZOm4vjqHGdIWunAFjFShc/lZ+ccu3V0aHr
SRvGk2KoJ3a0mGdl55FLuJqgOf3OMnF1e9HYJGEWu0VRVFzPxTxoy3UXChoHt8w7
EX5OFHbBsWDygy6QwdS8vJALzIAD6AreHAnieNT3pDYe6s+9AW0RruRnj4pqNlFM
yj6rviZJV6EvLTvxBPx3Tc7kTi7wmLl/N3DzwtuRiaBJP4oxnZ3IaJLjwz5xy8BV
G4yz4tI1BJzv+niFqlTKlBNEgpOn67nC3lriQqNvWMBZhPrzoE2C0rktVhjIO3g=
=2XKr
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
