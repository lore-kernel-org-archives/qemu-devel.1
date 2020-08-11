Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B75C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3FE2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3FE2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VAk-0000UB-U0
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k5VA8-0008QA-3T
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:22:00 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k5VA5-0002BA-7E
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:21:59 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsI8Y-1kxsAS06FG-00tkVm; Tue, 11 Aug 2020 16:21:54 +0200
Subject: Re: [PATCH v2 2/8] linux-user: add missing UDP get/setsockopt option
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
References: <cover.1597129029.git.scw@google.com>
 <71ad91e4ee9f41f439086d8f9de60501ad304859.1597129029.git.scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d21e0d92-3d59-a83d-4ac3-7a1e68109b2e@vivier.eu>
Date: Tue, 11 Aug 2020 16:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <71ad91e4ee9f41f439086d8f9de60501ad304859.1597129029.git.scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YxUa/jCcAEMNVEKwc9VVj8jIHc0yMBBBEf2JPzd0ylviWDwQ+SL
 mx++BHfUyhoL2ZcE3DN4zwbvKHYQoGaYGQhca8E5E4Unsfxmw14Ucd0nK2WO5bZc8KyLoVo
 M19F1yJ81MaidUmq7lb+s3/QS+WbFIInOOsBHjRTPOdYR9SRyGna/5vY5wit33+HwKxKlZm
 G/8VEuhEQMWI2QPnOOa7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b5TYlylCGnE=:/ZpegOM09/qIaApEp2oW6V
 fs8gPGGy8FXpDqpc0M4lJIL588daxIm7UkcZL0tIQEzyM2y8Xu6Uroz11baQKGjbSS9PGcTry
 Too9taRVTjzPsnzcpYBY4G5V9VHXnPJKkc6bzbIy7emJluQvufukM7yBegc4eQE8FYiEj1zNk
 ThlyYD405qZkrJqqE9pVsEkneAJYyct9FqpWvV2qNRbCrg7S3IHLlh3GGfarvDZ8XRK/tjsOf
 9alZPFd010Pripe8XFWE8pfuuYiRfVMI1PXS6n10dIIWqn7qqzUMtqZMxZr2jumXAeeuwmoeF
 jDipBTxdDJoR/ipSPPUgQ0cJlXxPlQioPfd5lznA5uMdWxD77p75C9tEf/Zall3ysVYf5cg/v
 GbGx/NUnR4AfPF6jkP6S72qp4v/Tmjcul4oa6VtAIMFxgwIYMAE7LL+RcUMq/3dp6HSlOmmmE
 Rvat52tve8zIHbSzX8rZP/FX/l57SIOsscHynGSRDLyl31hN2y1T1VU9XC3ipYssPR+KmQozE
 Va/I14iPUaXgxqOoJVSqKmr8r7UoY6pnG2Ul9v+di/zo8PBZY95qOC+U+pX1SXHhetXhq8MBv
 K4/nCsyJxlm/9ZHmbXYDwnXAPE4OH2IyXjJK2Bw43gcEIUuLnDFud1gkfnutkvPYMrn0amkET
 I8A+zmENOkSporu7R05v/iI+T/liASV0ob/kCKm0Kjaz1WdRuvtBlUq8Hhr1UpFrN/i3solq2
 2YA4mxyKHw3kKHetly9RFfgsGLSs/rhUYg3G0X2oLUxOnWkBuTUKgZUIm/MaApWS4nNCLCaa7
 5nTOU82+AnveXbM/+jswLKrBbOJEAIcm1W7duryo6tJ3EZ2y7XgrKW17P+30ycFwlzetlEC
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:57:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/08/2020 à 09:09, Shu-Chun Weng a écrit :
> SOL_UDP manipulate options at UDP level. All six options currently defined
> in linux source include/uapi/linux/udp.h take integer values.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v1 -> v2:
>   Split out SOL_UDP into own patch.
>   Updated do_print_sockopt().
> 
>  linux-user/strace.c  | 6 ++++++
>  linux-user/syscall.c | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4fff24b880..854b54a2ad 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -7,6 +7,7 @@
>  #include <sys/mount.h>
>  #include <arpa/inet.h>
>  #include <netinet/tcp.h>
> +#include <netinet/udp.h>
>  #include <linux/if_packet.h>
>  #include <linux/netlink.h>
>  #include <sched.h>
> @@ -2190,6 +2191,11 @@ static void do_print_sockopt(const char *name, abi_long arg1)
>          print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
>          print_pointer(optval, 0);
>          break;
> +    case SOL_UDP:
> +        qemu_log("SOL_UDP,");
> +        print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> +        print_pointer(optval, 0);
> +        break;
>      case SOL_IP:
>          qemu_log("SOL_IP,");
>          print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5645862798..177eec5201 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -53,6 +53,7 @@
>  //#include <sys/user.h>
>  #include <netinet/ip.h>
>  #include <netinet/tcp.h>
> +#include <netinet/udp.h>
>  #include <linux/wireless.h>
>  #include <linux/icmp.h>
>  #include <linux/icmpv6.h>
> @@ -1938,7 +1939,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>  
>      switch(level) {
>      case SOL_TCP:
> -        /* TCP options all take an 'int' value.  */
> +    case SOL_UDP:
> +        /* TCP and UDP options all take an 'int' value.  */
>          if (optlen < sizeof(uint32_t))
>              return -TARGET_EINVAL;
>  
> @@ -2586,7 +2588,8 @@ get_timeout:
>          }
>          break;
>      case SOL_TCP:
> -        /* TCP options all take an 'int' value.  */
> +    case SOL_UDP:
> +        /* TCP and UDP options all take an 'int' value.  */
>      int_case:
>          if (get_user_u32(len, optlen))
>              return -TARGET_EFAULT;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

I'm wondering if the int_case of getsockopt() manages correctly the
length: length can be between 0 and sizeof(int), but the int_case only
uses a put_user_u32() or a put_user_u8(). Do we need the put_user_u16()?

Thanks,
Laurent

