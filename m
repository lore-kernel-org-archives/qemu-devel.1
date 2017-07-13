Received: from eggs.gnu.org ([2001:4830:134:3::10]:44514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVc8T-0008AO-4v
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVc8S-0008Te-7P
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:18:21 -0400
References: <20170713100117.11961-1-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80884511-d2f6-1058-45cf-a84e44fa20d7@redhat.com>
Date: Thu, 13 Jul 2017 06:18:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170713100117.11961-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SIU83rmIWlxXjEBHBEOOH8qK3OOPciVDK"
Subject: Re: [Qemu-devel] [PATCH v5 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SIU83rmIWlxXjEBHBEOOH8qK3OOPciVDK
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <80884511-d2f6-1058-45cf-a84e44fa20d7@redhat.com>
Subject: Re: [PATCH v5 0/4] block: Block driver callbacks fixes
References: <20170713100117.11961-1-el13635@mail.ntua.gr>
In-Reply-To: <20170713100117.11961-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 05:01 AM, Manos Pitsidianakis wrote:
> This series makes implementing some of the bdrv_* callbacks easier for =
block
> filters by passing requests to bs->file if bs->drv doesn't implement it=
 instead
> of failing, and adding default bdrv_co_get_block_status() implementatio=
ns.
>=20
> This is based against Kevin Wolf's block branch, commit
> da4bd74d2450ab72a7c26bbabb10c6a287dd043e

Not quite the case, since...

>=20
> v5:
>   rebase against ced1484322 of https://github.com/XanClic/qemu.git bloc=
k to fix
>   apply conflicts

=2E..you rebased here instead ;)  But thanks for doing that!


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SIU83rmIWlxXjEBHBEOOH8qK3OOPciVDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ1bxAAoJEKeha0olJ0NqQV8H/3x6og4GgVcoPlJ9jIvpDS7i
yH79my8VcCazuDTieuXpNivQ2/UauopKMawJMNmv5g2z/r63moy3mJuCoHmNDOee
TQ1ex6Mr9mL4O7DgvqWjCJQLQtkMqgcBYfNah6/nFNJpVEnul2HZ8aE25apocX6h
hxUkyZC/TvQA5HVNGIjOjsv+OHBWK/m1d/0bXwH9VuH32LL9f5EVNZ81X2ev8Ja6
EzuJ7YjF1UmjFBxZknVwvroB/9UMQgVoVAxllmlF/g0YrFsaia15Gq/ynS9tPXjC
cwjb3Ml3mzKWuen30Az43i19ftVn6dqE8J81NFoqwLBI1SIN/Fbedt/1k1MqZGM=
=pbDh
-----END PGP SIGNATURE-----

--SIU83rmIWlxXjEBHBEOOH8qK3OOPciVDK--
