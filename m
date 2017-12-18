Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwPu-00014P-Vk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwPu-0008QK-7s
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:29:18 -0500
Date: Mon, 18 Dec 2017 14:29:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218142904.GL16653@stefanha-x1.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-6-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-6-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/7] block/commit: use block_job_throttle
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


--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 07:59:51PM -0500, John Snow wrote:
> Depending on the value of `speed` and how fast our backends are,
> delay_ns might be 0 very, very often. This creates some warning
> messages that spook users, but it's also pretty inefficient.
>=20
> Use block_job_throttle instead to yield a little more intelligently.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN9CwAAoJEJykq7OBq3PIvTwIAITxWMCSUi4upTjIuUJHlB5/
LhLt10m7UyVLr9IVNT9BOtwiGV1RgLIyyq9GNRfU2690o0pcY6y5SYFLOenHgyyD
3VGz6yu3dBD9DYIYGqGTsLHrn1hAxDs+Uzn2Er7GhYnkFxM3bP9j6oXVNbqZkpL2
kt3DBnhJyEiP2UnurGsosHgwxOkMnd4MvenZxmr184+T7vNpgMuw8Ho1XdbJa3Sr
TQmrs4WP1qF1Dbax8n/9mblhO4hJn2huBdDIncdkZZVCRxwiIAOJxKl8VqSL8qfB
hzqJoqMI0qE/LAPsE1DfwgdR7U62NCAlIdloNqcaLAqnUDS5TIPVacolt1nbbQA=
=PViP
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--
