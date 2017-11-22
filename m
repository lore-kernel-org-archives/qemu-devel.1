Received: from eggs.gnu.org ([2001:4830:134:3::10]:50578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHZfc-0004B3-Pu
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHZfb-0002l8-Tl
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:22:48 -0500
References: <6d62e07f-af78-e3bf-5765-1d3e5dba341e@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b7dd044b-3671-7027-6d24-f24863ba5126@redhat.com>
Date: Wed, 22 Nov 2017 19:22:35 +0100
MIME-Version: 1.0
In-Reply-To: <6d62e07f-af78-e3bf-5765-1d3e5dba341e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="isOeeWXwMjDd17Qs86kgqXh975Fn39J1d"
Subject: Re: [Qemu-devel] qemu iotest 020 failing for vmdk after 2b7731938d9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Lukas Doktor <ldoktor@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--isOeeWXwMjDd17Qs86kgqXh975Fn39J1d
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Lukas Doktor <ldoktor@redhat.com>
Message-ID: <b7dd044b-3671-7027-6d24-f24863ba5126@redhat.com>
Subject: Re: qemu iotest 020 failing for vmdk after 2b7731938d9
References: <6d62e07f-af78-e3bf-5765-1d3e5dba341e@redhat.com>
In-Reply-To: <6d62e07f-af78-e3bf-5765-1d3e5dba341e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-21 23:16, John Snow wrote:
> Commit 2b7731938d9 adds a blkdebug driver test for failing commits, but=

> the vmdk driver doesn't appear to appreciate this format:
>=20
> +_qemu_img_wrapper create -f vmdk -b "json:{'driver': 'raw',
> +                         'file': {
> +                             'driver': 'blkdebug',
> +                             'inject-error': [{
> +                                 'event': 'write_aio',
> +                                 'errno': 28,
> +                                 'once': true
> +                             }],
> +                             'image': {
> +                                 'driver': 'null-co'
> +                             }}}"
> "/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/t.vmdk"
> +qemu-img: TEST_DIR/t.IMGFMT: Could not create image: Invalid argument
>=20
>=20
> ...so;
>=20
> (A) VMDK should be dropped from 020, or
> (B) This sub-test should be rewritten, or
> (C) This sub-test should be split out into a new unit where VMDK can be=

> dropped.
>=20
> I don't like (A) very much because I like testing our weird formats whe=
n
> possible, I don't like (B) very much because I don't really like
> wrangling QMP commands inside of the bash unit tests.
>=20
> (C) Could work; though it's odd to have it away from its kin in 020.

The issue is not blkdebug, the issue is that the backing file is not in
vmdk format (because it's a null-co node at heart).

I can make it a VMDK, but that'll be fun either when specifying the
backing file file.image node because this test is supposed to work with
all protocols but NFS; or I'll have to resort to the gold old
blkdebug:conf:file syntax...  But why not, it works.

Now I'll just have to figure this out:

-qemu-img: Block job failed: No space left on device
+Image committed.

:-/

Max


--isOeeWXwMjDd17Qs86kgqXh975Fn39J1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloVwGsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdwEH/0d2tpb2gCckDfaKxnBhRWbXkAk7vXgE
OC1YhsAh/z88ywfAmxuY0bTXYu+R2rY0SPOZ0f7iX+ELR8iWvJLO/V6TPuz5jmNG
YUlr5UHvHXe1pTlkZnxC6ch79fut5E151bQ1fP7bOVV24u56vMKbduJTdBmszk/1
TCEBXGKxmTvD4m6H0w0YSp+hjP7IyTgY8dqF+6RQh3rj01tfYKVC4L3UbpyoVbgx
eXvjO3Nw9Bew0NPs5IC5CBV5ElZK1Dl7JamMsKf06nyqmbaQXq3nMS1PKEhLhgYZ
sQVdMAG3k+Tv10AkcxyKGgSJEQoU2y/D4Q3OjfQUhvxyi2oBXWBhLlM=
=sAun
-----END PGP SIGNATURE-----

--isOeeWXwMjDd17Qs86kgqXh975Fn39J1d--
