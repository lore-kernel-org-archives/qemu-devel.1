Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE298C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F7320850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F7320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hExZs-0008Nq-H0
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 10:54:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hExZ1-00084S-Dv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hExZ0-0000Ps-4V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:53:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hExYz-0000PA-RO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:53:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so12330371wre.7
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=F+Yy1GcYKfDnAYZk40/5uuHKXTNoD/lEcBcVKgW1npQ=;
	b=X0ISxyJF4XbSC0kj5SnalSq/DV+X4lXdjDRjGchIyb7pYG4AhM+1wfRlELcpH/d6oD
	aHMw0Kw/ehI10cfMIEsYhfIdtN+QrOyvD1tZOX1lRG/tV7yONuyRuvCdZvGA9pUWxvtU
	Hj4rWfbHczbXu8bRRrTfTf6sWhn+FAK1JzdV/+MazH0u1+Mxh5isBTj7ESl2dL058SNO
	3J0m05/8jErNkGy1Ml7pjjF0FD0Fq822QqKoTdsywNGhasRb0nWV8/8WNVMuUo/adrBx
	nfrd8CF6HgXu6/CuMUnOHaY7FTgqMmjDRCwNDMIH5gqlsbmN17iyyWaPSUU4ZcjttNXT
	vT2A==
X-Gm-Message-State: APjAAAXb1TYl5vp2sP+RQzBkDdhVY72vvT6Q2smddd03EiUYrEo5ZRHn
	h3M/H+7UaP18sqRijsSW+xENSQ==
X-Google-Smtp-Source: APXvYqyaGiwfSuyU3r2NwuGfIgfR5SHvh9fAFYm8HL7i3jfHMc8W/W2Y16xeZ/X2qXDZJy0Q0U9Akw==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr18315560wrq.280.1555080836901; 
	Fri, 12 Apr 2019 07:53:56 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id b9sm14178924wmc.9.2019.04.12.07.53.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 07:53:56 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20190317002259.25994-1-philmd@redhat.com>
	<20190317002259.25994-2-philmd@redhat.com>
	<alpine.BSF.2.21.9999.1903170254400.9264@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <34b2dd6e-8c40-f639-8cb9-59d37f4ce9fd@redhat.com>
Date: Fri, 12 Apr 2019 16:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903170254400.9264@zero.eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/input/Kconfig: Rename the 8042 PS/2
 Keyboard Controller
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Artyom Tarasenko <atar4qemu@gmail.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412145350.K25JsYRncP4Yq8rIT6F7x1tuKygvmTa755K_ZjbvYrY@z>

On 3/17/19 3:05 AM, BALATON Zoltan wrote:
> On Sun, 17 Mar 2019, Philippe Mathieu-Daudé wrote:
>> The Intel 8042 chipset also includes some functions unrelated to
>> the keyboard, such the A20-Gate. Rename it using the chipset name.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> default-configs/mips-softmmu-common.mak | 2 +-
>> hw/alpha/Kconfig                        | 2 +-
>> hw/i386/Kconfig                         | 2 +-
>> hw/input/Kconfig                        | 2 +-
>> hw/input/Makefile.objs                  | 2 +-
>> hw/sparc64/Kconfig                      | 2 +-
>> hw/unicore32/Kconfig                    | 2 +-
>> 7 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak
>> b/default-configs/mips-softmmu-common.mak
>> index 0795d522db..bad7ee3360 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -13,7 +13,7 @@ CONFIG_SERIAL_ISA=y
>> CONFIG_PARALLEL=y
>> CONFIG_I8254=y
>> CONFIG_PCSPK=y
>> -CONFIG_PCKBD=y
>> +CONFIG_I8042=y
>> CONFIG_FDC=y
>> CONFIG_ACPI=y
>> CONFIG_ACPI_X86=y
>> diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
>> index 22cefd9577..eb99765123 100644
>> --- a/hw/alpha/Kconfig
>> +++ b/hw/alpha/Kconfig
>> @@ -8,5 +8,5 @@ config DP264
>>     select IDE_CMD646
>>     select MC146818RTC
>>     select PCI
>> -    select PCKBD
>> +    select I8042
>>     select SMC37C669
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 78fd70396a..7fa5395894 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -20,7 +20,7 @@ config PC
>>     select FDC
>>     select I8259
>>     select I8254
>> -    select PCKBD
>> +    select I8042
>>     select PCSPK
>>     select I82374
>>     select I8257
>> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
>> index e2e66f0858..14e76c5df4 100644
>> --- a/hw/input/Kconfig
>> +++ b/hw/input/Kconfig
>> @@ -5,7 +5,7 @@ config LM832X
>>     bool
>>     depends on I2C
>>
>> -config PCKBD
>> +config I8042
>>     bool
>>     default y
>>     depends on ISA_BUS
>> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
>> index c8b00f71ec..6e4c3389be 100644
>> --- a/hw/input/Makefile.objs
>> +++ b/hw/input/Makefile.objs
>> @@ -1,7 +1,7 @@
>> common-obj-$(CONFIG_ADB) += adb.o adb-mouse.o adb-kbd.o
>> common-obj-y += hid.o
>> common-obj-$(CONFIG_LM832X) += lm832x.o
>> -common-obj-$(CONFIG_PCKBD) += pckbd.o
>> +common-obj-$(CONFIG_I8042) += pckbd.o
> 
> This makes config option different from the filename so I wonder if it's
> worth changing it or better to keep it same as its file like the others?
> A20 gate is controlled by AT keyboard controller but that's probably a
> hack made by the designers of that machine, it's still used mainly as a
> keyboard controller so just to avoid changes we could live with the
> PCKBD name as well (which might even be simpler to understand for people
> not familiar with chip numbers).

Regarding Kconfig, when we model a machine, I find clearer to name the
chipset used by their name. Now when it is about optional feature, I
don't mind.

The other Intel chipset are named similarly:

$ ls -1 hw/*/i[0-9]*c
hw/dma/i82374.c
hw/dma/i8257.c
hw/i2c/i2c-ddc.c
hw/intc/i8259.c
hw/intc/i8259_common.c
hw/isa/i82378.c
hw/timer/i8254.c
hw/timer/i8254_common.c

I'm happy to rename the file as i8042.c as you suggested, however I'll
do it in another patch previous to this one.

Thanks,

Phil.

> Regards,
> BALATON Zoltan
> 
>> common-obj-$(CONFIG_PL050) += pl050.o
>> common-obj-y += ps2.o
>> common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
>> diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
>> index 4a8166ebb7..24ccb11c87 100644
>> --- a/hw/sparc64/Kconfig
>> +++ b/hw/sparc64/Kconfig
>> @@ -10,7 +10,7 @@ config SUN4U
>>     select PCI_SABRE
>>     select IDE_CMD646
>>     select PARALLEL
>> -    select PCKBD
>> +    select I8042
>>     select SIMBA
>>
>> config NIAGARA
>> diff --git a/hw/unicore32/Kconfig b/hw/unicore32/Kconfig
>> index 4443a29dd2..67f4c867c1 100644
>> --- a/hw/unicore32/Kconfig
>> +++ b/hw/unicore32/Kconfig
>> @@ -1,5 +1,5 @@
>> config PUV3
>>     bool
>>     select ISA_BUS
>> -    select PCKBD
>> +    select I8042
>>     select PTIMER
>>

