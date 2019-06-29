Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43985C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 12:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAC22086D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 12:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAC22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhCbt-0002MA-PY
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 08:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhCb0-0001td-Du
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhCaw-0002Bh-QT
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:36:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhCat-00025C-DH
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:36:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so7076803wrl.11
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 05:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UOWB7MFYjv7a0Kdw+D38z6CWhRgyZVoFyAz/2nzGvOA=;
 b=SeGYr4tg1L4A+W8Ae/NkFMs8772cAaxn61SfH6E7oyaZSY/fON/Zg3ERUFtwNblGWo
 vZ8K1b2Iu76c0UW63pNzdo83mDZbz7js7QNijuGhh6oAouYL8GgAQEfT3LjeL0RWh0Ua
 5ah8N2/cL5g1Tgs93qI9Z2UvfRqC6ehU4wjXULPF5w46im2ji4Y94ueiNFQrChcMNrPO
 2nFFIXxfGWfqGIJ7EoJzTCGy7hzoWlb+ZhgsdeoP6j2YZuoIGkRizM09iZJWP+ihz0g8
 f4h2Cl7j7ugKnxZ4nQ1gPiWHdAe+wN54WVGNSZeZ1WKYgU32ZOXrq3IcofJrInQNUCP+
 Xe5g==
X-Gm-Message-State: APjAAAVV6KgC6cJaNg6eWdrRMifbs6JdUxVDpbtkpq/jHCfWhDd4r2m2
 he4BoBJiXViJPMYYdJflorh6jQ==
X-Google-Smtp-Source: APXvYqwatVaY+KwAr9YYCItC8jWPTMjS3ozHA+0yeBpqVzPKHfUJZmBv+kRYW1fBx2tD/RYxTVLfOQ==
X-Received: by 2002:adf:e802:: with SMTP id o2mr2398636wrm.171.1561811795589; 
 Sat, 29 Jun 2019 05:36:35 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x4sm5523947wrw.14.2019.06.29.05.36.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 05:36:34 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-4-huth@tuxfamily.org>
 <074eb5c6-8a7f-1018-47f9-9801e0aba704@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7321aa3f-3054-d8bd-84ee-b0070c5d61a4@redhat.com>
Date: Sat, 29 Jun 2019 14:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <074eb5c6-8a7f-1018-47f9-9801e0aba704@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 3/4] m68k: Add NeXTcube machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/19 2:26 PM, Philippe Mathieu-Daudé wrote:
> On 6/28/19 8:15 PM, Thomas Huth wrote:
>> It is still quite incomplete (no SCSI, no floppy emulation, no network,
>> etc.), but the firmware already shows up the debug monitor prompt in the
>> framebuffer display, so at least the very basics are already working.
>>
>> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>>
>>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c
>>
>> and altered quite a bit to fit the latest interface and coding conventions
>> of the current QEMU.
>>
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>>  hw/m68k/Makefile.objs       |   2 +-
>>  hw/m68k/next-cube.c         | 988 ++++++++++++++++++++++++++++++++++++
>>  include/hw/m68k/next-cube.h |  38 ++
>>  3 files changed, 1027 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/m68k/next-cube.c
>>
>> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
>> index 688002cac1..f25854730d 100644
>> --- a/hw/m68k/Makefile.objs
>> +++ b/hw/m68k/Makefile.objs
>> @@ -1,3 +1,3 @@
>>  obj-$(CONFIG_AN5206) += an5206.o mcf5206.o
>>  obj-$(CONFIG_MCF5208) += mcf5208.o mcf_intc.o
>> -obj-$(CONFIG_NEXTCUBE) += next-kbd.o
>> +obj-$(CONFIG_NEXTCUBE) += next-kbd.o next-cube.o
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> new file mode 100644
>> index 0000000000..700d386fb9
>> --- /dev/null
>> +++ b/hw/m68k/next-cube.c
>> @@ -0,0 +1,988 @@
>> +/*
>> + * NeXT Cube System Driver
>> + *
>> + * Copyright (c) 2011 Bryce Lanham
>> + *
>> + * This code is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published
>> + * by the Free Software Foundation; either version 2 of the License,
>> + * or (at your option) any later version.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "exec/hwaddr.h"
>> +#include "exec/address-spaces.h"
>> +#include "sysemu/sysemu.h"
>> +#include "sysemu/qtest.h"
>> +#include "hw/hw.h"
>> +#include "hw/m68k/next-cube.h"
>> +#include "hw/boards.h"
>> +#include "hw/loader.h"
>> +#include "hw/scsi/esp.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
>> +#include "hw/block/fdc.h"
>> +#include "qapi/error.h"
>> +#include "ui/console.h"
>> +#include "target/m68k/cpu.h"
>> +
>> +/* #define DEBUG_NEXT */
>> +#ifdef DEBUG_NEXT
>> +#define DPRINTF(fmt, ...) \
>> +    do { printf("NeXT: " fmt , ## __VA_ARGS__); } while (0)
>> +#else
>> +#define DPRINTF(fmt, ...) do { } while (0)
>> +#endif
>> +
>> +#define TYPE_NEXT_MACHINE MACHINE_TYPE_NAME("next-cube")
>> +#define NEXT_MACHINE(obj) OBJECT_CHECK(NeXTState, (obj), TYPE_NEXT_MACHINE)
>> +
>> +#define ENTRY       0x0100001e
>> +#define RAM_SIZE    0x4000000
>> +#define ROM_FILE    "rom66.bin"
> 
> Where can we find this file to test your work?

I found one:

http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/68040_Non-Turbo_Chipset/

I have to say I'm impressed :)

Let me share this comment from
http://old-computers.com/museum/computer.asp?c=277

"did you know the 040 nextcube was actually used for graphics design at
id software at the time doom was made?"

=)

