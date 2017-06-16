Received: from eggs.gnu.org ([2001:4830:134:3::10]:36999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLuFV-00055U-31
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLuFU-0003LR-4r
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:37:29 -0400
References: <20170613172006.19685-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6a9f4539-6e7d-7ca6-0699-59c18377e0bf@redhat.com>
Date: Fri, 16 Jun 2017 18:37:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170613172006.19685-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VJ3n0Q2SwIB6ll7uuMFnMxFOPnh2liEfP"
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix gcc 7 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJ3n0Q2SwIB6ll7uuMFnMxFOPnh2liEfP
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a9f4539-6e7d-7ca6-0699-59c18377e0bf@redhat.com>
Subject: Re: [PATCH 0/2] block: Fix gcc 7 warnings
References: <20170613172006.19685-1-mreitz@redhat.com>
In-Reply-To: <20170613172006.19685-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 19:20, Max Reitz wrote:
> blkdebug and blkverify use snprintf() to generate a filename; however,
> that may not fit into the target buffer (BDS.exact_filename). If so,
> they generate a truncated and thus pretty much unusable filename. In
> this case it's better to just not generate a filename at all (until we
> have better infrastructure which is not bound by a static buffer size).=

>=20
> Also, gcc 7 warns about these snprintf() instances and these patches fi=
x
> these warnings. There is another one in hw/usb/bus.c which is not
> addressed by this series.
>=20
> Max Reitz (2):
>   blkdebug: Catch bs->exact_filename overflow
>   blkverify: Catch bs->exact_filename overflow
>=20
>  block/blkdebug.c  | 10 +++++++---
>  block/blkverify.c | 12 ++++++++----
>  2 files changed, 15 insertions(+), 7 deletions(-)

Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--VJ3n0Q2SwIB6ll7uuMFnMxFOPnh2liEfP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZRAk/EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPGC
CACT0HNAiSnmpY0Doa7JDI+PPephYpc8bPGqkgFsENdEh/TBXhaHQq5xtLYMb+4h
W4QVsU+uUy1Wz1M/3YBODezTEibK+Ow6ouUyQajBxDbD8lOJPvfx7mvRYUj9FTff
xuRg0amQtrSScPq0quR5jnxJowt3DJAV/Xslm4JUW+CaoxMDpE9scHv6x9hmkkt1
5nckNIdF3qjQoFZ4LhIop5pWhodFPHBQnaWSbLFaDOCyHCl3ulByjHoB53KN/+zH
NOxbZ+TaLpnztC9lADE+FyY4ngWLlIeaQ5siHFt08AL+Ye4wTH72GAFqCkHrWjoe
eHkYiMLaJ1hjFgBpaLbKiYKM
=sEIR
-----END PGP SIGNATURE-----

--VJ3n0Q2SwIB6ll7uuMFnMxFOPnh2liEfP--
