Received: from eggs.gnu.org ([209.51.188.92]:50937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqfk1-0006H5-IQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqfjv-0003tH-Of
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:00:57 -0500
References: <20190202011048.12343-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d3a1905-db14-cbbc-bdad-2f6da9dfaec5@redhat.com>
Date: Mon, 4 Feb 2019 09:00:44 -0600
MIME-Version: 1.0
In-Reply-To: <20190202011048.12343-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jH6TMN4rXcxH8BC9lXM8c3r0RgFQwUwZO"
Subject: Re: [Qemu-devel] [PATCH v2] block/dirty-bitmap: Documentation and
 Comment fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jH6TMN4rXcxH8BC9lXM8c3r0RgFQwUwZO
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fam Zheng <fam@euphon.net>
Message-ID: <6d3a1905-db14-cbbc-bdad-2f6da9dfaec5@redhat.com>
Subject: Re: [PATCH v2] block/dirty-bitmap: Documentation and Comment fixups
References: <20190202011048.12343-1-jsnow@redhat.com>
In-Reply-To: <20190202011048.12343-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 7:10 PM, John Snow wrote:
> The meaning of the states has changed subtly over time,
> this should bring the understanding more in-line with the
> current, actual usages.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> ---
> V2: Amended some wordings, though this is a little chatty now.
>     Hopefully it's clearer, though.
> ---

>  /**
> - * A BdrvDirtyBitmap can be in three possible states:
> - * (1) successor is NULL and disabled is false: full r/w mode
> - * (2) successor is NULL and disabled is true: read only mode ("disabl=
ed")
> - * (3) successor is set: frozen mode.
> - *     A frozen bitmap cannot be renamed, deleted, anonymized, cleared=
, set,
> - *     or enabled. A frozen bitmap can only abdicate() or reclaim().
> + * A BdrvDirtyBitmap can be in four possible user-visible states:
> + * (1) Active:   successor is NULL, and disabled is false: full r/w mo=
de
> + * (2) Disabled: successor is NULL, and disabled is true: qualified r/=
w mode,
> + *               guest writes are dropped, but monitor writes are poss=
ible,
> + *               through commands like merge and clear.
> + * (3) Frozen:   successor is not NULL.
> + *               A frozen bitmap cannot be renamed, deleted, cleared, =
set,
> + *               enabled, merged to, etc. A frozen bitmap can only abd=
icate()
> + *               or reclaim().
> + *               In this state, the anonymous successor bitmap may be =
either
> + *               Active and recording writes from the guest (e.g. back=
up jobs),
> + *               but it can be Disabled and not recording writes.

s/but/or/

> + * (4) Locked:   Whether Active or Disabled, the user cannot modify th=
is bitmap
> + *               in any way from the monitor.

Worth a parenthetical comment mentioning NBD export as a possible reason
for Locked to be visible?

With the one word fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jH6TMN4rXcxH8BC9lXM8c3r0RgFQwUwZO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxYU5wACgkQp6FrSiUn
Q2oM+wgAmNrjr+fJC5RlUIR+EvhLXgEMx5m/gJfUqXEarKyB8IMBoAkDF4OKiYJU
AwKONU4edh2B3r9zDa24M2nq+lVwDpzy2Otdi4Z3eIeR1lJGrZkDfr5ZA02wpvVf
9n/r3HucAztWQwLPVcrS+9/snaUiFfXbmUGJqB/QMpss5J1IJgk0dIchV7lKzDMq
nzxLbM5gdhHoenvnTQXpONQbJU7dk2hb6PCS7lIyhfOicuuZEeUbMTPES/3sSGWd
miI33SzS3MuV5Oz2uYs2DbLjeI8YK/wmqzLr8UHDXZr0gxnscK9TygTrLJPCOVFc
DhmOcRgObkPE+P286S0B11zRkjDOgA==
=W7ip
-----END PGP SIGNATURE-----

--jH6TMN4rXcxH8BC9lXM8c3r0RgFQwUwZO--
