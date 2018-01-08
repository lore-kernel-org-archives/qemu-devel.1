Received: from eggs.gnu.org ([2001:4830:134:3::10]:51998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYcgi-0001Nj-26
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYcgh-0002d9-6T
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:02:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYcgg-0002ch-Sb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:02:23 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-9-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52654e3d-15cb-4225-d52a-a529c975c1a4@redhat.com>
Date: Mon, 8 Jan 2018 20:02:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/12] slirp: removed unused code
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

On 08.01.2018 18:29, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/ip.h | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/slirp/ip.h b/slirp/ip.h
> index e29ccd3c9f..71c3642cfe 100644
> --- a/slirp/ip.h
> +++ b/slirp/ip.h
> @@ -233,17 +233,4 @@ struct	ipasfrag {
>  #define ipf_next     ipf_link.next
>  #define ipf_prev     ipf_link.prev
> =20
> -/*
> - * Structure stored in mbuf in inpcb.ip_options
> - * and passed to ip_output when ip options are in use.
> - * The actual length of the options (including ipopt_dst)
> - * is in m_len.
> - */
> -#define MAX_IPOPTLEN	40
> -
> -struct ipoption {
> -	struct	in_addr ipopt_dst;	/* first-hop dst if source routed */
> -	int8_t	ipopt_list[MAX_IPOPTLEN];	/* options proper */
> -} QEMU_PACKED;
> -
>  #endif
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
