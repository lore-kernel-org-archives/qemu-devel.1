Received: from eggs.gnu.org ([2001:4830:134:3::10]:37817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhLd-0007Oi-Uw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhLd-00016U-81
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:54:50 -0400
Date: Thu, 10 May 2018 09:54:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510085442.GG1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/9] iscsi: Query and save device
 designator when opening
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


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 10:58:11PM +0800, Fam Zheng wrote:
> The device designator data returned in INQUIRY command will be useful to
> fill in source/target fields during copy offloading. Do this when
> connecting to the target and save the data for later use.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/iscsi.c            | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/scsi/constants.h |  2 ++
>  2 files changed, 43 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9AjSAAoJEJykq7OBq3PI38QH/Rxt85EA0/5Du0plZi0qy3H+
ZJWsOoNF97eKXDuSSr7PXlyei4Q+UoZY6FKRbHAQk2KENxOWlGseKp8AX7M0S0Ku
7wkIO9fqtZQxb79TUthA/+ecHNgO/TuD9FuE78En3JhPI+U3AAp0xcy/XZ40e9ba
/tPgX33z6CeiuVwU3UzC9GpeNireAMOl2MfYdCymaVLx/t7b8htxTU/B6FTkkLWs
/kwyblx2Q3+2wG3HqrIMr/BpqWLID13yUgs9jeoA9kjmSPl3C6UQJgnB332nbATw
eNc8bCavb+Z9ormSLRGoFt9kxxXMvuLTy/Z0AZkhYYTsx5M1Q6NKx2BIZ2ZzMaQ=
=n5gz
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
