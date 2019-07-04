Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258FEC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF3821721
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF3821721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4mY-0007Wx-KR
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hj4lh-00070t-7Y
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hj4lf-0006Jn-Av
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:39:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52561)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hj4ld-0006FE-N5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:39:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M6EKU-1hcU7f13s0-006cQS; Thu, 04 Jul 2019 18:39:07 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1562251966-19318-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <486ba742-e1ab-d473-430c-56b24c291d64@vivier.eu>
Date: Thu, 4 Jul 2019 18:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562251966-19318-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cxwmX6ZoqqJnhwXTtRPtbPaIf7HanLoBY9mLzcUzWC/ap+ktApT
 Ge2ehfk8LT32iJFJn+ovwB8vfvh4hTGXaA+MOuAqrg7hhVABQKcCZDq3h8WIup6dCFeZzvF
 QYNCk3oQ+8gx0SFy1qi6h4fDak0TOFegfhy2LN0chsx2sROud0ILJHQwQxHfxWrzD7wG25h
 +Qj4ezZz9kKEQTYAa3ptg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/dM04zn/HGQ=:JGZ9VHCyF3Sum7bLVc23m1
 cV9XK/kz19N/oKrpMCGXJ1m8qkPeV0NJ39cdQ3DpheNfafbelIGJOioiKdxR7YyQkK6zvftZo
 23WLadBMI8hBrwpja2mHZS9+ULwVE31kXWig1i8Lvomyz+knQ+Ej65tU20jCIfs6MZZQY52x0
 6TCnspqTT9rOAbTHKkv6aAHbddaaU8+mfOSIA82PcQKnkppOyq4vngtRpCxCTVScHhvJ3uRBK
 w449tmhTHkngrOEkm4narL4CWPL9wYpgS/8feGRCbH1ecvXB6rkuvDafnPdF3cDvKzFiS+4R0
 kVucOOdxJmzf3t4eaBvULR3mF4IgTEsEwELbR+2+d8Zx6oq804OKHQEjA+lysTo2s17GTORQ3
 9/YOntnw1RMEM1LZPS6ZOHhv9iiRe4r+f2fsgTe9m6XZY4SwWm/N8MHYqSEzgjr2/dqXY4wM3
 HbRV4iozcJjG5YqraCa25edup03eCiyA9OqULOuKiZ+UhuewEXh8jwDRzNtZ8kkem5S9IMP/K
 BqWiL4jx9G06tFOVgbJL4ornIUkiGcCwA5IGVH1CD+wpRthFJtYk5iGydI+Vpc2CtxXDMPmNT
 Hiy+COi7ms/wr1aO+tjVvljBfzjZJNzx0pKYMEY5plDMDpgWyYIofBGEDfiyhfBqGaN04DPKX
 5TjwlDFcXZoZcVfsUk2lbExCgPwUxx1NFd1ACvqQNSvYx2ZBP+6c873xcA2h1cBaa1kYfOK//
 8F/61pF0WCvk7B0KMasVIGiMIuOd2iQmJvfV3DjsjLozDQlymASPab3T3MY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH for 4.1] linux-user: Fix structure
 target_ucontext for MIPS
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Dragan Mladjenovic <dmladjenovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/07/2019 à 16:52, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Structure ucontext for MIPS is defined in the following way in
> Linux kernel:
> 
> (arch/mips/include/uapi/asm/ucontext.h, lines 54-64)
> 
> struct ucontext {
>     /* Historic fields matching asm-generic */
>     unsigned long       uc_flags;
>     struct ucontext     *uc_link;
>     stack_t             uc_stack;
>     struct sigcontext   uc_mcontext;
>     sigset_t            uc_sigmask;
> 
>     /* Extended context structures may follow ucontext */
>     unsigned long long	uc_extcontext[0];
> };
> 
> Fix the structure target_sigset_t for MIPS to reflect the definition
> above, except the correction for field uc_extcontext, which will
> follow at some later time.
> 
> Fixes: 94c5495d
> 
> Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/mips/signal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
> index 6aa303e..455a8a2 100644
> --- a/linux-user/mips/signal.c
> +++ b/linux-user/mips/signal.c
> @@ -71,10 +71,9 @@ struct sigframe {
>  };
>  
>  struct target_ucontext {
> -    target_ulong tuc_flags;
> -    target_ulong tuc_link;
> +    abi_ulong tuc_flags;
> +    abi_ulong tuc_link;
>      target_stack_t tuc_stack;
> -    target_ulong pad0;
>      struct target_sigcontext tuc_mcontext;
>      target_sigset_t tuc_sigmask;
>  };
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

I think the padding is not needed anymore because the ABI types are now
aligned using the target ABI rules.

Thanks,
Laurent

