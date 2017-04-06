Received: from eggs.gnu.org ([2001:4830:134:3::10]:52684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw8WI-0003ja-0z
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw8WH-00075v-1j
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:36:18 -0400
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <420d6509-15f0-ceca-e953-16497b5a116c@redhat.com>
Date: Thu, 6 Apr 2017 09:36:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170406142527.25835-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UphInaJlCtDq6dHa4muSRObCgUhAS1353"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/5] block: Fix unpaired
 aio_disable_external in external snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UphInaJlCtDq6dHa4muSRObCgUhAS1353
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <420d6509-15f0-ceca-e953-16497b5a116c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/5] block: Fix unpaired
 aio_disable_external in external snapshot
References: <20170406142527.25835-1-famz@redhat.com>
 <20170406142527.25835-2-famz@redhat.com>
In-Reply-To: <20170406142527.25835-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 09:25 AM, Fam Zheng wrote:
> bdrv_replace_child_noperm tries to hand over the quiesce_counter state
> from old bs to the new one, but if they are not on the same aio context=

> this causes unbalance.
>=20
> Fix this by forcing callers to move the aio context first, and assert
> it.
>=20
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c    | 3 +++
>  blockdev.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UphInaJlCtDq6dHa4muSRObCgUhAS1353
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5lJUAAoJEKeha0olJ0NqUHAH/RNtN1vO/Td6TrJk/4hnodtH
uAqEpTCjM/6fF7veWoJ3dNwH+lHTh568PAI4hkjadD3nuE6ynSLoHy/R8f2jUjbi
JQKPfgi/8ju84PeZqpieN2fwmtLKQhZXG+ut/bAgLlzel7+j5QbwhdOixE0aNzhj
BcuuWf0U3ZmT5LIV/i7tKeP6gLHu/OD8QHc7EdUGi1MFZnai2yzFv3yU9tDJzBIQ
O5/KlC7GnZIdDdnOqFGbyqdYbGBh5TClztxkOSRTzp7g0sQgiSH6ZiYl29+1QOb0
7B80P321r/s0J/QLsZwBCquiWsUMdyUW06ThSt/3uSQDTqzcaIuXea2xZH7Kxzw=
=r/wO
-----END PGP SIGNATURE-----

--UphInaJlCtDq6dHa4muSRObCgUhAS1353--
