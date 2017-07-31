Received: from eggs.gnu.org ([2001:4830:134:3::10]:37626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcDLq-0003XK-5d
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcDLm-0001fL-Pz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcDLm-0001f9-Fr
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:15:22 -0400
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
	<20170731160135.12101-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2af88b8d-9d59-72bf-bd25-b83fbba726f4@redhat.com>
Date: Mon, 31 Jul 2017 11:15:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170731160135.12101-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aK555nICScciLjnH0MCAggW0FTUg97XBf"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] trace-events: fix code style: %# ->
 0x%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aK555nICScciLjnH0MCAggW0FTUg97XBf
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com,
 cohuck@redhat.com
Message-ID: <2af88b8d-9d59-72bf-bd25-b83fbba726f4@redhat.com>
Subject: Re: [PATCH v3 2/4] trace-events: fix code style: %# -> 0x%
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
 <20170731160135.12101-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170731160135.12101-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 11:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> In trace format '#' flag of printf is forbidden. Fix it to '0x%'.
>=20
> This patch is created by the following:
>=20
> check that we have a problem
>> find . -name trace-events | xargs grep '%#' | wc -l
> 56
>=20
> check that there are no cases with additional printf flags before '#'
>> find . -name trace-events | xargs grep '%[-+ 0'I]+#' | wc -l

That's not the actual command you used; maintainer can fix the typo by
using "%[-+ 0'I]+#" instead.

> 0
>=20
> check that there are no wrong usage of '#' and '0x' together
>> find . -name trace-events | xargs grep '0x%#' | wc -l
> 0
>=20
> fix the problem
>> find . -name trace-events | xargs sed -i 's/%#/0x%/g'
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aK555nICScciLjnH0MCAggW0FTUg97XBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/V4QACgkQp6FrSiUn
Q2pPxQf/QQNSyaj1TL6ya5/5DvIAwgG3AJuDKn5pxlmtKecRjz0FPcd7zzxjd89h
sWXps3W0hUXA3TLldIFmLXEqcDtrT5MJLhIwvzCs54DjR9WVoG5FjQC8kBEIw+kV
ymg+AIJjfaEM5FFfG1de66M95yYhb7JhMJ69FxBcr/F0CE36hsvqZ5u1GdpXLcxY
/LRtW3ttII6sevpaD/Tv5RHDlH0YhFfoER4cx5eIHl0rtCFXWqyawI7DJEZemo00
guDrQk30Eydy8UCPjJjXfY9F7zs5PtAio4FO7AyMr4iQuiGhkIC53Vw82mn8J0oG
Ozh1VsrZbfpG1/gO4siZpu7xCKQC4g==
=VvYy
-----END PGP SIGNATURE-----

--aK555nICScciLjnH0MCAggW0FTUg97XBf--
