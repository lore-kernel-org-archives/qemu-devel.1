Received: from eggs.gnu.org ([2001:4830:134:3::10]:46131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPAwP-0005TU-Aj
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPAwK-0002DQ-G2
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:31:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPAwK-0002Cu-9X
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:30:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C54DC027386
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:30:56 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d2e58fa-ae2b-3bff-d24f-4af29ca8518b@redhat.com>
Date: Thu, 5 Jan 2017 10:30:54 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fDuTAfNqdO7aNQGab2oKklft0SxQ2INUr"
Subject: Re: [Qemu-devel] [PATCH 2/8] io: stop incrementing reference in
 qio_task_get_source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fDuTAfNqdO7aNQGab2oKklft0SxQ2INUr
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2d2e58fa-ae2b-3bff-d24f-4af29ca8518b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] io: stop incrementing reference in
 qio_task_get_source
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-3-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Incrementing the reference in qio_task_get_source is
> not neccessary, since we're not running concurrently

s/neccessary/necessary/

> with any other code touching the QIOTask. This
> minimizes chances of further memory leaks.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h    | 7 ++++---
>  io/channel-socket.c  | 3 ---
>  io/channel-tls.c     | 2 --
>  io/task.c            | 1 -
>  tests/test-io-task.c | 1 -
>  5 files changed, 4 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fDuTAfNqdO7aNQGab2oKklft0SxQ2INUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbnS+AAoJEKeha0olJ0NqQHUH/iekBhe0pQQn5AyAbZPI33/9
hc/c1s++0VHkSsKfHASTKzMunRr/MR4EkSFj7QH567LqUtXoTOMBvYwd5A2Kc9t9
bdRRMHAEtv1AxmKFIgRhzkzVycFfBEHAqIJg5mFpfFmZQJv9Ha/LdUs54jDaRwkK
jqEYBySOvy+kpROALMffQu20W4fERzqk4ZdZDHIsd71AK1PpeScoo62mnEwTk+Xc
meLeOinZsuCTISDZCxqU4Yq+UdBMZjxeXYdYA1Hwo2tFyD4rO2UmWAi3g09/tI2p
B+X7Tngg8HyPoG0FY/t4rQlaYkzdJyT7Iv1/3DZ1NSx9yGnP3Vr1T1nk+pGp6Hw=
=aN1i
-----END PGP SIGNATURE-----

--fDuTAfNqdO7aNQGab2oKklft0SxQ2INUr--
