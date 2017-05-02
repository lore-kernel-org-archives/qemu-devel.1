Received: from eggs.gnu.org ([2001:4830:134:3::10]:49734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5g4a-00071X-6e
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5g4X-0004D5-2f
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:15:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5g4W-0004Co-Qh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:15:05 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-4-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3224a61-cc45-c419-6aff-a3cc43ffed80@redhat.com>
Date: Tue, 2 May 2017 17:15:02 -0500
MIME-Version: 1.0
In-Reply-To: <1493735386-39622-4-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pOnPAhI2wCv2OdstQikhqeq4qS4NmTtvK"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pOnPAhI2wCv2OdstQikhqeq4qS4NmTtvK
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <c3224a61-cc45-c419-6aff-a3cc43ffed80@redhat.com>
Subject: Re: [PATCH v3 3/4] qmp: refactor duplicate code
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1493735386-39622-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1493735386-39622-4-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
> This patchset factor out the duplicate qmp throttle interface code
> that was present in both block and fsdev device files.

Instead of adding the duplicate code in patch 2 then cleaning it out
here, you should refactor this patch to be first (fix existing code in
blockdev.c to make use of the new interfaces), then add the new fsdev
code that uses this code right away.

>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  blockdev.c                      | 53 +++------------------------------=
----
>  fsdev/qemu-fsdev-throttle.c     | 51 +--------------------------------=
---
>  fsdev/qemu-fsdev.c              |  1 -
>  hmp.c                           | 34 ++++++++++++------------
>  include/qemu/throttle-options.h |  5 ++++
>  util/Makefile.objs              |  1 +
>  util/throttle-options.c         | 58 +++++++++++++++++++++++++++++++++=
++++++++
>  7 files changed, 85 insertions(+), 118 deletions(-)
>  create mode 100644 util/throttle-options.c
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pOnPAhI2wCv2OdstQikhqeq4qS4NmTtvK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCQTmAAoJEKeha0olJ0NqNHkIAJNXW2WRUPYdHTsrviySaPkX
mzx2fymzdOqP+CbJauZZhErZ2sgorl0g5xo2KozeiuPR1eJgeUmaTWv6Vt4HYanU
FtvER2wBmffzvrH8/IPO2Z5PGVJi8Gw9hMJsF0Jw9Q8KT1wKPvOoUcwkBcS9bDEQ
KyziOXoid7tBVYHlh3P9OE6Mxk0TJWty78I1/Ez4ONXCMb/BR/dTxzxm6k89EIwC
EKdDAaiVXJ4TFA5AdiTm5mU4G7+hwI+AD0Xk/RjpHLb+M/HTk/KbTYvTIRvwRK9W
KHL3dE7r/tg4B7ZiXIfRZUjvXZd4DMaDGhXhe9+PVAMBFEWi7Rvw8VhkbMUmyvw=
=iw0b
-----END PGP SIGNATURE-----

--pOnPAhI2wCv2OdstQikhqeq4qS4NmTtvK--
