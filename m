Received: from eggs.gnu.org ([209.51.188.92]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjnV3-0006kf-TL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjnV3-00087j-7L
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:53:05 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efeecb20-1589-6ece-e6a3-d7db850c9dd6@redhat.com>
Date: Wed, 16 Jan 2019 09:52:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2b3bK7L4NV1fd7rhDS2kfnhhdVsAUXcF9"
Subject: Re: [Qemu-devel] [PATCH v4 03/10] block/nbd-client: split
 connection from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2b3bK7L4NV1fd7rhDS2kfnhhdVsAUXcF9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <efeecb20-1589-6ece-e6a3-d7db850c9dd6@redhat.com>
Subject: Re: [PATCH v4 03/10] block/nbd-client: split connection from
 initialization
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Split connection code to reuse it for reconnect.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2b3bK7L4NV1fd7rhDS2kfnhhdVsAUXcF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/U1oACgkQp6FrSiUn
Q2o7wgf/SLosmledMaTfisXDCOJMTE4T8Fu1Eeu158yMbHtNmW0GiqXkBwkOJiTi
4PboJogmnooRWfOWs6q13lf5vdxHwK/yJGYjpguJK30asnJW5+gyND5IyAmhch34
iFbXdOVrvhw3tCOYwNaoLU3/ZVliCYPSpa/MCctNRL7Kl2Xlt+ycYmQjfw5umJeu
em7wYtVhKQ0ylsRWTiMukRX/VdScHDbm6uXUh0TXjcOcrqnjw29CAzZ9s/ArLf/K
UnpPrunX7suoUVs+Xin70Gm7zKcMt5C3k59YV4NzwrCHkIGTYoo9pYHTV0jsznZe
N/2dUoz6wM8WhTPvy976urJxG3+tkw==
=7pmn
-----END PGP SIGNATURE-----

--2b3bK7L4NV1fd7rhDS2kfnhhdVsAUXcF9--
