Received: from eggs.gnu.org ([2001:4830:134:3::10]:57999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRkhO-0002WQ-7o
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRkhL-0001nY-2q
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:06:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRkhK-0001nS-QI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:06:07 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8F5361B91
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 19:06:06 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-20-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e805da6b-ad8d-8cdb-f947-20e0d0096465@redhat.com>
Date: Thu, 12 Jan 2017 13:06:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-20-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j3icLXq5vvPgOHHSe32XfKBv2JfRMP5Ak"
Subject: Re: [Qemu-devel] [PATCH 19/40] char: move to chardev/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j3icLXq5vvPgOHHSe32XfKBv2JfRMP5Ak
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <e805da6b-ad8d-8cdb-f947-20e0d0096465@redhat.com>
Subject: Re: [PATCH 19/40] char: move to chardev/
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> The following commits will split char.c in several files. Let's put the=
m
> in a subdirectory.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c =3D> chardev/char.c | 0

Yay - one less file in the top level :)

>  MAINTAINERS                   | 2 +-
>  Makefile.objs                 | 2 +-
>  chardev/Makefile.objs         | 1 +
>  tests/Makefile.include        | 6 +++---
>  5 files changed, 6 insertions(+), 5 deletions(-)
>  rename qemu-char.c =3D> chardev/char.c (100%)
>  create mode 100644 chardev/Makefile.objs
>=20

> +++ b/tests/Makefile.include
> @@ -9,7 +9,7 @@ SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir =
\
>  check-unit-y =3D tests/check-qdict$(EXESUF)
>  gcov-files-check-qdict-y =3D qobject/qdict.c
>  check-unit-y +=3D tests/test-char$(EXESUF)
> -gcov-files-check-qdict-y =3D qemu-char.c
> +gcov-files-check-qdict-y =3D chardev/char.c
>  check-unit-y +=3D tests/check-qfloat$(EXESUF)
>  gcov-files-check-qfloat-y =3D qobject/qfloat.c
>  check-unit-y +=3D tests/check-qint$(EXESUF)
> @@ -489,7 +489,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(t=
est-util-obj-y)
>  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test=
-qom-obj-y)
>  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-q=
om-obj-y)
> =20
> -tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $=
(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
> +tests/test-char$(EXESUF): tests/test-char.o chardev/char.o qemu-timer.=
o $(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)

Pre-existing so you just kept it, but maybe we should use \ line
wrapping to avoid long lines.

With or without wrapping,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--j3icLXq5vvPgOHHSe32XfKBv2JfRMP5Ak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYd9OcAAoJEKeha0olJ0Nq5uQH/1tFCPtc/zJFGSY1w8GJ3uff
RWcrxfXzQCx+y8lLx24SVgoVFNF9BQcifE02b2fl4L8GwahPqWks/jyEMHn887VW
kf0UzGck+T0cUk+HqfV+lTnCNqMqJqq1sReyPw8q+otGrHxE+9YzeuJI26ftJ14M
bRqLNIFs5I3L4wPprHotFFz8xG4AGgSJZan3YJUWQ/fSWZ8XjRyCqA8MeH37py+B
3n5/sl5W1/ZppEaIc0j+8Zr7SxML2jqTAUk5iB8ZFc/forX8pOfTrmEIFZBVWP7T
U8QLK/8zC2NkBKYt2StBP1nCPiKr/vLeVSzuL5hZnkLEN6ikOccVt+sy82Birw4=
=lAGS
-----END PGP SIGNATURE-----

--j3icLXq5vvPgOHHSe32XfKBv2JfRMP5Ak--
