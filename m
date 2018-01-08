Received: from eggs.gnu.org ([2001:4830:134:3::10]:40162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYbSF-0002fp-WF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYbSB-0002C2-5I
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYbSA-0002Ax-Vs
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:43:19 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e92bad59-3c19-748c-a8d3-ba5116f0d488@redhat.com>
Date: Mon, 8 Jan 2018 18:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/12] slirp: struct icmp/ethhdr ARE packed
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

On 08.01.2018 18:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/ip6_icmp.h | 6 +++---
>  slirp/ip_icmp.h  | 2 +-
>  slirp/slirp.h    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
> index b3378b17b5..a4ccc69974 100644
> --- a/slirp/ip6_icmp.h
> +++ b/slirp/ip6_icmp.h
> @@ -17,20 +17,20 @@
>  struct icmp6_echo { /* Echo Messages */
>      uint16_t id;
>      uint16_t seq_num;
> -};
> +} QEMU_PACKED;
> =20
>  union icmp6_error_body {
>      uint32_t unused;
>      uint32_t pointer;
>      uint32_t mtu;
> -};
> +} QEMU_PACKED;
> =20
>  /*
>   * NDP Messages
>   */
>  struct ndp_rs {     /* Router Solicitation Message */
>      uint32_t reserved;
> -};
> +} QEMU_PACKED;
...
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 9f29b52610..9a7287e7cc 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -103,7 +103,7 @@ struct ethhdr {
>      unsigned char  h_dest[ETH_ALEN];   /* destination eth addr */
>      unsigned char  h_source[ETH_ALEN]; /* source ether addr    */
>      unsigned short h_proto;            /* packet type ID field */
> -};
> +} QEMU_PACKED;
> =20
>  struct slirp_arphdr {
>      unsigned short ar_hrd;      /* format of hardware address */
>=20

The above structs all look naturally aligned to me - so why do you need
the QEMU_PACKED here?

 Thomas
