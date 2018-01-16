Received: from eggs.gnu.org ([2001:4830:134:3::10]:60465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXVF-00082A-AZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXVE-0007uV-5W
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:06:37 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6303b684-cd5c-4c99-518e-896f2b5a68f7@redhat.com>
Date: Tue, 16 Jan 2018 14:06:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jNOQjeK4y0WY72f8kMsBEUlHApBd3ByVW"
Subject: Re: [Qemu-devel] [RFC PATCH 10/10] block: x-blockdev-create QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNOQjeK4y0WY72f8kMsBEUlHApBd3ByVW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <6303b684-cd5c-4c99-518e-896f2b5a68f7@redhat.com>
Subject: Re: [RFC PATCH 10/10] block: x-blockdev-create QMP command
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-11-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> This adds a synchronous x-blockdev-create QMP command that can create
> qcow2 images on a given node name.
>=20
> We don't want to block while creating an image, so this is not the fina=
l
> interface in all aspects, but BlockdevCreateOptionsQcow2 and
> .bdrv_co_create() are what they actually might look like in the end. In=

> any case, this should be good enough to test whether we interpret
> BlockdevCreateOptions as we should.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json      | 12 ++++++++++++
>  include/block/block_int.h |  2 ++
>  block.c                   | 48 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c             |  3 ++-
>  4 files changed, 64 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9341f6708d..93357a4d5d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3415,6 +3415,18 @@
>    } }
> =20
>  ##
> +# @x-blockdev-create:
> +#
> +# Create an image format on a given node.
> +# TODO Replace with something asynchronous (block job?)
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'x-blockdev-create',
> +  'data': 'BlockdevCreateOptions',
> +  'boxed': true }
> +

So simple, compared to all the prep work in earlier patches ;)

I like the approach.  As you say, there's still more work before we can
remove the x- prefix, but I think you're headed on a good track.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jNOQjeK4y0WY72f8kMsBEUlHApBd3ByVW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeW0MACgkQp6FrSiUn
Q2peiAf/ektEItl+rJQlTptifT2XhUxPtkmEnA4yPrIlx/sus7FJpKwQHnmZiv6m
RzimXL6v1v8LhxCF7NadNjR59XzCrWH7I7RM852LeXhkbvTL1STH+PXLObcq+q/c
Rhp7bS+T7KRU5PZaRyJJsv+RPE8uKUGbj0e7ylKSh1O85lt+P784PI0hiYS4Cu9D
4wk+OTdFmF0hg1wq4lecKwkpOsP+vrhbRVwQjxZw90qkQMJNJEYVrNvqcqxJz4Dc
zZgHCS5wjE+ZT7nAsqJeniuWQ0jXJpku9aFf0liAKxhX5ceetXwzyyx+mTitlGEw
l6QscOoRzSpPfsYj643NRtVVMq1WBA==
=jObl
-----END PGP SIGNATURE-----

--jNOQjeK4y0WY72f8kMsBEUlHApBd3ByVW--
