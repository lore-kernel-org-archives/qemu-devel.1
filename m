Received: from eggs.gnu.org ([2001:4830:134:3::10]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX5aX-0006iS-NI
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX5aW-0003iM-OK
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:29:41 -0500
Date: Thu, 4 Jan 2018 13:29:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104132934.GG10106@stefanha-x1.localdomain>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-6-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <1513595351-5899-6-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 5/5] block/parallels: add backing support
 to readv/writev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 02:09:11PM +0300, Denis V. Lunev wrote:
> From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
>=20
> Since parallels format supports backing files, refine
> readv/writev (allocate_clusters) to redirect read/write requests
> to a backing file (if cluster is not available in the current bs).
>=20
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTiw+AAoJEJykq7OBq3PIaPwH/1+mv25x/rSMlcbnTooS4BkO
RV1fCkUczCD1lqpmZo0vLlW4g5LgvbQPOgznuesdMeJfCsH5gJG44jeS+tE4hb2j
R4wcIGZ740LFXSfsr5L4+ztwmWerIOsoBBJpcNyJgNkq21B5DigkCNNKCXj95DwM
0jetE+cY1Fmf9QJ3ONHSPvbSSRA+LyE8dBJX3CYgeuqAhfF8EyE60GcV2BQzh3Gh
QKA9CwGYn8RZT/YJy6GmlDwSx9wmLahXxDxEX0Snx5ZLy57FUsRBg3WJ/f8n8IKY
gOZIjh0z6E6Gs03wIwZm4myjdcXGvXQi3j3hdJKCROw+5SoabtheS2U24EIhc/8=
=bPGN
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
