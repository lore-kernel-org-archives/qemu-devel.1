Received: from eggs.gnu.org ([209.51.188.92]:58035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1WF5-0002MR-1a
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1WF4-0002VZ-AM
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:05:51 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:40831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1WF3-0002Uv-VV
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:05:50 -0500
References: <20190227191556.GA20198@ls3530.dellerweb.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e6a8123c-20f9-8cc4-594f-8db02c3607cc@vivier.eu>
Date: Wed, 6 Mar 2019 14:05:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190227191556.GA20198@ls3530.dellerweb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add missing IPV6 sockopts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

On 27/02/2019 20:15, Helge Deller wrote:
> When running ssh over IPv6 with linux-user I faced this warning:
>  Unsupported setsockopt level=41 optname=67
>  setsockopt IPV6_TCLASS 32: Protocol not available:
> 
> This patch adds a few missing IPV6 options, including IPV6_TCLASS.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5bbb72f3d5..08efbf14b6 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1871,6 +1874,20 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>          case IPV6_RECVHOPLIMIT:
>          case IPV6_2292HOPLIMIT:
>          case IPV6_CHECKSUM:
> +        case IPV6_ADDRFORM:
> +        case IPV6_2292PKTINFO:
> +        case IPV6_RECVTCLASS:
> +        case IPV6_RECVRTHDR:
> +        case IPV6_2292RTHDR:
> +        case IPV6_RECVHOPOPTS:
> +        case IPV6_2292HOPOPTS:
> +        case IPV6_RECVDSTOPTS:
> +        case IPV6_2292DSTOPTS:
> +        case IPV6_TCLASS:
> +        case IPV6_RECVPATHMTU:
> +        case IPV6_TRANSPARENT:
> +        case IPV6_FREEBIND:
> +        case IPV6_RECVORIGDSTADDR:
>              val = 0;
>              if (optlen < sizeof(uint32_t)) {
>                  return -TARGET_EINVAL;
> 

It looks good. Could you also update do_getsockopt() list?

Thanks,
Laurent
