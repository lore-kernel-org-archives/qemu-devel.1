Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF40C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778AF2074C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778AF2074C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsBJ-0003kD-L8
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCsAS-0002nO-LO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCsAR-0003IX-H4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:48:32 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jCsAO-0002wQ-Sl; Fri, 13 Mar 2020 17:48:29 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MlfCm-1jcXvp1iCI-00imBF; Fri, 13 Mar 2020 22:48:23 +0100
Subject: Re: [PATCH v7 2/4] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com
References: <cover.1584051142.git.alistair.francis@wdc.com>
 <4a7fd05532400d10aa0f684c9043e2ac7b34d91c.1584051142.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2ff48a56-8230-493d-f014-e4e164404b04@vivier.eu>
Date: Fri, 13 Mar 2020 22:48:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4a7fd05532400d10aa0f684c9043e2ac7b34d91c.1584051142.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZPUddPnQtnLw4YQkkev0f9fD671oM5o5qk7t5ONx1PRUEAmCs5u
 dIQrOndpQQ+JXUJr9NUtCuBHq/9KLA2CzEEGKTZXB+3bl0mvD7jjYdqMVran8jYQvp6VSwG
 vOEEilUgKCy8RUDFXSNDI7aueGN+by1A3DE3VAgn9xpy0cUX7vjoW5Jq25QOLcT6moBm07K
 W1WrdfwrHHZvLo6p0j7fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1R1PaJTIh3Q=:OyHm0V0OQpOGVqpZNs/gve
 xAInoq0o5apwusajlWFXxfAJnJFjTXYSSrxlk9RRZIrUEvsAaBjM4yE51pf/sbUg0rbZ5egS9
 5tX3CAjbm3Zwd59zHb7Nn0O9Ia4es6Vjfg+fr74ZC9EbkmCNALTy5+3rjXm3jg0b4bmHdBDQt
 /fCaJVgp4AJN8mDdgPlV33HCf4UtVsVWGHnjDEnKSdEs+kfaNb6N45Sb9lN+89tc5Fo+RXSGl
 XoPIovkeuitxxguJS9zNoJrU0FzmSiNKwJQbipwEcj9r39QtFhbLz5fhJRd6wqxgDREKhflsm
 aaczWxO4QBioSd58OY/H6Vdq4T2W5oCPfh5J+hyxpzlHyvtGveX4buoLOCjOCU/KUqs5F6KDM
 p04FeO1VadzglzLu5PtiypU1nVqEFX9Od/SWK1dBnhmSv9XtrPnOQ3Kvb/s28AddtiBDiETNk
 OkNEnjynrQar8xx/qBAf7ZhlDKUz3Fbd6rG0pzc9yVxnctjX1duBTWrYpFnRezsqRKbN4rXFk
 I8lUUDFuP5nYrGjuDis6HqIFuhQLSHOnqRXKE3hgCfMCP0/YWnQXIkGihYaTIQ9xNvPpfHtIi
 8OEkp7i58t+RxB8WMBNCCA60IdmFNuw2A9PK6wCUmFYHfnSjjjjngl7LcR1oTrb+Kk5dhQW3A
 beHZTivQmmj5+6dVLT0pC0an5fheTZi3OC3WkagKnK+HUu3mNQuIsRR09lFb5kHK6x3zQWTtc
 L4geSJYsRFh6gqnxgWjYmdeq9b71GTm/RmPyK9oxV+1d18hx7Y4W9SqOKAZPy8XvEfulVPQvn
 3nCdTPCevOWKaG+IkvJhwhXNphqrguAIN10D5P1etzBJQUEtURcScGf5LfgBjnd0o70r9ow
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/03/2020 à 23:13, Alistair Francis a écrit :
> Add support for the clock_gettime64/clock_settime64 syscalls.
> 
> If your host is 64-bit or is 32-bit with the *_time64 syscall then the
> timespec will correctly be a 64-bit time_t. Otherwise the host will
> return a 32-bit time_t which will be rounded to 64-bits. This will be
> incorrect after y2038.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 909bec94a5..60fd775d9c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1229,6 +1229,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_clock_settime64)
> +static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
> +                                                 abi_ulong target_addr)
> +{
> +    struct target__kernel_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 0);
> +    return 0;
> +}
> +#endif
> +
>  static inline abi_long host_to_target_timespec(abi_ulong target_addr,
>                                                 struct timespec *host_ts)
>  {
> @@ -11458,6 +11474,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_settime64
> +    case TARGET_NR_clock_settime64:
> +    {
> +        struct timespec ts;
> +
> +        ret = target_to_host_timespec64(&ts, arg2);
> +        if (!is_error(ret)) {
> +            ret = get_errno(clock_settime(arg1, &ts));
> +        }
> +        return ret;
> +    }
> +#endif
>  #ifdef TARGET_NR_clock_gettime
>      case TARGET_NR_clock_gettime:
>      {
> @@ -11469,6 +11497,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_gettime64
> +    case TARGET_NR_clock_gettime64:
> +    {
> +        struct timespec ts;
> +        ret = get_errno(clock_gettime(arg1, &ts));
> +        if (!is_error(ret)) {
> +            ret = host_to_target_timespec64(arg2, &ts);
> +        }
> +        return ret;
> +    }
> +#endif
>  #ifdef TARGET_NR_clock_getres
>      case TARGET_NR_clock_getres:
>      {
> 

Applied to my linux-user branch.

Thanks,
Laurent

