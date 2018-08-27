Received: from eggs.gnu.org ([2001:4830:134:3::10]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFNS-00011D-Mf
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFCm-0007ce-Ib
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:57:09 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-10-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <29fed4d6-de2c-8ef3-c003-6407d8129735@redhat.com>
Date: Mon, 27 Aug 2018 12:56:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-10-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lkcnwuUgm1aMFKr8jDXg6QLf3u3P2x3wT"
Subject: Re: [Qemu-devel] [PATCH v2 9/9] jobs: remove job_defer_to_main_loop
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
--lkcnwuUgm1aMFKr8jDXg6QLf3u3P2x3wT
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <29fed4d6-de2c-8ef3-c003-6407d8129735@redhat.com>
Subject: Re: [PATCH v2 9/9] jobs: remove job_defer_to_main_loop
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-10-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Now that the job infrastructure is handling the job_completed call for
> all implemented jobs, we can remove the interface that allowed jobs to
> schedule their own completion.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/job.h | 17 -----------------
>  job.c              | 40 ++--------------------------------------
>  2 files changed, 2 insertions(+), 55 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--lkcnwuUgm1aMFKr8jDXg6QLf3u3P2x3wT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD2PMACgkQ9AfbAGHV
z0AHvwgAlj7PL5IK3qfRVr4wIlztSiKnsL06YnDZH1/Wrcci1fjCVvswB5q1+mUD
fRg+u+FtMYzp+PUJpRgMXYdK4RYpjqnod0RtN+WNO6db59fnnwy8QD2GJaTq+yQ7
VvQ6z+vOxamdUNEVIAHjKgmOI25m2vPPF7z07h4sangaFP63y7Q/2kaLPsGb72/6
ruo3xtAFR56VwXfEIn0AtfTvn4NsN86dz4FKwSz1DLF0RUnLj0OVJrQCeJMzjDR5
ZOHEeyNONnTw3QgnBLeBrNbS/8DJruw2rWYvGLZMWR6xvPLWLbArHQAiu9znwAMj
b+ftSErfn9p1twWBWy/dBZTHpOrj/g==
=SDhx
-----END PGP SIGNATURE-----

--lkcnwuUgm1aMFKr8jDXg6QLf3u3P2x3wT--
