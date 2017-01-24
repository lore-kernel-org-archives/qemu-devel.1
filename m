Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW4Pv-0006ha-Ck
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW4Ps-0008Hh-CE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cW4Ps-0008H0-6K
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:57:56 -0500
References: <20170124105332.15992-1-lma@suse.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <750161d4-df3c-e079-758d-3d16417363dc@redhat.com>
Date: Tue, 24 Jan 2017 10:57:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170124105332.15992-1-lma@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0aLcoEbq63QSBGJnu547JjDIeno4W05Ia"
Subject: Re: [Qemu-devel] [PATCH] qmp: set accurate parameter name for error
 msg of device-list-properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0aLcoEbq63QSBGJnu547JjDIeno4W05Ia
From: Eric Blake <eblake@redhat.com>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <750161d4-df3c-e079-758d-3d16417363dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: set accurate parameter name for error
 msg of device-list-properties
References: <20170124105332.15992-1-lma@suse.com>
In-Reply-To: <20170124105332.15992-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2017 04:53 AM, Lin Ma wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---

The commit message is rather sparse; is there an easy formula for
triggering the error message, to give more context about the change?

>  qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qmp.c b/qmp.c
> index 0028f0b..812db6c 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -531,7 +531,7 @@ DevicePropertyInfoList *qmp_device_list_properties(=
const char *typename,
> =20
>      klass =3D object_class_dynamic_cast(klass, TYPE_DEVICE);
>      if (klass =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name", TYPE_DE=
VICE);
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYP=
E_DEVICE);
>          return NULL;
>      }
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0aLcoEbq63QSBGJnu547JjDIeno4W05Ia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYh4eQAAoJEKeha0olJ0Nqf+YH/32xdTHX6UAyGm6U0BL8KuS6
KR8DVBBhkCGRkRt4PDq6xYcVhqnyeGMLWisK0N3K2SKNKJzMjYlEBGluI5cCMKm4
cvn58UwypQ6AyQzu11s116DwRwHt55t9+casYhTdjMbFQlwSNsr54zhwJBGR6xHl
8bQ6tfrTF/YR/wEHc2I0WmUKptxtBoKrxfICcNW90a2msqJmzp9Wltx8GVVbSivR
ooABz2w7j0DaZw3RHvrBXdqLFFkN1j9P30iy6RyBaZQBxkrCDhhBHIdhzi21/UXd
m/mtxVol2ruKG9fEP3ENLUaCuWuz8XGKzkowh6C8UOgYU1Hkdsvaea4L32n/qIg=
=n35v
-----END PGP SIGNATURE-----

--0aLcoEbq63QSBGJnu547JjDIeno4W05Ia--
