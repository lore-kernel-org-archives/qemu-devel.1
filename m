Received: from eggs.gnu.org ([2001:4830:134:3::10]:48277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8zp-0001Nn-Nz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8zp-0002kW-0A
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:49:53 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<6ea11ae43c681181f86193352ef3527ff3f64f68.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ae01314-c748-dbab-ec3d-2f67f77124b9@redhat.com>
Date: Wed, 30 Aug 2017 14:49:45 -0500
MIME-Version: 1.0
In-Reply-To: <6ea11ae43c681181f86193352ef3527ff3f64f68.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tu2aU2fTKEbQcTvSKj5GidQx4P2csNLdR"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/curl: check error return of
 curl_global_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tu2aU2fTKEbQcTvSKj5GidQx4P2csNLdR
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <9ae01314-c748-dbab-ec3d-2f67f77124b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/curl: check error return of
 curl_global_init()
References: <cover.1504112061.git.jcody@redhat.com>
 <6ea11ae43c681181f86193352ef3527ff3f64f68.1504112061.git.jcody@redhat.com>
In-Reply-To: <6ea11ae43c681181f86193352ef3527ff3f64f68.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:57 AM, Jeff Cody wrote:
> If curl_global_init() fails, per the documentation no other curl
> functions may be called, so make sure to check the return value.
>=20
> Also, some minor changes to the initialization latch variable 'inited':=

>=20
> - Make it static in the file, for clarity
> - Change the name for clarity
> - Make it a bool
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/curl.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/curl.c b/block/curl.c

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tu2aU2fTKEbQcTvSKj5GidQx4P2csNLdR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnFtkACgkQp6FrSiUn
Q2q73wgApeJf2NurxhZiX6YEkBv0u1Sl4kc4hh5rhG2AMBKQtNlozJoLtj14rV8p
HYpoiNrCxwRH5LAam+wWZrQ7Or0bjznyFxEAbQC4JpOzZ2nap7RB39IjP9xjMA6x
2760cCcNLIM28xqgSuTsEfrc5I3ASKHta10OqYFTa628uQ3vJCeEt7/CYDAe2uIY
K14kxTgoTXQ11qX2v7GoXE5/ScQrXvIoDB2SNA2OzGD5aqsluwz4BjVY33tP8Umg
LP98igQt8ghjPpIvmtmEzuYBIvAVjHce6iQbJpZViAcp1toxzfjmF2c8ovFrYcBU
0bDW/7O9KLx5B5oONCX4PcR76bEawQ==
=HCLq
-----END PGP SIGNATURE-----

--tu2aU2fTKEbQcTvSKj5GidQx4P2csNLdR--
