Received: from eggs.gnu.org ([2001:4830:134:3::10]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1caqXo-0003cQ-6A
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1caqXn-0001cz-9u
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:09:52 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a47c84f-8edb-4be5-92cf-ffaf19006951@redhat.com>
Date: Mon, 6 Feb 2017 15:09:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="noc2Tk2SGMSsk7eoxaDKjTAtmO25o18Ma"
Subject: Re: [Qemu-devel] [PATCH 02/18] nbd-server: refactor simple reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--noc2Tk2SGMSsk7eoxaDKjTAtmO25o18Ma
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <3a47c84f-8edb-4be5-92cf-ffaf19006951@redhat.com>
Subject: Re: [PATCH 02/18] nbd-server: refactor simple reply sending
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Rename functions appropriately and also make a separate copy of NBDRepl=
y
> - NBDSimpleReply, to replace NBDReply for the server. NBDReply itself
> will be upgraded in future patches to handle both simple and structured=

> replies in the client.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  7 +++++++
>  nbd/server.c        | 25 +++++++++++++------------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--noc2Tk2SGMSsk7eoxaDKjTAtmO25o18Ma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmOYXAAoJEKeha0olJ0NqK9AIAIoDqzWaXxyOr6sO2i9rPIZG
csvGsU6bJnx2yX7PEaUBs40u1diNuPCJY8e8TzL5Ar3y0DIru9ZDA5q39K+Jd9TE
/dUAeQxRNCaVAqJ6S0nJJERtWkyeUsW8MQVLRe/2YUOPKypkYel0MA3C0Ml2WuTm
Cgsg4qwKbitefU2gWJ2PqXK0qye4gegf1mnbk6oA7jrAYbpRjQG0WPXdLB0OfW6F
cc+rNTj5T4Zq1ZJirBJeD2nvhoyI4J3CmJGr60nQIeR2zLuou+h9ntv8nk1u1jte
hqPuWK801jpnwFiYcLz5+ppm7HwOekazpikgj6sjdgGQ05K8t/8U23t4hN8SUww=
=LATb
-----END PGP SIGNATURE-----

--noc2Tk2SGMSsk7eoxaDKjTAtmO25o18Ma--
