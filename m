Received: from eggs.gnu.org ([209.51.188.92]:54197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghy0H-0008K7-66
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghy0G-00078Z-6t
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:41:45 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-2-git-send-email-marcolso@amazon.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <415436f1-56ec-586a-8500-c18a4bcd2959@redhat.com>
Date: Fri, 11 Jan 2019 15:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <1542006398-30037-2-git-send-email-marcolso@amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Nw7bnNBH03SvYsK1lEAoIHl77Yya7970"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] blkdebug: Extend rule check for
 additional types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Nw7bnNBH03SvYsK1lEAoIHl77Yya7970
From: Max Reitz <mreitz@redhat.com>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <415436f1-56ec-586a-8500-c18a4bcd2959@redhat.com>
Subject: Re: [PATCH v3 2/3] blkdebug: Extend rule check for additional types
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
 <1542006398-30037-2-git-send-email-marcolso@amazon.com>
In-Reply-To: <1542006398-30037-2-git-send-email-marcolso@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 08:06, Marc Olson wrote:
> Break out the more common parts of the BlkdebugRule struct, and make
> rule_check() more explicit about operating only on error injection type=
s
> so that additional rule types can be added in the future.
>=20
> Signed-off-by: Marc Olson <marcolso@amazon.com>
> ---
>  block/blkdebug.c | 59 +++++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 31 insertions(+), 28 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5Nw7bnNBH03SvYsK1lEAoIHl77Yya7970
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw4qxMACgkQ9AfbAGHV
z0CT9wgAuVI/MCxQhAm/1jKgnd01ut9qYF7j+N02zrLf72eKm9ZgKDVkrpXag2t3
LlyX58TRopwmg/CRKeVhY+stMGB5s9MV77JIXdDOeY51Vz22LdeR5RlEBbmjixfG
qqMMyonoZIpy8Egbrsv/eLmGPXPzz6VTkqz0F8+2JQu0Z60rMoassFkVPJPU+xPL
EIv6TWMdt0N1PxTGhqjayUbyq3EHyElDJcAG4Ou8CTYkBcJvoOPHxvH0JDRSOvF+
zvEtoaCy7kdU94BNYjyscpNxemZCdMq6DDnwdGyRWilGO4yxrDT4ay22T3U69TIn
h4YTadvcpzCXTvopM1H/vdRLfFuaEQ==
=pxaP
-----END PGP SIGNATURE-----

--5Nw7bnNBH03SvYsK1lEAoIHl77Yya7970--
