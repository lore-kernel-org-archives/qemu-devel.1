Received: from eggs.gnu.org ([209.51.188.92]:43703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glfA5-0003dD-3h
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glfA3-0003q9-1x
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:23:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1glf9z-0003m8-7m
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:23:05 -0500
References: <20190121181030.2112-1-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
Date: Mon, 21 Jan 2019 13:22:55 -0600
MIME-Version: 1.0
In-Reply-To: <20190121181030.2112-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="65E8KxbOkLrFyocmO7g4OfWcSq0RUQI9F"
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--65E8KxbOkLrFyocmO7g4OfWcSq0RUQI9F
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>
Message-ID: <76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
References: <20190121181030.2112-1-philmd@redhat.com>
In-Reply-To: <20190121181030.2112-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/21/19 12:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit 2974e916df8 introduced the VirtioNetRscChain structure which
> refer to a VirtIONet, declared later, thus required VirtIONet typedef
> to be declarated forward.

s/be declarated forward/use a forward declaration/

> However, when compiling with Clang in -std=3Dgnu99 mode, this triggers
> the following warning/error:
>=20
>     CC      hw/net/virtio-net.o
>   In file included from qemu/hw/net/virtio-net.c:22:
>   include/hw/virtio/virtio-net.h:189:3: error: redefinition of typedef =
'VirtIONet' is a C11 feature [-Werror,-Wtypedef-redefinition]
>   } VirtIONet;
>     ^
>   include/hw/virtio/virtio-net.h:110:26: note: previous definition is h=
ere
>   typedef struct VirtIONet VirtIONet;
>                            ^
>   1 error generated.
>   make: *** [rules.mak:69: hw/net/virtio-net.o] Error 1
>=20
> Fix it by removing the duplicate typedef definition.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/virtio/virtio-net.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--65E8KxbOkLrFyocmO7g4OfWcSq0RUQI9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxGHA8ACgkQp6FrSiUn
Q2rIDgf8D8Xu7z4wKgA2KN5FO7YwOwYAI8nB6bpR03jbfX7i/GJ6Vvdh0pTacQQ2
1v0AypvqRdgLPa4GCtEdyQvAg64GaiVOhYH5kMs9QCCsrCbX3dbavZngAgmz7IkF
cxvuGYiltN2aZEo7dYzq36XHi55w3Ogfo3SR+aiqQgTBHGsV4PbIBjKI20V3JnnS
hQMsH7lpNijyu0I+v+7US0BVAP+EyrBwv1CMe5tUDFwSRdudwHwvWFt3LPpmPIHR
1xZbB2TRoXpyrmbkn8c3eoTMdpf+xoOOMhq9LvJcqIFh/YbgN9BrESLwD/+yXPKc
Dk4q8FLBGJyBZTziA+S+cWQY8EOIBg==
=3z1e
-----END PGP SIGNATURE-----

--65E8KxbOkLrFyocmO7g4OfWcSq0RUQI9F--
