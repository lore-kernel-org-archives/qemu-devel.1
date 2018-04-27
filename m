Received: from eggs.gnu.org ([2001:4830:134:3::10]:53117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5A7-0006Ho-DB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5A6-0003wX-K5
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:19:51 -0400
References: <20180427142002.21930-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5b0df82-8ab4-a4fe-3f47-a3be6a9536d2@redhat.com>
Date: Fri, 27 Apr 2018 10:19:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180427142002.21930-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a1EUOIHEGELD4Z8shAiwxPjd1mQBLJJjT"
Subject: Re: [Qemu-devel] [PATCH 0/2] fix coverity bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, den@openvz.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a1EUOIHEGELD4Z8shAiwxPjd1mQBLJJjT
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com,
 famz@redhat.com, stefanha@redhat.com, den@openvz.org,
 peter.maydell@linaro.org
Message-ID: <d5b0df82-8ab4-a4fe-3f47-a3be6a9536d2@redhat.com>
Subject: Re: [PATCH 0/2] fix coverity bugs
References: <20180427142002.21930-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180427142002.21930-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 09:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> Here are two bug fixes, thanks to Peter for reporting.
>=20
> Both are introduced in 2.12.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   nbd/client: fix nbd_negotiate_simple_meta_context
>   migration/block-dirty-bitmap: fix memory leak in
>     dirty_bitmap_load_bits

Reviewed-by: Eric Blake <eblake@redhat.com>

Adding both to my NBD queue

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--a1EUOIHEGELD4Z8shAiwxPjd1mQBLJJjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjP4MACgkQp6FrSiUn
Q2qLEwgAh9+kRcEGcGhkPF3cFxcASrVnAUhgIi3Z+OHDc1+/pnrhdD8qBEW0Sis4
O32WQRo+vTVvUH2WWgkq7Fd5H8xsiVyoNQbR5Y0rbnoqUWyW//nWgwrKLiD0xOgy
T+MbgH4rhxxBXLaQFMrcZOYuuyO6wP6AiuaVGh2HcpGzMzDPFQWONrOo8Xo2hvVz
CBWqQrrVSIMMDDiR2bkNu+abiNFRA7E+kJ+TnU89/k/uflsagQEkKW1pdnroAeXb
Cuf6a8T4A2FvMxAHbX+k4JlIJei58dNU3sMSzmPlu/bi/52xslDfgByTDb59/7H3
I+8T2Km168xVtUvawyMmrABcxx9+/w==
=6jHh
-----END PGP SIGNATURE-----

--a1EUOIHEGELD4Z8shAiwxPjd1mQBLJJjT--
