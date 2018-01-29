Received: from eggs.gnu.org ([2001:4830:134:3::10]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egCkd-0005I3-Uq
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egCkY-0001HL-6G
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:57:48 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ce7c11c5-bb34-fc54-308e-9f4ade6237fb@redhat.com>
Date: Mon, 29 Jan 2018 17:57:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v78XtRLE58aUd3tAwQTayBAea2cOHAHUw"
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v78XtRLE58aUd3tAwQTayBAea2cOHAHUw
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <ce7c11c5-bb34-fc54-308e-9f4ade6237fb@redhat.com>
Subject: Re: [RFC PATCH 02/10] block/qapi: Add qcow2 create options to schema
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-3-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-11 20:52, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1749376c61..9341f6708d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3320,6 +3320,37 @@
>  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> =20
>  ##
> +# @BlockdevQcow2CompatLevel:
> +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (vers=
ion 2)
> +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (versi=
on 3)
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'BlockdevQcow2CompatLevel',
> +  'data': [ '0_10', '1_1' ] }

Just my two cents: I'd prefer 2 and 3 because I've never quite liked
that people are supposed to remember some pretty random qemu version
numbers anyway.

Max


--v78XtRLE58aUd3tAwQTayBAea2cOHAHUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvUnsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASv8H/iOe2H3UoKIdzm00LwlmZEXMrwSRuiC6
ugESmmBM31c9+lKlzLpY9kfc3qRxKqBAEmJN13gTSC5MtEjZmeirIWASDlm743OF
IY9AqKhlirXlb11HzGgEnYYrfHWefnCfaCRo160yKsbv7/K/X2845KT1+8XStjS7
6qPT8dr6GMhceV4ZBWFd0hfZ31MVYJX5hqZwVE9g28CaCpaKAotqoBQjA9fWby9S
t4lPx5/tyBqccwp6LG365w8TE73Nt13ViF0ooSPbyUi2AQlX88KwzQ+lw1+fb9Iu
YWirh/4j9G++SmQRNmP3RCoWs8fcWJRh76RNhYkTWRfKTwj6jomJX4A=
=XSnC
-----END PGP SIGNATURE-----

--v78XtRLE58aUd3tAwQTayBAea2cOHAHUw--
