Received: from eggs.gnu.org ([2001:4830:134:3::10]:43275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp4CH-0002ZF-1g
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 22:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp4CF-0007GZ-Rw
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 22:34:25 -0400
References: <20170207235757.2026-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9aace1af-8673-9829-116d-8deebd908cc5@redhat.com>
Date: Sat, 18 Mar 2017 03:34:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Io3ij4xjKLFcd0A5ocnRx61stQtv32P0b"
Subject: Re: [Qemu-devel] [PATCH] progress: Show current progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Io3ij4xjKLFcd0A5ocnRx61stQtv32P0b
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9aace1af-8673-9829-116d-8deebd908cc5@redhat.com>
Subject: Re: [PATCH] progress: Show current progress on SIGINFO
References: <20170207235757.2026-1-mreitz@redhat.com>
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 00:57, Max Reitz wrote:
> Currently we only print progress information on retrieval of SIGUSR1.
> Some systems have a dedicated SIGINFO for this, however, so it should b=
e
> handled appropriately if it is available.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Can anyone test this on a BSD system? O:-)
> ---
>  util/qemu-progress.c | 3 +++
>  qemu-img.texi        | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Ping


--Io3ij4xjKLFcd0A5ocnRx61stQtv32P0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljMnKcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/SUH/j9DaZiYbPg3Mf+xQvwAAv2oPWH62/Cb
fXo1KsbHYsxTUO98oPoCzfT0skQGsm7H6Mli2pw+J/8enZwoJML/qsYb5Ji+V8K0
g2mCIftPWebRtrCmIONwG/6vT7eLJ43r3cWaHrgkGZSvqS48aTTDRla8Zpb2e/1M
qXB2t99sgjKzXVwztbG9Xef+24Rk73IKwI0B8Z2z7Dt78fY3xwK6zZpWUqL3e1ET
dwhrZTlAwXqsiWdAYyA39KntKz3r+x7Xd0xXYNNSHoubVsY4EMdy7WtIc28X5CA3
I1OJGPRkpB92QJt98cRNSDn5U9MZvdMqcAhl0qufTuW1/gEXE/Lht3g=
=TTch
-----END PGP SIGNATURE-----

--Io3ij4xjKLFcd0A5ocnRx61stQtv32P0b--
