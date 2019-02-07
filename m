Received: from eggs.gnu.org ([209.51.188.92]:50180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlWl-0004F4-0r
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlWk-0002W0-6z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:23:47 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-16-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d78f740-2b9a-0b89-0c9a-36f46bcca189@redhat.com>
Date: Thu, 7 Feb 2019 09:23:11 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-16-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8J70mj3CStPGlMOHWjliWUCkRwKN9jqjA"
Subject: Re: [Qemu-devel] [PATCH v3 15/17] hw/ide: drop iov field from
 IDEState
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
--8J70mj3CStPGlMOHWjliWUCkRwKN9jqjA
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <9d78f740-2b9a-0b89-0c9a-36f46bcca189@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 15/17] hw/ide: drop iov field from
 IDEState
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-16-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> @iov is used only to initialize @qiov. Let's use new
> qemu_iovec_init_buf() instead, which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/hw/ide/internal.h | 1 -
>  hw/ide/atapi.c            | 9 ++++-----
>  hw/ide/core.c             | 8 ++------
>  3 files changed, 6 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8J70mj3CStPGlMOHWjliWUCkRwKN9jqjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcTV8ACgkQp6FrSiUn
Q2oKVQf/T/gTckVf/8zhmhWrjIE4a/gHs9xkDAqsGM16HFTH6C99LNV9EqQdAgrU
Uqdr7bzry9i6iHjOqUdTZgpd2Hb0koZAIa+QEFhigz4JOIKA8qh3dOC3Z9zRa98Z
EdbiS8i1TmQPGzaAMBhe/AwCjusiupJiU5/14i4b/KsV0+GPGvymMy0ald7ITb9u
Ae0e4cubFgEaKvujQABXH5ymKY3WtjBUwsD08ehAZ+kMzHQR3KFrz9JThkKOECoS
iUSd9tfULvkC1W845VTDR7O+Zcrht+yrede0gX+TC0CYy/uC4eWYYVeJByDcfac5
95WmZ2xpFYfCxN993ddxCy/G0uPVuw==
=KaMV
-----END PGP SIGNATURE-----

--8J70mj3CStPGlMOHWjliWUCkRwKN9jqjA--
