Received: from eggs.gnu.org ([2001:4830:134:3::10]:53810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUs6u-0007pm-E2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUs6q-0006SR-DP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:09:40 -0400
Date: Tue, 11 Jul 2017 11:09:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711100931.GN17792@stefanha-x1.localdomain>
References: <20170705102231.20711-1-stefanha@redhat.com>
	<1272552299.46884872.1499250365562.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SgT04PEqo/+yUDw3"
Content-Disposition: inline
In-Reply-To: <1272552299.46884872.1499250365562.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block: make
 .bdrv_create() a coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--SgT04PEqo/+yUDw3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 06:26:05AM -0400, Marc-Andr=E9 Lureau wrote:
>=20
>=20
> ----- Original Message -----
> > The BlockDriver->bdrv_create() function is always called from coroutine
> > context.  These patches rename it and clean up qcow2 code that is curre=
ntly
> > calling CoMutex functions outside coroutine_fn.
> >=20
> > Stefan Hajnoczi (2):
> >   block: rename .bdrv_create() to .bdrv_co_create()
> >   qcow2: make qcow2_co_create2() a coroutine_fn
> >=20
>=20
> I came to the same changes with my series, so
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

In that case:

NACK

Marc-Andr=E9 posted a more extensive series that does the same fixes.  He
is also the one who originally found this issue.  Drop my series.

Stefan

--SgT04PEqo/+yUDw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZKPbAAoJEJykq7OBq3PIwAMIAMUQwEeg9TDgo4lgJ7xqmdOD
lMG8r0zBsrwT+ZapXyTNqq/GEvRhK/6cRUwFkpxTpnbQU8KdjOW5cqM0hc+YJZD5
ykaUhPntMJsnixhZnFyG+7x1NAJ8gGHP5zRlqJG8z8v0ESw9xAeuA/9mzmUVBV/y
gIV2dMy5MW/nnaYR3j4nxK9v0g7qO9fUnzDGR7IAJyar0NqEEaBZBtffoGA2ZTaV
AY4k3WMuPvIlLSdM4vZIoR2jg+o4mMWyz2SyXiGjK5vHr0v/J6llmvH0+dVv/cRz
JjEW0A4n7b8txBi5wUkmeALI3t/zQJtoqTZxeUOoYuLXyAUuUEqHJuL4KW+SDlo=
=Sn5G
-----END PGP SIGNATURE-----

--SgT04PEqo/+yUDw3--
