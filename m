Received: from eggs.gnu.org ([209.51.188.92]:46527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm4VN-000313-Bx
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm4Ty-00070v-1m
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:25:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm4Tx-0006zM-PG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:25:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ECFAA0C2B
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 22:25:20 +0000 (UTC)
References: <20190122144103.18310-1-pagupta@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1d15efe-8653-8e47-acf5-b8839f84db19@redhat.com>
Date: Tue, 22 Jan 2019 16:25:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190122144103.18310-1-pagupta@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MMs2ZQRggcvCjLcITS9TL2EbwcAriojhI"
Subject: Re: [Qemu-devel] [PATCH] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, xiaohli@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MMs2ZQRggcvCjLcITS9TL2EbwcAriojhI
From: Eric Blake <eblake@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, xiaohli@redhat.com, pbonzini@redhat.com
Message-ID: <d1d15efe-8653-8e47-acf5-b8839f84db19@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev: Avoid adding duplicate chardev
References: <20190122144103.18310-1-pagupta@redhat.com>
In-Reply-To: <20190122144103.18310-1-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 8:41 AM, Pankaj Gupta wrote:
> Hotplugging existing char chardev with qmp, dereferences(removes)=20
> existing chardev. This patch avoids adding a chardev if a chardev=20
> with same id exists.
>=20

> +++ b/chardev/char.c
> @@ -985,6 +985,12 @@ ChardevReturn *qmp_chardev_add(const char *id, Cha=
rdevBackend *backend,
>      ChardevReturn *ret;
>      Chardev *chr;
> =20
> +    chr =3D qemu_chr_find(id);
> +    if (chr) {
> +        error_setg(errp, "Chardev '%s' already exist", id);

s/exist/exists/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MMs2ZQRggcvCjLcITS9TL2EbwcAriojhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHmE4ACgkQp6FrSiUn
Q2oN+QgAgV0W41o2MsyKEnpAUBwITyeOL/3dARDxhTgdm1CrjW2xa8CDwP87F6dA
z2CMQe3of4rQKR95UuTifke4M9zTZ84bmBWBInjTpa+Yjam0kpHTw+KHvpUfDwMH
eQZ8SktnVtIghAgu1XCil8ptIxT5yDepwpKIvSJvyU/wSJUaveMqRrMA5f6SaO3R
iCFMNBBUVkCpoHFqKMPvsLUC4ZythoG19UUSPoE0OTlq58vdIoIr6hUXWRPWTjYY
Rq445RbBFUUJ3QuwewyKZXJgOugmUIR55PP/7pn/r96tWaaDEiadwc20vULpRQAX
A845U11bGbhldBFNUL4z5vs+vPkvGQ==
=gwbJ
-----END PGP SIGNATURE-----

--MMs2ZQRggcvCjLcITS9TL2EbwcAriojhI--
