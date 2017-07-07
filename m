Received: from eggs.gnu.org ([2001:4830:134:3::10]:46628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVVx-0004S4-DM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVVt-0002wv-JT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVVt-0002wd-AA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:49:49 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3309e31-4cd3-ec58-e5c0-01b79631fe6e@redhat.com>
Date: Fri, 7 Jul 2017 10:49:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ffV5s5wGh60qpjoGr03UDbUHiTJpU1CLB"
Subject: Re: [Qemu-devel] [PATCH v3 06/10] nbd/client: refactor TRACE of
 NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ffV5s5wGh60qpjoGr03UDbUHiTJpU1CLB
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <e3309e31-4cd3-ec58-e5c0-01b79631fe6e@redhat.com>
Subject: Re: [PATCH v3 06/10] nbd/client: refactor TRACE of NBD_MAGIC
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are going to switch from TRACE macro to trace points,
> this TRACE complicates things, this patch simplifies it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ffV5s5wGh60qpjoGr03UDbUHiTJpU1CLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX62YAAoJEKeha0olJ0NqrBwH/2IObK0wKlNEYlfaMXkSM8L/
+2R7Mmfn/KJ7aZMS7WtgUW2XFhVPt444aD8KRZhtpSstpUZa0tmALqpay4Q+AZKf
1XBReUdrzQZeXnDbvlq6RupjJRlAU+tAhVdERSCZl9ToQ8ZiiEPeaHxLHNNMk4/1
4fr43glIKBxIVHFhUWrR9Tl+pf/uhi+NtLTES+g0JZ6IolJx4Rdz4/vv3PNdNPc/
47ovjOgrnKONgQfykCqDQ1TT8kQXYYDsFsvCo+aVEb1131OEsKe8P9qYbUO+on7F
8g/ev9tj+csJ6VkRBcpfVF7J1DlOH6nlStekFVZC4b0Jqhp3Mim2ilXRossHPnE=
=RIjx
-----END PGP SIGNATURE-----

--ffV5s5wGh60qpjoGr03UDbUHiTJpU1CLB--
