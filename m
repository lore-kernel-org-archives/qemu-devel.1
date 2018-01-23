Received: from eggs.gnu.org ([2001:4830:134:3::10]:43550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edzs8-0007BA-63
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edzs2-0002SW-F6
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1edzs2-0002RZ-4a
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:18 -0500
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
Date: Tue, 23 Jan 2018 08:48:15 -0600
MIME-Version: 1.0
In-Reply-To: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TvGDjOHGX9onlE8Kta9gMBjqOFkCc0XVL"
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TvGDjOHGX9onlE8Kta9gMBjqOFkCc0XVL
From: Eric Blake <eblake@redhat.com>
To: River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org
Message-ID: <982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
In-Reply-To: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 10:40 PM, River Chiang wrote:
>     Signed-off-by: River Chiang <riverchiang@gmail.com>
>=20
> ---------------------------------- qemu-img.c
> ----------------------------------
> index 68b375f998..5ce594ea00 100644
> @@ -2098,6 +2098,9 @@ static int img_convert(int argc, char **argv)
>      if (s.src_num < 1) {
>          error_report("Must specify image file name");
>          goto fail_getopt;
> +    } else if (!strcmp(argv[optind], out_filename)) {
> +        error_report("Override the input file with the output file");
> +        goto fail_getopt;

Comparing names is too prone to false negatives.  'foo' and './foo' are
the same file, but your test won't catch it.  Better might be checking
if stat() reports the same dev/inode pair for the two files.

By the way, your patch is not in proper 'git send-email' format, which
makes it hard to test whether it even applies.  More patch submission
hints at http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TvGDjOHGX9onlE8Kta9gMBjqOFkCc0XVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpnSy8ACgkQp6FrSiUn
Q2pI2QgAlDMIshS/vKYvY1JFpY/tuVFixFMZNpLSEg7GHZ1oObpygqrJpAEB6Cwj
Tws3iJptntjStribJdnyWgTg4JwZUN8T8cbTY/p9gXTge1/27mxMp1URiPa9Qgon
VPCxOc7sxaya708YhMGaIm+jSnC0E/opcjnHnhhqTBaOXLhTEBqHmc2rLGSh/Hoq
OZ+/H++aTe0xhmecudelVfOms1HyyVE9cIm6EJ+1R/BZH7XDi5uky1GbQvM6OlJE
lMK5iGFIYmOHJTi7Cn+031HHVJ0/1sddFHfHcDHUNnL0kVEgvwxVq8GKLd3kMm+C
FshSgpV4ksRnK/Ukihlh+elyxguNPg==
=d5wm
-----END PGP SIGNATURE-----

--TvGDjOHGX9onlE8Kta9gMBjqOFkCc0XVL--
