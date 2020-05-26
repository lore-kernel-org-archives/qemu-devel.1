Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69EBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9835206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9835206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdaVM-0001hG-PV
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@netbsd.org>)
 id 1jdZSQ-0006Fm-HS; Tue, 26 May 2020 09:17:26 -0400
Received: from mail.netbsd.org ([199.233.217.200]:60308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@netbsd.org>)
 id 1jdZSP-0003Ez-7Y; Tue, 26 May 2020 09:17:26 -0400
Received: from [IPv6:::1] (localhost [127.0.0.1])
 by mail.netbsd.org (Postfix) with ESMTP id 11E5E84C8B;
 Tue, 26 May 2020 13:17:18 +0000 (UTC)
Subject: Re: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD
 and NetBSD
To: David CARLIER <devnexen@gmail.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@readhat.com, qemu-trivial@nongnu.org
References: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
 <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
 <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
From: Kamil Rytarowski <kamil@netbsd.org>
Autocrypt: addr=kamil@netbsd.org; keydata=
 mQINBFVwUF8BEADHmOg7PFLIcSDdMx5HNDYr8MY2ExGfUTrKwPndbt3peaa5lHsK+UGoPG48
 KiWkhEaMmjaXHFa7XgVpJHhFmNoJXfPgjI/sOKTMCPQ5DEHEHTibC4mta7IBAk+rmnaOF0k8
 bxHfP8Qbls66wvicrAfTRXn/1ReeNc3NP4Sq39PoVHkfQTlnQiD4eAqBdq61B7DhzjhbKAZ4
 RsNtLfB6eOv9qvmblUzs50ChYewM9hvn+c7MdDH+x2UXoSDhkBDkKcJGkX91evos8s9AuoEd
 D32X5e+bmdUGe8Cr3cAZJ8IEXR6F9828/kxzPliMsCWVRx1Fr28baCJOUGgFPNr3ips78m9+
 Iw8PdQ101jU0dvucDFxw/1SCGYEZzV+O/237oRPuLCiDX5nhQoxf6dn9ukQleLBMNy2BLI4H
 g342NhF21HLA+KlyLOHaMKQCKzlal+zVNZTRTCh/ikMhsxWQjBfnqTDbMj85DnWwtump27SI
 qhPjUnS0a6MKoS/A+hbi64k5zztkvloELfCSrX7NyBTT0jgF2IGFIxZMrKCtQ9StcGMCV9MX
 tjcBy6fj7QMontEaIDRJEMjg8UIGw1B687OhalOv1ISia4xOWvpYAM6ipgqh6tBQmFzasL9P
 h1RtcVdFpFbhwVlr1Bly8c25gBNQHL5GUjLMn45LlQz50OzrkwARAQABtCNLYW1pbCBSeXRh
 cm93c2tpIDxrYW1pbEBOZXRCU0Qub3JnPokCOQQTAQgAIwUCVbKF6wIbIwcLCQgHAwIBBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEEuzCOmwLnZsrgwQAMdXTXDWkxtUciFgBnioE6hvZYOBV7Xa
 Gh3dwgVvS5rLwwq5ob1R9qdtCGMYxdaCAQCzo2hhUfe9ts11/Q4Pg0aDAb5CfdVVTmyvLMu+
 gtK99t/sG4SfCdn8Bb8rCfRRDpkTq1cAGy6pp7rxyMrFBITTbdBWVcWdEdlMhEZtV8Z1BNDI
 kwEwZkYnM1UxOGW4rJNjNU+hBjNAscCTwBSbpG6NV1oBbgmgJ1PfaPCeAmGTLZyI57VLuFJy
 kR0Jlj8Ui7dAaJgO1WYdmvL+48s0N2QGEoHnrf50xoO34LlrIBUsCLmhtjWhZiuj0meCxNTr
 5YpdBP13b2i64OCruH8/M4IO85GAIWxIMMv510rge9qSe38NHCzSmn9zcjFwVXIh9flZi7PK
 eqOP3yah6r1ZIBY68If/2FtvwDptUi1NHoSpN+dt0kRg26hDqMFOg+Jc6o7Wtm+3vFNDhU4I
 8HkjDr62VlbHBxe6gDgVELcecWgXOydKgdrQhOPwCBJkPJigifsIz4EZQnyI3CchFja3qR9J
 Vo4iXwqAi6xN4RD0PS775JYDh56qUaaUsEctQ/D6Xm7Bbdv1VPlsYs/9uXxc/jWVhkd1sDn2
 KZ3kv7uo04DoejVGWK9B4XEZ1ufRPzmlV0SYohX34ouLBq5Q6wbyw6+hUM+yM9RcvgkOCVgB
 laejuQINBFVwUF8BEAC61vNvzAAcYvkU89YoStDcGyun1ENNWpHOnuQEw613/Xgys6xZbKKa
 Xhee8Fiwm6FlaiYWh66Vw5cA+hMna9PDp6tZi106JnKZ9DcYxanHOCQ5V42OwUX0BDfwUIwq
 YgOz12Cf4pdIheVkDfiSEot3XrdI3lT8od9iWeehx5zfW77utVrWGUXkMFJKmiKzxyzjV+gF
 gLk2wH+L7KoYiV/MfLukLa7mTJAK4mi0sfjLStPlf5gELvPtyooKG0gs0MbDSG2qmzb1/A4Y
 ET8Vaa7wJulIePym+Du5TJBwptls0KEF9a04kp2Oc2zlUd/Z5z3lLBiZaXpfProbz3Ydjg4O
 2+XTn+SHSq10l3agjiAkGwHH83Xnzn/clg3iTvwYgdOcwvfEnJ1FGz3DAzcBd/+IMaszJjuo
 dBVckt07mc97sseDjy+vIIyQGdMzDmI0U9UK7nDUFpnIfG5LYe+myBS1CgFrZAQ/WNg0j7aq
 CiIgbhVAOFi2sPRYlph2L8LZRUPFHLTt23vdJXdFDuKM6JSvPiDf914UpjXr/WSwT43lJzlO
 O3zgKGM7eclFsetDF3p0I4SVHvR7dHbIC5IHibssmk7bQgH0K1aGUX/QC18v3VY7wYYaotYH
 RnTiGbBGz+XxPhZYiXKQuyFu6dY3qOw/VjbsV6KVNn49z2Zg4RQV8QARAQABiQIfBBgBCAAJ
 BQJVcFBfAhsMAAoJEEuzCOmwLnZs9rIP/2MTyZ0252u51LFsMHa9/ylTyvl+UKq8iR852lkZ
 X9bH9nH4cUcen5vZo0EZI3IVOemHUq71u+DTq8PSj5vtJ0DW+sGBEbjW3Q4IjJ+96PPrlemK
 fYS0KWVwEzzNQLEejjduU43x83DvQ/URzSWgGnhMBqXUyJdsHyTFFNFwQ9U71gX00+wXHJyh
 aXRlK+7gRKtCWuNFtW/5bQXL9epxDAS0POIVAdBc1FtPLwg08Pj0KwHsGQpEr5/W8ybDtLF+
 zISHIKCj1lZ8dv/7D1PmH5SEXzsv+bbzvPtb6zhoIA8HONshaG2eAYknAiCJZ0gj0npgktwc
 u9VkvDvHMD9+VyNzRV/M6Ak4nDeEG6QecTPv8IqCcAHDI27nY/49BvFVOJOMwqbTp5Xvfa71
 ksP1mARrN+bIYMfOy7OhfCxGeZydvBhgCLKdL698aXmgy0xrmrOw+GXO69GVcebOvxWMXxz1
 FOG/JnLIe1ZgCo2YF5wy8zTCGKCMx6gAwnku2nJmDGNsePVedV00FmB8mQ7Oxz+3B9+LtFim
 FHHR33PlRnViXlG+XTm9NontiGE0LvG4TzIY5CYNSw8PBao795dQMSsmMI4FHlvTIgupE9g1
 PQWP+2H2C0RtnLUanRNUGRkze1+MNG7jc+fqJIo5s7+PSs26rUvA38QzEOJ95k7hdJty
