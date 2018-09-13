Received: from eggs.gnu.org ([2001:4830:134:3::10]:60714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Rk3-0005LB-K9
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Rk2-00075u-SQ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:33:07 -0400
References: <cover.1536226505.git.berto@igalia.com>
	<4e73b26693677b6067545590708adcba66da1c06.1536226505.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <468c987f-b5b3-da16-b722-8481afc5bb9b@redhat.com>
Date: Thu, 13 Sep 2018 15:32:53 +0200
MIME-Version: 1.0
In-Reply-To: <4e73b26693677b6067545590708adcba66da1c06.1536226505.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h4be1g1eQLjc7SUkMuRl5Kr2l9H53MG88"
Subject: Re: [Qemu-devel] [PATCH v3 08/10] block: Allow changing 'discard'
 on reopen
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
--h4be1g1eQLjc7SUkMuRl5Kr2l9H53MG88
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <468c987f-b5b3-da16-b722-8481afc5bb9b@redhat.com>
Subject: Re: [PATCH v3 08/10] block: Allow changing 'discard' on reopen
References: <cover.1536226505.git.berto@igalia.com>
 <4e73b26693677b6067545590708adcba66da1c06.1536226505.git.berto@igalia.com>
In-Reply-To: <4e73b26693677b6067545590708adcba66da1c06.1536226505.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.09.18 11:37, Alberto Garcia wrote:
> 'discard' is one of the basic BlockdevOptions available for all
> drivers, but it's not handled by bdrv_reopen_prepare() so any attempt
> to change it results in an error:
>=20
>    (qemu) qemu-io virtio0 "reopen -o discard=3Don"
>    Cannot change the option 'discard'
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--h4be1g1eQLjc7SUkMuRl5Kr2l9H53MG88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluaZwUACgkQ9AfbAGHV
z0BsxAf/VL1uWOYjMENAeHteXhg/MNcENlfCLKTrHdBWL2shkzErYgkOrw7zEaq8
oGmllyah9OU+gR0eFMker74xO/RqDVr0PfgGu1BgfFc1JIZ5zOgmU580VcQ97mza
YkpcEV43Mqcn2o9g4eFRzNYBBN6LjXEl+6V1GocDxkUd3C/+dV4rlcYHVz6VzMKy
Y22tEnUC5JXuaC9oP9bt6KwVt1ShNzCI0kssXz+deMvRIW714OiL96ot2OY5Ck6p
twoVvqsmdvfD5kfUUbiVSH2Hu9F5IdfaNxkzPcGzF7bE7zz/4WPqZJOpT3Z1JL7s
NXnhTjfYVoM4eifP9A5wMOMn/NO0Pg==
=vOqW
-----END PGP SIGNATURE-----

--h4be1g1eQLjc7SUkMuRl5Kr2l9H53MG88--
