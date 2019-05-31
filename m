Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96010C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544AC24746
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNCzenZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544AC24746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41167 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfQ2-0001hR-IK
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 07:09:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWfOP-0000gk-NO
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWfOO-0001Yk-G8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:08:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWfOO-0001Ma-79
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:08:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id t5so5680037wmh.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=g4Hy4PX6gYpRnNa0z5dfpnoTFOXH3emFx/mXiHVWR8c=;
	b=uNCzenZAZzL5IeLjJlJc0FN8kSAzwFRB7LwwwNxPik1vjLYVdI0uUaUAC5c2KipG96
	8k5IXK5fSbtW54xveMkBM9evsRPwVrDxOHhtPosfzEHtWgkw62/s703L/Anrh/10WKuu
	aqQQoub6Iw6EX6UUkv3tsgWJwiapvD6/YH+k6yPem1kftAMJFfk81aTNq2tKtII9YOry
	x3C6CfHdhGXTWwdQ7v5W/o7kX5Xa4rWrdXb8uTkmhq059MdKCtHKM+8XJmeIKRfS7OPs
	k6ac+gxeo+lShnzB7462Mp3TD3jowbKl+EhWRe6hqtPKm6dVQcD7c3+OAV20knF+8cYx
	cdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=g4Hy4PX6gYpRnNa0z5dfpnoTFOXH3emFx/mXiHVWR8c=;
	b=W5UYqlWjQe8S4kV8lcvHd3yh8GjVnSId3c47ER3Qk7iOsjtyAXOUa9/nrL57/w8l+y
	G26IntZcqbG7/+UakyUEfTsaDOwAtxmW2gLJOQYimoUNlquzEjo28/epsP5Rd34I8JNu
	FPhKq7hRkIRdyBTuEiPwlMxQPhmo3WHhW42LLjY9GP7OWjm415Ku9hS3jVJOxZHjK3w7
	+WwzdwshxgKfV0HKVAEXkzr240i4qg8nX0mFxmaMNzjLytwD2/9L7ypliLBhVZpNTk9v
	3ib9tL6450oDhoYwbZdlKwHKAXQ7geNnmc0G4dgKk8RWyCUCoTstPbuLhjZMCB1rjLjB
	VRcA==
X-Gm-Message-State: APjAAAXyUXnDNpo094xeiht63HJIB8fHnnvoEv/2qAWJGtch18hbSt2N
	FTz/+IsTCdV+g/K7sID9rLUyuA==
X-Google-Smtp-Source: APXvYqxKDRmKbdGpcTXVvG/x27XgvCx9U0Ty+QrfcWpErlz+sxATR8yKb3rVAnQVJtV7aMFpiE7I4g==
X-Received: by 2002:a1c:21c4:: with SMTP id h187mr5500234wmh.27.1559300888460; 
	Fri, 31 May 2019 04:08:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z193sm9151478wmc.20.2019.05.31.04.08.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 04:08:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 802091FF87;
	Fri, 31 May 2019 12:08:06 +0100 (BST)
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-7-alex.bennee@linaro.org>
	<20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Miroslav Rezanina <mrezanin@redhat.com>
In-reply-to: <20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
Date: Fri, 31 May 2019 12:08:06 +0100
Message-ID: <87sgsu51bd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common
 interface for WRITE0/WRITEC in arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Miroslav Rezanina <mrezanin@redhat.com> writes:

