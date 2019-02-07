Received: from eggs.gnu.org ([209.51.188.92]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlID-0002V3-PK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlIB-00007h-Ng
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:08:45 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a40f5fe8-877f-4beb-dfe4-1265e1104130@redhat.com>
Date: Thu, 7 Feb 2019 09:08:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UxSZD9pkHiX6NXJi4lTiw9SyWGuCLDRFN"
Subject: Re: [Qemu-devel] [PATCH v3 06/17] block/stream: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UxSZD9pkHiX6NXJi4lTiw9SyWGuCLDRFN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <a40f5fe8-877f-4beb-dfe4-1265e1104130@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/17] block/stream: use
 QEMU_IOVEC_INIT_BUF
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new QEMU_IOVEC_INIT_BUF() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/stream.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--UxSZD9pkHiX6NXJi4lTiw9SyWGuCLDRFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcSeIACgkQp6FrSiUn
Q2oHsQf/Xiv0r4ma12IWXRwKtoqQllHCSHqeqwn+iAWOwQzurl7p8AbiiKqn0Wgt
yTq5MCyD3GK6EDbSlM04AvoEsjGX1vrpUcQgujW9FPwiPE44bOFuT2GNBnkVg+Hq
yu6tqD52rjMayWCBI10cQLLYfwx7yZqJFt0dKMKF8bp0xGvFrmGhMeeGSue0YGko
ZatpV1lt5/IEh67MqvlQ/GgL69ZTV5eXUS+jdWj3/I9gjTpL3VikV0/LFwlS24th
yZngEBDZKjoQR2MrTIe0cQLemN9VbN+qOMRN0R4xDNrxo2l8gf2iBQaR7dQxOwD3
ORtfZhUIRM42PfZsmo//MsrzuxZ4jw==
=YczE
-----END PGP SIGNATURE-----

--UxSZD9pkHiX6NXJi4lTiw9SyWGuCLDRFN--
