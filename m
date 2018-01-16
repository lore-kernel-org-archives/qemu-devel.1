Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSdj-0008L5-A2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSdd-0007yl-Qq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:55:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebSdd-0007y9-Gz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:54:57 -0500
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-12-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b080e172-7d37-6d76-8960-2614a8d24f3f@redhat.com>
Date: Tue, 16 Jan 2018 08:54:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180116134217.8725-12-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pMfji57fdUgQ9FypfctLvMnCYfy5mEFOW"
Subject: Re: [Qemu-devel] [PATCH v5 11/14] input: add missing JIS keys to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Miika S <miika9764@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMfji57fdUgQ9FypfctLvMnCYfy5mEFOW
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Miika S <miika9764@gmail.com>
Message-ID: <b080e172-7d37-6d76-8960-2614a8d24f3f@redhat.com>
Subject: Re: [PATCH v5 11/14] input: add missing JIS keys to virtio input
References: <20180116134217.8725-1-berrange@redhat.com>
 <20180116134217.8725-12-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-12-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:42 AM, Daniel P. Berrange wrote:
> From: Miika S <miika9764@gmail.com>
>=20
> keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana=

>=20
> Signed-off-by: Miika S <miika9764@gmail.com>

Not a typical legal name (since a Signed-off-by is a legal statement for
tracing copyright restrictions, using an actual name instead of a
pseudonym is preferable; however, we have examples of commits in the
past that did not do so, so I'm not going to insist on this one).

> ---
>  hw/input/virtio-input-hid.c | 7 +++++++
>  qapi/ui.json                | 5 ++++-
>  ui/keycodemapdb             | 2 +-
>  3 files changed, 12 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pMfji57fdUgQ9FypfctLvMnCYfy5mEFOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeEgwACgkQp6FrSiUn
Q2qlIAf/XvGhrqwTEJL70RbXUI5Cb0EhIcNZf8ljItWIJr4qa5zw1DTFbP89aYmc
KYJnRytxnes2Ufwx+YU3k63+ok6pMRzeDsZuAXhmLFHCh5qPuoKgWnpuBFzPfZ+c
cdG7czS0+GkMJFHcfI+rNzPC5JF6CXZD250akTkrUnn0QteLGxfvU9/iYB9ekgPl
PbH94PFxPrgvO7ZprAvrfdRrb+UFS1Xb+cLB2EivsfXRJEvHjQgdN3jMpylunwxq
hRgO2ZRcv2b3gSkGIMczVvbUW4BQPZBXTUAqNHLp6FOa4kwrB2lzbpIetx8gbOGQ
bLN85iD3vHidZpa6yIAKM+UZQMMTsg==
=S6FL
-----END PGP SIGNATURE-----

--pMfji57fdUgQ9FypfctLvMnCYfy5mEFOW--
