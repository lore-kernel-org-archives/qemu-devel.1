Received: from eggs.gnu.org ([2001:4830:134:3::10]:33886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepVN-0006sP-Bx
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepVK-0004cT-OY
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:51:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepVK-0004be-FA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:51:46 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DE2581241
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:51:46 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-18-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f95f34e1-0b55-da43-2328-81b5954a218e@redhat.com>
Date: Fri, 17 Feb 2017 14:51:41 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-18-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hM6AF8Bu9Rd5PdjWEf5L7QrfgmaeeN4Wq"
Subject: Re: [Qemu-devel] [PATCH 17/24] util/cutils: Drop
 QEMU_STRTOSZ_DEFSUFFIX_* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hM6AF8Bu9Rd5PdjWEf5L7QrfgmaeeN4Wq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f95f34e1-0b55-da43-2328-81b5954a218e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/24] util/cutils: Drop
 QEMU_STRTOSZ_DEFSUFFIX_* macros
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Writing QEMU_STRTOSZ_DEFSUFFIX_* instead of '*' gains nothing.  Get
> rid of these eyesores.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>=20
> diff --git a/util/cutils.c b/util/cutils.c
> index ef658bb..4a290ea 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -178,30 +178,22 @@ int fcntl_setfl(int fd, int flag)
>  }
>  #endif
> =20
> -#define QEMU_STRTOSZ_DEFSUFFIX_EB 'E'
> -#define QEMU_STRTOSZ_DEFSUFFIX_PB 'P'
> -#define QEMU_STRTOSZ_DEFSUFFIX_TB 'T'
> -#define QEMU_STRTOSZ_DEFSUFFIX_GB 'G'
> -#define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
> -#define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
> -#define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
> -
>  static int64_t suffix_mul(char suffix, int64_t unit)
>  {
>      switch (qemu_toupper(suffix)) {
> -    case QEMU_STRTOSZ_DEFSUFFIX_B:
> +    case 'B':
>          return 1;
> -    case QEMU_STRTOSZ_DEFSUFFIX_KB:

Oh, my comments on 16/24 were a bit premature; those macros were used.
But I'm definitely in favor of this cleanup!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hM6AF8Bu9Rd5PdjWEf5L7QrfgmaeeN4Wq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2JdAAoJEKeha0olJ0Nq1ikH/2j8tHJGvFTl7qrKqgt8ld7B
HqL6FDEveWIlkemfkdkuLt779t2SnFZ794TWZiTHxBC9xvy/OJryd/vNUqNpuBSu
Fm8MMgTOYa6YUEZXgMzjGUD5Mt+7pTJbzXqzuMDVv23tor49suGd8A3wnL+RmG1S
vVxwTANpvQRMmdB8pnr5xVcdGNWgwNEm5PFIqn80/8rgVyg4b4W/p/6zT9zGIpyo
9+X7Ee6XzNVyUDZk62IQFElW0KfQ3dNzBKW4R0xkt7x1wgVMBr80j61BdfGlPMTD
tlPIKHTHtFuTvpLvIu9dpDGZDpZIXcGIoCH1KbmarcqkN0rL0s5PexQFf+cVe78=
=fuEx
-----END PGP SIGNATURE-----

--hM6AF8Bu9Rd5PdjWEf5L7QrfgmaeeN4Wq--
