Received: from eggs.gnu.org ([2001:4830:134:3::10]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEr9-0000tp-4S
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEl6-0007t1-68
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:28:32 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-5-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <18f0d76d-cd66-26a7-ef81-a6b9ef1c6c80@redhat.com>
Date: Mon, 27 Aug 2018 12:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JOLZN9tvuJ5BQM0x3alhoS6rw7IVHexgw"
Subject: Re: [Qemu-devel] [PATCH v2 4/9] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JOLZN9tvuJ5BQM0x3alhoS6rw7IVHexgw
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <18f0d76d-cd66-26a7-ef81-a6b9ef1c6c80@redhat.com>
Subject: Re: [PATCH v2 4/9] block/commit: utilize job_exit shim
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-5-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Change the manual deferment to commit_complete into the implicit
> callback to job_exit, renaming commit_complete to commit_exit.
>=20
> This conversion does change the timing of when job_completed is
> called to after the bdrv_replace_node and bdrv_unref calls, which
> could have implications for bjob->blk which will now be put down
> after this cleanup.
>=20
> Kevin highlights that we did not take any permissions for that backend
> at job creation time, so it is safe to reorder these operations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--JOLZN9tvuJ5BQM0x3alhoS6rw7IVHexgw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD0kIACgkQ9AfbAGHV
z0AXIAf+MUGpFtcZZCMA4PtAoVTWExH98O1JonD8tcZnYq5VAiczDrRPTi85ti5D
8+eKBDo6cf0OkSE/B03bpH37SBwgSNR0kBjtsZNIuLv5wZI2B5L918O7VeWWU6Tq
ljTkFjB6rKW9ywI0aJfA6ZDLV44O/vumk/nZnF1dcWZX5ZyeCkeHXCwPzN1m0NqI
7nPEgylKttuhF9cfcTYZ7fallIEN3W9Uj6jKbDyA9CtiJV8zK9rT/HiMR3lM1BrD
Wdl5p6opkMwo3UrijEgCkK6IW82BMwV9In5WEPtO2gMF+7VDWwbJjLZgW02vpx7S
Bht7UdnQUdLc78dPvxPgfVePhBOwvQ==
=JRNX
-----END PGP SIGNATURE-----

--JOLZN9tvuJ5BQM0x3alhoS6rw7IVHexgw--
