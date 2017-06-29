Received: from eggs.gnu.org ([2001:4830:134:3::10]:54799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQc3q-0006Jc-Ph
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQc3n-0008UV-Ja
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:12:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQc3n-0008U9-9v
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:12:51 -0400
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <024979b1-9a1a-0556-5138-480f8ed1a70e@redhat.com>
Date: Thu, 29 Jun 2017 11:12:47 -0500
MIME-Version: 1.0
In-Reply-To: <1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k5CrtHTWCfr5tIJCKiGUtvkprsp60Vbll"
Subject: Re: [Qemu-devel] [PATCH 2/3] scripts/run-coverity-scan: Script to
 run Coverity Scan build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k5CrtHTWCfr5tIJCKiGUtvkprsp60Vbll
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 patches@linaro.org
Message-ID: <024979b1-9a1a-0556-5138-480f8ed1a70e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] scripts/run-coverity-scan: Script to run
 Coverity Scan build
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
 <1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/13/2017 10:54 AM, Peter Maydell wrote:
> Add a new script to automate the process of running the Coverity
> Scan build tools and uploading the resulting tarball to the
> website. This is primarily intended to be driven from Travis,
> but it can be run locally (if you are a maintainer of the
> QEMU project on the Coverity Scan website and have the secret
> upload token).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/run-coverity-scan | 170 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100755 scripts/run-coverity-scan
>=20
> diff --git a/scripts/run-coverity-scan b/scripts/run-coverity-scan
> new file mode 100755
> index 0000000..e6d5fc5
> --- /dev/null
> +++ b/scripts/run-coverity-scan
> @@ -0,0 +1,170 @@
> +#!/bin/sh -e

I'm not a fan of 'set -e'; it seldom does what you think it should do,
especially when shell functions are involved.  It's better to be
explicit about error handling than it is to rely on a crutch that has
well-defined but non-intuitive behavior.

> +mkdir -p "$COVERITY_TOOL_BASE"
> +cd "$COVERITY_TOOL_BASE"
> +

Of course, calls like these are where you have to either be explicit or
rely on the 'set -e' crutch.

Thankfully, I didn't see any bashisms, so you appeared to have stuck to
portable /bin/sh code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k5CrtHTWCfr5tIJCKiGUtvkprsp60Vbll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVSb/AAoJEKeha0olJ0NqP4wIAKchw8mDJud9B6tgaSWhmquI
PmuSJ0Sjykv6xsT+fC44n5C/Fw/Q0I0m2Op7Hbcxgx2ljLJQlKE/SznJ+6s7QIrk
ZTb/mS9wKcllHMLxv/fgWneQ8HVVIbr7pYFsZJz/106pCOFQ1W8g/n3nqnub21mU
3pF6xfXUFBdmv9rDy7sC8XB7q7A4R9eEmnh6/GHhoT6AUV4ApKGKE9p+o7Gj48Bt
etvteaOI0nj+SeeBIlk5EIcnkX/fnmRRp49prsb8hSDZ6cDTN83mzNgAYe+uFjnC
X4017xWmsZUJYtauDJvZD0tlnZ2xAfEK8G9lpsuYc2dU8pB1wXzl/9L2OMLdguI=
=WRry
-----END PGP SIGNATURE-----

--k5CrtHTWCfr5tIJCKiGUtvkprsp60Vbll--
