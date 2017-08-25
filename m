Received: from eggs.gnu.org ([2001:4830:134:3::10]:57504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlM6Y-0008Jc-Vu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlM6X-0003nh-OZ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:25:26 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c6ebc5a-7e7f-212d-517b-e0d9a3f18692@redhat.com>
Date: Fri, 25 Aug 2017 16:25:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q3erWgG7pxn8ti7rMT8Gcq5X7b5owCTxG"
Subject: Re: [Qemu-devel] [PATCH 05/17] block/nbd-client: get rid of ssize_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q3erWgG7pxn8ti7rMT8Gcq5X7b5owCTxG
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <3c6ebc5a-7e7f-212d-517b-e0d9a3f18692@redhat.com>
Subject: Re: [PATCH 05/17] block/nbd-client: get rid of ssize_t
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use int variable for nbd_co_send_request return value (as
> nbd_co_send_request returns int).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q3erWgG7pxn8ti7rMT8Gcq5X7b5owCTxG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmglb0ACgkQp6FrSiUn
Q2pKlwf9Hf5PcC1n9vmglztoilMbcDzmYu3cIPzuZn+EQD34cF36evNBlRHyXaHJ
2KoircHVB9+AUpTEnolZoovGv0HrizVD9j/bjfVokhQbMPEVrNxy78hbJH0+ONg/
hV4DphBNs8ycPRGVtxoRKflXBrdR7t3uRKru5szD9Cy9XGOSCq5YLNYnLN3fV10f
Rj6JFnOVWWduB39wauDQGcd8Qgz8RuY99qv73TIJ+jTniMWfYrDozVvstIbJKGt5
1z14Gk0LwtyOtmq9KwsmP3Y/Z35gB5q8w8tX/m5ltaDU3febdd321ebpXCa5TkxU
HNPBst6TKKks0Md0yk/tGGs1sJcFRQ==
=Pk0C
-----END PGP SIGNATURE-----

--Q3erWgG7pxn8ti7rMT8Gcq5X7b5owCTxG--
