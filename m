Received: from eggs.gnu.org ([209.51.188.92]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIzan-0007XT-5h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIzal-0005rF-Lu
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:52:28 -0400
References: <20190423160608.7519-1-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1db3bb5-6028-e8a4-f56b-fdd22215688f@redhat.com>
Date: Tue, 23 Apr 2019 12:52:18 -0500
MIME-Version: 1.0
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr"
Subject: Re: [Qemu-devel] [PATCH] net: Print output of "-net nic,
 model=help" to stdout instead of stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <f1db3bb5-6028-e8a4-f56b-fdd22215688f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net: Print output of "-net nic, model=help"
 to stdout instead of stderr
References: <20190423160608.7519-1-thuth@redhat.com>
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Markus, as he send a recent batch of similar patches]

On 4/23/19 11:06 AM, Thomas Huth wrote:
> We are printing all other help output to stdout already (e.g. "-help",
> "-cpu help" and "-machine help" output). So the "-net nic,model=3Dhelp"=

> output should go to stdout instead of stderr, too. And while we're at
> it, also print the NICs line by line, like we do it e.g. with the
> "-cpu help" or "-M help" output, too.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1574327
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/net/net.c b/net/net.c
> index f3a3c5444c..2cf5e76469 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -837,9 +837,10 @@ int qemu_show_nic_models(const char *arg, const ch=
ar *const *models)
>          return 0;
>      }
> =20
> -    fprintf(stderr, "qemu: Supported NIC models: ");
> -    for (i =3D 0 ; models[i]; i++)
> -        fprintf(stderr, "%s%c", models[i], models[i+1] ? ',' : '\n');
> +    printf("Supported NIC models:\n");
> +    for (i =3D 0 ; models[i]; i++) {
> +        printf("%s\n", models[i]);
> +    }
>      return 1;
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly/UNIACgkQp6FrSiUn
Q2pLsggAoZ110sQJBNhz05OBWHy7JQ9Fa1S7rcjEfhDM7BA68oj3X3VzxcPVVsv0
jo+mBKTVryVMqKpv1RCziPWbo/tHJvMnERHHqX+24zXeztLaxD0H/JjxvrA/I2EA
nPqARjEFpTtwKLBx5+j/+A6W5z66GZy3goqWor17Bs9nyVPa811N9LhsCGNVT//M
1IMASrN1dE0k8R4d+0xwbJdt7COZHP8UJv41zG+TRFEyZcIO8EbgoE4QVoxQYSIy
Ounyiz5t9gXKSHWdTxuc0U7LTNTxMf49920wIdunddj/7ZqIG4NTZTlDSt7MPnbg
1yzTX7IZRVYg4KLiquREl86qyo/uzA==
=/CYd
-----END PGP SIGNATURE-----

--oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr--
