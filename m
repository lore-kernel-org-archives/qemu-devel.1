Received: from eggs.gnu.org ([2001:4830:134:3::10]:43326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea4E5-0002lg-Cu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea4E1-0000wV-AB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:38:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ea4E1-0000to-1A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:38:45 -0500
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
	<1515756676-3860-53-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8e975b0-638d-d603-85af-cb9a7b091bfa@redhat.com>
Date: Fri, 12 Jan 2018 12:38:37 -0600
MIME-Version: 1.0
In-Reply-To: <1515756676-3860-53-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fAc9WxweWKa8SpJ62YenmEDPQyKhLGVVU"
Subject: Re: [Qemu-devel] [PULL 52/52] scripts/analyse-locks-simpletrace.py:
 script to analyse lock times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fAc9WxweWKa8SpJ62YenmEDPQyKhLGVVU
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <b8e975b0-638d-d603-85af-cb9a7b091bfa@redhat.com>
Subject: Re: [Qemu-devel] [PULL 52/52] scripts/analyse-locks-simpletrace.py:
 script to analyse lock times
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
 <1515756676-3860-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-53-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 05:31 AM, Paolo Bonzini wrote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> This script allows analysis of mutex acquisition and hold times based
> on a trace file. Given a trace control file of:
>=20
>   qemu_mutex_lock
>   qemu_mutex_locked
>   qemu_mutex_unlock
>=20
> And running with:
>=20
>   $QEMU $QEMU_ARGS -trace events=3D./lock-trace
>=20
> You can analyse the results with:
>=20
>   ./scripts/analyse-locks-simpletrace.py trace-events-all ./trace-21812=

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/analyse-locks-simpletrace.py | 99 ++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100755 scripts/analyse-locks-simpletrace.py
>=20
> diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-loc=
ks-simpletrace.py
> new file mode 100755
> index 0000000..a69ed5c
> --- /dev/null
> +++ b/scripts/analyse-locks-simpletrace.py
> @@ -0,0 +1,99 @@
> +#!/usr/bin/env python
> +# -*- coding: utf-8 -*-
> +#
> +# Analyse lock events and
> +#

Truncated sentence?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fAc9WxweWKa8SpJ62YenmEDPQyKhLGVVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpZAK0ACgkQp6FrSiUn
Q2pzUgf/b2wVpchBpvDnu9mwsV/iaN/K28Wcf/61a/+aAfDhlrinV5NgSFUyCGu3
kNGklf95CooaWhkxNp978PlMm5FHOkS4SMiLu5pdyftbveRa2wtVzzsElhu7Ag9i
Z/spXjcTm/9uNfzWNXCCmEyjm9e6FHwR3+1i2ONcNBLd/8zOs46y6KEeVPt9EtvC
0+gyiw2j9r41KZ3mdqByKTWBrn6F1xK9m70Ldeq3NmBVFKMexk28d4JkxIuaqmsU
S9AceS7dHiT92Yh+hNVnZpu+TnXDMZyOIjyu0PNpvPmq6MCzd5ErWJ2SiuDBCXe5
7XDuwMIFa+kTmnMA60g5a2fHqCt7NA==
=gLqP
-----END PGP SIGNATURE-----

--fAc9WxweWKa8SpJ62YenmEDPQyKhLGVVU--
