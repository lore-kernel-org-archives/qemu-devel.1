Received: from eggs.gnu.org ([2001:4830:134:3::10]:41912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKAe-00042X-Mq
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKAZ-0004jZ-Ph
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUKAZ-0004ij-GM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:22:55 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-2-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <596f956e-8e52-57ac-5153-87002c68ecef@redhat.com>
Date: Thu, 19 Jan 2017 15:22:52 -0600
MIME-Version: 1.0
In-Reply-To: <1484859998-25074-2-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HG8PmTroG9CvRace6IH7egRU6L6jmemjM"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] compiler: drop ; after BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HG8PmTroG9CvRace6IH7egRU6L6jmemjM
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <596f956e-8e52-57ac-5153-87002c68ecef@redhat.com>
Subject: Re: [PATCH v3 1/4] compiler: drop ; after BUILD_BUG_ON
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
 <1484859998-25074-2-git-send-email-mst@redhat.com>
In-Reply-To: <1484859998-25074-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:07 PM, Michael S. Tsirkin wrote:
> All users include the trailing ; anyway, let's require that -
> it seems cleaner.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 157698b..7512082 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -86,7 +86,8 @@
>  #define type_check(t1,t2) ((t1*)0 - (t2*)0)
> =20
>  #define QEMU_BUILD_BUG_ON(x) \
> -    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attrib=
ute__((unused));
> +    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
> +        __attribute__((unused))
> =20
>  #if defined __GNUC__
>  # if !QEMU_GNUC_PREREQ(4, 4)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--HG8PmTroG9CvRace6IH7egRU6L6jmemjM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgS4sAAoJEKeha0olJ0NqJ58IAJkQtpLnH5fFcs+uR6kk/tpo
1N5VuWph0L2Q9M1fm5gv52PElYLfT0qcH+PjTiqFpPyNB/lDVFPVu5ArgDUZRPXD
Lz59cKbD8GylTFu790n4IqGFnA4NgS9FU1K5IbOGjUHdlvApqFIMJ22mAc4ridGJ
MeFdWCOuOV3mqRSOIdjG4azVg64CEASMdUks1uq0TUwSk+FztvSGIvBAUfh+XMIt
K0E7HVUqFOkDxfzljbDwwogwLG3ZiesclY+HORfeIB+8nNXzD3YaxetcMBy8XJgI
euu6OQ741bSRz/93xbfqSU80LQTOVnK+snvJ1LhSciByw/i8zQIInoUUgQs7ZT8=
=f72G
-----END PGP SIGNATURE-----

--HG8PmTroG9CvRace6IH7egRU6L6jmemjM--
