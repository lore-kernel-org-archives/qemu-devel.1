Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3C3C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F7620848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F7620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2COi-00087H-H5
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2CO1-0007AN-PU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2CO0-0005MX-42
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:10:25 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:41733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2CNz-0005M3-Ra
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:10:24 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N18MG-1jVVXv1j58-012cSs; Thu, 13 Feb 2020 12:09:53 +0100
Subject: Re: [PATCH v2 5/9] linux-user: mips: Update syscall numbers to kernel
 5.5 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1581558393-9182-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1581558393-9182-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9146df56-af9e-ca88-5565-b0b6a160af5d@vivier.eu>
Date: Thu, 13 Feb 2020 12:09:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1581558393-9182-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xEPryXm3dHi9Wclo6QQqvZdEURfgV4qyKT4xbtTfND96jXvSAvX
 GIzJhf5OMsxxBLu6CSBb9VxRDWRTgHZrVFPy30VNovJbHVNqApWQ8CYmuES//qq7aoHbPOt
 oJ47G4NCUCgyf8Ed5N6KMndJW3cp65461G+Rcp0fa03x2qXt40eWtK+7pSpo1My073rj4Aj
 bkUlSutujnUg/ZIe3LPhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sA6Sb7K9mQw=:gCkrd0/9embBnNUyw8EqkW
 9sRay5lw1bPvzMfndezc/NWiurfqxNZ//KdRKVgW1wy4FukMC6pUKJf+NbUlOHLoPBCEyIloD
 5t7ebs8ytv5EfqgBR5iGIRf7nD/OoRPmYeRE6Q2L7iBuAmt0AUCQfib//nS5VBy0Yi/16bD8Q
 rrTYf5AEhj0rSp96RQkLzomunTk4VSjQ4XXT6tiMoGIca/kp/t61CS/gnKXFN/BBUGb+3XRwZ
 1phXjnejr8fgv9LXk+QosXdVZJ1OZbGwyNT8620kgDjfgh33gPs3+aJE+H0Qg0XfwjkiK1VTp
 9/Bv08jcA3R550jLHYIIEh/3h6P6emHXcTrCAmUypfvQoF1vsrlKpR3KsBCEjXWIhC8kp20H8
 zHZk4/haln+tGAXRxnZjtiHVgeRyTKg+VQD3pHVhWNo+6CeW4qI3HfATLgGMeBDrJYF0lKYFY
 K9Bj3GgqY6TzXqBxYrbBH5tcMkhONWJTKiMKc7Up8QDKXAoyHyTiVMKHOb3SeK0Ri9c+HE280
 HCaEcVJs1kw6Lz6UOcTqow2kAkU1bwfbMHTRrOiejzryZa81GxvCjKbVxwnAWyLbZ5xb8O6gv
 H4Q4eWxPiVy3FzT+bMwMFB4xkuwejlsYIVDUaYGnAaAlDH6HKZZMU0fx1yjYcCm1QYipmHl56
 RsIrKiTaYQ4MyyUvMFcrR/poo7diH2tGtxps6wwlK+DSlYQZWkMH/sjJzG8dBt7Beax/IzWK+
 OevFLE1ZaF0PblqvAMJd9ehfngpEmn7KRsxhxTJQSMU9yA2j7JvwljbvuyiJA/v0IlPvbmHnq
 AtmDvHgJQA71e8afS1e4zCg7ha0mIDhS98EDgSgwES8Z4ueCqglDZdFcdLlCdCO89Q9se94
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/02/2020 à 02:46, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update mips syscall numbers based on Linux kernel tag v5.5.
> 
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/mips/syscall_nr.h   | 45 +++++++++++++++++++++++
>  linux-user/mips64/syscall_nr.h | 50 ++++++++++++++++++++++++-
>  linux-user/mips/cpu_loop.c     | 83 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 175 insertions(+), 3 deletions(-)
> 
...
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 39915b3..a2c72fa 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -25,8 +25,9 @@
>  #include "internal.h"
>  
>  # ifdef TARGET_ABI_MIPSO32
> +#  define MIPS_SYSCALL_NUMBER_UNUSED -1
>  #  define MIPS_SYS(name, args) args,
> -static const uint8_t mips_syscall_args[] = {
> +static const int8_t mips_syscall_args[] = {
>          MIPS_SYS(sys_syscall    , 8)    /* 4000 */
>          MIPS_SYS(sys_exit       , 1)
>          MIPS_SYS(sys_fork       , 0)
> @@ -390,6 +391,80 @@ static const uint8_t mips_syscall_args[] = {
>          MIPS_SYS(sys_copy_file_range, 6) /* 360 */
>          MIPS_SYS(sys_preadv2, 6)
>          MIPS_SYS(sys_pwritev2, 6)
> +        MIPS_SYS(sys_pkey_mprotect, 4)
> +        MIPS_SYS(sys_pkey_alloc, 2)
> +        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
> +        MIPS_SYS(sys_statx, 5)
> +        MIPS_SYS(sys_rseq, 4)
> +        MIPS_SYS(sys_io_pgetevents, 6)
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYS(sys_semget, 3)
> +        MIPS_SYS(sys_semctl, 4)
> +        MIPS_SYS(sys_shmget, 3)                    /* 395 */
> +        MIPS_SYS(sys_shmctl, 3)
> +        MIPS_SYS(sys_shmat, 3)
> +        MIPS_SYS(sys_shmdt, 1)
> +        MIPS_SYS(sys_msgget, 2)
> +        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
> +        MIPS_SYS(sys_msgrcv, 5)
> +        MIPS_SYS(sys_msgctl, 3)
> +        MIPS_SYS(sys_clock_gettime64, 2)
> +        MIPS_SYS(sys_clock_settime64, 4)
> +        MIPS_SYS(sys_clock_adjtime64, 2)           /* 405 */
> +        MIPS_SYS(sys_clock_getres_time64, 4)

According to
https://github.com/strace/strace/blob/master/linux/syscallent-common-32.h:

[BASE_NR + 406] = { 2,	0,		SEN(clock_getres_time64),
"clock_getres_time64"	},

once fixed you can add my

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

