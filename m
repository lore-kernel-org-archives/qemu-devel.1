Received: from eggs.gnu.org ([2001:4830:134:3::10]:43902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVIFj-0007Ae-07
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVIFi-0005qy-5a
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:04:31 -0400
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <68ab6178-8c48-3798-f227-fdd0c6eeca70@redhat.com>
Date: Wed, 12 Jul 2017 16:04:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="scXM4I6T6oVnb4ktqmFrei7RO6SaWsJP4"
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--scXM4I6T6oVnb4ktqmFrei7RO6SaWsJP4
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <68ab6178-8c48-3798-f227-fdd0c6eeca70@redhat.com>
Subject: Re: [PATCH v5 0/4] Add shrink image for qcow2
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-12 13:46, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> # ./qemu-img create -f qcow2 image.qcow2 4G
> Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=3Dof=
f cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
> wrote 1073741824/1073741824 bytes at offset 0
> 1 GiB, 1 ops; 0:00:04.59 (222.886 MiB/sec and 0.2177 ops/sec)
>=20
> # ./qemu-img resize image.qcow2 512M
> warning: qemu-img: Shrinking an image will delete all data beyond the s=
hrunken image's end. Before performing such an operation, make sure there=
 is no important data there.
> error: qemu-img: Use the --shrink option to perform a shrink operation.=

>=20
> # ./qemu-img resize --shrink image.qcow2 128M
> Image resized.
>=20
> # ./qemu-img info image.qcow2
> image: image.qcow2
> file format: qcow2
> virtual size: 128M (134217728 bytes)
> disk size: 128M
> cluster_size: 65536
> Format specific information:
>     compat: 1.1
>     lazy refcounts: false
>     refcount bits: 16
>     corrupt: false
>=20
> # du -h image.qcow2=20
> 129M    image.qcow2

Thanks, looks good.  Now we'll just have to wait for the warn_report()
series.

Max


--scXM4I6T6oVnb4ktqmFrei7RO6SaWsJP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZixmEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQD7M
B/0YILXk5lXX7G0Ei0z1zRQVGguRDZyGYqlYKs8No10+3anCZjBVXyE8i22dIpDy
8zWAcMxEKT2l0ZT5EpeVW/BbijZgoHmkWYIfjbVO6V7O45ojrMnYDRyfZd8zIpqq
0ZK6ey0QWN5kyv5pgGcHUcvzTEZLtewDZzEjg87n8CSqzTmcfuXQ4tbrBZwjVZcq
2aJ3HXfqmZsePuB6ovc3e28ipHTROTuW6Em3r4vA8zzbXTQP6kbkcUEAC0ATVMLK
DKYWd0vP4fKKY/1ZwBKbqBZJ6w6KFYhNZXFSUyF+XZyUCIlbxfdJ+GK6MEn649Tt
iP3X/yw+9N69gVPkXGoSMDqj
=irtN
-----END PGP SIGNATURE-----

--scXM4I6T6oVnb4ktqmFrei7RO6SaWsJP4--
