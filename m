Received: from eggs.gnu.org ([2001:4830:134:3::10]:45602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5dZS-0007pC-Cu
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5dZO-0001DO-EL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5dZO-0001DA-5F
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:07:02 -0400
References: <20171020141027.17010-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2200140-bdeb-1746-20a2-15b1fb283c28@redhat.com>
Date: Fri, 20 Oct 2017 15:06:58 -0500
MIME-Version: 1.0
In-Reply-To: <20171020141027.17010-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FApWDosvfVIMXt6Rxc3HHdlg6f6JoaAqp"
Subject: Re: [Qemu-devel] [PATCH] build: allow setting a custom GIT binary
 for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Chen, Farrah" <farrah.chen@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FApWDosvfVIMXt6Rxc3HHdlg6f6JoaAqp
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Chen, Farrah" <farrah.chen@intel.com>
Message-ID: <d2200140-bdeb-1746-20a2-15b1fb283c28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: allow setting a custom GIT binary for
 transparent proxying
References: <20171020141027.17010-1-berrange@redhat.com>
In-Reply-To: <20171020141027.17010-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 09:10 AM, Daniel P. Berrange wrote:
> Some users can't run a bare 'git' command, due to need for a transparen=
t
> proxying solution such as 'tsocks'. This adds an argument to configure =
to
> let users specify such a thing:
>=20
>   ./configure --with-git=3D"tsocks git"
>=20
> The submodule script is also updated to give the user a hint about usin=
g this
> flag, if we fail to checkout modules.

Does my hint about using 'git config url.XYZ.insteadof git://...' do the
trick without needing this patch?

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile                 |  4 ++--
>  configure                |  5 +++++
>  scripts/git-submodule.sh | 30 +++++++++++++++++++++++++-----
>  3 files changed, 32 insertions(+), 7 deletions(-)
>=20

> +++ b/scripts/git-submodule.sh
> @@ -3,14 +3,19 @@
>  # This code is licensed under the GPL version 2 or later.  See
>  # the COPYING file in the top-level directory.
> =20
> -set -e
> -

Is the change of dropping 'set -e' and adding 'error' worth doing as an
independent patch?

>  substat=3D".git-submodule-status"
>  update)
> -    git submodule update --init $modules 1>/dev/null
> -    git submodule status $modules > "${substat}"
> +    $GIT submodule update --init $modules 1>/dev/null

style of whether 1> or plain > is sufficient.

But in spite of my comments, the patch looks correct. So if we agree
that we want it, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FApWDosvfVIMXt6Rxc3HHdlg6f6JoaAqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqV2IACgkQp6FrSiUn
Q2oNogf+LFqn8+LeFEkpwN7Z9+b6VzI1rI2to3m2pFAMEnD1b95xtmOyR+vop4D+
xjBU873G9upHzfMZmyugRt4BUlU0OAcfyDhWCv1k3InAW1xUgaQxZu+dhsx8ga4H
rp6p6NYEWoroLtW2B/rq25TTt7qvj93jzTpwcUZrEb2C4rO0gwKC6F8uKD9r8RSr
E8BUO4YHnyRfUsZHf95Ti5tF5teqy5SYXYoO9p1pt0tmSrz3u2/+QsdTayva3BLy
KRdJ57j5db8aLSFtpzxglbjANbuYhmyqpbwD6BOLui0xWpH0KtpS0cMXMmpR34og
YWHOsu/pezEna1B9d2sy8YkoVzmHQg==
=Fwnv
-----END PGP SIGNATURE-----

--FApWDosvfVIMXt6Rxc3HHdlg6f6JoaAqp--
