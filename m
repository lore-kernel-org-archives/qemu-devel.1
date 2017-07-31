Received: from eggs.gnu.org ([2001:4830:134:3::10]:33738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcA7O-0004Rc-N9
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcA7K-0004Yc-Hm
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:48:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcA7K-0004XX-8B
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:48:14 -0400
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77d164e6-e0e7-2a7d-65e7-8bbb1eb0a44a@redhat.com>
Date: Mon, 31 Jul 2017 07:48:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170729131159.24949-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1DseAeWcSG5ggvJk4q9OkWRaw8RIAeqbt"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] trace-events: fix code style: %# ->
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
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1DseAeWcSG5ggvJk4q9OkWRaw8RIAeqbt
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com
Message-ID: <77d164e6-e0e7-2a7d-65e7-8bbb1eb0a44a@redhat.com>
Subject: Re: [PATCH v2 2/4] trace-events: fix code style: %# -> 0x%
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
 <20170729131159.24949-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170729131159.24949-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/29/2017 08:11 AM, Vladimir Sementsov-Ogievskiy wrote:
> In trace format '#' flag of printf is forbidden. Fix it to '0x%'.
>=20
> This patch is created by the following:
>=20
> check that we have a problem
>> find . -name trace-events | xargs grep '%#' | wc -l
> 56
>=20
> check that there are no cases with additional printf flags
>> find . -name trace-events | xargs grep '%[-+ 0]+#' | wc -l
> 0

Missing a check for the ' flag required by POSIX (but not C99); although
we don't use that either.

>=20
> check that there are no wrong usage of '#' and '0x' together
>> find . -name trace-events | xargs grep '0x%#' | wc -l
> 0
>=20
> fix the problem
>> find . -name trace-events | xargs sed -i 's/%#/0x%/g'
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1DseAeWcSG5ggvJk4q9OkWRaw8RIAeqbt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/JwgACgkQp6FrSiUn
Q2qXmQf/UUgBcElBo7VJL8Cz5tC5oJl0MV8mibnhO821Bw9O52fZPkf5vjzx9+Hk
FWQOkwiltnYTnUa2yOvHxXAIc0PViihKtjH3kEpF+159si3drkyU51nZoCdesCUl
X4BQRk7txLtkAtNCXPFW4cyc47GLyDOxvRtJRdRuzI2Lvxj/rod/3RgLH1XdJgDk
uHx7BB8/Bz2OBX/I+HhingylmFCwl4CFa4UWUWHIkYxTQ/stdA49mBluc9sgOI+j
boZNhtgAQs0i3q+Qj1lo3PHp41eYpRq9cFEMWHn+D2OqkkudGp/uskjJb+Qsaw/P
FLsd7RbxqFtEiVvNl91RkN0CqawH/g==
=o3+/
-----END PGP SIGNATURE-----

--1DseAeWcSG5ggvJk4q9OkWRaw8RIAeqbt--
