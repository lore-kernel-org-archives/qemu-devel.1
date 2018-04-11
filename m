Received: from eggs.gnu.org ([2001:4830:134:3::10]:43322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6O0m-0004Ao-6t
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6O0l-0001GJ-9E
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:14:40 -0400
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-12-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fec5bd7d-74e8-a3f7-f885-df0fb0d3b9bf@redhat.com>
Date: Wed, 11 Apr 2018 17:14:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180411185425.2461-12-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lb1zoUE9YYhPX91kKeie6CWHFzKS8taSF"
Subject: Re: [Qemu-devel] [PATCH v4 11/13] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lb1zoUE9YYhPX91kKeie6CWHFzKS8taSF
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <fec5bd7d-74e8-a3f7-f885-df0fb0d3b9bf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/13] block/mirror: Add active mirroring
References: <20180411185425.2461-1-mreitz@redhat.com>
 <20180411185425.2461-12-mreitz@redhat.com>
In-Reply-To: <20180411185425.2461-12-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 01:54 PM, Max Reitz wrote:
> This patch implements active synchronous mirroring.  In active mode, th=
e
> passive mechanism will still be in place and is used to copy all
> initially dirty clusters off the source disk; but every write request
> will write data both to the source and the target disk, so the source
> cannot be dirtied faster than data is mirrored to the target.  Also,
> once the block job has converged (BLOCK_JOB_READY sent), source and
> target are guaranteed to stay in sync (unless an error occurs).
>=20
> Active mode is completely optional and currently disabled at runtime.  =
A
> later patch will add a way for users to enable it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  qapi/block-core.json |  18 ++++
>  block/mirror.c       | 252 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 265 insertions(+), 5 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c50517bff3..8210d601f4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1049,6 +1049,24 @@
>  { 'enum': 'MirrorSyncMode',
>    'data': ['top', 'full', 'none', 'incremental'] }
> =20
> +##
> +# @MirrorCopyMode:
> +#
> +# An enumeration whose values tell the mirror block job when to
> +# trigger writes to the target.
> +#
> +# @background: copy data in background only.
> +#
> +# @write-blocking: when data is written to the source, write it
> +#                  (synchronously) to the target as well.  In
> +#                  addition, data is copied in background just like in=

> +#                  @background mode.
> +#
> +# Since: 2.12

Missed an instance of 2.13

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lb1zoUE9YYhPX91kKeie6CWHFzKS8taSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrOiMAACgkQp6FrSiUn
Q2p/GQf9HRsuDrWP3B2fqimsv3sYRtA+z+tEc6n2485FeVtIbSdBKuA3uYjBz7Sy
udt6As9Ed0l3UrciGlrJISN5tu3WsSplOg8nriQUmYZJK8JsRPG1078pJO/cVBI7
cngtWVuBGp/4PJTFzSYNLKVIaHmUHpuE0gaz4aRPnKjgWPqmKAjn4YNBCGbTHh32
OEnPKrRLaTMb0dberRwqDfnYJRjSjq2loUJ5EkKsz4e+sActokH31I0b9QDqoYW/
XjPub/2WqnEBWarEJf3J+f17kgyu+sL8VNhSrycs10aY/AoAoJfo+zEAXH0HFLCL
eRQwrwa+mgyeB2me9+Q6KMz3qHjuVQ==
=q18q
-----END PGP SIGNATURE-----

--lb1zoUE9YYhPX91kKeie6CWHFzKS8taSF--
