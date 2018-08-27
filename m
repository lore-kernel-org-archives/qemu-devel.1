Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuH67-0003EV-M5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuH16-0007Pf-Jc
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:53:14 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-7-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c1e934f1-82d4-5668-a7ac-8cdc05372ced@redhat.com>
Date: Mon, 27 Aug 2018 14:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-7-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JmsOaNykJqT10DZqUPERQUGKwDj2RK0rH"
Subject: Re: [Qemu-devel] [PATCH v2 06/13] block/commit: refactor stream to
 use job callbacks
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
--JmsOaNykJqT10DZqUPERQUGKwDj2RK0rH
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <c1e934f1-82d4-5668-a7ac-8cdc05372ced@redhat.com>
Subject: Re: [PATCH v2 06/13] block/commit: refactor stream to use job
 callbacks
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-7-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

@subject: s/commit/stream/

On 2018-08-24 00:22, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/stream.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

This is a nice patch.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--JmsOaNykJqT10DZqUPERQUGKwDj2RK0rH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD9CkACgkQ9AfbAGHV
z0CU1ggAgCMwzI4yFJL6rtysQYkTbqPz8vSeXAw+U1hCekpeA9vgpXpodSVn9jfH
yqNpxYDevIk9eeB2u6UYlXfSYB7vLz/yzglhfK0GDB2RX/fsCQlj4yk3JaxDlUVH
jwjKy+UxX2cSS0ZOM5kQ2ApACXANPebrlVHkjNskV+dZi1vGmxCYlh35i4+O2/dr
sQJvco5+8PmQUIOmKXY4AIaMYdVSLiLfd19VaZ4Ln6L1yU9xU7uoBYR/nVtcL0mo
qvZjRR4ORr8i5Mo4mf3VqmsP3Cu66MU/rAqr0WrU9T1yupVk8O9tvtZLGBzCynjD
mWmV5Yr0JDY2Th950hUZbGiXf3WwLw==
=6Huh
-----END PGP SIGNATURE-----

--JmsOaNykJqT10DZqUPERQUGKwDj2RK0rH--
