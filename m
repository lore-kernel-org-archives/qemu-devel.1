Received: from eggs.gnu.org ([2001:4830:134:3::10]:44032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyu8-0005ob-Sl
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyu8-0001Gq-5C
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:44:56 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b250d8fb-ed4b-1e3c-6608-b1b908712ff4@redhat.com>
Date: Wed, 29 Aug 2018 13:44:46 +0200
MIME-Version: 1.0
In-Reply-To: <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pw9Z4H6WzyVfvFkcie8hV0WgCzqUmFWKE"
Subject: Re: [Qemu-devel] [PATCH 7/9] block: Allow changing 'discard' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pw9Z4H6WzyVfvFkcie8hV0WgCzqUmFWKE
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b250d8fb-ed4b-1e3c-6608-b1b908712ff4@redhat.com>
Subject: Re: [PATCH 7/9] block: Allow changing 'discard' on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
In-Reply-To: <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> 'discard' is one of the basic BlockdevOptions available for all
> drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
> the user cannot change it and doesn't get an error explaining that it
> can't be changed.
>=20
> This should update the discard setting, but does nothing:
>=20
>    (qemu) qemu-io virtio0 "reopen -o discard=3Don"
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 804d557608..21f1eb9cd1 100644
> --- a/block.c
> +++ b/block.c
> @@ -3178,6 +3178,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
> =20
>      update_flags_from_options(&reopen_state->flags, opts);
> =20
> +    value =3D qemu_opt_get(opts, "discard");
> +    if (value !=3D NULL) {
> +        if (bdrv_parse_discard_flags(value, &reopen_state->flags) !=3D=
 0) {
> +            error_setg(errp, "Invalid discard option");
> +            ret =3D -EINVAL;
> +            goto error;
> +        }
> +    }
> +

Let me add a:

Reviewed-by: Max Reitz <mreitz@redhat.com>

Although I think it might need a _del.


--Pw9Z4H6WzyVfvFkcie8hV0WgCzqUmFWKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGhy8ACgkQ9AfbAGHV
z0D/KQgAusuzXFfUkKy4/KTzwIimGI1igj4PY1Z7a8uNmem+ri2WP2HF+vYOJJ0M
IVeN/5rrKiNIoYZdHdXQ/bj5V2f0xcFAMltBADPt/VZ4Wl8x2uivNS8zUfoTLqLB
YaM8yDz+mBIcAhI+4090alMlP3KWEMvYHYBW6GkUScfi90Qy1xazz/EakdTyyNGp
NuELsRRwek1oECeCJoWw1aMDiL61/vzlmk1Aiq6hwRY801+6xqUWH4OyCbvsNLcq
D/pTHCgVElc2LUP5g5GlffnyusGo5cKy2ms4R+iVhFWqx/+k9KYcY9wy4vP6yRRH
K2FZw2wJfPWKOFvON2JPYEjpmfOt0g==
=PiRM
-----END PGP SIGNATURE-----

--Pw9Z4H6WzyVfvFkcie8hV0WgCzqUmFWKE--
