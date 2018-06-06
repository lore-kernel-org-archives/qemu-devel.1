Received: from eggs.gnu.org ([2001:4830:134:3::10]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeGA-0003x6-UQ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeG9-0008UD-79
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:38:18 -0400
References: <20180606193702.7113-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c4206420-f623-4a64-7b28-1bf66b932be2@redhat.com>
Date: Wed, 6 Jun 2018 21:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180606193702.7113-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ePXUYlzbPrE01mByVOf2aLQFrd4kvUFqx"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qcow2: Do not mark inactive images
 corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ePXUYlzbPrE01mByVOf2aLQFrd4kvUFqx
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <c4206420-f623-4a64-7b28-1bf66b932be2@redhat.com>
Subject: Re: [PATCH v2 0/3] qcow2: Do not mark inactive images corrupt
References: <20180606193702.7113-1-mreitz@redhat.com>
In-Reply-To: <20180606193702.7113-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 21:36, Max Reitz wrote:
> The non-public logs in
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1583346 (sorry...) reveal=

> this problem:
>=20
> $ (Create a qcow2 file "foo.qcow2" with a corrupted first L1 entry)
> $ echo 'qemu-io none0 "read 0 512"' \
>     | x86_64-softmmu/qemu-system-x86_64 -drive if=3Dnone,file=3Dfoo.qco=
w2 \
>                                         -monitor stdio \
>                                         -incoming exec:'cat /dev/null'
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "read 0 512"
> qcow2: Marking image as corrupt: L2 table offset 0x44200 unaligned (L1 =
index: 0); further corruption events will be suppressed
> qemu-system-x86_64: block/io.c:1691: bdrv_co_pwritev: Assertion `!(bs->=
open_flags & BDRV_O_INACTIVE)' failed.
> [1]    18444 done                 echo 'qemu-io none0 "read 0 512"' |
>        18445 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -dr=
ive if=3Dnone,file=3Dfoo.qcow2 -monitor stdi
>=20
> Oops.

And I forgot to CC qemu-stable this time.

Oops =C3=972


--ePXUYlzbPrE01mByVOf2aLQFrd4kvUFqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYOB0ACgkQ9AfbAGHV
z0DARgf/U3mP9AIt29rkf8neWx2ppasFKwc2Y4pZ9MF926gDDT+4m8PkTD+b/QMb
UUI6OQhqrny8lRzcYfY6lPfitGqbrWFHqf1+PbMxKfVCTpC1e91qF9/G8sOs3nbZ
K26pFAyM1/0KEpgCbDPIy6FpHji9eomYugK9Y+hw1MZXje2LWMVHnhTAJ8cMqyBG
Vu9uQMsntU57HNNzBglewnEpGajPgvlA0OxmKKJ2gG2TIqztLcBl9f4gesTFF7YP
xhwNrWN2tpRLxH5sE/PfpgR7BTkXHHmiKacJG+rXKXj/15qFR2zvMGSJUjuJ1I3G
LfNBJOFNzkn57+1R4Enz+WbIm1qS4A==
=kJFW
-----END PGP SIGNATURE-----

--ePXUYlzbPrE01mByVOf2aLQFrd4kvUFqx--
