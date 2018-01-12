Received: from eggs.gnu.org ([2001:4830:134:3::10]:40123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxWE-0005xI-Va
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxWA-0000bt-EF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:29:06 -0500
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:42194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxWA-0000bR-7a
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:29:02 -0500
Received: by mail-qt0-x232.google.com with SMTP id c2so5603868qtn.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:29:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9da34f89-3866-bbae-636e-bf26a74cc4ff@amsat.org>
Date: Fri, 12 Jan 2018 08:28:54 -0300
MIME-Version: 1.0
In-Reply-To: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="mQSK16IWverl5bvDxvlGppeK5ZbwXPNdC"
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mQSK16IWverl5bvDxvlGppeK5ZbwXPNdC
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <9da34f89-3866-bbae-636e-bf26a74cc4ff@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 01/12/2018 08:11 AM, Paolo Bonzini wrote:
> Using "fedora:latest" makes behavior different depending on when you
> actually pulled the image from the docker repository.  In my case,
> the supposedly "latest" image was a Fedora 25 download from 8 months
> ago, and the new "test-debug" test was failing.
>=20
> Use "27" to improve reproducibility and make it clear when the image
> is obsolete.
>=20
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I wonder what script you are using, and if the R: tag in MAINTAINERS is
that useful, since I saw few docker patches I'm interestd in but I was
not CC'd:

$ ./scripts/get_maintainer.pl -f tests/docker/dockerfiles/fedora.docker
"Alex Benn=C3=A9e" <alex.bennee@linaro.org> (maintainer:Build and test au=
=2E..)
Fam Zheng <famz@redhat.com> (maintainer:Build and test au...)
"Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (reviewer:Build and test =
au...)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dock=
erfiles/fedora.docker
> index 32de731..714adad 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:latest
> +FROM fedora:27

I'd rather use the deprecation approach like we use for Debian,
see tests/docker/dockerfiles/debian.docker.

That said, you remind me of a series doing the same for Ubuntu I forgot
to send, if you want I can add fedora25 and fedora27 before sending.

Regards,

Phil.

>  ENV PACKAGES \
>      ccache gettext git tar PyYAML sparse flex bison python2 bzip2 host=
name \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>=20


--mQSK16IWverl5bvDxvlGppeK5ZbwXPNdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpYm/kACgkQ4+MsLN6t
wN4tXRAAj0wTmwjkSvLsRjojmq/cMXV/3ruJxEi9l4ksfF8xkTM0dS4DMRQw2LP8
5NXrPKRs3Jx/14F2B0DQbhFp2h87Wi/CQ2rIKasEtF8B+7Z5BQcx6U+CdTMBM8Wf
6cO6OkQf5E+ptxapU0kBtUoN4Ulme5wkO4Ogm0lFMCCg/lqCUf1i6jdtXRODEiFw
Mb0r0iEenP128DMpdAISqJuTQOuQh6eLqFiGYmrXg5jjaqdYrsQad5tDOeGnm6cM
gb6zhgWOu6zs9ntN/IpBSHgixte7vT9uBV7TZsyFX5fn9J/j4VP4OJqx0Vz6w/7/
XhXt4X5aX2soRdoDRoOXzIJw8VBAjnaaFVfScmxh6mTTTvEPVa6vuxAtsBC5dwqx
VTKEilcSm7CnPqfDe7grEH9WHYPT4+MR1N8sREMsCFXPeCYgg1TTBujrM3cgG9UO
0GZ8ffKiilX+cEnjMGt0iKm3Gcei7AURGWZm0MnMddqTIxNsJGmzk9cNshih981e
aDz02legCwsNR1jN55U3R4xYhzd0JnJqI2pzLqKrVuutxp23EKMXFQeQ8nRgAnZi
mHBZCInb4fxPnQyWV5tImonBuzjWV0Ch5CZQufwasE218IxpX0ehyS5EMGd5KQvO
UqzbpS6d7rUP6Gf2e6KIXkJDRrfm+wICmVbdUfdwQbChfk8Dt8I=
=TJ2c
-----END PGP SIGNATURE-----

--mQSK16IWverl5bvDxvlGppeK5ZbwXPNdC--
