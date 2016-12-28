Received: from eggs.gnu.org ([2001:4830:134:3::10]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMGog-00042z-Om
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMGod-00027U-KC
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:11:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMGod-00027C-CU
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:10:59 -0500
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
	<20161228145344.30819-1-cov@codeaurora.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
Date: Wed, 28 Dec 2016 10:10:56 -0600
MIME-Version: 1.0
In-Reply-To: <20161228145344.30819-1-cov@codeaurora.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3xn2CnBxLWnPtIMKJW0D2kAAH7E3v1RQr"
Subject: Re: [Qemu-devel] [PATCH v2] build: include sys/sysmacros.h for
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
--3xn2CnBxLWnPtIMKJW0D2kAAH7E3v1RQr
From: Eric Blake <eblake@redhat.com>
To: Christopher Covington <cov@codeaurora.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
Subject: Re: [PATCH v2] build: include sys/sysmacros.h for major() and minor()
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
 <20161228145344.30819-1-cov@codeaurora.org>
In-Reply-To: <20161228145344.30819-1-cov@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/28/2016 08:53 AM, Christopher Covington wrote:
> The definition of the major() and minor() macros are moving within glib=
c to
> <sys/sysmacros.h>. Include this header to avoid the following sorts of
> build-stopping messages:
>=20

> The additional include allows the build to complete on Fedora 26 (Rawhi=
de)
> with glibc version 2.24.90.
>=20
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  include/sysemu/os-posix.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
> index b0a6c0695b..772d58f7ed 100644
> --- a/include/sysemu/os-posix.h
> +++ b/include/sysemu/os-posix.h
> @@ -28,6 +28,7 @@
> =20
>  #include <sys/mman.h>
>  #include <sys/socket.h>
> +#include <sys/sysmacros.h>

I repeat what I said on v1:

Works for glibc; but <sys/sysmacros.h> is non-standard and not present
on some other systems, so this may fail to build elsewhere.  You'll
probably need a configure probe.  Autoconf also says that some platforms
have <sys/mkdev.h> instead of <sys/sysmacros.h> (per its AC_HEADER_MAJOR
macro).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3xn2CnBxLWnPtIMKJW0D2kAAH7E3v1RQr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYY+QQAAoJEKeha0olJ0NqmF4IAKIoJ1MrWMXJMXwMcwTJEzI2
MEeNpvtPULzAj2x2Y9mFN5blDRpjyY9l1bv3JAGy0Ult9ELx+ArbF+9ZZXe8+qsc
cAdkUirgbjJWU/l/TNVaS8o+oT5/YOVio2Z8NPWvR9ZvU3R5UYKgbHhdIpkhHo7u
TIlgHgNvzC/Id0SgXNRWrzQ/pttdTRgwQ0QHja+3NU509pLFf2HjpM2rg60h6MfN
mCKto0gt3WKevZvs8viDQQ8Cp2n8mT1WYgq1yi6vmfL9lt1bUkOt1Sk8+p1Lq+i6
lfAieR+yB+aN9X/YDEW1ROPzJGaLVuIvVmVpATxoMD7IvRjg7VOU6bhsCxMgwII=
=6Bzf
-----END PGP SIGNATURE-----

--3xn2CnBxLWnPtIMKJW0D2kAAH7E3v1RQr--
