Received: from eggs.gnu.org ([2001:4830:134:3::10]:53687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecHQR-0008Je-Pj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecHQQ-0003eW-NT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:08:43 -0500
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
	<20180118181123.37056-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35482a43-af44-9134-f112-30cf0cb135be@redhat.com>
Date: Thu, 18 Jan 2018 15:08:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180118181123.37056-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="El0QqorFPRN1ACMZyi0RSIIP3TpiTXghI"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] hmp: add name parameter to
 nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--El0QqorFPRN1ACMZyi0RSIIP3TpiTXghI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <35482a43-af44-9134-f112-30cf0cb135be@redhat.com>
Subject: Re: [PATCH v2 2/6] hmp: add name parameter to nbd_server_add
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
 <20180118181123.37056-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180118181123.37056-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
> Support name parameter for HMP too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hmp.c           | 3 ++-
>  hmp-commands.hx | 9 +++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20

> +++ b/hmp-commands.hx
> @@ -1553,8 +1553,8 @@ ETEXI
> =20
>      {
>          .name       =3D "nbd_server_add",
> -        .args_type  =3D "writable:-w,device:B",
> -        .params     =3D "nbd_server_add [-w] device",
> +        .args_type  =3D "name:-n,writable:-w,device:B",
> +        .params     =3D "nbd_server_add [-n] [-w] device",

Doesn't quite look like my proposal:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01639.html

-        .args_type  =3D "writable:-w,device:B",
-        .params     =3D "nbd_server_add [-w] device",
+        .args_type  =3D "writable:-w,device:B,name:s?",
+        .params     =3D "nbd_server_add [-w] device [name]",

In fact, using -n is not quite right, because that's just a boolean flag
rather than a string.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--El0QqorFPRN1ACMZyi0RSIIP3TpiTXghI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphDNQACgkQp6FrSiUn
Q2o+PQf/comG2aRAsofqTElwa3baISooph8lex4tq0uNlema2Bg6NKeO/Ex1KRBD
Zq4Jz7e5w0uGfeH17JdbvAbYAWUSNHSPwuEQ/93fuI+n/5XsdGHDsOVEId1SvBzd
wbn5D0/e5EhfNEXpJdtLGKNA6ki+Xv0Flj2UgG3xSjaD/K5P+sXEIop9fM74YX7h
pHeTRVdttTyvgq04T/1o9KkVpGDmlqRZpNryDnccQkBjsHiTbzMGpKZrXJEd1q+E
nec3iVCrrHj4sb+MgZkA+KLpghimKkYp6sUiFymPLE4S0PISo2aMX/FGTOwr9zEV
CtigtKtTPpm0l1ZoLZyDRHavgAWzYw==
=QU+u
-----END PGP SIGNATURE-----

--El0QqorFPRN1ACMZyi0RSIIP3TpiTXghI--
