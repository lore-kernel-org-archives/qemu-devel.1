Received: from eggs.gnu.org ([2001:4830:134:3::10]:60036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du0gX-00080E-R0
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du0gW-0004Og-My
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:22:21 -0400
References: <20170918124230.8152-1-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c53ecaa4-89c1-b163-f925-aaad7d497482@redhat.com>
Date: Mon, 18 Sep 2017 20:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170918124230.8152-1-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kuttc5vPMWAGr4qi2FKU6h80hv2UulKPf"
Subject: Re: [Qemu-devel] [PATCH v8 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kuttc5vPMWAGr4qi2FKU6h80hv2UulKPf
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 den@openvz.org
Message-ID: <c53ecaa4-89c1-b163-f925-aaad7d497482@redhat.com>
Subject: Re: [PATCH v8 0/4] Add shrink image for qcow2
References: <20170918124230.8152-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170918124230.8152-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 14:42, Pavel Butsykin wrote:
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
> # du -h image.qcow2
> 129M    image.qcow2

Thanks, I've added the missing space in patch 1 and applied the series
to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--kuttc5vPMWAGr4qi2FKU6h80hv2UulKPf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnADssSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMJUIALvXzR/6eE9MgE4GnQriX3XnpshtSvS8
9CPz+uESSpEV0yAp3YnlC7Dl6R5ZMVB3WJ4s+83b2NZ7sAuLtjpHceUiMMXc5Z+x
v85CHtPp25cRteEv+fRSTatZUR528UVc4Gk2NPMnFroHWoHjNrAo4T0xkC8HBgzG
GTyPL8m+azWpdW7SuQ5HrBmih+zB71Ekq91EVHcVQ7LoMZp+8BUAZ4KFcecTWMxJ
IZ2S4Zu8J//3Eg+z3/s7KZMHvNa1mBWA/90f+KSkWB3sRDmd8Imfw/afPRXYgJoM
sFAVKVuF0w4Wx9RfEh+6hgAsYu65CZCeyGTUWQF1ZTet8nqZJUDI7kQ=
=Rx/t
-----END PGP SIGNATURE-----

--kuttc5vPMWAGr4qi2FKU6h80hv2UulKPf--
