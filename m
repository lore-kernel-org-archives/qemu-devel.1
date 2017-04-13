Received: from eggs.gnu.org ([2001:4830:134:3::10]:51138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cym1B-0005D4-Kx
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cym1A-0007xE-JT
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:11:05 -0400
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170413203401.3213-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1ccbdee-dec2-8727-bff4-687e535e41a6@redhat.com>
Date: Thu, 13 Apr 2017 16:10:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170413203401.3213-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0p3QsUjHakv0CNiaW8cGTI1Awmau64oVe"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/3] qemu-img/convert: Always set
 ret < 0 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0p3QsUjHakv0CNiaW8cGTI1Awmau64oVe
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <b1ccbdee-dec2-8727-bff4-687e535e41a6@redhat.com>
Subject: Re: [PATCH for-2.10 1/3] qemu-img/convert: Always set ret < 0 on
 error
References: <20170413203401.3213-1-mreitz@redhat.com>
 <20170413203401.3213-2-mreitz@redhat.com>
In-Reply-To: <20170413203401.3213-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 03:33 PM, Max Reitz wrote:
> Otherwise the qemu-img process will exit with EXIT_SUCCESS instead of
> EXIT_FAILURE.
>=20
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 37c2894678..f2809e1ab4 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2069,6 +2069,7 @@ static int img_convert(int argc, char **argv)
>              opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
>                                             optarg, true);
>              if (!opts) {
> +                ret =3D -1;
>                  goto fail_getopt;
>              }
>              break;
> @@ -2081,6 +2082,7 @@ static int img_convert(int argc, char **argv)
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
>                            NULL, NULL)) {
> +        ret =3D -1;
>          goto fail_getopt;
>      }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0p3QsUjHakv0CNiaW8cGTI1Awmau64oVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7+lfAAoJEKeha0olJ0Nq9CIIAIAnnbs+0XsFxvVu/JC0I9FX
to++3D0qFLU2KU2ozlxFzSSiCD0k3hADhEfi4Z4PKKgloV6Y9SYk6WaJ/ah1OfiL
lP2l0tjbjfxA0cjEGMWBf5yj0+MMPKtOoWL0GKzMSsZwrXpNCcoFMKg3Elx/JVVt
m2mJuMIPIzzWFiSJNl2dEtgOfzhq+VaGlIByCDRHGsVT8Bv7jzMjycxXgE7ML7Zo
Wa8OU456Rprj1Jgl1vHjYacKlUfUfH3A8VHCnnJ4fCJuZwx5RGG8cKjALEqsnRmj
/3FwAyV7EG5p8XQC+LqL7VcuiAdctmUTkVy7AEjouCpkz2ft5nQW6wdUovoXARg=
=3vpX
-----END PGP SIGNATURE-----

--0p3QsUjHakv0CNiaW8cGTI1Awmau64oVe--
