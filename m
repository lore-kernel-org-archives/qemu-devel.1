Received: from eggs.gnu.org ([2001:4830:134:3::10]:52527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDvio-0006MG-Jd
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDvin-0005Bj-PG
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:34:46 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-2-vsementsov@virtuozzo.com>
	<3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0808545c-a4cd-e22a-42ac-fc102473afb7@redhat.com>
Date: Thu, 25 May 2017 11:34:37 -0500
MIME-Version: 1.0
In-Reply-To: <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t87Omj7JCGRPJURS0S9Q02XGfmh1Ikf6e"
Subject: Re: [Qemu-devel] [PATCH 1/7] block: fix comment for
 bdrv_get_allocated_file_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t87Omj7JCGRPJURS0S9Q02XGfmh1Ikf6e
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <0808545c-a4cd-e22a-42ac-fc102473afb7@redhat.com>
Subject: Re: [PATCH 1/7] block: fix comment for bdrv_get_allocated_file_size()
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-2-vsementsov@virtuozzo.com>
 <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
In-Reply-To: <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 11:32 AM, Eric Blake wrote:
> If we have the following 6 qcow2 file clusters backed by the underlying=

> lseek(SEEK_DATA/HOLE) file system contents:
>=20
> BDRV_BLOCK_UNALLOCATED   N/A
> BDRV_BLOCK_ZERO_PLAIN    N/A
> BDRV_BLOCK_ZERO_ALLOC    hole
> BDRV_BLOCK_ZERO_ALLOC    data
> BDRV_BLOCK_DATA          hole
> BDRV_BLOCK_DATA          data

Sorry, these should all be s/BDRV_BLOCK/QCOW2_CLUSTER/ and
s/DATA/NORMAL/ - as I was referring to the qcow2 cluster status given by
qcow2_get_cluster_type() (as of commit fdfab37 or later).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--t87Omj7JCGRPJURS0S9Q02XGfmh1Ikf6e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJwedAAoJEKeha0olJ0NqcjUH/A6JQ5FD7U7jhYZwGsp12fkD
wgYEWVE+7WCh86CEVzSy8a1p6s4wbfAKOklY3t3CRNyUK+pA2KaG2SXc6CV+BVfj
g+30y00HUE9bMGftOePCijAEYfnG+9aw8pkSPcHZkrnVH3prrQRiAmR8CEsBhMmV
yrobf/+fmr518KivqnhgyYpNUMTxq//2SR2hlRV7nAp3d510MTJ99L14+bx2kwY1
yQNSo7z1eyECfzAgvnasId+j8Fj3gyazLWhicJlNrlGloa6CWIvYNtlpCluQWjey
xyZqOGQqfdjol+XYZ463gvJmZeNcaydtzm/KdWdRhoVoC9oVZXfbYvNFyeV1pVY=
=TW/9
-----END PGP SIGNATURE-----

--t87Omj7JCGRPJURS0S9Q02XGfmh1Ikf6e--
