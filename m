Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMbJ6-00046d-Kq
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 09:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMbJ2-0006iR-Of
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 09:03:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMbJ2-0006i3-GH
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 09:03:44 -0500
References: <20161228145344.30819-1-cov@codeaurora.org>
	<20161228200433.24244-1-cov@codeaurora.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db6c1fd9-16ac-7670-0fe3-966139864a23@redhat.com>
Date: Thu, 29 Dec 2016 08:03:41 -0600
MIME-Version: 1.0
In-Reply-To: <20161228200433.24244-1-cov@codeaurora.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7CeIUXaa4uiIKuw2fSL03jnvgGS06ERwg"
Subject: Re: [Qemu-devel] [PATCH v3] build: include sys/sysmacros.h for
 major() and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Covington <cov@codeaurora.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7CeIUXaa4uiIKuw2fSL03jnvgGS06ERwg
From: Eric Blake <eblake@redhat.com>
To: Christopher Covington <cov@codeaurora.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <db6c1fd9-16ac-7670-0fe3-966139864a23@redhat.com>
Subject: Re: [PATCH v3] build: include sys/sysmacros.h for major() and minor()
References: <20161228145344.30819-1-cov@codeaurora.org>
 <20161228200433.24244-1-cov@codeaurora.org>
In-Reply-To: <20161228200433.24244-1-cov@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/28/2016 02:04 PM, Christopher Covington wrote:

It's best when posting a v3 to do so as a new thread, rather than buried
in-reply-to an earlier thread, as some maintainers' tools overlook
deeply-threaded patches.  Probably won't matter too much in this case,
but it's useful information for future submissions; other tips can be
found here:
http://wiki.qemu.org/Contribute/SubmitAPatch


> The definition of the major() and minor() macros are moving within glib=
c to
> <sys/sysmacros.h>.

Or more precisely, major() and minor() have ALWAYS been in
<sys/sysmacros.h> under glibc, but are now being removed from
<sys/types.h>.  But your patch is the correct fix: if <sys/sysmacros.h>
exists, include it.

> Include this header when it is available to avoid the
> following sorts of build-stopping messages:
>=20
> qga/commands-posix.c: In function =E2=80=98dev_major_minor=E2=80=99:
> qga/commands-posix.c:656:13: error: In the GNU C Library, "major" is de=
fined
>  by <sys/sysmacros.h>. For historical compatibility, it is
>  currently defined by <sys/types.h> as well, but we plan to
>  remove this soon. To use "major", include <sys/sysmacros.h>
>  directly. If you did not intend to use a system-defined macro
>  "major", you should undefine it after including <sys/types.h>. [-Werro=
r]
>          *devmajor =3D major(st.st_rdev);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> qga/commands-posix.c:657:13: error: In the GNU C Library, "minor" is de=
fined
>  by <sys/sysmacros.h>. For historical compatibility, it is
>  currently defined by <sys/types.h> as well, but we plan to
>  remove this soon. To use "minor", include <sys/sysmacros.h>
>  directly. If you did not intend to use a system-defined macro
>  "minor", you should undefine it after including <sys/types.h>. [-Werro=
r]
>          *devminor =3D minor(st.st_rdev);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> The additional include allows the build to complete on Fedora 26 (Rawhi=
de)
> with glibc version 2.24.90.
>=20
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  configure                 | 18 ++++++++++++++++++
>  include/sysemu/os-posix.h |  4 ++++
>  2 files changed, 22 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7CeIUXaa4uiIKuw2fSL03jnvgGS06ERwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYZRe+AAoJEKeha0olJ0Nqy5IIAKeeK9rv67Rmh8NOye98XVt0
dIKWZsRaPARAwzbnaSan7QWO4ZcHI3K0gGV40F5EE6CuQ4eadOGgpOAKtvvPZZok
kPuxNUASa5wfPbT5V8JDlsX47Q97+nPFf0iFAaqmW00PCtpCEX/0myyE9YoKun/m
6G6InPDcK+BseifMsFAx5IVo6k77cRtEc+mhpI8/qGGbjk+zx7Xv+haR2YXOXKvr
flQ6iEgf24bWntlcDHNOAyI6JhV2Rp6vVM7BS/1JzYR/Uc9HwV0c20NuzvSdpwic
JLWiX+qqgQKYNO0hISNPHW8VgLCDVM+ows11QsEjYQRmPPXa2qn2Iui2cSXWzas=
=siOL
-----END PGP SIGNATURE-----

--7CeIUXaa4uiIKuw2fSL03jnvgGS06ERwg--
