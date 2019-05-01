Received: from eggs.gnu.org ([209.51.188.92]:38715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLrSN-000583-2f
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLrSK-0002oA-1Z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hLrSJ-0002mz-PI
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:47:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B94A4CD001
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 15:47:34 +0000 (UTC)
References: <20190501145052.12579-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d27247ee-6fb7-5a5d-2720-f21f3382c075@redhat.com>
Date: Wed, 1 May 2019 10:47:30 -0500
MIME-Version: 1.0
In-Reply-To: <20190501145052.12579-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jkeRwep2eGkxEZahCXraThw6v4oH3inQs"
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid string truncation
 warnings when copying UNIX path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jkeRwep2eGkxEZahCXraThw6v4oH3inQs
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <d27247ee-6fb7-5a5d-2720-f21f3382c075@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid string truncation warnings
 when copying UNIX path
References: <20190501145052.12579-1-berrange@redhat.com>
In-Reply-To: <20190501145052.12579-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/1/19 9:50 AM, Daniel P. Berrang=C3=A9 wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from util/qemu-sockets.c:18:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builti=
n_strncpy=E2=80=99 specified bound 108 equals destination size [-Wstringo=
p-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qem=
u-sockets.c:880:5:
> /usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builti=
n_strncpy=E2=80=99 specified bound 108 equals destination size [-Wstringo=
p-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> We are already validating the UNIX socket path length earlier in
> the functions. If we save this string length when we first check
> it, then we can simply use memcpy instead of strcpy later, avoiding
> the gcc truncation warnings.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jkeRwep2eGkxEZahCXraThw6v4oH3inQs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzJv5IACgkQp6FrSiUn
Q2opswf5AbjGC4AfEmV1hhWZCbn/rM8i/fh9bQVoIicb8n3r+omPyFgvp0PPTFSD
qaQz4fGr+SoIRJ9D0Kyoxnq7bCbke1NZoLUGUdxEPawRMX8X8VmOnOTD7701Ajmb
OY2IVwlYHG9OcZMZvLNITMwFvjes30iTBjKR5BI7Em/X/duSfKReLa9pBoXjasDt
QIAf+bCHg8Zy8GxlqPoCRmuqzxv12JDiYY46ps2KU26RFLufim5eM3CS8CwT3eMH
K8AsDq0OG0Zb7plFms5Kf++LMzU2fI5HmNtF5Dk32Rnh2+jUs9hC8wDu2VdtggQ8
JSGMeq0KOsamLVNKCzv89yTDNpQxtA==
=U78n
-----END PGP SIGNATURE-----

--jkeRwep2eGkxEZahCXraThw6v4oH3inQs--
