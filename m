Received: from eggs.gnu.org ([2001:4830:134:3::10]:51250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTi-00061C-Kn
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTh-0004iz-De
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:58 -0400
Date: Wed, 18 Jul 2018 14:19:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718131951.GI21825@stefanha-x1.localdomain>
References: <20180712025420.4932-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <20180712025420.4932-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] nvme: Fix nvme_init error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 10:54:20AM +0800, Fam Zheng wrote:
> It is wrong to leave this field as 1, as nvme_close() called in the
> error handling code in nvme_file_open() will use it and try to free
> s->queues again.
>=20
> Another problem is the cleaning ups are duplicated between the fail*
> labels of nvme_init() and nvme_file_open(), which calls nvme_close().
>=20
> A third problem is nvme_close() misses g_free() and
> event_notifier_cleanup().
>=20
> Fix all of them.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v2: Adopt the suggested fix by Kevin.
> ---
>  block/nvme.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTz53AAoJEJykq7OBq3PI+gEH/1v0Ceuf+wcetAQhbuSuEKYI
rFw2DvekeUQePBc6zeicTWcLpR2+BIuH2/YLCrus8L87EepDQQfx8xw3d8UCZWTa
C4SEsbBx9SAYCmFuAsjVzm/QARgHSPPnPHWDcSnaA/ow1ZFy0llbjls6htzJAc7g
q2MVx5qjPLRb85+MRo8SphaXz8G9gJiOWUpqIYEhwYRdYJOQo92abU3uqtsZFjOV
mcXAfRkJaBOGbyupw7h0WMNWs4aKCcJ2c7Wa7lAEEcQP60kA8RMEcPiAfMiKzDt7
f9IuIO4YGQiJ13I+AQT2a3tVm1k4+owmE1mpAULjYFtnzdZBoWF/xs6NLPj5GzU=
=0glX
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
