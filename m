Received: from eggs.gnu.org ([2001:4830:134:3::10]:47998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCs1W-00040F-VH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCs1W-00061H-0Y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:25:42 -0400
References: <20170522180735.26677-1-mreitz@redhat.com>
	<20170522180735.26677-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab779027-06ea-5d90-2297-e12288070cec@redhat.com>
Date: Mon, 22 May 2017 13:25:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170522180735.26677-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KLXjqGrpdlvRDVKhK2vPlKMOAnoStgPcI"
Subject: Re: [Qemu-devel] [PATCH 1/2] block: Fix backing paths for filenames
 with colons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KLXjqGrpdlvRDVKhK2vPlKMOAnoStgPcI
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ab779027-06ea-5d90-2297-e12288070cec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: Fix backing paths for filenames
 with colons
References: <20170522180735.26677-1-mreitz@redhat.com>
 <20170522180735.26677-2-mreitz@redhat.com>
In-Reply-To: <20170522180735.26677-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 01:07 PM, Max Reitz wrote:
> path_combine() naturally tries to preserve a protocol prefix. However,
> it recognizes such a prefix by scanning for the first colon; which is
> different from what path_has_protocol() does: There only is a protocol
> prefix if there is a colon before the first slash.
>=20
> A protocol prefix that is not recognized by path_has_protocol() is none=
,
> and should thus not be taken as one.
>=20
> Case in point, before this patch:
> $ ./qemu-img create -f qcow2 -b backing.qcow2 ./top:image.qcow2
> qemu-img: ./top:image.qcow2: Could not open './top:backing.qcow2':
>     No such file or directory
>=20
> Afterwards:
> $ ./qemu-img create -f qcow2 -b backing.qcow2 ./top:image.qcow2
> qemu-img: ./top:image.qcow2: Could not open './backing.qcow2':
>     No such file or directory
>=20
> Reported-by: yangyang <yangyang@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KLXjqGrpdlvRDVKhK2vPlKMOAnoStgPcI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIy0fAAoJEKeha0olJ0NqyvsH/ihLJt3895/OWjJc9b/j1JrW
mIL7y0GgpN2gshT7rgyPlYhKY0tYI/ORiUg+W7sTHwcYFpUsHKCbxXSMF0F0Lxme
7Vlh1R3eGTi7OWQP/ST03qz0HFBspW0fmSMFVkFvXqJEhAe7moFJZQOmFuRyJDqH
Smgf7XDCQro0m47KwbtAtMUJgB12Uv+SiXOt8ZswNUNwAWoTUwDLAxH6dEO8H4y2
IF/2EJfhyscaAQRr0l1co9PX1jCOJcaLmtjlJgHuWK1NEj0OH0B9Yv/Da0AJ2CZ5
C/P2UUHGd6AjLQScO1Ga6nzY5zRGUxXLmoqt4PBgIlgq+dEkX6hrCRKNhSq+AVY=
=f7Pn
-----END PGP SIGNATURE-----

--KLXjqGrpdlvRDVKhK2vPlKMOAnoStgPcI--
