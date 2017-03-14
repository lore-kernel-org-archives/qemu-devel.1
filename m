Received: from eggs.gnu.org ([2001:4830:134:3::10]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnpx7-00088e-Sj
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnpx3-0008G1-GP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnpx3-0008Fk-7r
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:09:37 -0400
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
	<1489508300-48184-19-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d75e465b-9775-348e-3cfd-ee20ec3f6154@redhat.com>
Date: Tue, 14 Mar 2017 12:09:34 -0500
MIME-Version: 1.0
In-Reply-To: <1489508300-48184-19-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dmfQT7MFxxr84xtG9fbnhL6khm5iVI6fk"
Subject: Re: [Qemu-devel] [PULL 18/18] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmfQT7MFxxr84xtG9fbnhL6khm5iVI6fk
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d75e465b-9775-348e-3cfd-ee20ec3f6154@redhat.com>
Subject: Re: [PULL 18/18] nbd/client: fix drop_sync [CVE-2017-2630]
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
 <1489508300-48184-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-19-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:18 AM, Paolo Bonzini wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Comparison symbol is misused. It may lead to memory corruption.
> Introduced in commit 7d3123e.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
> [eblake: add CVE details, update conditional]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.com>=


Encoding issues?

> Message-Id: <20170307151627.27212-1-eblake@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  nbd/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 5c9dee3..3dc2564 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size=
)
>      char small[1024];
>      char *buffer;
> =20
> -    buffer =3D sizeof(small) < size ? small : g_malloc(MIN(65536, size=
));
> +    buffer =3D sizeof(small) >=3D size ? small : g_malloc(MIN(65536, s=
ize));
>      while (size > 0) {
>          ssize_t count =3D read_sync(ioc, buffer, MIN(65536, size));
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dmfQT7MFxxr84xtG9fbnhL6khm5iVI6fk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCPOAAoJEKeha0olJ0NqGh8IAIhdVa14AyRPe0N0cWZBtXor
AcxN5FKXUKbFL78PHtuyjb1ZPEjcfz3PtSShzZ+Ng9OEmwOcHuN93WSnjMPIvCys
zgnxFom9SqlvD2BO0QO80aVnfEo/Qzuih1jbKw3lGqLR32SPp+ncIF+tf4lDXAx0
un/e2UN0x2dpKX8GRNy5vSAabKxKyQI1tqDwum4QSrHD3CiFLgSATELmJO34iKfK
MGd5HCR2RBD838ExzUET3I3Z0e8xr93wFQH2+fIEHrreXWcS+7GkYi1ldr0QcjWN
tC5Gd9B4fG95WA0vwQoBxk2us88W3/L71TbbrhuvgU+8IBlZvBGavVbFy7pfl80=
=CuuW
-----END PGP SIGNATURE-----

--dmfQT7MFxxr84xtG9fbnhL6khm5iVI6fk--
