Received: from eggs.gnu.org ([2001:4830:134:3::10]:50348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4Pkx-00026N-S5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4Pkx-0005Sy-1D
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:42:11 -0400
References: <20180329110914.20888-1-famz@redhat.com>
	<20180404132332.GR4467@stefanha-x1.localdomain>
	<20180404134923.GL12052@lemon.usersys.redhat.com>
	<20180405125509.GJ32222@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8ca0deb-75b7-b8a5-14fa-ff67fbb559f7@redhat.com>
Date: Fri, 6 Apr 2018 13:41:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180405125509.GJ32222@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fsT5BmSeuUNRXiinh4yPZn7CjLEymMxpN"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/8] qemu-img convert with
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fsT5BmSeuUNRXiinh4yPZn7CjLEymMxpN
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f8ca0deb-75b7-b8a5-14fa-ff67fbb559f7@redhat.com>
Subject: Re: [Qemu-block] [RFC PATCH 0/8] qemu-img convert with copy
 offloading
References: <20180329110914.20888-1-famz@redhat.com>
 <20180404132332.GR4467@stefanha-x1.localdomain>
 <20180404134923.GL12052@lemon.usersys.redhat.com>
 <20180405125509.GJ32222@stefanha-x1.localdomain>
In-Reply-To: <20180405125509.GJ32222@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/04/2018 14:55, Stefan Hajnoczi wrote:
> bdrv_copy_file_range() will invoke bdrv_co_copy_file_range_src() on
> src[qcow2].  The qcow2 block driver will invoke
> bdrv_co_copy_file_range_src() on src[file].  The file-posix driver will=

> invoke bdrv_co_copy_file_range_dst() on dst[raw].  The raw driver will
> invoke bdrv_co_copy_file_range_dst() on dst[file], which sees that
> src_bds (src[file]) is also file-posix and then goes ahead with
> copy_file_range(2).
>=20
> In the case where src[qcow2] is on file-posix but dst[raw] is on iSCSI,=

> the iSCSI .bdrv_co_copy_file_range_dst() call fails with -ENOTSUP and
> the block layer can fall back to a traditional copy operation.
>=20
> With this approach src[qcow2] could take a lock or keep track of a
> serializing request struct so that other requests cannot interfere with=

> the operation, and it's done in a natural way since we remain in the
> qcow2 function until the entire operation completes.  There's no need
> for bookkeeping structs or callbacks.

Could there be AB-BA deadlock if the guest attempts a concurrent copy
from A to B and from B to A?

Paolo


--fsT5BmSeuUNRXiinh4yPZn7CjLEymMxpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrHXQQACgkQv/vSX3jH
roP51Af/fQXHUQdy3yz9cwhB7vO8NUqdk2YO4y1LUxZO7+28I6Mq2WSCtBURGFIJ
ASWiE8qSpTiT5H4MSxWbNKJOZwaISG4KO1o64VhsGn/SINYwlBQSmDVlkjQZlWmr
71rLESIRfD2hYrIZ16QjgjCpPr0eWy3Ak+gKzWaUjjt7UaFtQc4goRBz+DZO0qDc
cbnWW2LhU8VxmL+OK2vCfHx/p7p768FI8Q6UUnQ5CNUd46FlKQ/7gwlQV4iAAVKA
+Up+yxtkRoTNiZlaV3AzVScWv1h9hPjFyce5eMLqwz0zCci+9JhHab48L1mMjQHF
EC8XpQQPHGW62nPK8IIAn6ZyHInM+g==
=6N9B
-----END PGP SIGNATURE-----

--fsT5BmSeuUNRXiinh4yPZn7CjLEymMxpN--
