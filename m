Received: from eggs.gnu.org ([2001:4830:134:3::10]:41022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7jzL-0001uv-Mt
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7jzJ-0000Rr-4C
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:50:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7jzI-0000Qd-SF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:50:13 -0400
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af6f4140-e264-dc45-8b0c-36b5d520ce28@redhat.com>
Date: Mon, 8 May 2017 09:50:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170508141536.20690-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fjd0U2lb7Mxd0Q5F3sOP27LEFHtS49AeT"
Subject: Re: [Qemu-devel] [PATCH v6 1/9] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fjd0U2lb7Mxd0Q5F3sOP27LEFHtS49AeT
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <af6f4140-e264-dc45-8b0c-36b5d520ce28@redhat.com>
Subject: Re: [PATCH v6 1/9] block: add bdrv_measure() API
References: <20170508141536.20690-1-stefanha@redhat.com>
 <20170508141536.20690-2-stefanha@redhat.com>
In-Reply-To: <20170508141536.20690-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 09:15 AM, Stefan Hajnoczi wrote:
> bdrv_measure() provides a conservative maximum for the size of a new
> image.  This information is handy if storage needs to be allocated (e.g=
=2E
> a SAN or an LVM volume) ahead of time.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

It looks like non-trivial changes since v5, are you sure this R-b is
still appropriate?

> ---
> v6:
>  * Change bdrv_measure() return type to BlockMeasureInfo * [Eric]
>  * Clarify that holes in sparse POSIX files are still counted [Eric]
> ---
>  qapi/block-core.json      | 25 +++++++++++++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  2 ++
>  block.c                   | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fjd0U2lb7Mxd0Q5F3sOP27LEFHtS49AeT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEIWeAAoJEKeha0olJ0Nqgc0H/iCM5Ql3xY+KrsSTCrSCaVGu
eIOkM1fTpbSzLb4j/h5iAkkrETZw5UJshf1bVLOdSXs/LrJ2zwbVp2VWuW5piAKX
3Wf55lETa1yl2IyamiPQgVQZgOXHRzEa//Av0hHjBmO3P9x+rf69O2285EO6oTx/
Nwbnprrs83q/5rFJWMa+OAy1AwxpuDb/ZRNQ2O1iysngCTIlyxm0aF+cL1/ncBXh
sB/z+DAtwCYldnBtksH8DEb9RF3xMNk1vh9QanTUVYaHNuZRef5X348Y/zfVK0uP
Xe1OUO2fCXfgMWCNqn7Yh9avG3O5b5y89fAMaK4STerqaRrOLcQK6RvNIqIN7Tk=
=529e
-----END PGP SIGNATURE-----

--fjd0U2lb7Mxd0Q5F3sOP27LEFHtS49AeT--
