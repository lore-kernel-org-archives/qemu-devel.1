Received: from eggs.gnu.org ([2001:4830:134:3::10]:47419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcfv-0003Bd-0Q
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcfu-0003xn-7P
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:58:55 -0500
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97ffde23-8da4-fc99-85f0-a96d05b9fca6@redhat.com>
Date: Tue, 14 Nov 2017 15:58:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h3CBxm7WG4Ju1DDCbVfmWGdver7saFQ9N"
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3CBxm7WG4Ju1DDCbVfmWGdver7saFQ9N
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com,
 den@openvz.org, stefanha@redhat.com
Message-ID: <97ffde23-8da4-fc99-85f0-a96d05b9fca6@redhat.com>
Subject: Re: [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-23 11:29, Vladimir Sementsov-Ogievskiy wrote:
> Snapshot-switch actually changes active state of disk so it should
> reflect on dirty bitmaps. Otherwise next incremental backup using
> these bitmaps will be invalid.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/snapshot.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--h3CBxm7WG4Ju1DDCbVfmWGdver7saFQ9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLBIgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYGEH/1UpzdZxrtN03JrCBIiy7b1BRkQbdYUE
U0SyFqsp2WYONcPqxirEjAdQYzIXm7R6vWhjqEsRdzHSiXpLoJCucUppo9Xs1cZQ
qYWrUNF1pzwPIQmgI7FCnK7xbQAiXbwtdIsWLN7GWMCSCWqXOHTZ3SsC4Ec3SAnW
Oqp99vHNm15P8ic2ZbYx9ASbG2aFQyJfr1efiHTjVlkxQfM/IsWlHLhJ1Lqd0kVP
lH5XGpo3BGgkHIoW29cl0DrV+58nhcE+FUEBfQn0Y2shvhnoRBhNKx/OfHHmfbsw
/ANCqae1x1S9/5MhmEm1ZLDIWcp1cr0txTAHLUO11pjcywqgv41xTvc=
=Ve3I
-----END PGP SIGNATURE-----

--h3CBxm7WG4Ju1DDCbVfmWGdver7saFQ9N--
