Received: from eggs.gnu.org ([2001:4830:134:3::10]:33264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSaq-0005rl-HA
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSan-0005yX-Ei
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:52:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebSan-0005y2-6H
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:52:01 -0500
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-11-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09245bb8-bc24-17b8-945e-5cee3da9fd37@redhat.com>
Date: Tue, 16 Jan 2018 08:51:30 -0600
MIME-Version: 1.0
In-Reply-To: <20180116134217.8725-11-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EBH0RpwAKxIEX4UthFM4cCre1knMA3fWg"
Subject: Re: [Qemu-devel] [PATCH v5 10/14] configure: allow use of python 3
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
--EBH0RpwAKxIEX4UthFM4cCre1knMA3fWg
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09245bb8-bc24-17b8-945e-5cee3da9fd37@redhat.com>
Subject: Re: [PATCH v5 10/14] configure: allow use of python 3
References: <20180116134217.8725-1-berrange@redhat.com>
 <20180116134217.8725-11-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-11-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:42 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  configure | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

Presumably, you tested with this patch first in the series to come up
with patches 1-9 ;)

> diff --git a/configure b/configure
> index b272a0336b..60b99f45f6 100755
> --- a/configure
> +++ b/configure
> @@ -1598,9 +1598,8 @@ fi
> =20
>  # Note that if the Python conditional here evaluates True we will exit=

>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6) or sys.=
version_info >=3D (3,))'; then
> -  error_exit "Cannot use '$python', Python 2.6 or later is required." =
\
> -      "Note that Python 3 or later is not yet supported." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then=

> +  error_exit "Cannot use '$python', Python 2 >=3D 2.6 or Python 3 is r=
equired." \
>        "Use --python=3D/path/to/python to specify a supported Python."
>  fi
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EBH0RpwAKxIEX4UthFM4cCre1knMA3fWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeEXMACgkQp6FrSiUn
Q2rU6AgAkENLz93iigAdFb1Ng2qbyEcvVbmspUTGADYmT9+HiZ1OswD3VRVWKRP9
nNtXU1d6NM3nCb4ShBzmesA2XzcqZ8yfDQXrL6zJzDWlS7zfezjHPodtDS9KnY8B
k4Wh1nzr323HthEhycSVH9FcvOCHpmCX5PqL0e+Fgok5cMl+u5WHdhmeGFf8DaNv
BaGaj+r0t/GYpu1cY/k/OYS1KgKiL61vyjTDOGna37iokZUkOqMRXEffkav5Ul9Y
o/jexbGyMa3rzr/KPQqhDT3Y86vfyM7gXjKFYBvIpwyXKnkntAbTDxkiMUs3yZyq
RAgrC9Dx7dMqPijVeetECPcWaNp2Rg==
=P55Q
-----END PGP SIGNATURE-----

--EBH0RpwAKxIEX4UthFM4cCre1knMA3fWg--
