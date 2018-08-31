Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvjaz-0005lR-Ps
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvjQN-00041X-TF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:25:21 -0400
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-9-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d5c669fa-b30e-0d1f-3d66-238c95413e9e@redhat.com>
Date: Fri, 31 Aug 2018 15:25:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180830015734.19765-9-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pAsc8KtzHAnbU2jBKj1a6XnpPKofQOFAO"
Subject: Re: [Qemu-devel] [PATCH v3 8/9] jobs: remove ret argument to
 job_completed; privatize it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pAsc8KtzHAnbU2jBKj1a6XnpPKofQOFAO
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com
Message-ID: <d5c669fa-b30e-0d1f-3d66-238c95413e9e@redhat.com>
Subject: Re: [PATCH v3 8/9] jobs: remove ret argument to job_completed;
 privatize it
References: <20180830015734.19765-1-jsnow@redhat.com>
 <20180830015734.19765-9-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-30 03:57, John Snow wrote:
> Jobs are now expected to return their retcode on the stack, from the
> .run callback, so we can remove that argument.
>=20
> job_cancel does not need to set -ECANCELED because job_completed will
> update the return code itself if the job was canceled.
>=20
> While we're here, make job_completed static to job.c and remove it from=

> job.h; move the documentation of return code to the .run() callback and=

> to the job->ret property, accordingly.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/job.h | 28 +++++++++++++++-------------
>  job.c              | 11 ++++++-----
>  trace-events       |  2 +-
>  3 files changed, 22 insertions(+), 19 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--pAsc8KtzHAnbU2jBKj1a6XnpPKofQOFAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluJQawACgkQ9AfbAGHV
z0Aklwf8CF/xxfyis5OwhHMlizeXuv40IvN6zk2HJl8YAdDq+9HRGno04EQopEfY
FoIA1WtMhragUt39ctm9vMrTr/VDzWXnoxRRHnVVdPZ9ry0pIfa4OhJARCvAq4lz
+Nhaz0f3+ht4KJdJLVbfxMiM2z84VDcvmWtsJlRfBpYGkZOfcgVh6/a25Osr+hRa
hwDk2VyM3DkRI4raTGEtkFM7nAn/umF0w7tyFGkSpuv0oKJR7vTa2bygjcMQMbHo
IeXiwcKs50LTIXxw1hW/kpSD0y0UFzJN7auSlqWAMmwab7IcLGZo+7WhQ1I9cOjt
Ck7wuw3ovUmk38vyRZXLoyRXSNGnjQ==
=PjP+
-----END PGP SIGNATURE-----

--pAsc8KtzHAnbU2jBKj1a6XnpPKofQOFAO--
