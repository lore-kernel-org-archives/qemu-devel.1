Received: from eggs.gnu.org ([209.51.188.92]:43214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmfuM-0002h8-Q0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmfuL-0007e0-PR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:23:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gmfuL-0007c7-Gz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:23:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2308D4E92B
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:23:04 +0000 (UTC)
Date: Thu, 24 Jan 2019 14:22:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190124142256.GF4764@stefanha-x1.localdomain>
References: <20190123120016.4538-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20190123120016.4538-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] trace: make systemtap easier to use
 for simple logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 12:00:12PM +0000, Daniel P. Berrang=E9 wrote:
> This is a followup to
>=20
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04173.html
>  v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04759.html
>  v3: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05477.html
>=20
> Changed in v4:
>=20
>  - Fix license to be GPLv2-or-later (Eric)
>  - Misc typo fixes (Eric)
>=20
> Changed in v3:
>=20
>  - g_strndup the QXL log_buf before printing to avoid a race
>    with guest removing the nul terminator (Stefan)
>  - Add filtering of PIDs with "-p PID" arg to qemu-trace-stap
>  - Add a man page for qemu-trace-stap (Eric)
>  - Remove examples in docs/devel/tracing.txt and just refer
>    people to the above man page.
>  - Use strerror(errno) instead of raw errno in vfio traces (Eric/Alex)
>  - Quote probe wildcards to be shell glob safe (Eric)
>  - Mention explicitly that it is launched separately from QEMU (Eric)
>=20
> Changed in v2:
>=20
>  - Fix safety of QXL logging
>  - Handle format specifier macros is a more reliable manner
>  - Fix trace-events files missing newline
>  - Remove use of %m formats
>=20
> Daniel P. Berrang=E9 (4):
>   display: ensure qxl log_buf is a nul terminated string
>   trace: enforce that every trace-events file has a final newline
>   trace: forbid use of %m in trace event format strings
>   trace: add ability to do simple printf logging via systemtap
>=20
>  MAINTAINERS                          |   1 +
>  Makefile                             |  10 ++
>  Makefile.target                      |  11 +-
>  docs/devel/tracing.txt               |   4 +
>  hw/display/qxl.c                     |  14 ++-
>  hw/display/trace-events              |   2 +-
>  hw/gpio/trace-events                 |   2 +-
>  hw/vfio/pci.c                        |   2 +-
>  hw/vfio/trace-events                 |   2 +-
>  scripts/qemu-trace-stap              | 175 +++++++++++++++++++++++++++
>  scripts/qemu-trace-stap.texi         | 140 +++++++++++++++++++++
>  scripts/tracetool/__init__.py        |   6 +
>  scripts/tracetool/format/log_stap.py | 127 +++++++++++++++++++
>  13 files changed, 487 insertions(+), 9 deletions(-)
>  create mode 100755 scripts/qemu-trace-stap
>  create mode 100644 scripts/qemu-trace-stap.texi
>  create mode 100644 scripts/tracetool/format/log_stap.py
>=20
> --=20
> 2.20.1
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcScpAAAoJEJykq7OBq3PIQU4H/0UNPjY1QLq6uyTL44wKMY+U
QtdeupAZmNP0rxRB84xOhaMsS6KOKUMtGFRoZ+/1HE8AdYro8HoLzreDXCSx2jHy
3wduL52SIzHHIvEcGzdKeQIcL4L2TzWwY3mEN/MALoPE8XJFs+iDL73Q/pWzeTWo
ZzsWMWPc9bgu89ELpMkQmJ8yG2YQyj3BnyRC2SbTxyp3aDRttAbNmXLJ/19bw9lo
KSikLQ56cEokn6koPDf/5fjBeqw5YyPo4W/KsRj08ffqLO6xoXoVcYCAdReEduJh
BSGuroUf/8ftMHhSi+B95ZxnOZc2OLNUBa22K9NI3GS5r1ls92RcSDCUhyTtooc=
=72zd
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
