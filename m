Received: from eggs.gnu.org ([209.51.188.92]:38190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gkTlQ-0006A7-O3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gkTlK-0000Mb-VE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:00:48 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-11-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <927a196d-fd7d-09bd-65f9-e5ef21c40629@redhat.com>
Date: Fri, 18 Jan 2019 14:00:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="32mu846D1xVSCs2TCxF3rSvoNHZPdtcR2"
Subject: Re: [Qemu-devel] [PATCH v5 10/11] block/backup: tiny refactor
 backup_job_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--32mu846D1xVSCs2TCxF3rSvoNHZPdtcR2
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <927a196d-fd7d-09bd-65f9-e5ef21c40629@redhat.com>
Subject: Re: [PATCH v5 10/11] block/backup: tiny refactor backup_job_create
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-11-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Move copy-bitmap find/create code. It's needed for the following
> commit, as we'll need copy_bitmap before actual block job creation. Do
> it in a separate commit to simplify review.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 69 +++++++++++++++++++++++++++++---------------------=

>  1 file changed, 40 insertions(+), 29 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--32mu846D1xVSCs2TCxF3rSvoNHZPdtcR2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxBzeQACgkQ9AfbAGHV
z0Bz5Af+JQqGX6mdfiWsjzlUctbRI5kbVpSHVvmNylfkkfu3t5kgU5kfCevIqE/F
w9onA1dVGoUd9N3ex7u4RXPPl9vu27DOMguD9aayKpOZlB1HZLFNqYr39qGVVd7z
lLUiJieQYmbX+k0iTK0pgCJU6SkF5qCFNdh4LhDx/brBAYal22HqjjnN7acLkf+r
JOrCcwyNwveW8MVzpzC8RgGVZ5D6bp0jYbRO70vgClh7XdHhj+fP1aiBlTYSIRdj
LuhRnrUNh6J9Wab4KwFE9nWBcULaP4Uyc8H52i6zoCdCbKnDnSeBwlcqKkaFWsLo
++48TWWwi9kR5mkIyCCbJip9nyoVZQ==
=6UU6
-----END PGP SIGNATURE-----

--32mu846D1xVSCs2TCxF3rSvoNHZPdtcR2--
