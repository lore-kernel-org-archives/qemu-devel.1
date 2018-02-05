Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eiisg-0001KB-9T
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eiisf-00006g-D2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:40:30 -0500
References: <20180205125023.12394-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce6a6439-2a00-57d2-8dea-8a1f03df87bf@redhat.com>
Date: Mon, 5 Feb 2018 09:40:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180205125023.12394-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cr6pms7XWbhROY54qHegdc1CKxg4viozz"
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support only raw format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cr6pms7XWbhROY54qHegdc1CKxg4viozz
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <ce6a6439-2a00-57d2-8dea-8a1f03df87bf@redhat.com>
Subject: Re: [PATCH] iotests: 205: support only raw format
References: <20180205125023.12394-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180205125023.12394-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 06:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> The test is about qmp interface to NBD server, so there no reasons
> to run it for various disk formats. Also it actually do not support
> luks format, so, disable all format except raw.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/205 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
> index 10388920dc..a78ff37104 100644
> --- a/tests/qemu-iotests/205
> +++ b/tests/qemu-iotests/205
> @@ -153,4 +153,4 @@ class TestNbdServerRemove(iotests.QMPTestCase):
> =20
> =20
>  if __name__ =3D=3D '__main__':
> -    iotests.main()
> +    iotests.main(supported_fmts=3D['raw'])

Isn't that stricter than necessary?  The test works with qcow2; it was
just luks that was special (because we weren't passing in proper
secrets).  At any rate, I'm adding Dan in case he has a quick idea of
what it would take to get luks working, rather than just disabling it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Cr6pms7XWbhROY54qHegdc1CKxg4viozz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp4euQACgkQp6FrSiUn
Q2rG4AgAi5kcwsIdF3GdVXYpdWGusZarEPK4nxSm+dSwDV4Cvdt7QBhz5srYEV0J
DBScwO8rR4JyoJW5+3zQQQecistGC5ImOUMKM29NtK4tbzhG13n5f+UFHjZ39d0s
VrPOTfhZR7LiusvgYeNTGBvLzP1R//mEtpQbP0+GPxhr/UOG5iWR+Sw78bgDa8EL
bZwzsPZLfV3+sueBTjM5+oIyb7PHCj299MI3dzzaldfeJIwtVyYYLQtn02AbpGM+
u+pJHnEt07Ffk3iNXg50ObNQxxFAeotevyQZlCAD0HQpgriml9Uf50Ah8dttJW9M
GWS1EE+zScnW6pp1tHkE4a2R3Zu+dg==
=5Sx7
-----END PGP SIGNATURE-----

--Cr6pms7XWbhROY54qHegdc1CKxg4viozz--
