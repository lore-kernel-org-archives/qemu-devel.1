Received: from eggs.gnu.org ([2001:4830:134:3::10]:50969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSsLW-00026T-2T
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSsLV-0006vZ-43
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:00:30 -0400
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04a2947d-183a-35a4-e235-6cecd64d9a42@redhat.com>
Date: Wed, 5 Jul 2017 17:00:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170703221456.30817-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TkFKsxkNal4qLqbGGTxaSkKFSkrrQjN3K"
Subject: Re: [Qemu-devel] [PATCH v2 01/15] block: add default
 implementations for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, el13635@mail.ntua.gr, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TkFKsxkNal4qLqbGGTxaSkKFSkrrQjN3K
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 el13635@mail.ntua.gr, Jeff Cody <jcody@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 jsnow@redhat.com
Message-ID: <04a2947d-183a-35a4-e235-6cecd64d9a42@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] block: add default implementations
 for bdrv_co_get_block_status()
References: <20170703221456.30817-1-eblake@redhat.com>
 <20170703221456.30817-2-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 05:14 PM, Eric Blake wrote:
> From: Manos Pitsidianakis <el13635@mail.ntua.gr>
>=20
> bdrv_co_get_block_status_from_file() and
> bdrv_co_get_block_status_from_backing() set *file to bs->file and
> bs->backing respectively, so that bdrv_co_get_block_status() can recurs=
e
> to them. Future block drivers won't have to duplicate code to implement=

> this.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> Message-Id: <20170629184320.7151-4-el13635@mail.ntua.gr>
>=20

Missing my Signed-off-by if we take this one in isolation through my
series, and still awaiting resolution on what will happen to the rest of
his series (v3 had some valid review comments that still need addressing)=


> ---
> v2: Including this patch from Manos, since it affects my later patches;=

> however, I anticipate that we will get a full v3 series from Manos
> merged first


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TkFKsxkNal4qLqbGGTxaSkKFSkrrQjN3K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXWFrAAoJEKeha0olJ0NqrMQH/jDD0k7cOWfaDoFYSjb/D0k/
mxEZJjNH51OlFwfbJQVJX31clCv07WegGvfeu+qlzgUjFP+TddPJ5FlLHpik3Z8Q
pTXyMp1ko6Wqhnb5YBPF6hCQHa6O1iDi6DcvIHuK6abSzDFoKkZoW0S+oAbOea12
BbkKy6N3+o97Ib5/LSm4oTREvM2dGCFlz3JOIdZPgQPm0+WxmXSdUznEfo4QQYRy
n1IhV2O9/3ewEXUudi78k1KWNmJbXsv9OZV4ZV6+oBJVo+ppGT/KLtX35SYTfm5l
obS4Z1elt0urk+8IFUEmuNK1WrNBkwnaEhZiOWp34EXP8X3AZsGIbmWSAg+PtCI=
=T/tY
-----END PGP SIGNATURE-----

--TkFKsxkNal4qLqbGGTxaSkKFSkrrQjN3K--
