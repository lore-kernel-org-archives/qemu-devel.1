Received: from eggs.gnu.org ([2001:4830:134:3::10]:45517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIL5k-0006cA-Ki
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIL5j-0004XC-Sb
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:33:12 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-38-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6ce55b41-fd9f-d735-b4ae-3433b49cc34e@redhat.com>
Date: Mon, 14 May 2018 23:33:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-38-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ziOK85ojrAkBq3mD9HRPN4fx4nVsjSSea"
Subject: Re: [Qemu-devel] [PATCH 37/42] job: Move progress fields to Job
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
--ziOK85ojrAkBq3mD9HRPN4fx4nVsjSSea
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <6ce55b41-fd9f-d735-b4ae-3433b49cc34e@redhat.com>
Subject: Re: [PATCH 37/42] job: Move progress fields to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-38-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-38-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> BlockJob has fields .offset and .len, which are actually misnomers toda=
y
> because they are no longer tied to block device sizes, but just progres=
s
> counters. As such they make a lot of sense in generic Jobs.
>=20
> This patch moves the fields to Job and renames them to .progress_curren=
t
> and .progress_total to describe their function better.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h | 25 -------------------------
>  include/qemu/job.h       | 27 +++++++++++++++++++++++++++
>  block/backup.c           |  8 ++++----
>  block/commit.c           |  4 ++--
>  block/mirror.c           |  4 ++--
>  block/stream.c           |  4 ++--
>  blockjob.c               | 26 ++++++++------------------
>  job.c                    | 10 ++++++++++
>  qemu-img.c               |  8 ++++++--
>  9 files changed, 61 insertions(+), 55 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ziOK85ojrAkBq3mD9HRPN4fx4nVsjSSea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6AJAACgkQ9AfbAGHV
z0BYjgf/U4JuthpkzFxMEhpwNiULjNFZag08tXtQmr4F3Ot+t0vv0NkkmSm/9/bH
BDBUtrch0aXmg227N2jL46zQh7oSfTruvGcFnkMignZzM59hQKNNAf3aQ7/8uQ9Y
M6XUwEghBln9PTyltks84DAQ9gmD2T3eepSn64smBgaOVILuXve+FaNtLYdEvOEk
oTkMVfuQmzDXg0gOV1mZ8A7ZVIy3nSH2mPdcKaNAD+EN1krDWJlUNHwmtcyvgccW
WBBicXebJp1re6WMxbTB091yqXpBkz995Ox8qTX3qQaPaAzo3muyEFZLXLwbS+nb
U4N4rKPugi9ogzfNCo4olSa/fvII+Q==
=KdBN
-----END PGP SIGNATURE-----

--ziOK85ojrAkBq3mD9HRPN4fx4nVsjSSea--
