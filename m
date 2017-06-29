Received: from eggs.gnu.org ([2001:4830:134:3::10]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQeY9-0007t0-29
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQeY8-0001Pt-40
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:52:21 -0400
References: <20170621133023.27627-1-mreitz@redhat.com>
	<20170621133023.27627-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
Date: Thu, 29 Jun 2017 13:52:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170621133023.27627-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RuMm9RxKn3LDtIAuMJiIUDdWsppmmcsd4"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RuMm9RxKn3LDtIAuMJiIUDdWsppmmcsd4
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
Subject: Re: [PATCH v4 1/2] iotests: Use absolute paths for executables
References: <20170621133023.27627-1-mreitz@redhat.com>
 <20170621133023.27627-2-mreitz@redhat.com>
In-Reply-To: <20170621133023.27627-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 08:30 AM, Max Reitz wrote:
> A user may specify a relative path for accessing qemu, qemu-img, etc.
> through environment variables ($QEMU_PROG and friends) or a symlink.
>=20
> If a test decides to change its working directory, relative paths will
> cease to work, however. Work around this by making all of the paths to
> programs that should undergo testing absolute. Besides "realpath", we
> also have to use "which" to support programs in $PATH.

Is this sentence stale...

>=20
> As a side effect, this fixes specifying these programs as symlinks for
> out-of-tree builds: Before, you would have to create two symlinks, one
> in the build and one in the source tree (the first one for common.confi=
g
> to find, the second one for the iotest to use). Now it is sufficient to=

> create one in the build tree because common.config will resolve it.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/comm=
on.config
> index d1b45f5..c1dc425 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -103,6 +103,12 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
>      export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server`"
>  fi
> =20
> +export QEMU_PROG=3D$(realpath -- "$(type -p "$QEMU_PROG")")

=2E..now that you updated per my review to favor 'type' over 'which'?
Otherwise, the R-b stands.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RuMm9RxKn3LDtIAuMJiIUDdWsppmmcsd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVUxbAAoJEKeha0olJ0NqV20H/3JCk3zxPrqHj/nx5z6t8f2v
t8jypZBRoS05ZIHwAaqA8s1vnnEOl/kngtTtS+Me42Q0E86FGsS1u4rvwzV+s/ck
xAvEv8226UI/lTCl8KQzdBRPW86ATZ5WTTSBlCyf6jvu4IwmyhFCd7OEdKc4pfQ8
Z0nCo7D0Ww15eGgS500xInY+ry/KkUPFADWGKJ7jI7lX/LmZ8TTn5gIC9pm2ALzp
0+CFRdM9rYqp9juYvLOOSqkI5+w57QrKufKETMzHObrOmU81ye6o5/t6eoLUlEm1
jdmrfUtiml5n+P6kCerp16bVMnWu/Qr3Z9592Uub7WWZLBr8HLyJV3Vocx3u3wY=
=Mqps
-----END PGP SIGNATURE-----

--RuMm9RxKn3LDtIAuMJiIUDdWsppmmcsd4--
