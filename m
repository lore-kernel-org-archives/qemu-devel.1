Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D2CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7B52147A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7B52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQayu-0005aJ-MG
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:12:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQauD-000152-Dc
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQaio-0000vh-0E
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:56:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQain-0000re-PT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:56:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so20054978wrp.2
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wVzWKCSgq0uOq8MbdDKMrwMceaiMFq2iCJT4QoKJH5g=;
	b=hJi/h547ElU9cprXLJ6oHbPktoWMeUJsW/+39wBic26jtggwntWzbNw8bSHojgpByF
	YJFpDkP012fhJ2BTXZGfU6zyp1G98xLdXVIFxE8R3HO6mOySzP95fG/fwXw65ej+Qm3j
	BR/4iwytHVwponxDpRqJLbE89QbRN425gQdLPQeWlI9G0nqxJ6EjWvlPSphMgYS7wlNx
	9p4737KO5eRJ/FwAYGvpej+eXHoeRiMKeRPiv7tEJD9ojp3m00vmyZGyENnm0CWY7bvM
	jvPEGk7iGKL5qSyapzqowr/CXoSHA9nYIrFzYCEzIkhU1+H1KrpXAbMVyEgg3Fn9ldpp
	r85A==
X-Gm-Message-State: APjAAAXuQjvmFmdw98E2oyY+5jUOuoIe9ezf9gZnOi4gs9blPbZCI0UY
	evJyaOOY+GbmigmgXmzSWv0cEg==
X-Google-Smtp-Source: APXvYqzP0sEAlpzXDtC5kiXCCF5L09AJcI5lZ2idu32vaVrD+fPhBPctFVsV7DCHlCxY8HjoFFfVGw==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr19179232wrn.201.1557852968579; 
	Tue, 14 May 2019 09:56:08 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	m187sm2053932wmm.37.2019.05.14.09.56.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:56:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1a9c7ca7-59a9-7075-c4a4-470a8342f1bd@redhat.com>
Date: Tue, 14 May 2019 18:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514155301.16123-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH 05/11] target/arm: fixup some of the
 commentary for arm-semi
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:52 PM, Alex Bennée wrote:
> This cleans up a number of the block comments to fit the proper style.
> While we are at it we also reference the official specification and
> document what the return register value can be.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/arm-semi.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 3273306c8ea..9e5a414dd89 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -2,6 +2,7 @@
>   *  Arm "Angel" semihosting syscalls
>   *
>   *  Copyright (c) 2005, 2007 CodeSourcery.
> + *  Copyright (c) 2019 Linaro
>   *  Written by Paul Brook.
>   *
>   *  This program is free software; you can redistribute it and/or modify
> @@ -16,6 +17,10 @@
>   *
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + *  ARM Semihosting is documented in:
> + *     Semihosting for AArch32 and AArch64 Release 2.0
> + *     https://static.docs.arm.com/100863/0200/semihosting.pdf
>   */
>  
>  #include "qemu/osdep.h"
> @@ -240,6 +245,15 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
>       put_user_u64(val, args + (n) * 8) :                \
>       put_user_u32(val, args + (n) * 4))
>  
> +/*
> + * Do a semihosting call.
> + *
> + * The specification always says that the "return register" either
> + * returns a specific value or is corrupted, so we don't need to
> + * report to our caller whether we are returning a value or trying to
> + * leave the register unchanged. We use 0xdeadbeef as the return value
> + * when there isn't a defined return value for the call.
> + */
>  target_ulong do_arm_semihosting(CPUARMState *env)
>  {
>      ARMCPU *cpu = arm_env_get_cpu(env);
> @@ -510,14 +524,16 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>  
>              output_size = ts->info->arg_end - ts->info->arg_start;
>              if (!output_size) {
> -                /* We special-case the "empty command line" case (argc==0).
> -                   Just provide the terminating 0. */
> +                /*
> +                 * We special-case the "empty command line" case (argc==0).
> +                 * Just provide the terminating 0.
> +                 */
>                  output_size = 1;
>              }
>  #endif
>  
>              if (output_size > input_size) {
> -                 /* Not enough space to store command-line arguments.  */
> +                /* Not enough space to store command-line arguments.  */
>                  return -1;
>              }
>  
> @@ -571,8 +587,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              GET_ARG(0);
>  
>  #ifdef CONFIG_USER_ONLY
> -            /* Some C libraries assume the heap immediately follows .bss, so
> -               allocate it using sbrk.  */
> +            /*
> +             * Some C libraries assume the heap immediately follows .bss, so
> +             * allocate it using sbrk.
> +             */
>              if (!ts->heap_limit) {
>                  abi_ulong ret;
>  
> @@ -620,7 +638,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          }
>      case TARGET_SYS_EXIT:
>          if (is_a64(env)) {
> -            /* The A64 version of this call takes a parameter block,
> +            /*
> +             * The A64 version of this call takes a parameter block,
>               * so the application-exit type can return a subcode which
>               * is the exit status code from the application.
>               */
> @@ -633,14 +652,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>                  ret = 1;
>              }
>          } else {
> -            /* ARM specifies only Stopped_ApplicationExit as normal
> -             * exit, everything else is considered an error */
> +            /*
> +             * ARM specifies only Stopped_ApplicationExit as normal
> +             * exit, everything else is considered an error
> +             */
>              ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
>          }
>          gdb_exit(env, ret);
>          exit(ret);
>      case TARGET_SYS_SYNCCACHE:
> -        /* Clean the D-cache and invalidate the I-cache for the specified
> +        /*
> +         * Clean the D-cache and invalidate the I-cache for the specified
>           * virtual address range. This is a nop for us since we don't
>           * implement caches. This is only present on A64.
>           */
> 

