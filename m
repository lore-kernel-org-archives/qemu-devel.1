Received: from eggs.gnu.org ([2001:4830:134:3::10]:35357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePQ2o-0005PI-2j
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePQ2n-0004LL-Bn
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:43:10 -0500
Date: Thu, 14 Dec 2017 09:42:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214094259.GB14433@stefanha-x1.localdomain>
References: <20171213204611.26276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20171213204611.26276-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] blockjob: kick jobs on set-speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 03:46:11PM -0500, John Snow wrote:
> If users set an unreasonably low speed (like one byte per second), the
> calculated delay may exceed many hours. While we like to punish users
> for asking for stupid things, we do also like to allow users to correct
> their wicked ways.
>=20
> When a user provides a new speed, kick the job to allow it to recalculate
> its delay.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>=20
> RFC: Why is block_job_mutex shared between all jobs,
>      instead of being per-job?
>=20
>  blockjob.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMkejAAoJEJykq7OBq3PI/N4IAMXRvnApIsN3KN9TXG2l4wMV
BfqSFFu6BMPURXYMkKqm1y6OBWkR0+AiK5FqccjFBV41isETxvwmjzAaVnpl4jZ/
9kOHfyh+mSgsR2qwX4OsfEKD4E3vLsl3RlZZ5aTb07SWoyJozFJck8Hd6hTsO3mf
pEcgfPcTeEXfXWsVEuttJdBB44vGj1RjkKq786+8E0bAidX8iOoyKhTB09dHB/ED
YzFF0ZOm1oEroPmkViIF8mJdRrQHWe4YSKbWpuIikbP7jrbSUPRajbzWFbN/eeUf
UtxFCq6jpGy/NrQWCYytNedii6GPOLIUfpCB4hOAMbjWWT4QAmRuW+ma8mWM69w=
=+JEu
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
