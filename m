Received: from eggs.gnu.org ([208.118.235.92]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFsK-0005Ha-7G
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFj2-00041n-RJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:30:31 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-3-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f2a57eda-ba95-dd1e-62b5-4fd7f3cf97e5@redhat.com>
Date: Mon, 27 Aug 2018 13:25:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LjxRhHVamnsueZ11qC1ExMR0IcWlZmehd"
Subject: Re: [Qemu-devel] [PATCH v2 02/13] block/mirror: add block job
 creation flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LjxRhHVamnsueZ11qC1ExMR0IcWlZmehd
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <f2a57eda-ba95-dd1e-62b5-4fd7f3cf97e5@redhat.com>
Subject: Re: [PATCH v2 02/13] block/mirror: add block job creation flags
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-3-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Add support for taking and passing forward job creaton flags.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c            | 5 +++--
>  blockdev.c                | 3 ++-
>  include/block/block_int.h | 5 ++++-
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--LjxRhHVamnsueZ11qC1ExMR0IcWlZmehd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD35wACgkQ9AfbAGHV
z0Cj3Qf+IsqzqKpiYg1C9JFk/jiPaB3WHAEfKijq4ZJr8FM6xSaGPdywVHgGoPyO
411VuK1ucVWXKWfTWTUN4WLzXazD+AkYe2jG/zy3szrshytBQhTXF9hALhsrJgOV
M9vPWPvPkGqO7UnGWxofuvAL9580l4+YfEIpeHvqs6TP//qAkmW0g9fpKrQ/s9V3
8mRRf4oXgklJmyaSxxz8cNO5sw4eYdeoGJ0tyx8/+KfPawRY/m7Z2Ca6qGLUPIvI
cvI4MhePZ7pPAvTbkPInUcE32z28CVYhce4V3UWk+VwTDj9J6mPsnXkWS3UnkPxm
QRZ3k9yZQ/vIVkRwe4CJcm0/lgIBkQ==
=PN5f
-----END PGP SIGNATURE-----

--LjxRhHVamnsueZ11qC1ExMR0IcWlZmehd--
