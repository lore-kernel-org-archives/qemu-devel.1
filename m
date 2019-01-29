Received: from eggs.gnu.org ([209.51.188.92]:41799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goKAU-0004Uu-Dj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goKAT-0000sM-La
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:34:34 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1goKAT-0000sC-Fq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:34:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id i12so9006055pfo.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 19:34:33 -0800 (PST)
Date: Tue, 29 Jan 2019 11:34:28 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129033428.GF3264@stefanha-x1.localdomain>
References: <20190125172229.23025-1-cfergeau@redhat.com>
	<20190125172229.23025-2-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <20190125172229.23025-2-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] log: Make glib logging go through
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 06:22:29PM +0100, Christophe Fergeau wrote:
> This commit adds a qemu_init_logging() helper which calls
> g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> are handled similarly to other QEMU logs. This means they will get a
> timestamp if timestamps are enabled, and they will go through the
> HMP monitor if one is configured.
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
> ---
>  bsd-user/main.c             |  2 ++
>  include/qemu/error-report.h |  3 ++-
>  linux-user/main.c           |  2 ++
>  qemu-img.c                  |  2 +-
>  qemu-io.c                   |  2 +-
>  qemu-nbd.c                  |  2 +-
>  scsi/qemu-pr-helper.c       |  1 +
>  util/qemu-error.c           | 48 ++++++++++++++++++++++++++++++++++++-
>  vl.c                        |  2 +-
>  9 files changed, 58 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT8nEAAoJEJykq7OBq3PI61cH/iUeFAcfLlwaO8iWPL315RCg
sI/fwxvDll+ZH+eKwJdT4xYwUsKtEDDCyXWMNxpI3HXdy1QP21CA1A8K9j4yJeFp
8roO2Xfp9j7wfEsnEif50dR5p8kukQsKBaTXgCLSD+cNikfV7yVzbaAYKTgfgk9D
ejh0GId3EztMApZBgegXU7hMpj5EK9m9Xsgp7mXm5eQRZ5dMkMhJkICQ3fVDLugs
0OtuE7Oh1xtuuf3amZZgGtJiSyMezwHzt+MgZcYwQp6dEHeSwtTo+ifR1OkO+CrD
+SZv6EFQFEc+8kMCxOaQTn5QRL0MEveB4tqfAejUwbnfwVcAGF57sGQ4NMmrmU0=
=bsFk
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
