Received: from eggs.gnu.org ([2001:4830:134:3::10]:34945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdbb-0003Vx-PR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdbY-00053R-JE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYdbY-00053M-AK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:56:36 -0500
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
	<1485888144-16531-8-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ecd713f1-0b3b-179f-3c2d-3082f44d57a9@redhat.com>
Date: Tue, 31 Jan 2017 12:56:31 -0600
MIME-Version: 1.0
In-Reply-To: <1485888144-16531-8-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Lvoa888MfHlvCj6xVJhgwrCCXSuW29ei"
Subject: Re: [Qemu-devel] [PULL v4 07/23] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Lvoa888MfHlvCj6xVJhgwrCCXSuW29ei
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecd713f1-0b3b-179f-3c2d-3082f44d57a9@redhat.com>
Subject: Re: [PULL v4 07/23] compiler: expression version of QEMU_BUILD_BUG_ON
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
 <1485888144-16531-8-git-send-email-mst@redhat.com>
In-Reply-To: <1485888144-16531-8-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 12:43 PM, Michael S. Tsirkin wrote:
> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
> to use outside functions, but sometimes it's useful
> to have a version that can be used within an expression.
> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
> that return zero after checking condition at build time.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/compiler.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index e0ce9ff..462ade2 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -100,6 +100,9 @@
>  #define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
 - \
>                                     sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
)
> =20
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
 - \
> +                                   sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
)
> +

Umm, we don't want this defined twice. I think you have a rebase
mistake, where 6/23 is bogus (it repeats the commit message of 4/23 and
the contents of 7/23).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6Lvoa888MfHlvCj6xVJhgwrCCXSuW29ei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkN3fAAoJEKeha0olJ0NqkPoH/2RqZTJMJi2K+sw3Du8FDTbR
SAecPcapJGFMM7+B6vr7P/NwkBKlTJsVqT98+ZSzl+oB4E40CSYWs1armtXABV3m
aWRTMj8X0fkTMof17hqPGEDKVoQhPRa6bTDhLAGJN5bxD6N8dQU1InsTx6nMyS9W
NQqJp9MkoHVjqoAUgpxwgcTbE3XRzMlFJXXQUrZFSFbx4DB6BUav5EGiCkvu2Wqh
SZ8h81Zh6NSeKSBNzx58tHgIenAv/60fgfoqG1a9mSQ9+595i24QySy0iF7A8Usw
oP+Dc9/0wynQjn/EtmNi4jJXLTnWphBZu3//t611NJCJdB+prEhp2oB0G/teeG8=
=0Snf
-----END PGP SIGNATURE-----

--6Lvoa888MfHlvCj6xVJhgwrCCXSuW29ei--
