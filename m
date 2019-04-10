Received: from eggs.gnu.org ([209.51.188.92]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEF7n-0003MJ-QS
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEF7m-0004lW-TS
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:26:55 -0400
References: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6bd4c6e6-a7f1-99f4-c6bf-77099a49e4e1@redhat.com>
Date: Wed, 10 Apr 2019 17:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rcqxSIdXoJut0VCcInnsaDjQQNfxrJzqX"
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-img convert: ignore read errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rcqxSIdXoJut0VCcInnsaDjQQNfxrJzqX
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <6bd4c6e6-a7f1-99f4-c6bf-77099a49e4e1@redhat.com>
Subject: Re: [PATCH 0/2] qemu-img convert: ignore read errors
References: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.04.19 16:56, Andrey Shinkevich wrote:
> The 'qemu-img convert' new command option 'force read' with the key '-R=
'
> allows converting a damaged image to get all the available information
> in case of the read errors. The program reports read errors and continu=
e
> the image conversion. The users should keep in their minds that the
> resulting image is inconsistent.

I=E2=80=99ve already sent a series =E2=80=9CAdd salvaging mode to convert=
=E2=80=9D back in December.

Max


--rcqxSIdXoJut0VCcInnsaDjQQNfxrJzqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuCzIACgkQ9AfbAGHV
z0DMowgAipgl1FtpRlHE6Nuz7jr0zt3ErFmnNAnlaq4hWy3x8DnbCECoZWgf4WIz
GDQYdcMtb98gUL7p5bcpR76U11oaxOEKrtxj5JMRZkySlDwN8SnNeamTZ1UEYikc
1s0LBbhQrMQ41rC1sRKBSQLjOsT/ZJddZybDTm8tuxVxs+4pNe/fjOo+WVn7exRa
nnAWd+z5gw6L9voxrtrIOF9sfvx1RqXKkYmybCk6+O8QhzrBa2Fi1bbMUInvBGVI
E/zyHQ/ACDqiKUHzHtgUcbJMosa9EFzfhua4ozS66DDFO17gQUdR1XUy/EcQVvdT
0RyAM3UIIrBdhcfogWzB8wnneElqhg==
=DVBD
-----END PGP SIGNATURE-----

--rcqxSIdXoJut0VCcInnsaDjQQNfxrJzqX--
