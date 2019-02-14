Received: from eggs.gnu.org ([209.51.188.92]:37689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJSx-000720-BA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJSv-0007zh-0F
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:02:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1guJSs-0007np-Se
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:02:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07A7EC0718A9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 16:01:57 +0000 (UTC)
References: <20190214152251.2073-1-armbru@redhat.com>
	<87h8d65r6k.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e51e4eac-419b-bea0-6eef-8805ca45ebd6@redhat.com>
Date: Thu, 14 Feb 2019 10:01:55 -0600
MIME-Version: 1.0
In-Reply-To: <87h8d65r6k.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrrByPr49E3diRijondLG6XGKhh8pCDT3"
Subject: Re: [Qemu-devel] [PATCH v5 00/18] qapi: add #if pre-processor
 conditions to generated code (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrrByPr49E3diRijondLG6XGKhh8pCDT3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <e51e4eac-419b-bea0-6eef-8805ca45ebd6@redhat.com>
Subject: Re: [PATCH v5 00/18] qapi: add #if pre-processor conditions to
 generated code (part 3)
References: <20190214152251.2073-1-armbru@redhat.com>
 <87h8d65r6k.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8d65r6k.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/14/19 9:24 AM, Markus Armbruster wrote:
> Diff from v4:
>=20

> +++ b/qapi/Makefile.objs
> @@ -18,8 +18,9 @@ util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-visit-=
%.o)
>  util-obj-y +=3D qapi-emit-events.o
>  util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-events-%.o)
> =20
> -common-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-commands-%.o)
> +common-obj-y =3D $(QAPI_COMMON_MODULES:%=3Dqapi-commands-%.o)

In other situations, use of =3D instead of +=3D has resulted in inadverte=
nt
omission of files. Should we just always use +=3D, rather than having to
remember to audit if the use of =3D is not overriding earlier lines?

> =20
> +obj-y =3D qapi-introspect.o

and again

>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-types-%.o)
>  obj-y +=3D qapi-types.o
>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-visit-%.o)
> @@ -28,4 +29,3 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)=

>  obj-y +=3D qapi-events.o
>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
>  obj-y +=3D qapi-commands.o
> -obj-y +=3D qapi-introspect.o
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LrrByPr49E3diRijondLG6XGKhh8pCDT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxlkPMACgkQp6FrSiUn
Q2rO3Af/UlDKUL9s8/oVU4/2YI1mkWJAyTnN9t4rihMvn3p/tIH4TLfZL/Nurxcb
zbO2gXxl9hRe0UoSUU/J+F9EvpfHpMBvz6hUFd5A8QKTVInMdkdeDXe4j7bY7YhS
NjEyHn9GdxLgyXjfL0zRTueXAPR0vSlwPhdP90sFvaQnOYOAWKms546v5dBWZGIH
5cF+5d5vElk8i1hdXZ0rtL0dnGmzOxXpurI6fUfyM0H3Iyu0sseJg4YTvF/ZP2+E
Lp0W63cCbD2kY8oxdBYy+4TTLtsDfAzkmu4yW3NnCjAp4hDUJuIWZNKUL71GZIox
cMJjHoa7gPYA5s4/YErVVpv+noXmyA==
=hNMO
-----END PGP SIGNATURE-----

--LrrByPr49E3diRijondLG6XGKhh8pCDT3--
