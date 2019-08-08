Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A1C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CFF2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CFF2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvhf8-000451-VY
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 08:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvheb-0003fC-Vx
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvhea-0000Ly-Qk
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:36:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvhea-0000Lh-Kg
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:36:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so94755744wrr.5
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 05:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZshjD4jboO6BcWhGHrKDroDgRhpaBMBgKh1+7YIRwck=;
 b=aCMjz5OgiqPTWQ97gK+sDXteDUTTe/Qt3+gxnEZepYzbXFwtcvzndhUofvouMTGMf4
 orr4KahkVfLzPuKPy8/DkTGzKpxvwFGzM9p8TvNp79yewUvt6kY93UHO1igFJfTlmkbk
 Ea/owGJX5cNTlV71ASN+L0wQn0HL1wUq3BiOBVflJsVwcK2E5wxwleLlI06/5gHu86Tq
 QkfFbLNKkhs4AdOuWB2T369RWhORIBiK0btOvy3xgjfl8mLoCqShUjByluUMsmMzBy+f
 plDJcZdyXnNWHVTjil0DEe+GMYdZrB7aUpjmvM4qluL8Z1/aQxc2225IBnCWhc5roiaO
 B0zQ==
X-Gm-Message-State: APjAAAVhpnklHJawKyLAQN0RREGNweg3tai7ilqEGqosoRV2QmXN9AAw
 TkEkOfgTqZPMjDOXMG1dYRSjVOXiO+s=
X-Google-Smtp-Source: APXvYqyXc0EU+4JQJcoQjCXpmd6U7dA33o5y4HodmCg+b15M9jMbo2iS5S9SD69OZMd9USbUnZ+KeQ==
X-Received: by 2002:adf:b1d0:: with SMTP id r16mr17274996wra.332.1565267783423; 
 Thu, 08 Aug 2019 05:36:23 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id o16sm3090543wrp.23.2019.08.08.05.36.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 05:36:22 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-17-armbru@redhat.com>
 <2739ad81-5e97-a7a6-8888-587224032a80@redhat.com>
 <87y303g8cs.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1a6d8a72-14e6-243f-1176-392e430d91e8@redhat.com>
Date: Thu, 8 Aug 2019 14:36:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87y303g8cs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 16/29] Include exec/memory.h slightly
 less
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 2:16 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>>> Drop unnecessary inclusions from headers.  Downgrade a few more to
>>> exec/hwaddr.h.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  hw/audio/lm4549.h                   | 1 +
>>>  hw/display/edid-region.c            | 1 +
>>>  hw/display/tc6393xb.c               | 1 +
>>>  hw/net/can/can_sja1000.h            | 1 +
>>>  hw/net/ne2000.c                     | 1 +
>>>  hw/xtensa/xtensa_memory.h           | 1 -
>>>  include/hw/arm/boot.h               | 1 -
>>>  include/hw/arm/fsl-imx7.h           | 1 -
>>>  include/hw/arm/soc_dma.h            | 2 +-
>>>  include/hw/block/flash.h            | 2 +-
>>>  include/hw/boards.h                 | 1 +
>>>  include/hw/char/parallel.h          | 1 -
>>>  include/hw/display/milkymist_tmu2.h | 1 +
>>>  include/hw/display/tc6393xb.h       | 2 --
>>>  include/hw/display/vga.h            | 2 +-
>>>  include/hw/hw.h                     | 1 -
>>>  include/hw/i2c/pm_smbus.h           | 1 +
>>>  include/hw/i2c/smbus_eeprom.h       | 1 +
>>>  include/hw/misc/auxbus.h            | 1 +
>>>  include/hw/ppc/xics.h               | 1 +
>>>  include/hw/usb.h                    | 1 +
>>>  include/hw/virtio/virtio.h          | 1 +
>>>  migration/colo.c                    | 1 +
>>>  migration/migration.h               | 1 +
>>>  migration/postcopy-ram.c            | 1 +
>>>  migration/rdma.c                    | 1 +
>>>  26 files changed, 20 insertions(+), 10 deletions(-)
>>>
>> [...]> diff --git a/migration/colo.c b/migration/colo.c
>>> index 9f84b1fa3c..0b5b620391 100644
>>> --- a/migration/colo.c
>>> +++ b/migration/colo.c
>>> @@ -23,6 +23,7 @@
>>>  #include "io/channel-buffer.h"
>>>  #include "trace.h"
>>>  #include "qemu/error-report.h"
>>> +#include "qemu/rcu.h"
>>>  #include "migration/failover.h"
>>>  #ifdef CONFIG_REPLICATION
>>>  #include "replication.h"
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index 26f01d00f6..a7882af67a 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -14,6 +14,7 @@
>>>  #ifndef QEMU_MIGRATION_H
>>>  #define QEMU_MIGRATION_H
>>>  
>>> +#include "exec/cpu-common.h"
>>>  #include "qapi/qapi-types-migration.h"
>>>  #include "qemu/thread.h"
>>>  #include "qemu/coroutine_int.h"
>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>> index 9faacacc9e..56054d0a73 100644
>>> --- a/migration/postcopy-ram.c
>>> +++ b/migration/postcopy-ram.c
>>> @@ -25,6 +25,7 @@
>>>  #include "ram.h"
>>>  #include "qapi/error.h"
>>>  #include "qemu/notify.h"
>>> +#include "qemu/rcu.h"
>>>  #include "sysemu/sysemu.h"
>>>  #include "sysemu/balloon.h"
>>>  #include "qemu/error-report.h"
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index 3036221ee8..b0e27b6174 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -25,6 +25,7 @@
>>>  #include "qemu/error-report.h"
>>>  #include "qemu/main-loop.h"
>>>  #include "qemu/module.h"
>>> +#include "qemu/rcu.h"
>>>  #include "qemu/sockets.h"
>>>  #include "qemu/bitmap.h"
>>>  #include "qemu/coroutine.h"
>>>
>>
>> To keep this patch cleaner, can you use a preparatory patch adding the
>> various "qemu/rcu.h"?
> 
> How would I explain that new patch?
> 
> Other patches that drop includes from headers also fix up their users by
> adding the includes that are actually needed there, e.g.:
> 
> * PATCH 03: hw/qdev-core.h dropped, fixups add only qemu/bitops.h or
>   hw/irq.h.
> 
> * PATCH 10: hw/ide/internal.h dropped, some fixups add only
>   exec/address-spaces.h or sysemu/sysemu.h.
> 
> * PATCH 17: qom/object.h dropped, fixup adds only hw/hw.h.
> 
> * PATCH 20: qemu/main-loop.h dropped, some fixups add only block/aio.h
>   or qemu/thread.h.  Touches five times as many files as this one...
> 
> * More.

I See.

> Does each of them need preparatory patches?

If those are only 4, why not... However this series is already big
enough, and what matters more: bisectable. Preparatory 3-lines patch
makes no difference, I was just aiming at perfection ;)

I am happy with the current organization.

> Would it help if their commit messages explained the fixups more
> clearly?

No, not that much, each commit is already well explained.

Sorry for the noise!

Phil,

