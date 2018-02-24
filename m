Received: from eggs.gnu.org ([2001:4830:134:3::10]:50887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbyR-0002Gj-Du
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbyQ-0006V4-IB
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:42:55 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7bb5f194-1783-2ff5-7d66-7d2f5af64c5a@redhat.com>
Date: Sat, 24 Feb 2018 16:42:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180122220806.22154-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f0AgZ9J6vro11upN7I2yAxBXTpXvN5kjU"
Subject: Re: [Qemu-devel] [PATCH v2 00/16] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f0AgZ9J6vro11upN7I2yAxBXTpXvN5kjU
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <7bb5f194-1783-2ff5-7d66-7d2f5af64c5a@redhat.com>
Subject: Re: [PATCH v2 00/16] block/mirror: Add active-sync mirroring
References: <20180122220806.22154-1-mreitz@redhat.com>
In-Reply-To: <20180122220806.22154-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

P=C3=AFng

On 2018-01-22 23:07, Max Reitz wrote:
> This series implements an active and synchronous mirroring mode.
>=20
> Currently, the mirror block job is passive an asynchronous: Depending o=
n
> your start conditions, some part of the source disk starts as "dirty".
> Then, the block job will (as a background operation) continuously copy
> dirty parts to the target disk until all of the source disk is clean.
> In the meantime, any write to the source disk dirties the affected area=
=2E
>=20
> One effect of this operational mode is that the job may never converge:=

> If the writes to the source happen faster than the block job copies dat=
a
> to the target, the job can never finish.
>=20
> When the active mode implemented in this series is enabled, every write=

> request to the source will automatically trigger a synchronous write to=

> the target right afterwards.  Therefore, the source can never get dirty=

> faster than data is copied to the target.  Most importantly, once sourc=
e
> and target are in sync (BLOCK_JOB_READY is emitted), they will not
> diverge (unless e.g. an I/O error occurs).
>=20
> Active mirroring also improves on a second issue of the passive mode: W=
e
> do not have to read data from the source in order to write it to the
> target.  When new data is written to the source in active mode, it is
> automatically mirrored to the target, which saves us the superfluous
> read from the source.


--f0AgZ9J6vro11upN7I2yAxBXTpXvN5kjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqRh/ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArhsH/2ljLb6Qq24ZKuSVPNyN4+Wh1zHuqd2f
w8jD+9Tt6D6E7o8Wt1v9CLqu14zdmYY2Y+U/u0nsthJ/f47s+rbbiLd+flkY7oLG
jFE0L3wTT++vfNeTKeb6tyS9l5mlc2qJvELVTG7/MT0mRBiiXtaHnuyqUXtviwgM
LBezlekMrVILDW9eLg8nDsOmRciz1bKPmji+KYohXxL93HqDE9hzehzQTJPzIHaS
wkQhilP7+roCaIMSgU7abbNsBvqOlPX9krdwEByI9TVf7aDf2BBjKpkSIvdTdN3G
0vXNCk6cf6MSIUTmLRJrEBunTXp1X7u9AvXKiYa98msyLOZdglXFU9w=
=0PJb
-----END PGP SIGNATURE-----

--f0AgZ9J6vro11upN7I2yAxBXTpXvN5kjU--
