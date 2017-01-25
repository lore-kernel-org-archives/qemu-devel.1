Received: from eggs.gnu.org ([2001:4830:134:3::10]:54493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNbn-0008F4-0G
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNbk-0000Ov-DD
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:27:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNbk-0000Nc-8N
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:27:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 707413A76AB
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:27:28 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:27:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125132725.GI10664@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
In-Reply-To: <20170124180420.12430-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] virtio: use VRingMemoryRegionCaches
 for avail and used rings
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


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 07:04:20PM +0100, Paolo Bonzini wrote:
> The virtio-net change is necessary because it uses virtqueue_fill
> and virtqueue_flush instead of the more convenient virtqueue_push.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: improved and simplified error recovery
>                 removed duplicate rcu_read_lock!
>=20
>  hw/net/virtio-net.c |  14 +++++-
>  hw/virtio/virtio.c  | 130 ++++++++++++++++++++++++++++++++++++++--------=
------
>  2 files changed, 107 insertions(+), 37 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKe9AAoJEJykq7OBq3PIRxkH/35q1n3hTqzPuxP6RtCuN50r
BJAJmCU2V4w4Efcm8ak6oDGzSIodPJodI+8/91N2kGz6r5FpnW55KwYsEOj5CZy6
4jC80WAkXvt+TBwc4E8BYBLG5tdCuSIgpA3LCocT0CVByenKFwY+TwBW5wplSKjW
5X6dHgi3fUrPQ4JXI1Xb/x/QKNRfuBMS9yI4T9Su6YKq1QnYUTUJWpWkEhwSGoA4
z5mCmXet6Loe3OdVLnbiHIBHngQQqEX4M18D6HpB561tjAol6sztXLssG1rEFm/u
kB6DW+H8M6Rbxa6yoh3N2ulfxgTSSQCOpa0NXia+QtZYsJ2CBUp+CGqcweJkOFM=
=bGd7
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--
