Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B4C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EA6267A4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EA6267A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWf0k-0006LA-R3
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:43:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWezr-0005y6-0O
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWezp-00070K-Ok
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:42:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWezp-0006yP-I7
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:42:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so1355914wre.7
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 03:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vO1Ew/ZqISYVIX5HEOx51Yc6znbw8xHoNHe4b+X75QI=;
	b=Mrqhd8v7GbOrSHZjvn199vkIvc5wYNaQQ0Leb9CidGOgKWG9RhwnWAX6DAukHOcfkL
	DAQPFkOcBOVgmUfmsMwcnQEXo+Pe8oWDK6GYSevqDPv/nOVE230rukNMWrZ1GW9Y6QkE
	IL34cnZESTO9iLGSyn3e/KNnuqkGPRGlwuI/5OKPtk+1nfejEJ83DtYodKoP1X7ah8mn
	6wwc+jj0iuS8hRFk4IVK3u8o8Tn2lJASH6STl4UYYxAYJlm5MQqPfgTQMLWGPFY7Bfc3
	xZZzbfZnqT5tOwMo5f2baBY1lP2PKIi0HjUSwejUXm7k1WABHdTw9cWGptsjLvidf1ue
	mXlg==
X-Gm-Message-State: APjAAAUBP9aAxVws/muRm/1t8pr0AHKKPDdsQjHhYOCqQsdB0X8qBPYj
	hBBJAiYIIodEFIQ6ISGGH/QDqg==
X-Google-Smtp-Source: APXvYqwOABhGPhI58u49aJcFB7gDWUQOcnrBA8FwVEAbTOeZBTv2VWZEN6kEottdx6cZ/dr3VB+h1Q==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5221529wri.213.1559299368264; 
	Fri, 31 May 2019 03:42:48 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	z20sm5766965wmf.14.2019.05.31.03.42.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 03:42:47 -0700 (PDT)
To: Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-7-alex.bennee@linaro.org>
	<20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <891973f7-2f2b-ad59-70bf-6069382fd977@redhat.com>
Date: Fri, 31 May 2019 12:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
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
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Miroslav,

On 5/31/19 11:12 AM, Miroslav Rezanina wrote:
> On Tue, May 14, 2019 at 04:52:56PM +0100, Alex Bennée wrote:
>> Now we have a common semihosting console interface use that for our
>> string output. However ARM is currently unique in also supporting
>> semihosting for linux-user so we need to replicate the API in
>> linux-user. If other architectures gain this support we can move the
>> file later.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
>> @@ -6,4 +6,6 @@ obj-y = main.o syscall.o strace.o mmap.o signal.o \
>>  obj-$(TARGET_HAS_BFLT) += flatload.o
>>  obj-$(TARGET_I386) += vm86.o
>>  obj-$(TARGET_ARM) += arm/nwfpe/
>> +obj-$(TARGET_ARM) += arm/semihost.o
>> +obj-$(TARGET_AARCH64) += arm/semihost.o
>>  obj-$(TARGET_M68K) += m68k-sim.o
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
>> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
>> +{
>> +    void *s = lock_user_string(addr);
>> +    len = write(STDERR_FILENO, s, len ? len : strlen(s));
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
>> -                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1", args);
>> -          } else {
>> -                return write(STDERR_FILENO, &c, 1);
>> -          }
>> -        }
>> +    {
>> +        qemu_semihosting_console_out(env, args, 1);
>> +        return 0xdeadbeef;
>> +    }
>>      case TARGET_SYS_WRITE0:
>> -        if (!(s = lock_user_string(args)))
>> -            /* FIXME - should this error code be -TARGET_EFAULT ? */
>> -            return (uint32_t)-1;
>> -        len = strlen(s);
>> -        if (use_gdb_syscalls()) {
>> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
>> -                                   args, len);
>> -        } else {
>> -            ret = write(STDERR_FILENO, s, len);
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
> this patch breaks build for softmmu target when CONFIG_SEMIHOSTING is not enabled as qemu_semihosting_console_out
> is not defined in such case - neither linux-user/arm/semihost.c nor hw/semihosting/console.c compiled and function
> is not in stubs/semihost.c

Kinda funny, I noticed the same issue at the same time, and was chatting
with Alex about it.

I prepared a patch expliciting we can not disable CONFIG_SEMIHOSTING on
the MIPS arch. Would that work for you?

Regards,

Phil.

