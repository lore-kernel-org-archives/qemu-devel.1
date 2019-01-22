Received: from eggs.gnu.org ([209.51.188.92]:57519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gm1Ih-0008IM-RL
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gm1Ic-0004wK-2p
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gm1Ia-0004vX-8o
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA4D058E59
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:13:43 +0000 (UTC)
Date: Tue, 22 Jan 2019 14:13:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190122141341.GB23035@stefanha-x1.localdomain>
References: <20190121170434.13592-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20190121170434.13592-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 06:04:35PM +0100, Christophe Fergeau wrote:
> This commit adds a qemu_init_logging() helper which calls
> g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> are handled similarly to other QEMU logs. This means they will get a
> timestamp if timestamps are enabled, and they will go through the
> monitor if one is configured.
> This commit also adds a call to qemu_init_logging() to the binaries
> installed by QEMU.
> glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
> glib default log handler.
>=20
> At the moment, this change will mostly impact SPICE logging if your
> spice version is >=3D 0.14.1. With older spice versions, this is not going
> to work as expected, but will not have any ill effect, so this call is
> not conditional on the SPICE version.
>=20
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> One more iteration of the patch as it hit CI failures
> (https://patchew.org/QEMU/20181214105642.673-1-cfergeau@redhat.com/ )
> Only difference from v4 is the addition of #include "qemu/error-report.h"
> in bsd-user and linux-user.
>=20
>=20
>  bsd-user/main.c             |  2 ++
>  include/qemu/error-report.h |  2 ++
>  linux-user/main.c           |  2 ++
>  qemu-img.c                  |  1 +
>  qemu-io.c                   |  1 +
>  qemu-nbd.c                  |  1 +
>  scsi/qemu-pr-helper.c       |  1 +
>  util/qemu-error.c           | 47 +++++++++++++++++++++++++++++++++++++
>  vl.c                        |  1 +
>  9 files changed, 58 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRyUVAAoJEJykq7OBq3PIY9kH+wWKCmxqTMfQJWH2GXlbfDVf
klxvr4psrOvf/3fMlZzHY9lKHilGFP/CDNIJftw7Vqh0IoHeMpQ3SBqBL1rhTb1K
e5WMcSxTH1DyA7qzpwZQNgFwb9PFtAyREG4rXC4exVMbyH0UXPAEnBBRCu2wkUMv
Z3cYyTZb0axuvZKTOhK07gYB1rjDPLBQfLSGTUAAcrC9+V2gdySV0vOLHiBJWGg0
dGYE3jsk5HocP3IhuSYM+7KEfs9Mr/lavelpSK0Rx2KIKDT+ePob5MvZE/Ai9nrQ
auDluTfZsR3BUeTslZB3K3u05efoLyGORpC+WeG2LgGacO6jfuansFyNbuyJ390=
=D0ia
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