> On Tue, May 14, 2019 at 04:52:56PM +0100, Alex Benn=C3=A9e wrote:
>> Now we have a common semihosting console interface use that for our
>> string output. However ARM is currently unique in also supporting
>> semihosting for linux-user so we need to replicate the API in
>> linux-user. If other architectures gain this support we can move the
>> file later.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/Makefile.objs  |  2 ++
>>  linux-user/arm/semihost.c | 24 ++++++++++++++++++++++++
>>  target/arm/arm-semi.c     | 31 ++++++-------------------------
>>  3 files changed, 32 insertions(+), 25 deletions(-)
>>  create mode 100644 linux-user/arm/semihost.c
>>
>> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
>> index 769b8d83362..285c5dfa17a 100644
>> --- a/linux-user/Makefile.objs
>> +++ b/linux-user/Makefile.objs
>> @@ -6,4 +6,6 @@ obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
>>  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
>>  obj-$(TARGET_I386) +=3D vm86.o
>>  obj-$(TARGET_ARM) +=3D arm/nwfpe/
>> +obj-$(TARGET_ARM) +=3D arm/semihost.o
>> +obj-$(TARGET_AARCH64) +=3D arm/semihost.o
>>  obj-$(TARGET_M68K) +=3D m68k-sim.o
>> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
>> new file mode 100644
>> index 00000000000..9554102a855
>> --- /dev/null
>> +++ b/linux-user/arm/semihost.c
>> @@ -0,0 +1,24 @@
>> +/*
>> + * ARM Semihosting Console Support
>> + *
>> + * Copyright (c) 2019 Linaro Ltd
>> + *
>> + * Currently ARM is unique in having support for semihosting support
>> + * in linux-user. So for now we implement the common console API but
>> + * just for arm linux-user.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "hw/semihosting/console.h"
>> +#include "qemu.h"
>> +
>> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, =
int len)
>> +{
>> +    void *s =3D lock_user_string(addr);
>> +    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
>> +    unlock_user(s, addr, 0);
>> +    return len;
>> +}
>> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
>> index 9e5a414dd89..253c66b172a 100644
>> --- a/target/arm/arm-semi.c
>> +++ b/target/arm/arm-semi.c
>> @@ -27,6 +27,7 @@
>>
>>  #include "cpu.h"
>>  #include "hw/semihosting/semihost.h"
>> +#include "hw/semihosting/console.h"
>>  #ifdef CONFIG_USER_ONLY
>>  #include "qemu.h"
>>
>> @@ -314,32 +315,12 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>>              return set_swi_errno(ts, close(arg0));
>>          }
>>      case TARGET_SYS_WRITEC:
>> -        {
>> -          char c;
>> -
>> -          if (get_user_u8(c, args))
>> -              /* FIXME - should this error code be -TARGET_EFAULT ? */
>> -              return (uint32_t)-1;
>> -          /* Write to debug console.  stderr is near enough.  */
>> -          if (use_gdb_syscalls()) {
>> -                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1"=
, args);
>> -          } else {
>> -                return write(STDERR_FILENO, &c, 1);
>> -          }
>> -        }
>> +    {
>> +        qemu_semihosting_console_out(env, args, 1);
>> +        return 0xdeadbeef;
>> +    }
>>      case TARGET_SYS_WRITE0:
>> -        if (!(s =3D lock_user_string(args)))
>> -            /* FIXME - should this error code be -TARGET_EFAULT ? */
>> -            return (uint32_t)-1;
>> -        len =3D strlen(s);
>> -        if (use_gdb_syscalls()) {
>> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
>> -                                   args, len);
>> -        } else {
>> -            ret =3D write(STDERR_FILENO, s, len);
>> -        }
>> -        unlock_user(s, args, 0);
>> -        return ret;
>> +        return qemu_semihosting_console_out(env, args, 0);
>>      case TARGET_SYS_WRITE:
>>          GET_ARG(0);
>>          GET_ARG(1);
>> --
>> 2.20.1
>>
>>
>
> Hi Alex,
>
> this patch breaks build for softmmu target when CONFIG_SEMIHOSTING is not=
 enabled as qemu_semihosting_console_out
> is not defined in such case - neither linux-user/arm/semihost.c nor hw/se=
mihosting/console.c compiled and function
> is not in stubs/semihost.c

How do you do that? I tried ../../configure --without-default-devices
and that still builds for me.

But I suspect what's needed is to change:

#ifndef CONFIG_USER_ONLY

to

#ifdef CONFIG_SEMIHOSTING

to the relevant headers and helper bits.

>
> Mirek


--
Alex Benn=C3=A9e

