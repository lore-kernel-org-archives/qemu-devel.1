Received: from eggs.gnu.org ([2001:4830:134:3::10]:41175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXla-0001uW-Tc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXlU-0005uw-KB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:19:22 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXlU-0005tb-9S
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:19:16 -0400
Received: by mail-qk0-x243.google.com with SMTP id b66-v6so3047623qkj.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:19:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627212152.26525-1-laurent@vivier.eu>
	<20180627212152.26525-3-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f39a8ce7-a7b6-52f9-35b6-6464f08735e6@amsat.org>
Date: Thu, 28 Jun 2018 11:18:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180627212152.26525-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: update do_setsockopt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 06/27/2018 06:21 PM, Laurent Vivier wrote:
> add IPV6_MULTICAST_HOPS and IPV6_MULTICAST_LOOP that need
> 32bit value conversion
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 4460f1e39a..50e20fb659 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3019,6 +3019,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>          case IPV6_V6ONLY:
>          case IPV6_RECVPKTINFO:
>          case IPV6_UNICAST_HOPS:
> +        case IPV6_MULTICAST_HOPS:
> +        case IPV6_MULTICAST_LOOP:
>          case IPV6_RECVERR:
>          case IPV6_RECVHOPLIMIT:
>          case IPV6_2292HOPLIMIT:
> 
