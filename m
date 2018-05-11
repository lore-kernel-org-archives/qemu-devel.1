Received: from eggs.gnu.org ([2001:4830:134:3::10]:42582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGWr-0001gK-Ad
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGWq-0006Jl-GG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:28:45 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9d18d578-3d86-5254-1de8-5156555c5ef0@redhat.com>
Date: Sat, 12 May 2018 00:28:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q89dfnOIMbuBVgIgSZ7Lz4mxnYFJKOn5C"
Subject: Re: [Qemu-devel] [PATCH 06/42] blockjob: Add block_job_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q89dfnOIMbuBVgIgSZ7Lz4mxnYFJKOn5C
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <9d18d578-3d86-5254-1de8-5156555c5ef0@redhat.com>
Subject: Re: [PATCH 06/42] blockjob: Add block_job_driver()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-7-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> The backup block job directly accesses the driver field in BlockJob. Ad=
d
> a wrapper for getting it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/blockjob.h | 7 +++++++
>  block/backup.c           | 8 +++++---
>  blockjob.c               | 5 +++++
>  3 files changed, 17 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--q89dfnOIMbuBVgIgSZ7Lz4mxnYFJKOn5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2GRAACgkQ9AfbAGHV
z0Cfmgf7BQqKjUILelStJbzzhIDIKt7kJxYLS1ngwZ2lijQTmVrhQc8qBuQrD4O+
tuWi+oP4avoOsv2zsqcQcE46BKAwtc4mKDcLYGaPmgmDt9N83x9QhWzPyi6i17V1
gJKPn8bYpR9tpZY07A1gR7z973xIqLszzaEWtHgQgK+5fjUazczfuRKj+4CnK/N9
KlVNAK/ECHe0nhZEladcWC8oiiGEIO9zAO6F2Eb0e8sf/hFgTAY1/4HSwvqvjcoQ
1GnGlRccZraSetQdLtcFiITQQPpWJgGJOnJM4meNAQoK4OU0E5/MKzcsodRQ6uQE
qAag5ayth0rySCDC70w+hUMiJKMUKA==
=ddnt
-----END PGP SIGNATURE-----

--q89dfnOIMbuBVgIgSZ7Lz4mxnYFJKOn5C--
