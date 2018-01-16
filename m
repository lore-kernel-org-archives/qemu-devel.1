Received: from eggs.gnu.org ([2001:4830:134:3::10]:58123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaV2-0000nx-Dt
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaV1-0004x4-8t
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:18:36 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f573609-a04e-b3c5-6359-b6e08b138549@redhat.com>
Date: Tue, 16 Jan 2018 17:18:25 -0600
MIME-Version: 1.0
In-Reply-To: <8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cCGzdW02xEfIvdUgk3kvLxIAIWdN8Xfrv"
Subject: Re: [Qemu-devel] [PATCH v2 31/32] qcow2: Allow configuring the L2
 slice size
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
--cCGzdW02xEfIvdUgk3kvLxIAIWdN8Xfrv
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <6f573609-a04e-b3c5-6359-b6e08b138549@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 31/32] qcow2: Allow configuring the L2
 slice size
References: <cover.1513342045.git.berto@igalia.com>
 <8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
In-Reply-To: <8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> Now that the code is ready to handle L2 slices we can finally add an
> option to allow configuring their size.
>=20
> An L2 slice is the portion of an L2 table that is read by the qcow2
> cache. Until now the cache was always reading full L2 tables, and
> since the L2 table size is equal to the cluster size this was not very
> efficient with large clusters. Here's a more detailed explanation of
> why it makes sense to have smaller cache entries in order to load L2
> data:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html
>=20
> This patch introduces a new command-line option to the qcow2 driver
> named l2-cache-entry-size (cf. l2-cache-size). The cache entry size
> has the same restrictions as the cluster size: it must be a power of
> two and it has the same range of allowed values, with the additional
> requirement that it must not be larger than the cluster size.
>=20
> The L2 cache entry size (L2 slice size) remains equal to the cluster
> size for now by default, so this feature must be explicitly enabled.
> Although my tests show that 4KB slices consistently improve
> performance and give the best results, let's wait and make more tests
> with different cluster sizes before deciding on an optimal default.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 10 ++++++++--
>  block/qcow2.c       | 33 +++++++++++++++++++++++++++------
>  block/qcow2.h       |  4 +++-
>  3 files changed, 38 insertions(+), 9 deletions(-)

Is there a QMP counterpart to the command-line option?  I suspect
Kevin's work on making a QMP command for image creation will also be
impacted.

I haven't reviewed the patch closely, yet.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cCGzdW02xEfIvdUgk3kvLxIAIWdN8Xfrv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeiEEACgkQp6FrSiUn
Q2qFOAf8Do5WCqrgtRgLoIXRjeZ8TE9jm/c+2E7KHcVK2Qr9VVAsIuc4vrS7IyRE
YXwZWBAh4BOUTZMT4Nx9YwOTh5GZQ1inQ+cRpn6MOCV3jIehta79HzNBjUGsDu/h
eW7Nwkbkrw+efJ8dTiZPCHNXEeN8jZEkjmY/9/eDhBKLQDa5tAsnhbFx7HjcqNvm
yrRbY4u97WRj9/2jH5yYzbxa9frtrQSUnrc7enLpEzIgILcK/NiMHWF3A/D6z2p1
+81QMQ7VsoUEUcB7KESTnnVs3Z3EKaeLtqMQGPxM0RiWfTiSSElURKgURhMkqWDK
2jyn8wTpOQakSnx/D2cmLU5urFXrFw==
=hxCc
-----END PGP SIGNATURE-----

--cCGzdW02xEfIvdUgk3kvLxIAIWdN8Xfrv--
