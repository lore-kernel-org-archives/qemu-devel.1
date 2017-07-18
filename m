Received: from eggs.gnu.org ([2001:4830:134:3::10]:51564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUHl-0003HK-0J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUHh-0005l5-Sp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:19:41 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-4-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72dfc5e2-8335-ec66-7e86-19ed72366a85@redhat.com>
Date: Tue, 18 Jul 2017 10:19:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-4-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OeqV2MLNvmp3EbGlO0nC36A7QeU5U2f0g"
Subject: Re: [Qemu-devel] [PATCH 03/29] qemu-img: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OeqV2MLNvmp3EbGlO0nC36A7QeU5U2f0g
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <72dfc5e2-8335-ec66-7e86-19ed72366a85@redhat.com>
Subject: Re: [PATCH 03/29] qemu-img: use QEMU_IS_ALIGNED macro
References: <20170718061005.29518-1-f4bug@amsat.org>
 <20170718061005.29518-4-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 01:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 182e697f81..6f5f956302 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3804,7 +3804,7 @@ static void bench_cb(void *opaque, int ret)
>          b->in_flight--;
> =20
>          /* Time for flush? Drain queue if requested, then flush */
> -        if (b->flush_interval && remaining % b->flush_interval =3D=3D =
0) {
> +        if (b->flush_interval && QEMU_IS_ALIGNED(remaining, b->flush_i=
nterval)) {
>              if (!b->in_flight || !b->drain_on_flush) {
>                  BlockCompletionFunc *cb;
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OeqV2MLNvmp3EbGlO0nC36A7QeU5U2f0g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluJwQACgkQp6FrSiUn
Q2pUmwgAlKSFZ7RVihHoGpqEhpjzlD+2MRUU52NE/WiW3PFuUp80C/0xq+oKr/CM
qMo3z/JLBHXnQVQlZGm/mPOhAhJvPyfPVQrQs7uIvybSGRRwQ1I4nd9hVjR4Q7qX
W6rGmOUB4pKKCO/kGQgCyXGbwS/aYoXk7AyGxljCtJy6DuBMXjyZYCl79jh1I1VA
RmHMxBkdMxbJGeqFZ0LeEibZTEQ4OD9WOb2DkCtM5voOWDu0oXSAAvJlWMSyYdi5
eITRs0j3VeMErkM1MIouSTPs6WUfGmKc1SwDzFU8FXNm4EJCxg4lVVClhhbvViSj
pYN9C3FHeoip5fKHrnjxSBEsh48XMQ==
=bEd/
-----END PGP SIGNATURE-----

--OeqV2MLNvmp3EbGlO0nC36A7QeU5U2f0g--
