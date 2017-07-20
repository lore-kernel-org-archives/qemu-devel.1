Received: from eggs.gnu.org ([2001:4830:134:3::10]:35823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYByC-0008UW-1w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYBy7-00052p-VA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYBy7-00052L-LR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:58:19 -0400
References: <20170720134716.13049-1-alex.bennee@linaro.org>
	<20170720134716.13049-3-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d780ed0-6e1e-d480-6e0b-fb294c8a130a@redhat.com>
Date: Thu, 20 Jul 2017 08:58:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170720134716.13049-3-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CWNcSPEUjLALLn9kMjePtBrofI8ATKkQK"
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 2/3] docker: fix dirty/stash
 detection on some systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CWNcSPEUjLALLn9kMjePtBrofI8ATKkQK
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d780ed0-6e1e-d480-6e0b-fb294c8a130a@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 2/3] docker: fix dirty/stash
 detection on some systems
References: <20170720134716.13049-1-alex.bennee@linaro.org>
 <20170720134716.13049-3-alex.bennee@linaro.org>
In-Reply-To: <20170720134716.13049-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 08:47 AM, Alex Benn=C3=A9e wrote:
> I reported this a while ago but evidently forgot to push the patch
> upstream. Without this I wasn't seeing the dirty tree state submitted
> to the docker build which is very confusing.
>=20
> Reference:
>   Subject: [PATCH 1/6] tests/docker/Makefile.include: fix diff-index ca=
ll
>   Date: Fri, 28 Oct 2016 17:33:34 +0100
>   Message-Id: <20161028163339.31096-2-alex.bennee@linaro.org>
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index d7dafdbd27..ff580edfad 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -20,7 +20,7 @@ IMAGES ?=3D %
>  # Make archive from git repo $1 to tar.gz $2
>  make-archive-maybe =3D $(if $(wildcard $1/*), \
>  	$(call quiet-command, \
> -		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
> +		(cd $1; if git diff-index --quiet HEAD -- 2>/dev/null; then \
>  			git archive -1 HEAD --format=3Dtar.gz; \
>  		else \
>  			git archive -1 $$(git stash create) --format=3Dtar.gz; \
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CWNcSPEUjLALLn9kMjePtBrofI8ATKkQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllwtvQACgkQp6FrSiUn
Q2ql4Af+JhsHElkJ4MvJ0oQ1TYkC+me8H7KbycWb5VRVY+LAkcW0cEFpiaQKO4Nv
5P6nVAVatrCpypexydKL9eFqMzeORY0NH4/b36vJs99dR1qgDIkgQ25aYR0hyeI+
+v/RHT8yypD8MgDbud0KxHml9Kxc0QWHFK5rlHlmZUz/iAYrgtmLV6wm61eUSgLq
rI7MsREdXDLxwcxGniqFCfjnXbM3Tk1YyIvt+jwHZThojV8QL6soPS6jeuv3m+I4
T3PoU3SgEgYlPnGA5UGX93cAsQtL9X+SYIaqfUdcrD5Ar6PtUUn0xTBqs7K1TFQk
l8PsLNW+PPef7Gjyp85ueUN6VlyPJQ==
=EWOW
-----END PGP SIGNATURE-----

--CWNcSPEUjLALLn9kMjePtBrofI8ATKkQK--