Message-ID: <5b53af7c-72bd-f096-1763-353a8f9596e9@netbsd.org>
Date: Tue, 26 May 2020 15:15:49 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=199.233.217.200; envelope-from=kamil@netbsd.org;
 helo=mail.netbsd.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:57:51
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 26 May 2020 10:21:34 -0400
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
Cc: Kamil Rytarowski <kamil@netbsd.org>, qemu-devel@nongnu.org,
 bauerchen@tencent.com, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Kamil Rytarowski <kamil@netbsd.org>

On 26.05.2020 09:29, David CARLIER wrote:
> From 792fbcd9114f43bd80fd1ef5b25cd9935a536f9f Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 08:25:26 +0100
> Subject: [PATCH] util/oslib: Returns the real thread identifier on FreeBSD and
>  NetBSD
> 
> getpid is good enough in a mono thread context, however
>  thr_self/_lwp_self reflects the real current thread identifier
>  from a given process.
> ---
>  util/oslib-posix.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 062236a1ab..916f1be224 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -48,11 +48,13 @@
>  #ifdef __FreeBSD__
>  #include <sys/sysctl.h>
>  #include <sys/user.h>
> +#include <sys/thr.h>
>  #include <libutil.h>
>  #endif
> 
>  #ifdef __NetBSD__
>  #include <sys/sysctl.h>
> +#include <lwp.h>
>  #endif
> 
>  #include "qemu/mmap-alloc.h"
> @@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
>  {
>  #if defined(__linux__)
>      return syscall(SYS_gettid);
> +#elif defined(__FreeBSD__)
> +    /* thread id is up to INT_MAX */
> +    long tid;
> +    thr_self(&tid);
> +    return (int)tid;
> +#elif defined(__NetBSD__)
> +    return _lwp_self();
>  #else
>      return getpid();
>  #endif
> 


