Received: from eggs.gnu.org ([2001:4830:134:3::10]:37930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6bh-00016i-LT
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6bg-0007ki-U1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:33:45 -0400
Date: Thu, 6 Apr 2017 13:33:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406123335.GI21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-9-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-9-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 08/16] block/file-posix:
 Preallocation for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:28PM +0200, Max Reitz wrote:
> By using raw_regular_truncate() in raw_truncate(), we can now easily
> support preallocation.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5jWfAAoJEJykq7OBq3PIK8wIAIcsWccdNp2w/LEgyvyqOoih
sAbaXkhztTldSq8SFQM+FlQqdZb8KQx5GnoClBjbSWyjlje13ti4hTtw5d1SnHLy
eTGO0RlgZIK16t3kkCUCPKv82g+Di6VTFXWw6Lq26fNz2s1aUEr7WwR4rRmn97/f
wR50NO0Xu7kmX7wH61Nr5SGgirLBa0Mk2f4bCavWOsq4/0+s2TqjYM1LeJ/WT/GS
GPO1kRgRHDVpIIMR5Trih5WvD/Q/cboecBzzkla/+fSp+izDtg3v2YrlM+FQrhwT
8ALsvofJZFEznTPCZMIfQZlm147hBLoWAM0T+4pXJomVTmsk1OS/WiIDJh7kMGc=
=pClw
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
