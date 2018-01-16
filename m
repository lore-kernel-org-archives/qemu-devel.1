Received: from eggs.gnu.org ([2001:4830:134:3::10]:60545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ50-0005Hl-7V
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ4z-0008U4-GD
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:47:38 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<f12fbd9730ce538671581bcdefce5fb5a048644d.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49dcf3d2-b8c8-b9cf-aade-77d335f98370@redhat.com>
Date: Tue, 16 Jan 2018 15:47:26 -0600
MIME-Version: 1.0
In-Reply-To: <f12fbd9730ce538671581bcdefce5fb5a048644d.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mkDmaLpeJ8vtna8Iwa9hw7t4b0UF2QJIX"
Subject: Re: [Qemu-devel] [PATCH v2 09/32] qcow2: Remove BDS parameter from
 qcow2_cache_clean_unused()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mkDmaLpeJ8vtna8Iwa9hw7t4b0UF2QJIX
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <49dcf3d2-b8c8-b9cf-aade-77d335f98370@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/32] qcow2: Remove BDS parameter from
 qcow2_cache_clean_unused()
References: <cover.1513342045.git.berto@igalia.com>
 <f12fbd9730ce538671581bcdefce5fb5a048644d.1513342045.git.berto@igalia.com>
In-Reply-To: <f12fbd9730ce538671581bcdefce5fb5a048644d.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_table_release(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 2 +-
>  block/qcow2.c       | 4 ++--
>  block/qcow2.h       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mkDmaLpeJ8vtna8Iwa9hw7t4b0UF2QJIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpecu4ACgkQp6FrSiUn
Q2rc5wgAnyXVgdqcp6vVaVd0wR8n1GvhrN0JZTKp+zPr9pwpkzA3V/4vOJmiWlh+
j58hagl/6xI+1/EO8clo7PTucNlYmfB6GWzZ3VwXx9azYeLkLAuqxl2yq6qnFTFU
thbOn3PwhMLdCkFpsTh4IpDtSR5iPkKi+R0+lylFWyL8EgmriMEyi7kaGLL/8b0A
mVO/fnO6GdMf/Pl0mz9IN+tcFeeJjOB5S5x1fWIJeAsTkmutH1glnsjXfdU6V8B4
u1LhXWTSFuSAmV/0ANHjvmRQbB9l1EmriS7gshvCeCq3MpqcSDBdu1uXym+WYBIz
kDD9I3/qdp+G6gokAc8F4m6yFflOrA==
=LWlT
-----END PGP SIGNATURE-----

--mkDmaLpeJ8vtna8Iwa9hw7t4b0UF2QJIX--
