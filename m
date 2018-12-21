Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <victortoso@redhat.com>) id 1gaLXa-0005ja-JC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <victortoso@redhat.com>) id 1gaLXV-000605-OT
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:12:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <victortoso@redhat.com>)
	id 1gaLXU-0005kd-UM
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:12:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2083C04BD5F
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:12:19 +0000 (UTC)
Date: Fri, 21 Dec 2018 15:12:09 +0100
From: Victor Toso <victortoso@redhat.com>
Message-ID: <20181221141209.5obaoqxf4mwkrq6v@wingsuit>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x7coqdvsw4djv7t2"
Content-Disposition: inline
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/12] spice: add -display spice-app,
 setup and launch a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com


--x7coqdvsw4djv7t2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 20, 2018 at 06:15:41PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> The QEMU GTK UI is quite featurful. Yet, it doesn't provide many of
> the functionalities one can expect from a VM desktop application (USB
> redirection, shared folders, drag and drop, better multimonitor
> support etc.).
>=20
> Spice is able to export many of the VM controls to a client, including
> QMP monitor, serial ports etc... It's thus possible for a Spice client
> to provide a similar experience as the QEMU GTK UI (while keeping
> similar display performances locally) and more.
>=20
> This series provides "-display spice-app" to setup a Spice server and
> launch a client (associated with the spice+unix:// URI). With
> virt-viewer series "Add QEMU-like UI: VT console & basic VM state"
> (under review), the resulting user experience is close to what qemu
> GTK UI provides.

Not much knowledge on the qemu codebase but I tested this and v1
with spice-gtk + virt-viewer patches and it works well so,

Tested-by: Victor Toso <victortoso@redhat.com>

> v2:
> - renamed -display app -> -display spice-app
> - error if full-screen or window-close is provided (supports can be
>   added later)
> - use a stable URI when -name is provided
> - print the URI at start
> - added "qapi: document DisplayType enum"
> - added "spice: use a default name for the server"
> - commit message tweaks
> - include previously reviewed "configure: bump spice-server required
>   version to 0.12.5", to avoid conflicts
> - rebased
>=20
> Marc-Andr=E9 Lureau (12):
>   configure: bump spice-server required version to 0.12.5
>   char/spice: trigger HUP event
>   char/spice: discard write() if backend is disconnected
>   spice: avoid spice runtime assert
>   spice: merge options lists
>   spice: do not stop spice if VM is paused
>   char: move SpiceChardev and open_spice_port() to spice.h header
>   char: register spice ports after spice started
>   build-sys: add gio-2.0 check
>   qapi: document DisplayType enum
>   spice: use a default name for the server
>   display: add -display spice-app launching a Spice client
>=20
>  qapi/ui.json            |  31 ++++++-
>  include/chardev/spice.h |  27 ++++++
>  include/ui/qemu-spice.h |   6 --
>  chardev/spice.c         |  70 +++++++-------
>  hw/display/qxl.c        |   2 -
>  ui/spice-app.c          | 200 ++++++++++++++++++++++++++++++++++++++++
>  ui/spice-core.c         |  21 +++--
>  chardev/trace-events    |   1 +
>  configure               |  17 +++-
>  qemu-options.hx         |   5 +
>  ui/Makefile.objs        |   5 +
>  11 files changed, 330 insertions(+), 55 deletions(-)
>  create mode 100644 include/chardev/spice.h
>  create mode 100644 ui/spice-app.c
>=20
> --=20
> 2.20.1.2.gb21ebb671b
>=20
>=20

--x7coqdvsw4djv7t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAlwc9LgACgkQl9kSPeN6
SE8UIA//RprmIKq5wbfqxWANexmCeWIH6A1FflJZcNUFCkTvp+smB3w7WE6eRCD9
CpmDRwsDOWMQO2muN2upn9VmaQYbhiW9GNIttSMCe2e89FiYZOGTAVh91LbdAt+p
+s8ocRwXudlmR7HWIzqgcx1TF2y8dzFdNKGAk3akOWNcW9zQkvyUuAFH9WgHbxm2
IqQpUqT17YCLP1gwVelMToOLIiYRDF42x3oaCKXbH1ivIxuhuoFUyKop0RxSI2df
D2LXKZDBMzf4yD6XuwKiN0mCT/iHMh5usLtoJ/Ucdi6rmP0IhOCZYkS5lJIsk+QC
sxsppEIlPgg6FghEQ7nLPSsbmvU2Fkyapak2naRlDfmjedZrq07cwx0BgidGxBg2
LZ4D9oGXBRw/GnmbYIX6cNmANPZFEqMr7Yr/ytNDJtbCjEKan/N+CG8IA+AMXXku
h6GVsngX3gCH2UhC9qYyDE66e0T6VoJIug3GqcNSF92pd9B2ojOtV1DdBQ9mdUEn
5kAx+BLw/jFxoqocvuUh67HHZEtKrmBqxgbiVEj/5ex59N1twebWBfl9NIeXGky9
oR9I9+i8oDdJ8FhZMTyH6lFIn8gossH/PlKB+P/LvVY2mZ7uvpHJYEahmKHoVUUj
vewMWLNh1UfvRUdJaCPN4X+T+nmIBF2mcPxjquCRre+mKi0HjH8=
=7Irt
-----END PGP SIGNATURE-----

--x7coqdvsw4djv7t2--
