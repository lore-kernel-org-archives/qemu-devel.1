Received: from eggs.gnu.org ([2001:4830:134:3::10]:41914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYbWC-00044X-DD
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYbVC-0005us-GI
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:47:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYbVC-0005tV-8M
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:46:26 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-6-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <96b015b8-e49c-913a-2454-de6674db3ef6@redhat.com>
Date: Mon, 8 Jan 2018 18:46:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/12] slirp: poison IN6_*_ADDR_*() macros
 to avoid them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org


Please add a proper patch description here why you are doing this. At
least it is not clear to me at a first glance.

 Thomas


On 08.01.2018 18:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/ip6.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/slirp/ip6.h b/slirp/ip6.h
> index 6c5d4eeaa3..c6493a0856 100644
> --- a/slirp/ip6.h
> +++ b/slirp/ip6.h
> @@ -8,6 +8,25 @@
> =20
>  #include "net/eth.h"
> =20
> +#ifdef __GNUC__
> +# undef IN6_IS_ADDR_UNSPECIFIED
> +# pragma GCC poison IN6_IS_ADDR_UNSPECIFIED
> +# undef IN6_IS_ADDR_LOOPBACK
> +# pragma GCC poison IN6_IS_ADDR_LOOPBACK
> +# undef IN6_IS_ADDR_LINKLOCAL
> +# pragma GCC poison IN6_IS_ADDR_LINKLOCAL
> +# undef IN6_IS_ADDR_SITELOCAL
> +# pragma GCC poison IN6_IS_ADDR_SITELOCAL
> +# undef IN6_IS_ADDR_V4MAPPED
> +# pragma GCC poison IN6_IS_ADDR_V4MAPPED
> +# undef IN6_IS_ADDR_V4COMPAT
> +# pragma GCC poison IN6_IS_ADDR_V4COMPAT
> +# undef IN6_ARE_ADDR_EQUAL
> +# pragma GCC poison IN6_ARE_ADDR_EQUAL
> +# undef IN6_IS_ADDR_MULTICAST
> +# pragma GCC poison IN6_IS_ADDR_MULTICAST
> +#endif
> +
>  #define ALLNODES_MULTICAST  { .s6_addr =3D \
>                              { 0xff, 0x02, 0x00, 0x00,\
>                              0x00, 0x00, 0x00, 0x00,\
>=20
