Received: from eggs.gnu.org ([2001:4830:134:3::10]:56818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d47a6-0002ML-RY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d47a2-00068i-S4
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:13:14 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d47a2-00068Q-M8
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:13:10 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so11549196wmb.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 08:13:10 -0700 (PDT)
Date: Fri, 28 Apr 2017 16:13:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170428151307.GA10286@stefanha-x1.localdomain>
References: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 0/8] qemu-ga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 12:46:28AM -0500, Michael Roth wrote:
> The following changes since commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cd=
a9:
>=20
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into =
staging (2017-04-26 20:50:49 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-04-25-v2-tag
>=20
> for you to fetch changes up to 53c58e64d0a27c59d763778faa2b5a522c544719:
>=20
>   qga: Add `guest-get-timezone` command (2017-04-27 00:40:25 -0500)
>=20
> ----------------------------------------------------------------
> qemu-ga patch queue
>=20
> * new commands: guest-get-timezone, guest-get-users, guest-get-host-name
> * fix hang on w32 when stopping qemu-ga service while fs frozen
> * fix missing setting of can-offline in guest-get-vcpus
> * make qemu-ga VSS w32 service on-demand rather than on-startup
> * fix unecessary errors to EventLog on w32
> * improvements to fsfreeze documentation
>=20
> v2:
>  * document 'zone' field of guest-get-timezone as informational-only
>    (Daniel, Eric)
>  * fix build error for glib < 2.32 (Peter)
>=20
> ----------------------------------------------------------------
> Marc-Andr=E9 Lureau (1):
>       qga: improve fsfreeze documentations
>=20
> Sameeh Jubran (4):
>       qemu-ga: Make QGA VSS provider service run only when needed
>       qga-win: Enable 'can-offline' field in 'guest-get-vcpus' reply
>       qga-win: Fix a bug where qemu-ga service is stuck during stop opera=
tion
>       qga-win: Fix Event Viewer errors caused by qemu-ga
>=20
> Vinzenz Feenstra (3):
>       qga: Add 'guest-get-host-name' command
>       qga: Add 'guest-get-users' command
>       qga: Add `guest-get-timezone` command
>=20
>  configure                   |   2 +-
>  include/glib-compat.h       |   6 +++
>  qga/commands-posix.c        |  60 +++++++++++++++++++++++++
>  qga/commands-win32.c        | 105 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  qga/commands.c              |  49 +++++++++++++++++++++
>  qga/main.c                  |  23 ++++++++++
>  qga/qapi-schema.json        |  88 ++++++++++++++++++++++++++++++++++++-
>  qga/vss-win32.h             |   1 +
>  qga/vss-win32/install.cpp   |  28 +++++++++++-
>  qga/vss-win32/install.h     |  20 +++++++++
>  qga/vss-win32/provider.cpp  |   1 -
>  qga/vss-win32/requester.cpp |   2 +
>  qga/vss-win32/vss-common.h  |  11 +----
>  qga/vss-win32/vss-handles.h |  14 ++++++
>  14 files changed, 393 insertions(+), 17 deletions(-)
>  create mode 100644 qga/vss-win32/install.h
>  create mode 100644 qga/vss-win32/vss-handles.h
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZA1wDAAoJEJykq7OBq3PICKYH/0qQ/txn/Y78BEMxLLIbQwaP
yer9BqoFvsR0ux9w8U3vsk6sASxsVKbUnvbSNRqYCNaXA+Y0ckx3eVHbzaOSR4p6
cS+Qqu7n/pgr7ksGX8FSrki4kolPoKuS/LwXsyPlp1Oc5qMW0jwIHvKOv58LYo3f
b/oUJfuvexyR+ekydga8t60r5uajnzIPfnYvCf/4yoy2eL5rFZS65/jFDZOMJq8c
76942dn48nUlG0yyy8cqDQzP3BgfjqbD4iS2l4unOpw4jPk07ZIMnsdlrs6CLyo6
BeKUwxjMUTcIuTQCkJ10IFswGrgxyLjDE61+neQUbgqN+wm3q2IRSmSALqxdXhA=
=BjGS
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
