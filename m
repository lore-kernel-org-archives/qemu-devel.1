Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15308C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1832053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1832053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNf7d-0007jE-3O
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:01:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNf6T-00076c-7W
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNf6R-0007PF-Ew
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:00:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNf6R-0007Lg-8Z
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:00:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so16176590wmc.0
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 08:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8PJRFru9GTn5IEri305UtxALWGHwapioC+ZsjmD6/IY=;
	b=T9YZVUL11uKGpoo7Dt3EcwUb+S/neJWf7XESxQG1evKx18LEvlmnHFQzJRsO2cwj5W
	DppxYKgTPVlPaaTWbRhe5I4+zIYwvBnXj6F15axAoJ9qJxyZrXhdOFMLk1MjtnnMyH/Y
	39PgsB3mjXGFr1c8Zvqp+NzwdbgOqRgw6lYyLHsUzCycRomC6OnI4UQxWWKc8E9ytYfy
	q6V8WmsVk7/mjODtmTGV1aOgtOBhks4pjaIbVfM+obBNO6KMCcrBoAe9XLTK9BCAaHYa
	IFaQJ29QtyD4gbdJAK0FljmdNE4e9kYyZYyUpfDCUXIVo3W/tmYysMSb0MxWKGcwMLVM
	xnjA==
X-Gm-Message-State: APjAAAWHkQLM+RUOMmjr/NC4t7b00L00hC8cgu2BtlQretjaVt/lVzIB
	GVZC+NwJ2QANvvgR8NSNG7Pn+w==
X-Google-Smtp-Source: APXvYqzOZOqn3H2R5hB9kisYzHr5Xl5b1KBRWN06TdvzRJ2rzGr2QxdU6tvfsz0osVKdXsXyyMz5rw==
X-Received: by 2002:a05:600c:1191:: with SMTP id
	i17mr16869817wmf.84.1557154826145; 
	Mon, 06 May 2019 08:00:26 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o13sm19229737wrg.40.2019.05.06.08.00.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 08:00:25 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-2-philmd@redhat.com>
	<310808da-71c5-19d8-be81-ae255682e79e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <28db6e11-2d49-757b-7851-e9a6fc0843d0@redhat.com>
Date: Mon, 6 May 2019 17:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <310808da-71c5-19d8-be81-ae255682e79e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/block/pflash_cfi01: Removed an
 unused timer
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 4:39 PM, Laszlo Ersek wrote:
> On 05/05/19 22:05, Philippe Mathieu-Daudé wrote:
>> The 'CFI01' NOR flash was introduced in commit 29133e9a0fff, with
>> timing modelled. One year later, the CFI02 model was introduced
>> (commit 05ee37ebf630) based on the CFI01 model. As noted in the
> 
> You got those commit references backwards, I believe:
> 
> * Commit 29133e9a0fff ("AMD NOR flash device support (initial patch by
> Jocelyn Mayer)", 2006-06-25) introduced "hw/pflash_cfi02.c".
> 
> * Commit 05ee37ebf630 ("Gumstix 'connex' board support by Thorsten
> Zitterell.", 2007-11-17) introduced "hw/pflash_cfi01.c".

Argh yes, thank you!

>> header, "It does not support timings". 12 years later, we never
>> had to model the device timings. Time to remove the unused timer,
>> we can still add it back if required.
>>
>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Yes, I plan to model those timings later. Actually I have a series
>> working, but I'd rather first
>> 1/ refactor common code between the both CFI implementations,
> 
> Good idea.
> 
>> 2/ discuss on list whether or not use timings for the Virt flash.
> 
> What would the timer buy us (specifically wrt. cfi01 / OVMF / ArmVirt)?
> 
> Being faithful to actual hardware is always good... except when it runs
> a significant risk of regressions. :) By that I don't mean "programming
> errors"; I mean that guest code would now have to conform to various
> timeouts, and that always makes me a bit concerned.

I'm glat you feel concerned :)
My goal is to model enough of the device to be able to run 'Capsule
Based Firmware Updates' [*], but I haven't investigated much yet.
Embedded firmware usually care about such timings. Anyway if this is
implemented as a feature, it would be disabled by default for the Virt
flash (I name the Virt flash the one used by the Virt X86/Aarch64 machines).

> 
> For this patch, with the commit references fixed:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Will do, thanks!

> 
> Thanks,
> Laszlo
> 
>> ---
>>  hw/block/pflash_cfi01.c | 15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 16dfae14b80..6dc04f156a7 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -42,7 +42,6 @@
>>  #include "hw/block/flash.h"
>>  #include "sysemu/block-backend.h"
>>  #include "qapi/error.h"
>> -#include "qemu/timer.h"
>>  #include "qemu/bitops.h"
>>  #include "qemu/host-utils.h"
>>  #include "qemu/log.h"
>> @@ -86,7 +85,6 @@ struct PFlashCFI01 {
>>      uint8_t cfi_table[0x52];
>>      uint64_t counter;
>>      unsigned int writeblock_size;
>> -    QEMUTimer *timer;
>>      MemoryRegion mem;
>>      char *name;
>>      void *storage;
>> @@ -110,18 +108,6 @@ static const VMStateDescription vmstate_pflash = {
>>      }
>>  };
>>  
>> -static void pflash_timer (void *opaque)
>> -{
>> -    PFlashCFI01 *pfl = opaque;
>> -
>> -    trace_pflash_timer_expired(pfl->cmd);
>> -    /* Reset flash */
>> -    pfl->status ^= 0x80;
>> -    memory_region_rom_device_set_romd(&pfl->mem, true);
>> -    pfl->wcycle = 0;
>> -    pfl->cmd = 0;
>> -}
>> -
>>  /* Perform a CFI query based on the bank width of the flash.
>>   * If this code is called we know we have a device_width set for
>>   * this flash.
>> @@ -771,7 +757,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>>          pfl->max_device_width = pfl->device_width;
>>      }
>>  
>> -    pfl->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
>>      pfl->wcycle = 0;
>>      pfl->cmd = 0;
>>      pfl->status = 0;
>>
> 

