Received: from eggs.gnu.org ([2001:4830:134:3::10]:36403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrJl-0008GD-Ni
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrJk-000895-P5
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:40:29 -0400
References: <20170522135704.842-1-stefanha@redhat.com>
	<20170522135704.842-5-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <497bff5d-6667-f88d-bd9d-0a706b4a9f73@redhat.com>
Date: Mon, 22 May 2017 12:40:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170522135704.842-5-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dp3TetCDIM8hP8EHtU3FwnJ3mM9GmWTeI"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] migration: use
 bdrv_drain_all_begin/end() instead bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dp3TetCDIM8hP8EHtU3FwnJ3mM9GmWTeI
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org
Message-ID: <497bff5d-6667-f88d-bd9d-0a706b4a9f73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] migration: use
 bdrv_drain_all_begin/end() instead bdrv_drain_all()
References: <20170522135704.842-1-stefanha@redhat.com>
 <20170522135704.842-5-stefanha@redhat.com>
In-Reply-To: <20170522135704.842-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 08:57 AM, Stefan Hajnoczi wrote:
> blk/bdrv_drain_all() only takes effect for a single instant and then
> resumes block jobs, guest devices, and other external clients like the
> NBD server.  This can be handy when performing a synchronous drain
> before terminating the program, for example.
>=20
> Monitor commands usually need to quiesce I/O across an entire code
> region so blk/bdrv_drain_all() is not suitable.  They must use
> bdrv_drain_all_begin/end() to mark the region.  This prevents new I/O
> requests from slipping in or worse - block jobs completing and modifyin=
g
> the graph.
>=20
> I audited other blk/bdrv_drain_all() callers but did not find anything
> that needs a similar fix.  This patch fixes the savevm/loadvm commands.=

> Although I haven't encountered a read world issue this makes the code
> safer.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  migration/savevm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Dp3TetCDIM8hP8EHtU3FwnJ3mM9GmWTeI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyJ6AAoJEKeha0olJ0Nq02wH/20euVLNhaXYd/fKd5d7Fu8f
GaBGNkQxqlQK0kqlriJtLQC4rZJ7nSHYUznQSYTM9x+Z4px0plkfU2DNsJMT30Im
f5KlYhLpYrJUimtsL26ZDjYVYYTVKCKYCxON0X+AH8Zk/faa8Q8ArTuUpQsvh1eX
WiM2so1Ci1PipVagREcPK8p8BXFwD2eZ2FddcAlVzAODlJUlKFwQnZGkw2XgaIUV
ty6Ar1ehX+E6grVq0QObN2gxwOoAP6Yo7mNUqf+BL8r5B3gpPy51KUNQLl7Gy6Vm
6j6+b6nYLsod7vcwnOgUBK6GcW6ntE2K1z2pjFn4tgsQT6UXnkyaeavy86IjWEI=
=rFXB
-----END PGP SIGNATURE-----

--Dp3TetCDIM8hP8EHtU3FwnJ3mM9GmWTeI--
