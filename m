Received: from eggs.gnu.org ([2001:4830:134:3::10]:54390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgpW-0002xu-5O
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgpR-0005b8-P9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAgpR-0005Zq-Fp
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:36:29 -0400
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <033fbe20-eee5-aaef-c828-3065b2c04ab3@redhat.com>
Date: Fri, 3 Nov 2017 13:36:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6aP4jrTTTJP1Ox5UutdRQt4dbnOLjNJ6S"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] build: don't fail if given a git
 submodule which does not exist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6aP4jrTTTJP1Ox5UutdRQt4dbnOLjNJ6S
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <033fbe20-eee5-aaef-c828-3065b2c04ab3@redhat.com>
Subject: Re: [PATCH v3 4/5] build: don't fail if given a git submodule which
 does not exist
References: <20171103153333.6416-1-berrange@redhat.com>
 <20171103153333.6416-5-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 10:33 AM, Daniel P. Berrange wrote:
> If going back in time in git history, across a commit that introduces a=
 new
> submodule, the 'git-submodule.sh' script will fail, causing rebuild to =
fail.
>=20
> This is because config-host.mak contains a GIT_SUBMODULES variable that=
 lists
> a submodule that only exists in the later commit. config-host.mak won't=
 get
> repopulated until config.status is invoked, but make won't get this far=
 due to
> the submodule error.
>=20
> This change makes 'git-submodule.sh' check whether each module is known=
 to git
> and drops any which are not present. A warning message will be printed =
when any
> submodule is dropped in this manner.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20

> +do
> +    $GIT submodule status $m 1> /dev/null 2>&1
> +    if test $? =3D 0
> +    then
> +        modules=3D"$modules $m"
> +    else
> +        echo "warn: ignoring non-existant submodule $m"

s/existant/existent/

With the typo fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6aP4jrTTTJP1Ox5UutdRQt4dbnOLjNJ6S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8tysACgkQp6FrSiUn
Q2rTsggAiUV+vREuF+vDFEPO+RSZVpdicLD1GI1BEEmiauMXu6PyVmE/GfHs8RDY
TX++N8Vl1291oYcMixvcsZQ+/WIDUWMunVz77MtZ31awuhssFJb09oTWRQtHYdpG
+ARiB+AnSnoWlUC2fPMh1ADiXjIoik4IFW17oA7PQfKBOwKTdcr1BHjdmFs5C5ih
GM0HsrDg5k7kW/+rwlGvZSGilxN73hrs+22+b6pjuJlOwUObAmmCg3z+puBf+CUS
eJx3HEQPViSmbQJqlIJxJVM65agT/5PmiDmsuncPIWotPvv2JRDNKaaPcFdQ5Vvq
Z2VU7vsxmlapHBp/AB+Oh+i7EimRCg==
=4bvT
-----END PGP SIGNATURE-----

--6aP4jrTTTJP1Ox5UutdRQt4dbnOLjNJ6S--
