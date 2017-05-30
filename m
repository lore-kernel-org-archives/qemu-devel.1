Received: from eggs.gnu.org ([2001:4830:134:3::10]:59398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoex-0003BA-Kr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoew-0004Ur-6d
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:26:35 -0400
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-10-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e87bfd88-4189-d212-6e3a-53fc10ab81d3@redhat.com>
Date: Tue, 30 May 2017 16:26:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170526165518.7580-10-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oGkbdOTjoLn5xiws8Q6suXiI2uJRjhXJ6"
Subject: Re: [Qemu-devel] [PATCH v3 09/16] block/qcow2: Generalize
 preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oGkbdOTjoLn5xiws8Q6suXiI2uJRjhXJ6
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e87bfd88-4189-d212-6e3a-53fc10ab81d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/16] block/qcow2: Generalize
 preallocate()
References: <20170526165518.7580-1-mreitz@redhat.com>
 <20170526165518.7580-10-mreitz@redhat.com>
In-Reply-To: <20170526165518.7580-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 11:55 AM, Max Reitz wrote:
> This patch adds two new parameters to the preallocate() function so we
> will be able to use it not just for preallocating a new image but also
> for preallocated image growth.
>=20
> The offset parameter allows the caller to specify a virtual offset from=

> which to start preallocating. For newly created images this is always 0=
,
> but for preallocating growth this will be the old image length.
>=20
> The new_length parameter specifies the supposed new length of the image=

> (basically the "end offset" for preallocation). During image truncation=
,
> bdrv_getlength() will return the old image length so we cannot rely on
> its return value then.

bdrv_getlength() is (currently) always sector-aligned (rounding up as
needed).

new_length is passed from qcow2_create2()'s total_size, which in turn
comes from qcow2_create()'s size, which can be user-supplied - but also
appears that we round up to ensure it is always sector-aligned.

Testing: 'qemu-img create -f qcow2 a.img 1' reports "size=3D1", but
'qemu-img info a.img' reports "virtual size: 512" - so we have a
secondary bug worth fixing later in that we are rounding AFTER what we
report to the user, but I'm not seeing a behavior change in this patch.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oGkbdOTjoLn5xiws8Q6suXiI2uJRjhXJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLeN6AAoJEKeha0olJ0Nqz20H/0UNmBbXCjAVA0z+2EJgJwnV
Sc1a12rJVdunA/ZtGTb9vtHNnAiKNBVrn+TngaeqS06A6yQ7TSv9/m5/JKac8Nou
9mNCsOsvSr7BHFqW4OtjmX43I+z2p6c0wzTvVZsWqdrsmrjJorx1uIsXAio94Kfd
7gynVRKlALb59XaTbFZCPSOligjLjaDYtJNyUw8S7Nlam7b/e8jmrfQXzJc+AcmB
P2TR0tELkACelO11+gT+0bJWPMFh3O4T3BqRsN/t5NrEvjbEy+NBFYzhmQLp6YKt
5pSBmy0ryqMC93iG0jdq2cwOzaVSIE+i2h36Zx70p8e/xhw++1jcLHZFwCkm4+Y=
=7Rll
-----END PGP SIGNATURE-----

--oGkbdOTjoLn5xiws8Q6suXiI2uJRjhXJ6--
