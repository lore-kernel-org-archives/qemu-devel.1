Received: from eggs.gnu.org ([2001:4830:134:3::10]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNa2-0006D7-O7
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNa1-0008S6-NF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:25:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNa1-0008Rl-Gc
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:25:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F6098553C
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:25:41 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:25:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125132538.GG10664@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <20170124180420.12430-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] virtio: add MemoryListener to cache
 ring translations
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


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 07:04:18PM +0100, Paolo Bonzini wrote:
> The cached translations are RCU-protected to allow efficient use
> when processing virtqueues.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: fix memory leak on error [Stefan]
>=20
>  hw/virtio/virtio.c         | 92 ++++++++++++++++++++++++++++++++++++++++=
++++--
>  include/hw/virtio/virtio.h |  1 +
>  2 files changed, 90 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKdSAAoJEJykq7OBq3PIcUEH+QGE+hFcqtn78BGv6lvreQeC
orPr6khIXO+0pZK0fehKWeYPM/JG685oT5M4PYVZtIHzWI6f/sSHuaLMjtoK65y7
9ZrJk95dMtD/OMAYMUaOCHOBWKUiWTJKXO+uLbusRhmJjnzSXZ8v4j08ZIKuk3R1
7wL4/Dp4R2jB19YTm4fIyedkVr9HuvQEjLqfWnLbxYPCwwWgxthK+TRPFpqkCQLB
OwNhsKr0MM4a7lkHAjFWYg+P86fjRSbPwoa2ZMmRdoknYBPVCvUuB1pm/vDNPuBi
96e1cWsmJF1QkI4QXbH4p6FIyGgHjgVaCpW6+pr6rqV2mwg096SKhRt97McVToE=
=Olxg
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
