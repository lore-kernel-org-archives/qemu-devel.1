Received: from eggs.gnu.org ([2001:4830:134:3::10]:38471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhPR-00014D-TE
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhPR-0002vC-6x
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:58:45 -0400
Date: Thu, 10 May 2018 09:58:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510085838.GH1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/9] iscsi: Create and use
 iscsi_co_wait_for_task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 10:58:12PM +0800, Fam Zheng wrote:
> This loop is repeated a growing number times. Make a helper.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/iscsi.c | 54 +++++++++++++++++-------------------------------------
>  1 file changed, 17 insertions(+), 37 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9Am+AAoJEJykq7OBq3PI8XcH/iSoG5syR4zRrQtPuTTdYM+Y
oGm2ciG3mb9zCrY4ystLHYo74PzPMdA9AlliIa0QJSw7cihAQHgJc/LHWcsrLZHI
q0joiSrB4Di7giGxPYHcV3eHTgSqi7TXpSkvTSsHUTiXAaX3MgTM858o23PcfGHV
SdHMBwbKazFNBxG4FDQJ3WXFCI2wvcrpQ84HxIjHoYbkwu22CaqO1ZFou6UXw0r/
s5FSqojd96NqC68cDxwU6+c76tBaUtpIbYw3R+9bgC7Kkn6rGaIIsJyaREVq7h2L
/+f8e3EOnrF14OHJEfckeJ0sC4sk0lxKCWTViJ8TS0QVxdeIraXt2YJwZDqT0XM=
=WCxI
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
