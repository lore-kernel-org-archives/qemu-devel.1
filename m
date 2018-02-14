Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em45D-00070c-EO
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em45C-0005F3-N2
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:55:15 -0500
References: <20180213233324.5096-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <95035782-da08-4da5-d7fc-82e7b8cb155e@redhat.com>
Date: Wed, 14 Feb 2018 21:54:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180213233324.5096-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LsaPDJjNg2gIt7KKJrZ2I0jNDQkmkIjBi"
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] s/size/entries/ when dealing with
 non-byte units
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LsaPDJjNg2gIt7KKJrZ2I0jNDQkmkIjBi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com
Message-ID: <95035782-da08-4da5-d7fc-82e7b8cb155e@redhat.com>
Subject: Re: [RFC PATCH 0/2] s/size/entries/ when dealing with non-byte units
References: <20180213233324.5096-1-eblake@redhat.com>
In-Reply-To: <20180213233324.5096-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-14 00:33, Eric Blake wrote:
> I mentioned this while reviewing Berto's series on L2 slice handling;
> this is a first cut at patches that I think are worth doing throughout
> the qcow2 code base if we like the idea.

I like the idea. :-)

The patches look good to me.

Max

> Eric Blake (2):
>   qcow2: Prefer 'entries' over 'size' for non-byte values in spec
>   qcow2: Prefer 'entries' over 'size' during cache creation
>=20
>  docs/interop/qcow2.txt |  4 ++--
>  block/qcow2.h          |  4 ++--
>  block/qcow2.c          | 21 +++++++++++----------
>  3 files changed, 15 insertions(+), 14 deletions(-)
>=20



--LsaPDJjNg2gIt7KKJrZ2I0jNDQkmkIjBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqEoiISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJDYH/AkrN/vCGyiura6chwI6z/w6EofhzEgQ
31igQliw7TTMQqs0JahsOYHslhH0YbHxLMPf9Np947Rh5+rF0gB1qesl8JKajDsn
aGZaFCkHI13ZnAz9Q18POfNQ7tFX8JbcNwH6PxM8MgH8+8fawx2Y6Pdz97DK5pRZ
mSV1cNERpRsuLxCuXi8IiR3yGYijFWdJs8Fr3ooUggtEZz5ayj4ff5YvMbBc/+Tv
XDg0Lz9GRQyWdhVZgXRVgzba0URgtTQ2kMrQSZEJGp3UFRTsJePQKZBYnK/cQX3p
A3t2xt8j0F/aqlMSFzHbu00x4mQxQ30egrCbnaqELyf0zK7VjRxaZKM=
=+v1W
-----END PGP SIGNATURE-----

--LsaPDJjNg2gIt7KKJrZ2I0jNDQkmkIjBi--
