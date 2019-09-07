Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD996C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 14:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847D62178F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 14:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847D62178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6bRP-0000Jy-H7
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 10:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6bQd-0008Mb-97
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6bQc-0000s1-8x
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:11:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45503)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6bQc-0000qN-02
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:11:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MN5W7-1hpu1C1Mvd-00J1uK; Sat, 07 Sep 2019 16:10:47 +0200
To: Shu-Chun Weng <scw@google.com>
References: <20190822231443.172099-1-scw@google.com>
 <20190822231443.172099-2-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <723d2aec-31f4-93b1-d1d6-dfe301d3e917@vivier.eu>
Date: Sat, 7 Sep 2019 16:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822231443.172099-2-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mqYp7aAPtliBClOtO+qu6WqLiIgn634omUX4ZDm99C9o/zJd70i
 wu8bNTlLI+mp69cWXa+epEKuNG+7IUf66N3cDRpafhMaGCqVv+UKS6fN/04C/bpynImksKf
 zaUB9qRBYJ2oE3cvZnFHoojMRBLzFp/CwpdqAU4kayOYrVTARKU3OEW0NyHE4AsfMTsNF7I
 41on1xnRH3lCEJQIyU03Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CifI/ljuN28=:3g/DAcVrJGa3La3pETqpr8
 hKRvQyxBLHVj5boiPxBMa4U5j+MY1H7owQQEj5LHZiHwE6gmlSPtHpGPnNBKNvIWJy7UJw49d
 UYx1mgN74qkfrzTI7aJgP1gtb7vLzz4M902TdPdP+owGc/9YZk2KZIVZAjMoeAE0OVgDIWMYq
 Kzg+55JSenmkta9d+lHaJIXxA1XVTbCyAojSbKY5NcI8z1yL6UhltEbUjOSidqjE2udNgJBeD
 CRLLqqDXbUDpLnkgfCimUlkhC/YM21KbXfO1D9gtZERi3TBJF7NutUG505TOpqlWamFx9epJy
 H2l/WaNQajxvXaQe5KV4kzyG9iM0Y+vzHkyXfkMu4mLDudhJBOCclChJiWKL+DsJaEF3v8iHW
 tM8XCeVXb0n/yK2y3XiObceWhgU0XPO63Hx3+mNS2ZVEHNc4tHMlr8VYWBwRw1p+Be7Bps5dL
 jlDXdBWq8Son9COqgz9mSAWi2TkOO3gdJbVlbOR/lzl3lxbZphJK5r1RmoWWvonczzHXotPgm
 5U5/64x3y6PjZB6Z6Km1OY+jXyvZO8sfnwauVTgP5fUg/DubC+ew6JZ6FVEdGNcRxcUtXbPTK
 KdZA4Nc9ta5vmdhomNcJ61Yb/zHsiIi3K+g1OprivuESTHMWkPG7MXKa3wfdmfgWMD8moQb2s
 emB1cYLf8y+2a6nG1gcQXKOtOg7lMoUa5TjXH9XjxxDLlAIszettwlvsXMkI2/7SAf7qqjbP9
 LhI9hL7dTtTYBAdeLRgX8BcaYmexgg+1ePOVWkjC2QUKJ+vWK88s7+355KmzxHBn+6kLmeneK
 zh1f7lfAX6kx6DV9mRqlrGiB3zOcm2LZA+Fd79QMoy47opbL9s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: add missing UDP and IPv6
 setsockopt options
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/08/2019 à 01:14, Shu-Chun Weng via Qemu-devel a écrit :
> UDP: SOL_UDP manipulate options at UDP level. All six options currently
> defined in linux source include/uapi/linux/udp.h take integer values.
> 
> IPv6: IPV6_ADDR_PREFERENCES (RFC5014: Source address selection) was not
> supported.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/syscall.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..8dc4255f12 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -49,8 +49,10 @@
>  #include <sys/sysinfo.h>
>  #include <sys/signalfd.h>
>  //#include <sys/user.h>
> +#include <netinet/in.h>
>  #include <netinet/ip.h>
>  #include <netinet/tcp.h>
> +#include <netinet/udp.h>
>  #include <linux/wireless.h>
>  #include <linux/icmp.h>
>  #include <linux/icmpv6.h>
> @@ -1837,7 +1839,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>  
>      switch(level) {
>      case SOL_TCP:
> -        /* TCP options all take an 'int' value.  */
> +    case SOL_UDP:
> +        /* TCP and UDP options all take an 'int' value.  */

Could you also do_getsockopt()?

>          if (optlen < sizeof(uint32_t))
>              return -TARGET_EINVAL;
>  
> @@ -2488,6 +2491,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>          case IPV6_RECVDSTOPTS:
>          case IPV6_2292DSTOPTS:
>          case IPV6_TCLASS:
> +        case IPV6_ADDR_PREFERENCES:

Could update do_setsockopt() too?

>  #ifdef IPV6_RECVPATHMTU
>          case IPV6_RECVPATHMTU:
>  #endif
> 

Thanks,
Laurent

