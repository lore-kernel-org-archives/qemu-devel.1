Received: from eggs.gnu.org ([209.51.188.92]:38085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Z8u-0005Yr-7l
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Z8t-0002om-Dl
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:11:40 -0500
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d582055f-6ee7-ad62-e178-023a283f89dd@redhat.com>
Date: Wed, 6 Mar 2019 10:11:34 -0600
MIME-Version: 1.0
In-Reply-To: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j3Rff7cJ1gDBLZnWptUiBnsBG1uV50f9A"
Subject: Re: [Qemu-devel] [PATCH 0/4] nbd: non-blocking negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j3Rff7cJ1gDBLZnWptUiBnsBG1uV50f9A
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <d582055f-6ee7-ad62-e178-023a283f89dd@redhat.com>
Subject: Re: [PATCH 0/4] nbd: non-blocking negotiation
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 6:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> Here is a try of moving to non-blocking negotiation in nbd
> code, proposed by Deniel in
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03817.html
>=20
> in thread "[PATCH v4 00/10] NBD reconnect"
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg05973.html
>=20
> Vladimir Sementsov-Ogievskiy (4):
>   io/channel: add qio_channel_get_attached_aio_context()
>   nbd/client: do negotiation in coroutine
>   nbd: do qemu_coroutine_yield during tls handshake
>   block/nbd-client: use non-blocking io channel for nbd negotiation

Will there be a v2 of this series?  Soft freeze for 4.0 is coming up
very rapidly, so I'm trying to gauge if this is still 4.0 material (and
I should hold off my NBD queue for a chance to include it) or if it is
more likely to slip into 4.1 (and I should post my NBD pull request
sooner to avoid burdening Peter with a last-minute rush next week).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--j3Rff7cJ1gDBLZnWptUiBnsBG1uV50f9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/8TcACgkQp6FrSiUn
Q2rAyQgAl4V17O7bHcw6LFo44yqRuc9wcsTxUWx9Xpn2DVAwCRCw0Cc0vDz2A6c7
BQv2XdxMPbwpJ5byalP3UEadEMihhXUpFViO42TkxbNPtAigknYftKW89Ggueszr
uZ/IiktjF6172/Tw4gTiuMr6qH/yBUqf/umLUTWcO3klyXNS9YSfTjPobD8mcR1y
WgNmXn12220FluYs+JrIm1uMIfpxaBBbcA7KHfUUfuYGqlaDRTcCtTkaWGasSP5X
yKbPbWHImtOIYSm2u5kp5cDeuQqu3/cwRWQsPJFeX2kXzMWx4ZTZVU2Fi+29EloY
bIMQLpY/XmY2c425UV+X7iyECSdvQQ==
=hiJ9
-----END PGP SIGNATURE-----

--j3Rff7cJ1gDBLZnWptUiBnsBG1uV50f9A--
