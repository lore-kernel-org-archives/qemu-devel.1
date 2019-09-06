Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BC720674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BC720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BLH-0002Mv-Pa
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6BKN-0001yL-Sg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6BKM-0000Px-Qz
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:18:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6BKM-0000Ov-HV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:18:50 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mgvj1-1iegnJ1fnZ-00hQty; Fri, 06 Sep 2019 12:18:12 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5aebdae9-2931-163e-b10d-981d6511c21e@vivier.eu>
Date: Fri, 6 Sep 2019 12:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L+83raG+93gi0vyx/06meLcyNQ1EWmWvm1GNiJbrXHYWK2L6W75
 wHwckQthxgxJJcXGRcgb/qIDe03DZpD8gplkAwEFiW9r1S1qtfT5xqb73GqB01cN4V/ocTa
 NdonvRUyFYWAeZrt0DCpFijZnmzw2ZN/elYJA9ZKZsiMlCctPSs6rXXKuxj43vVAgKXQA7F
 CEo2qRWY0MuxoTykR2iZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dn29yEV5kyU=:dTXtrWUpKDbjOfAprc9btM
 wxNS6JsKqq4U+5u4G8sTNscI2B54r1rqfdZMUAmL4vJ7mCi3oT5NFrk2HvwZEtkllb5LOt2sN
 s8LYnzV401iHbyCzaQG2m7wxQwJJz8UTIcWcJyWfXS81oOErSftB4hflRsOaSXkzBjvMOuKoO
 F38scQ55RD3Ydwe4OlB0WuN8LAed5h2E4XRLFk0bUO2QefP8ARJydPte0DZPBeBZVqSUHL17G
 cj1/S42tZTQGkJqZlhIYsGKM1mUhQNKWW71UaBQIV/hcmVwFbAId614KSTgq/b9jltbz8okOS
 9688lNkq9mMTBY3NnWQVd2AG6t5EpW0LBD+9Z3z4+6m/SZdgClHKf1tGPhPOQnQE52R2naZb/
 ykO3eRXnAopv+s/K2pLW9Sa5r9HSftAD8l4bqa0LoXlbcQxOCpJIRTlr2XclHx0U8h0VV5hWQ
 SbQNiGKI2AGT5gFMaTkHHbwBOV47n0umUCMLjgk01NftutThtlQPjougg+76GUBELKJQpFqU1
 icoNF4qtU26dRyit8bkuApQO3Zu53FcYGIGwTM7zPScvfdBYGYz2OTCDJXdDMS9M/P+p4nqvu
 958ZtfAZqJinnpuviEr91J30bSy+AA/pg6xVKPNf3tyTqMXTVSee4t/fZH5n39E4Z2O9ZNhIz
 SjQRSHiLRqyxg2xoZZmsIp+sNpiJOZKzTVuvZnb5DnqQfSxPT0ryINZAMnWIUN50RXP2+mNc0
 1EhX9L7PhVIemhauwRTX8r/cWO99aQi3JabvmH4xRLhcj1hq5ReqgXpGDnpAIfhS0EFOIW4lU
 JeXlIjdJeKE4bqjf2wMuEHuaWu2OM2J+i6zXK/XSzy6hB22muk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v6 3/8] linux-user: Add support for
 FIOGETOWN and FIOSETOWN ioctls
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
Cc: riku.voipio@iki.fi, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FIOGETOWN and FIOSETOWN ioctls have platform-specific definitions,
> hence non-standard definition in QEMU too.
> 
> Other than that, they both have a single integer argument, and their
> functionality is emulated in a straightforward way.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 2 ++
>  linux-user/syscall_defs.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index cd9b6f9..1830de9 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -177,6 +177,8 @@
>  #endif
>  #endif /* CONFIG_USBFS */
>  
> +  IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
>    IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
>    IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
>    IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 19a1d39..498223b 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -758,10 +758,14 @@ struct target_pollfd {
>  
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
> +#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
> +#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
>  #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
>  #define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
>  #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
>  #else
> +#define TARGET_FIOGETOWN       0x8903
> +#define TARGET_FIOSETOWN       0x8901
>  #define TARGET_SIOCATMARK      0x8905
>  #define TARGET_SIOCSPGRP       0x8902
>  #define TARGET_SIOCGPGRP       0x8904
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

