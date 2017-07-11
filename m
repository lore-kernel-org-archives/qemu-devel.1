Received: from eggs.gnu.org ([2001:4830:134:3::10]:37365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUyez-0005A5-9l
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUyey-0007Om-5Y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:09:17 -0400
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-3-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8bcff15-2d6c-bca9-cd44-b03ddf7d7812@redhat.com>
Date: Tue, 11 Jul 2017 12:09:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170711163748.17817-3-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mg2TTdCJ5Hs8ge8EOPl3oCdRSWwUH6cXt"
Subject: Re: [Qemu-devel] [PATCH v4 2/4] block: remove bdrv_media_changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mg2TTdCJ5Hs8ge8EOPl3oCdRSWwUH6cXt
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <b8bcff15-2d6c-bca9-cd44-b03ddf7d7812@redhat.com>
Subject: Re: [PATCH v4 2/4] block: remove bdrv_media_changed
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
 <20170711163748.17817-3-el13635@mail.ntua.gr>
In-Reply-To: <20170711163748.17817-3-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
> This function is not used anywhere, so remove it.
>=20

Might be interesting to figure out when it WAS last used.  If I grepped
correctly, it was commit 21fcf360 back in May 2012?

> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 14 --------------
>  block/raw-format.c        |  6 ------
>  include/block/block.h     |  1 -
>  include/block/block_int.h |  1 -
>  4 files changed, 22 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mg2TTdCJ5Hs8ge8EOPl3oCdRSWwUH6cXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZQYvAAoJEKeha0olJ0Nqp1IH/082+7pd862Vm4tN40n2iALs
daj2aXMXylrv71oJnFJdSMiV8YC8fO3Zdv420rlb+EIGVRNVApvV4FKdtXJF6Gau
ksxqPOz1+4/dVeNm/kIvC+3KYZ2pYMIYRL+861LDO/DPpqBKDHbD0IpDtdeGsvxl
MeDQlYw+l4N2cx/v8SqwI3Hy5wZ4PSInyaxPgm9sEFsy9Pf3oAFYryMuzAiERUbx
DAQWPCAa0KJbtGjIQytJP94MYECTJ9bYgKjwjJA0A+Ecl3tMDIFOLhTK4CzwCGYz
JaoaO4DIt8MWs8zhFOp9EUcTneQkcMKAurWISsTVM2oNSLUWK4GmKwZTLvJbAQQ=
=F7Ys
-----END PGP SIGNATURE-----

--mg2TTdCJ5Hs8ge8EOPl3oCdRSWwUH6cXt--
