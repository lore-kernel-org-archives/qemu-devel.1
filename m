Received: from eggs.gnu.org ([2001:4830:134:3::10]:42346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECQ2-0004Uc-Nn
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECPz-0000Qg-M7
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:52:14 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cECPz-0000QB-Fq
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:52:11 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so15463439wjb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:52:11 -0800 (PST)
Date: Tue, 6 Dec 2016 09:51:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206095108.GG12630@stefanha-x1.localdomain>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9] QAPI patches for 2016-12-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 05:45:04PM +0100, Markus Armbruster wrote:
> A set of fixes for MacOS from Eric, and a little documentation
> polishing from Marc-Andr=E9.  The diffstat for the .json may look scary,
> but the generated code is identical.
>=20
> The following changes since commit bd8ef5060dd2124a54578241da9a572faf7658=
dd:
>=20
>   Merge remote-tracking branch 'dgibson/tags/ppc-for-2.8-20161201' into s=
taging (2016-12-01 13:39:29 +0000)
>=20
> are available in the git repository at:
>=20
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2016-12-05
>=20
> for you to fetch changes up to 5072f7b38b1b9b26b8fbe1a89086386a420aded8:
>=20
>   qapi: add missing colon-ending for section name (2016-12-05 17:41:38 +0=
100)
>=20
> ----------------------------------------------------------------
> QAPI patches for 2016-12-05
>=20
> ----------------------------------------------------------------
> Eric Blake (3):
>       qmp-event: Avoid qobject_from_jsonf("%"PRId64)
>       test-qga: Avoid qobject_from_jsonv("%"PRId64)
>       tests: Avoid qobject_from_jsonf("%"PRId64)
>=20
> Marc-Andr=E9 Lureau (6):
>       qga/schema: fix double-return in doc
>       qapi: fix schema symbol sections
>       qapi: fix missing symbol @prefix
>       qapi: fix various symbols mismatch in documentation
>       qapi: use one symbol per line
>       qapi: add missing colon-ending for section name
>=20
>  qapi-schema.json                   | 346 +++++++++++++++++++------------=
------
>  qapi/block-core.json               | 209 +++++++++++-----------
>  qapi/block.json                    |  16 +-
>  qapi/common.json                   |  14 +-
>  qapi/crypto.json                   |  36 ++--
>  qapi/event.json                    |  58 +++----
>  qapi/introspect.json               |  28 +--
>  qapi/qmp-event.c                   |  17 +-
>  qapi/rocker.json                   |   2 +-
>  qapi/trace.json                    |   8 +-
>  qga/qapi-schema.json               |  52 +++---
>  tests/check-qjson.c                |   6 +-
>  tests/test-qga.c                   |   7 +-
>  tests/test-qobject-input-visitor.c |   5 +-
>  14 files changed, 406 insertions(+), 398 deletions(-)
>=20
> --=20
> 2.5.5
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRooMAAoJEJykq7OBq3PII2YIAMYxmGpsMyaSuBli4TBgTV2V
2NOMqg2FWSfPdjQT0jPMTNmRI1ksRx2oty7i48NwPw9H/Um7p3EMcQcb7feUpYP4
ZQMByXJU9mYRQLc/MsAk/dJO2Jzeza/uctGMtjqNYs2UfcVuYw90a82ptxHP/f91
QCJCI0F3lDOJ4FEGe8XYNDa3vulO/yoWRoI93fPFzb5FYvdUalT2sfN1nX+hlu0I
Ov4MDBTP+QcAm9pW9OBVhaIFzToW/ESfIpb6kqT7E8U/Y454ISAXrLyL+Il+11LF
gzbM3O/FZcTq1ST/spDYi8uJRfeMAVSK8euEZdEQkF9LM5RXYb8gJWREKkysp1Y=
=4kuH
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
