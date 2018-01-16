Received: from eggs.gnu.org ([2001:4830:134:3::10]:59703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSUn-0000uP-IS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSUk-0002Jh-Uu
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:45:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebSUk-0002Gk-M5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:45:46 -0500
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <829ceebd-4edb-44a4-7d91-828352e33fe1@redhat.com>
Date: Tue, 16 Jan 2018 08:45:25 -0600
MIME-Version: 1.0
In-Reply-To: <20180116134217.8725-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Vgc9bqEZPMH3L5hsYlCXwoMPhNcRUaRq"
Subject: Re: [Qemu-devel] [PATCH v5 08/14] qapi: force a UTF-8 locale for
 running Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Vgc9bqEZPMH3L5hsYlCXwoMPhNcRUaRq
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <829ceebd-4edb-44a4-7d91-828352e33fe1@redhat.com>
Subject: Re: [PATCH v5 08/14] qapi: force a UTF-8 locale for running Python
References: <20180116134217.8725-1-berrange@redhat.com>
 <20180116134217.8725-9-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:42 AM, Daniel P. Berrange wrote:
> Python2 did not validate locale correctness when reading input data, so=

> would happily read UTF-8 data in non-UTF-8 locales. Python3 is strict s=
o
> if you try to read UTF-8 data in the C locale, it will raise an error
> for any UTF-8 bytes that aren't representable in 7-bit ascii encoding.
> e.g.
>=20

>=20
> Many distros support a new C.UTF-8 locale that is like the C locale,
> but with UTF-8 instead of 7-bit ASCII. That is not entirely portable
> though. This patch thus sets the LANG to "C", but overrides LC_CTYPE
> to be en_US.UTF-8 locale. This gets us pretty close to C.UTF-8, but
> in a way that should be portable to everywhere QEMU builds.
>=20
> This patch only forces UTF-8 for QAPI scripts, since that is the one
> showing the immediate error under Python3 with C locale, but potentiall=
y
> we ought to force this for all python scripts used in the build process=
=2E
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2Vgc9bqEZPMH3L5hsYlCXwoMPhNcRUaRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeEAoACgkQp6FrSiUn
Q2qCJwgAnAaptDDDC2WaKGAUigDLAm4+AC2xwjAioi1ZdDt/XD97FoP8zRa1eOvs
IW5KwabkqNCzlqoAgro7QNIyZEW7xnGg6TEE97DTinfuq6ZtPygXd0vw2i9iz1f7
1Vh6/YDjLLz4uWkaBGjVSsm6s9k2JHrMWtLi7K0KaZBgVffFUGmwq1BbrNCwpRaK
FwQ0q6RFmrwhDIKScX7mwirtytuIeKQiZyQXErkYxfSR3Qgc9QA3RYcwUSLNILAT
prl5lfQtYspfnFojMKNrazoSi3lVi8BdgZIbKKkD5n2kQD8JuyMocCUTyAR5WnPq
1jQNcntMgIQxQdQ3xgVsUcgUi55T/Q==
=qCRK
-----END PGP SIGNATURE-----

--2Vgc9bqEZPMH3L5hsYlCXwoMPhNcRUaRq--
