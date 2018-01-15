Received: from eggs.gnu.org ([2001:4830:134:3::10]:39936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8P5-00042t-Rn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8P3-0007wO-7R
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:18:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eb8P2-0007vr-UI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:18:33 -0500
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a662f65-159c-bef0-8d38-71c033fb02c1@redhat.com>
Date: Mon, 15 Jan 2018 11:18:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180115170243.24578-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rWiKveZiJKED6zrcG7wXpibLtjdTWtvJk"
Subject: Re: [Qemu-devel] [PATCH v4 04/13] qapi: Adapt to moved location of
 'maketrans' function in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWiKveZiJKED6zrcG7wXpibLtjdTWtvJk
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a662f65-159c-bef0-8d38-71c033fb02c1@redhat.com>
Subject: Re: [PATCH v4 04/13] qapi: Adapt to moved location of 'maketrans'
 function in py3
References: <20180115170243.24578-1-berrange@redhat.com>
 <20180115170243.24578-5-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 11:02 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/qapi.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 514cca44bf..1fdd189c0d 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1734,7 +1734,10 @@ def c_enum_const(type_name, const_name, prefix=3D=
None):
>          type_name =3D prefix
>      return camel_to_upper(type_name) + '_' + c_name(const_name, False)=
=2Eupper()
> =20
> -c_name_trans =3D string.maketrans('.-', '__')
> +if hasattr(str, 'maketrans'):
> +    c_name_trans =3D str.maketrans('.-', '__')
> +else:
> +    c_name_trans =3D string.maketrans('.-', '__')
> =20
> =20
>  # Map @name to a valid C identifier.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rWiKveZiJKED6zrcG7wXpibLtjdTWtvJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpc4mAACgkQp6FrSiUn
Q2rWPAf/U3v/j0k+ucA4vy9ksNox5npl9Lu6K/Om4aJE7Sgty/as1qq3Ap1510vt
I7qDiykCORMKZcMUa7nwGg+5b+H4hjQzL8vaYrG+fKlytzy43t3gUPfW7GitkoF9
+YBKw/nk3+xoMsAynXZFuCsXYtquEq+NXOH7lH16J0eYBgjlah1vZEkrNKe0HyuP
KeC1lPCa4jaIdkA0Fx4sG3I0URA/PXjwVBRzIBISgyZ/KP24RdkcrY3oYzu7lvBW
GhEmAiYB02D2DHzSnQzLF0Ol1DPlJCDYOLCkEzbO2180Kh1y28mIkIg0fTteHEel
AbolUQiSG7L4coCpy7CdENw+ig4tcw==
=yXMC
-----END PGP SIGNATURE-----

--rWiKveZiJKED6zrcG7wXpibLtjdTWtvJk--
