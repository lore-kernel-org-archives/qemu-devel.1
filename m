Received: from eggs.gnu.org ([2001:4830:134:3::10]:46780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsS9P-0001uI-CK
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsS9O-00051I-EF
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:22:15 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-8-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <576e0cd4-9f3e-0861-1236-fbe8573516c2@redhat.com>
Date: Wed, 22 Aug 2018 14:21:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mk3agGBPavoqlC0xjef91KyVmnHp6xvtA"
Subject: Re: [Qemu-devel] [PATCH 7/7] jobs: remove job_defer_to_main_loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mk3agGBPavoqlC0xjef91KyVmnHp6xvtA
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <576e0cd4-9f3e-0861-1236-fbe8573516c2@redhat.com>
Subject: Re: [PATCH 7/7] jobs: remove job_defer_to_main_loop
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-8-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
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

In addition, you could make job_completed() static to job.c.

Max


--mk3agGBPavoqlC0xjef91KyVmnHp6xvtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9VWIACgkQ9AfbAGHV
z0Cqfwf9H1+JYZF6wltWJ95sbd3Kwb35ti1kAGKm2UBhKhHMdCbAyh+g/VF4gcK9
MAvGBmYaGsxCjcn0X5r/ndjDGAzaZ0rYinnfGqbPdbvZZZCl8U7VnVwEb0HzwRMT
WKrFVl6ayuVHGY1egBdiYuK6nWAsV+fkzeicMPqDMcIk58wDJLZYgWkBJJmN1XQd
IAFzdzoc6GybNzC4UEG8P4DdZJlNlvcbBhtZTGSYxDvaakACV93ribp6UftOMSet
yYHR2uoJcCHbswL/TLkjVFRG42PucwYe7GQyYrOL9pXDXnh9vn5ssWVB7WuXAkbK
4WXgVdFjMFEAUxQ7RsJBsAmWlQLAeg==
=Eqyb
-----END PGP SIGNATURE-----

--mk3agGBPavoqlC0xjef91KyVmnHp6xvtA--
