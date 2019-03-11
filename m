Received: from eggs.gnu.org ([209.51.188.92]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3NgD-0001X5-BL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3NgC-0002Pv-Dm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:21:33 -0400
References: <1552300145-12526-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d46de0f-a443-2c90-334b-edd34325ac16@redhat.com>
Date: Mon, 11 Mar 2019 11:21:27 -0500
MIME-Version: 1.0
In-Reply-To: <1552300145-12526-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3NYOdmDI1QFfX0zYfAGB1voUcH6HJV7K1"
Subject: Re: [Qemu-devel] [PATCH] configure: Remove old
 *-config-devices.mak.d files when running configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3NYOdmDI1QFfX0zYfAGB1voUcH6HJV7K1
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <6d46de0f-a443-2c90-334b-edd34325ac16@redhat.com>
Subject: Re: [PATCH] configure: Remove old *-config-devices.mak.d files when
 running configure
References: <1552300145-12526-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1552300145-12526-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 5:29 AM, Thomas Huth wrote:
> When running "make" in a build directory from the pre-Kconfig merge tim=
e,
> the build process currently fails with:
>=20
>  make: *** No rule to make target `.../default-configs/pci.mak',
>   needed by `aarch64-softmmu/config-devices.mak'.  Stop.
>=20
> To make sure that this problem at least goes away when the user runs
> "configure" (or "sh config.status") again, we have to make sure that
> we re-generate the .mak.d files. Thus remove the old stale files
> while running the configure script.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)

What are the conditions for make deciding it needs to rerun
config.status? Are end users still going to get 'make' failing with the
cryptic message (where we just advise on-list and on-wiki to
'./config.status' to fix it), or is there a way to build in a dependency
so that the makefile itself knows that if config.status has to be rerun,
that takes priority over any other rule that depends on .mak files?

>=20
> diff --git a/configure b/configure
> index b354e74..32c847f 100755
> --- a/configure
> +++ b/configure
> @@ -1792,6 +1792,9 @@ EOF
>  exit 0
>  fi
> =20
> +# Remove old dependency files to make sure that they get properly rege=
nerated
> +rm -f *-config-devices.mak.d
> +
>  if ! has $python; then
>    error_exit "Python not found. Use --python=3D/path/to/python"
>  fi
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3NYOdmDI1QFfX0zYfAGB1voUcH6HJV7K1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGiwcACgkQp6FrSiUn
Q2r86Af/VRJDF3RUpBcpcETmr4Xbb9lGe8m+lHqXP4I7R05e4Fvckxwrc523PDoX
JtEBRZzJn9aUtdjdj9teN7xevsMHoMK/g8+ZZ8YBYZEiWuIJXEqvWdQkjQwDBCb4
nWu/6BHqCz9TVs2mhVZ3am5/q8aLw76Lkr/N2+9Ya+C4+liRrpQEUvmb+bsL0orQ
Y2HM1/8Yw377uF6JXIYGMB+tiyZ46u6XTIi93S1Cis+BZAcKLDJtEycZe7WeyLDo
HzQzKV724WbKQ7QgJbcG/xt3jbysJbCUCIb54fl+oZ8lkiZd2AGewgi0fl0hUZDt
IHDOOiO9mVfDSB1aTMYIP6dehirNJQ==
=25cx
-----END PGP SIGNATURE-----

--3NYOdmDI1QFfX0zYfAGB1voUcH6HJV7K1--
