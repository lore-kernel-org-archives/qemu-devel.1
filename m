Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A0FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC6820679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC6820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXDX-0005RJ-Nh
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXCR-0003v4-Jz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXCQ-00064D-HD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXCQ-00063s-8E
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:14 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M5Q6n-1iLAHs2RF7-001Qge; Mon, 21 Oct 2019 14:54:09 +0200
Subject: Re: [PATCH v8 5/9] linux-user/strace: Dump AF_NETLINK sockaddr content
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-6-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9e764015-29b0-8608-0f15-0719aa1be248@vivier.eu>
Date: Mon, 21 Oct 2019 14:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D3NWYDmvFbaSLtL8wchSx7KrHBuaYs80HJTuFAQt47/0NT5Tomf
 sATMLFCQ/TEakGfl+BdoPhrvAgr7agKBK7goG/J1K3DB6tpb9fO6yeipe/nQXBXJDzZS7Yw
 U2N4ORhZbTXRs+zUbdeP3CSC2N8KzChz7v8wl2u/syE4sVO1m8R2vauIWl3DzNaFXsVedbD
 bHF7TG8xH/d822gNahSRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dMEZOKT/lQ4=:bSOWI6g3h3fcwCY69dBw03
 6sYaVA0jQez5laTSfBGDscr7AwyfR9XH5yMBPfM9c9zjonCCxXh5LUz2VRDDn04XBlVoloYW0
 E5USijyBgfAGHKxJjy8PSfX9O2yQm3LGaKZvIdmsKgynggU6pWN3XtHaE+EJVnyeczGIGzS/9
 FkEbcWBB/1PDOqFxgu7i5ppJjVC05VfjaeflIREMqq+PAi9C8kr8++fYX+PMmrua19WBiEbNI
 g3p3vISUYFy8HZtc7c/DJz6HqLiZY4tIXgiNoFw7vM+LXBd3S/oOrhEQwVHlDbHQ/tcq38B2q
 3PlGl07jsyVdKcQPzDSZJQF+tSoJGCXbHyRvM7eCnqJ+/jaDDjfG0IlZHzF9tFHxNdCfi85Yw
 jFSRofh7CopE/pN3CzGK2aXltlvCq6C4IbFlD+OK0XFBI9sY0QPi30Z7nyrT+Ac2y6uOIOBqQ
 j0KQQCom9Ye3QlXx8A/NfRinHELfuKRBU6O3b4IR/yS/ypq54QjXC9xMsULuen/jRy92mwgmk
 aMRF0cNKhmA4fD6gE08W3IZl3ATBqXUvUvBctAIhwO/+0XO61RLySckG3xw16n2neeAPQFn1I
 JSb9haA/T/guRb6C/9lbbHt7Vmm+VnklQ5CHvsgyMEpvE/R+AWRKCKKz2Knz4rvNj54C2wTAQ
 a9rcZ0aEtOpOfjn/3gpnp9oWFx6BefsSC+08JZIbRuWSVRDOX+hPDwBmGr65k0gzkL5kP6t1Q
 E6z4I9Iufok7WrBN5vXgahZMyV78ZqgYqsXrdL1C0iY5jWfGgbYyxy35tPocHTRtJ/rvHy3dZ
 ZhJLMIRKBPoX7Tf02aEPTW+PfYD98CST4vG0KTXmYjsQX05Gq4YHZZCOQqve79tctUjJujnlz
 2BxT4xc+FIRW3vXuiXLeCNwd5sWgcQ/rzozjrbn8o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
> v8: use tswap32 (lvivier)
> ---
>  linux-user/strace.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index fd5596a640..5fa7748427 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -8,6 +8,7 @@
>  #include <arpa/inet.h>
>  #include <netinet/tcp.h>
>  #include <linux/if_packet.h>
> +#include <linux/netlink.h>
>  #include <sched.h>
>  #include "qemu.h"
>  
> @@ -398,6 +399,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>              gemu_log("}");
>              break;
>          }
> +        case AF_NETLINK: {
> +            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
> +            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
> +                     tswap32(nl->nl_pid), tswap32(nl->nl_groups));
> +            break;
> +        }
>          default:
>              gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
>              for (i = 0; i < 13; i++) {
> @@ -424,6 +431,9 @@ print_socket_domain(int domain)
>      case PF_INET:
>          gemu_log("PF_INET");
>          break;
> +    case PF_NETLINK:
> +        gemu_log("PF_NETLINK");
> +        break;
>      case PF_PACKET:
>          gemu_log("PF_PACKET");
>          break;
> @@ -473,6 +483,33 @@ print_socket_protocol(int domain, int type, int protocol)
>          return;
>      }
>  
> +    if (domain == PF_NETLINK) {
> +        switch (protocol) {
> +        case NETLINK_ROUTE:
> +            gemu_log("NETLINK_ROUTE");
> +            break;
> +        case NETLINK_AUDIT:
> +            gemu_log("NETLINK_AUDIT");
> +            break;
> +        case NETLINK_NETFILTER:
> +            gemu_log("NETLINK_NETFILTER");
> +            break;
> +        case NETLINK_KOBJECT_UEVENT:
> +            gemu_log("NETLINK_KOBJECT_UEVENT");
> +            break;
> +        case NETLINK_RDMA:
> +            gemu_log("NETLINK_RDMA");
> +            break;
> +        case NETLINK_CRYPTO:
> +            gemu_log("NETLINK_CRYPTO");
> +            break;
> +        default:
> +            gemu_log("%d", protocol);
> +            break;
> +        }
> +        return;
> +    }
> +
>      switch (protocol) {
>      case IPPROTO_IP:
>          gemu_log("IPPROTO_IP");
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


