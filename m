Received: from eggs.gnu.org ([2001:4830:134:3::10]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0ot-0003nj-EB
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0os-0003qe-Dp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:51:15 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
Date: Mon, 3 Jul 2017 07:51:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170703122505.32017-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2UKniQ0KHN5K4v29pCR5VTEiaGjw6oU1G"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2UKniQ0KHN5K4v29pCR5VTEiaGjw6oU1G
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-4-mreitz@redhat.com>
In-Reply-To: <20170703122505.32017-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 07:25 AM, Max Reitz wrote:
> Currently, bdrv_reopen_prepare() assumes that all BDS options are
> strings. However, this is not the case if the BDS has been created
> through the json: pseudo-protocol or blockdev-add.
>=20
> Note that the user-invokable reopen command is an HMP command, so you

s/invokable/invocable/

> can only specify strings there. Therefore, specifying a non-string
> option with the "same" value as it was when originally created will now=

> return an error because the values are supposedly similar (and there is=

> no way for the user to circumvent this but to just not specify the
> option again -- however, this is still strictly better than just
> crashing).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20

> +            /* TODO: When using -drive to specify blockdev options, al=
l values
> +             * will be strings; however, when using -blockdev, blockde=
v-add or
> +             * filenames using the json:{} pseudo-protocol, they will =
be
> +             * correctly typed.
> +             * In contrast, reopening options are (currently) always s=
trings
> +             * (because you can only specify them through qemu-io; all=
 other
> +             * callers do not specify any options).
> +             * Therefore, when using anything other than -drive to cre=
ate a BDS,
> +             * this cannot detect non-string options as unchanged, bec=
ause
> +             * qobject_is_equal() always returns false for objects of =
different
> +             * type.  In the future, this should be remedied by correc=
tly typing
> +             * all options.  For now, this is not too big of an issue =
because
> +             * the user simply can not specify options which cannot be=
 changed

Seeing "can not" usually looks wrong for "cannot"; but here, it is
grammatically correct.  But better would be "the user can simply not
specify" or "the user can simply avoid specifying options".

> +             * anyway, so they will stay unchanged. */

The grammar tweak is minor, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2UKniQ0KHN5K4v29pCR5VTEiaGjw6oU1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWj25AAoJEKeha0olJ0NqUjUH/0B1TY+6Jtgjdf1T1wXAB+Re
4E3X7F0kxERvL0Uz5rcjNszmnksdymVqaeypq3cZO16/N99VDqD/YO7rOSkUrOmY
7oNJCTgn1aK8YQ4/f0zvfgDK+AUfARzoq3iir43LrzHoGpNVec3bAcBSmJxq+2ro
uv+68SlsrQ/iZ9691iyEolrP8eQHJ4U0O6IJ0kroIkN0J4YQ/H+eTdjdctewNj24
oXz5Pppz9Si7wWVfmwaPrfLz7Up+u64Y000a3Bg1rTBjPelKBgwcWAuHFSaoqy9K
0H05GFPwi38HLlFpnsj2KDcvIdsGM19kgwhFT2v2uk7EKnBLxuRub2GnmrBbXoE=
=m1A6
-----END PGP SIGNATURE-----

--2UKniQ0KHN5K4v29pCR5VTEiaGjw6oU1G--
