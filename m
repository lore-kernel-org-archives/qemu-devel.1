Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD0C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD12206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD12206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPUN-0005eK-G0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNP4J-0007xt-Qt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 19:29:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNP4H-0001GZ-Os
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 19:29:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MjjSt-1kp4yO28N9-00lAOd; Wed, 30 Sep 2020 01:29:55 +0200
Subject: Re: [PATCH v2 4/8] linux-user: Add IPv6 options to do_print_sockopt()
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
References: <cover.1597129029.git.scw@google.com>
 <7d61f792c22de8df3c6a9438eacc3906620e7c54.1597129029.git.scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <88f3d62a-af87-c0b8-a665-67441aad5a0b@vivier.eu>
Date: Wed, 30 Sep 2020 01:29:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7d61f792c22de8df3c6a9438eacc3906620e7c54.1597129029.git.scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a+zQJR+ArbQONRI4x6cS7Jp8HXOhZtLtfpvBjMmGtB7ArvG0R5D
 58L3NHGby0Mnwm6sk2qvJwOVlPj0U/QygXIbOkTgnnZirlSQWJTwo+i+YsN98kWAOdRu3yf
 +Juv9mol8lX3l9tpcpsz6Y8eHUhYL7qDrtSsGv3ogZa7NHE8SFk4n9XrET0UBPTXNa44ONj
 CyaS1gk9QP9xYU6NEqf1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jt30zYxLyZk=:J6aCfRZraNenK4L4dAqIMg
 Koha00y0JRMGV9q9gLwPkkSyUjzlWSnp9JOfSR/jIStqj5JHuUNl8mx9WkThtf8byRE3Cogq9
 CpYAzgX9vTbhgVjpt4mEXENMEpxbw+Q+hLQXdNQdFA4AYTOAGyaFeTITq7/yjlvihws2LmMUw
 3tIGEtQpYFV4CWyYFjXb5foytX5fLIc6PxzkjFshn95CbYbTReOY72OdZlaufFAD3AQvUfmLF
 QuAc19aihm9jnjcm+BwU5D+R8OQPE02Kg4QCbOjkHZ4NdHNGvoLyRnnX3Bb4fZk4w4RjsZnR5
 68z0WhMen4YRUZRJt/ix1oRpRkvmj3N4/T2vYiLkffKYoWdvSsBO1hxJaKOEDB6amRMZh6b/A
 5yqyr3+rVWlwuoX964zzGFHr0CydDSb+bCOP5W+hnEg7VtNlAv86ZdY/dZO+KtAD/opYEKNij
 AdocOUbiBY+D6pkttTzIkc9i3G44cglOt6eSnv85ziE5/SKUWY9sAb1Bk4BN625eOFPTVjUjL
 4sjdzPrbYI/D89K5bv+JAiVIBj9omOtGOh2+oBlFESre5NFJOxjOLLMosdD3VtZ/3w9db4Txc
 z+XLU90ONXFHdU+TFs9tCU8Ge0NQTC3UNwIt98xOzlBqoHLu6Ij+C9tUAnem+P568LHI8mcYB
 KMgJ4q/AxOmYQa8pDRF0kMn90g5s49mx4GmaNsmpLAAQFDLyMdpz92JYx+7pYk3M7KQJrdED2
 DLuUCqeuzEKk/p1fv/Z8921QPevwmVUhtT8JdEKy4WzzCchaAZGoScFlueefRnbfKO0uoprZ/
 Z2yq76pbUWPVyevJOizICZ8gPtCejeIaWtaRDMQB+mJjwaPY4L+1wa69zZE+ScvUbhwNsCH
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 19:29:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v1 -> v2:
>   New: Add all IPV6 options to do_print_sockopt(), including the newly supported
>   IPV6_ADDR_PREFERENCES.
> 
>  linux-user/strace.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 854b54a2ad..089fb3968e 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -6,6 +6,7 @@
>  #include <sys/select.h>
>  #include <sys/mount.h>
>  #include <arpa/inet.h>
> +#include <netinet/in.h>
>  #include <netinet/tcp.h>
>  #include <netinet/udp.h>
>  #include <linux/if_packet.h>
> @@ -2307,6 +2308,113 @@ print_optint:
>              break;
>          }
>          break;
> +    case SOL_IPV6:
> +        qemu_log("SOL_IPV6,");
> +        switch (optname) {
> +        case IPV6_MTU_DISCOVER:
> +            qemu_log("IPV6_MTU_DISCOVER,");
> +            goto print_optint;
> +        case IPV6_MTU:
> +            qemu_log("IPV6_MTU,");
> +            goto print_optint;
> +        case IPV6_V6ONLY:
> +            qemu_log("IPV6_V6ONLY,");
> +            goto print_optint;
> +        case IPV6_RECVPKTINFO:
> +            qemu_log("IPV6_RECVPKTINFO,");
> +            goto print_optint;
> +        case IPV6_UNICAST_HOPS:
> +            qemu_log("IPV6_UNICAST_HOPS,");
> +            goto print_optint;
> +        case IPV6_MULTICAST_HOPS:
> +            qemu_log("IPV6_MULTICAST_HOPS,");
> +            goto print_optint;
> +        case IPV6_MULTICAST_LOOP:
> +            qemu_log("IPV6_MULTICAST_LOOP,");
> +            goto print_optint;
> +        case IPV6_RECVERR:
> +            qemu_log("IPV6_RECVERR,");
> +            goto print_optint;
> +        case IPV6_RECVHOPLIMIT:
> +            qemu_log("IPV6_RECVHOPLIMIT,");
> +            goto print_optint;
> +        case IPV6_2292HOPLIMIT:
> +            qemu_log("IPV6_2292HOPLIMIT,");
> +            goto print_optint;
> +        case IPV6_CHECKSUM:
> +            qemu_log("IPV6_CHECKSUM,");
> +            goto print_optint;
> +        case IPV6_ADDRFORM:
> +            qemu_log("IPV6_ADDRFORM,");
> +            goto print_optint;
> +        case IPV6_2292PKTINFO:
> +            qemu_log("IPV6_2292PKTINFO,");
> +            goto print_optint;
> +        case IPV6_RECVTCLASS:
> +            qemu_log("IPV6_RECVTCLASS,");
> +            goto print_optint;
> +        case IPV6_RECVRTHDR:
> +            qemu_log("IPV6_RECVRTHDR,");
> +            goto print_optint;
> +        case IPV6_2292RTHDR:
> +            qemu_log("IPV6_2292RTHDR,");
> +            goto print_optint;
> +        case IPV6_RECVHOPOPTS:
> +            qemu_log("IPV6_RECVHOPOPTS,");
> +            goto print_optint;
> +        case IPV6_2292HOPOPTS:
> +            qemu_log("IPV6_2292HOPOPTS,");
> +            goto print_optint;
> +        case IPV6_RECVDSTOPTS:
> +            qemu_log("IPV6_RECVDSTOPTS,");
> +            goto print_optint;
> +        case IPV6_2292DSTOPTS:
> +            qemu_log("IPV6_2292DSTOPTS,");
> +            goto print_optint;
> +        case IPV6_TCLASS:
> +            qemu_log("IPV6_TCLASS,");
> +            goto print_optint;
> +        case IPV6_ADDR_PREFERENCES:
> +            qemu_log("IPV6_ADDR_PREFERENCES,");
> +            goto print_optint;
> +#ifdef IPV6_RECVPATHMTU
> +        case IPV6_RECVPATHMTU:
> +            qemu_log("IPV6_RECVPATHMTU,");
> +            goto print_optint;
> +#endif
> +#ifdef IPV6_TRANSPARENT
> +        case IPV6_TRANSPARENT:
> +            qemu_log("IPV6_TRANSPARENT,");
> +            goto print_optint;
> +#endif
> +#ifdef IPV6_FREEBIND
> +        case IPV6_FREEBIND:
> +            qemu_log("IPV6_FREEBIND,");
> +            goto print_optint;
> +#endif
> +#ifdef IPV6_RECVORIGDSTADDR
> +        case IPV6_RECVORIGDSTADDR:
> +            qemu_log("IPV6_RECVORIGDSTADDR,");
> +            goto print_optint;
> +#endif
> +        case IPV6_PKTINFO:
> +            qemu_log("IPV6_PKTINFO,");
> +            print_pointer(optval, 0);
> +            break;
> +        case IPV6_ADD_MEMBERSHIP:
> +            qemu_log("IPV6_ADD_MEMBERSHIP,");
> +            print_pointer(optval, 0);
> +            break;
> +        case IPV6_DROP_MEMBERSHIP:
> +            qemu_log("IPV6_DROP_MEMBERSHIP,");
> +            print_pointer(optval, 0);
> +            break;
> +        default:
> +            print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> +            print_pointer(optval, 0);
> +            break;
> +        }
> +        break;
>      default:
>          print_raw_param(TARGET_ABI_FMT_ld, level, 0);
>          print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

