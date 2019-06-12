Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93AC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A9D208CA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A9D208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6SW-0004Bc-RY
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hb6Ph-0002cC-Ae
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hb6Pf-0001p6-HZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:47:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52427)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hb6Pf-0001lO-84
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:47:51 -0400
Received: from [192.168.100.43] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1MdeSn-1iAAAy2cjJ-00Zc01; Wed, 12 Jun 2019 18:47:29 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7af245e5-9d01-0402-3cb3-a1d5037a4395@vivier.eu>
Date: Wed, 12 Jun 2019 18:47:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559903719-7162-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8iHfpGX5k53SxadoWUSZjd+1b9huPp4H5QGlWyZlqaqHClDXl53
 tHZRh3l/+amqskDfedsM2TWISiekk9IstCz+o5xxKpVQc+FcxvyTP+/vRnoQ13nEbRsHOTT
 OUTuW+/uLpTZdxMwps9kzMplV+XUcsPi5zwkBk7fJmm2AujRCIgCKY+xi7dQn9r6lO1zheW
 /FvETh3DRyrxyj3H5zwOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZeeDS8DbTMM=:ELN6QaQdw2I/1lt8YuE1AS
 vrg+3tdXwHTdFrB4H/Gwv8OOyEzmHRjgNyder66hKGEKAcv1K9cgSv8uchhoBqr4U7HlemDyI
 vlzwr6isLC9ogdjDw6hsVWxw+GusuCza+r5eKMB0xD4qFFqX0pZeOlplqjDqtpUHFsDTrq8zP
 wnVPFn5K7+RJ4MPIZZzOadWJz04x0khRY5joWaJ5ssMTnXS77NgM6CLJMrN7LBQKgNimzAFT+
 0WaM71JkEHbri4k61SEFfKJmIDLDW5rGiWP/Cd/T7ji6OKZm3QyM7t+ZKzC9GPX5otVxj5Hyc
 WZ1OHaUjhhi73cgjQahoTz1IB563QZxu4ImKi/wHjUue2BMVQiwyMsrry09TPpcIZLldRA+wC
 fhUVkUuJifLt6dXZex+HcwIVlnX8InCwlREKXk2RFNpg7zlfr5IoO28jBKiOLqL+y7m22Dgpg
 QUVh5qT/QUSBo6eNA2sajMCqsBnMtK47rNG+ez5q2ZJVxagWYmAse6lIjcNKp06erH8fFwbtc
 E8DKRm0WonRXZ3zGxrC9zAyiHSriFC9GtStYnMDpZfhunu2jSXA9zbIoNZAKbyvUMiz2oP1wU
 YIbMC7HOk1GjC9uJ6mecbl/7CihDMX8A187rshBu7OZb3FCDtFLWBHbn2idHcOrYOCdQC2iLj
 Xu8nC+aZbJATjXFH4j88RU3XFWthEdklJ0oa/W5N75p7k20ElaQ+wRfeSVuzC52hoyuOYOAfn
 xjpODuZRS+oH4AutdhSofCsxqHJagWEUZ6rAOvRtrOpS+c1FgpAumzNW9bY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v10 1/3] linux-user: Add support for
 setsockopt() options IPV6_<ADD|DROP>_MEMBERSHIP
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
Cc: Neng Chen <nchen@wavecomp.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/06/2019 12:35, Aleksandar Markovic wrote:
> From: Neng Chen <nchen@wavecomp.com>
> 
> Add support for options IPV6_ADD_MEMBERSHIP and IPV6_DROP_MEMPEMBERSHIP
> of the syscall setsockopt(). These options control membership in
> multicast groups. Their argument is a pointer to a struct ipv6_mreq,
> which is in turn defined in IP v6 header netinet/in.h as:
> 
>  struct ipv6_mreq {
>      /* IPv6 multicast address of group */
>      struct  in6_addr  ipv6mr_multiaddr;
>      /* local IPv6 address of interface */
>      int     ipv6mr_interface;
>  };
> 
> ...whereas its definition in kernel's include/uapi/linux/in6.h is:
> 
>  #if __UAPI_DEF_IPV6_MREQ
>  struct ipv6_mreq {
>      /* IPv6 multicast address of group */
>          struct  in6_addr ipv6mr_multiaddr;
>      /* local IPv6 address of interface */
>      int     ipv6mr_ifindex;
>  };
>  #endif
> 
> The first field of ipv6_mreq has the same name ("ipv6mr_multiaddr")
> and type ("in6_addr") in both cases. Moreover, the in6_addr structure
> consists of fields that are always big-endian (on host of any endian),
> therefore the ipv6_mreq's field ipv6mr_multiaddr doesn't need any
> endian conversion.
> 
> The second field of ipv6_mreq may, however, depending on the build
> environment, have different names. This is the reason why the lines
> "#if __UAPI_DEF_IPV6_MREQ" and "#if defined(__UAPI_DEF_IPV6_MREQ)"
> are used in this patch - to establish the right choice for the field
> name. Also, endian conversion is needed for this field, since it is
> of type "int".
> 
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5e29e67..dde6889 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1921,6 +1921,33 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>                                         &pki, sizeof(pki)));
>              break;
>          }
> +        case IPV6_ADD_MEMBERSHIP:
> +        case IPV6_DROP_MEMBERSHIP:
> +        {
> +            struct ipv6_mreq ipv6mreq;
> +
> +            if (optlen < sizeof(ipv6mreq)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +#if defined(__UAPI_DEF_IPV6_MREQ)
> +#if __UAPI_DEF_IPV6_MREQ
> +            ipv6mreq.ipv6mr_ifindex = tswap32(ipv6mreq.ipv6mr_ifindex);
> +#else
> +            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
> +#endif /* __UAPI_DEF_IVP6_MREQ */
> +#else
> +            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
> +#endif /* defined (__UAPI_DEF_IPV6_MREQ) */
> +
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                       &ipv6mreq, sizeof(ipv6mreq)));
> +            break;
> +        }
>          default:
>              goto unimplemented;
>          }
> 

It becomes complicated...

I think the first version of your patch using only ipv6mr_interface is
the correct one:

- POSIX defines ipv6mr_interface [1]

- __UAPI_DEF_IVP6_MREQ appears in kernel headers with v3.12

  cfd280c91253 net: sync some IP headers with glibc

- without __UAPI_DEF_IVP6_MREQ kernel defines ipv6mr_ifindex

and in cfd280c91253 it is explained:

   "If you include the kernel headers first you get those,
    and if you include the glibc headers first you get those,
    and the following patch arranges a coordination and
    synchronization between the two."

So before 3.12, a program can't include both netinet/in.h and linux/in6.h.

In linux-user/syscall.c, we only include netinet/in.h (glibc) and not
linux/in6.h (kernel-headers), so ipv6mr_interface is the one to use.

I found debian/wheezy (2013) is the most recent debian distro without
the definition of __UAPI_DEF_IPV6_MREQ, but it doesn't have gcc-4.8 and
thus QEMU can't be built.

Thanks,
Laurent

[1]
http://pubs.opengroup.org/onlinepubs/009695399/basedefs/netinet/in.h.html

