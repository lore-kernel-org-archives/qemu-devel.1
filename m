Received: from eggs.gnu.org ([2001:4830:134:3::10]:48868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYVT-0002nS-51
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYVS-00059f-4z
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:07:35 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-3-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e409a506-3861-3a65-7cdb-5f5b6f3a3365@redhat.com>
Date: Wed, 8 Nov 2017 16:07:26 -0600
MIME-Version: 1.0
In-Reply-To: <20171108215703.9295-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sognxK9vPoJ0nfQWaihx2xXTm7Xw8uPFQ"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] nbd-client: Refuse read-only client
 with BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sognxK9vPoJ0nfQWaihx2xXTm7Xw8uPFQ
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com
Message-ID: <e409a506-3861-3a65-7cdb-5f5b6f3a3365@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] nbd-client: Refuse read-only client
 with BDRV_O_RDWR
References: <20171108215703.9295-1-eblake@redhat.com>
 <20171108215703.9295-3-eblake@redhat.com>
In-Reply-To: <20171108215703.9295-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 03:56 PM, Eric Blake wrote:

> Fix iotest 147 to comply with the new behavior (since nbd-server-add
> defaults to a read-only export, we must tell blockdev-add to set up a
> read-only client).

My bad for testing only './check -nbd' and not also './check -qcow2';
iotest 58 and 140 also need fixing. I'll post the patch for squashing
while awaiting review; I'd like for this to make it into -rc1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sognxK9vPoJ0nfQWaihx2xXTm7Xw8uPFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDgB8ACgkQp6FrSiUn
Q2pOFgf+LwMZxhzFH3bQssl2ooXIkgwJg9ryVtGNL2UmJjW+Gme+XneNjhS39SZf
CHA6wwq8cVHjW16LZ7EdjdPbTImeLgwIRJRSPxJ8qpMpr9tz8K+vkXZceRzzhdBf
k6RvNKeOzDY6imnNcq0p2+CCL95jKQYJfKrp4AoJ1OLCC8vo+kcKtQb7e1Tfy7R7
DSkJYJ0rRfFVe3N18SrdQL7dJmm0OcgDDF3xyAbWPOByOY2sQAd6roddkM9yKzvy
3L9IwBA2nIjzh8VBM5Acegw09rl7TgGPexAtAK6aCKZDieAQul9rMK6NE/hIjCyy
BaUsPB9yAFaf9w5heEnvD6Enw68dEw==
=xzev
-----END PGP SIGNATURE-----

--sognxK9vPoJ0nfQWaihx2xXTm7Xw8uPFQ--
