Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNZU-0005ga-J6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNZO-0008B8-Sy
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:25:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNZO-0008Ao-NC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:25:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEB6781235
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:25:02 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:24:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125132458.GF10664@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <20170124180420.12430-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] virtio: use MemoryRegionCache to
 access descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 07:04:17PM +0100, Paolo Bonzini wrote:
> Clear cache->mr so that address_space_cache_destroy does nothing
> the second time it is called.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: rebased on new patch 3, rely on previous patch
>=20
>  hw/virtio/virtio.c    | 80 +++++++++++++++++++++++++--------------------=
------
>  include/exec/memory.h |  2 ++
>  2 files changed, 41 insertions(+), 41 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKcqAAoJEJykq7OBq3PIc7QH/Ai7QDnKTBVmk6189Lf/lIod
EjnXCP90HkqpZ5fKKUIapn6td6U9+BTy52r9aBPRv6c0I6EzlxUozvdK6z/o/yRj
Ox71gqQhhoIHKSeZmU4CTVgTU/tjl+u8M3xI5cQofVg8U7eCRvpf3izgCIYyf03K
1EhAbLGwCc/edh1LINIuvuvpnRKOrLQRBvvNft8glRap8QClUEkxVT/39Q9JhP9F
t4wi46ojZxxo4JZodmqq9M3rNW6OVYg3/DN85h7Kz0WVPazTbPq2ysHlF7g6HWrS
h2XaGjP9c9Rkcq3113tr0cZb+HAeCEzw6UWusyUUXoBT3OdHboqGsyGkYBW6sdM=
=dKZI
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
