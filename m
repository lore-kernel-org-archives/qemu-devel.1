Received: from eggs.gnu.org ([2001:4830:134:3::10]:52666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evkpQ-0006es-Dv
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evkpP-0004AY-Hi
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:23:00 -0400
References: <20180313142003.12124-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <958efb4e-89fa-def5-0963-42c8259e99ca@redhat.com>
Date: Tue, 13 Mar 2018 15:22:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180313142003.12124-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Ejob497YZblYocwhR7bAcB8MwwlT77an"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: Fix permission during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Ejob497YZblYocwhR7bAcB8MwwlT77an
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <958efb4e-89fa-def5-0963-42c8259e99ca@redhat.com>
Subject: Re: [PATCH v3 0/2] block: Fix permission during reopen
References: <20180313142003.12124-1-famz@redhat.com>
In-Reply-To: <20180313142003.12124-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 15:20, Fam Zheng wrote:
> v3: Fix test case. [Max]
>=20
> v2: Use update_flags_from_options. [Kevin]
>=20
> We write open the whole backing chain during reopen. It is not necessar=
y and
> will cause image locking problems if the backing image is shared.
>=20
> Fam Zheng (2):
>   block: Fix flags in reopen queue
>   iotests: Add regression test for commit base locking

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7Ejob497YZblYocwhR7bAcB8MwwlT77an
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqn3r0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/ukH/2zvFia6Ani7t+toYeC+ed4pPr/2UTVE
w0ZnxJxeiYppZS/Ia6B75GLPhXfdslen2LgftA36RS3SumAYQpdo4vQ2/WDuFsoT
FOl3fEQHuVq/p0FTYhTw5nccq3GmxW6rDoqGpwObbcmzTDsKsjxOrAKDJO0iyGnV
qUlt4rA3dHQWYnj0GEQgqwYDU7sKD4+UdedPVmYb2CIo+oBn0v0mdRpVWshH+P3T
alsmEL4u8eFUw2iKdgx2FbwP5c2Re6/cFAoAEMhu0qIdGS2qy1Vkq22zWM8cWBHl
Ut7QN7lPVJqxPNEWw/Eg2MFUBbmFtFsD8H5idtzaTyxTMi2AwExa+rU=
=VWAc
-----END PGP SIGNATURE-----

--7Ejob497YZblYocwhR7bAcB8MwwlT77an--
