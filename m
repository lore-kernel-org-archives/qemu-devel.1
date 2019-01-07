Received: from eggs.gnu.org ([209.51.188.92]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPns-00046E-9b
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPnr-0001Ai-3R
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:58:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggPnp-000194-7J
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:58:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so6243148wmd.0
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 23:58:28 -0800 (PST)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-6-philmd@redhat.com>
	<ddc16ba0-339e-2d6a-5771-f63f8f084b8c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <abe790c0-420a-5575-ce3a-c54100e97e47@redhat.com>
Date: Mon, 7 Jan 2019 08:58:25 +0100
MIME-Version: 1.0
In-Reply-To: <ddc16ba0-339e-2d6a-5771-f63f8f084b8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/16] hw/devices: Move Blizzard
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 1/7/19 7:39 AM, Thomas Huth wrote:
> On 2019-01-04 18:58, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS                   |  1 +
>>  hw/arm/nseries.c              |  1 +
>>  hw/display/blizzard.c         |  2 +-
>>  include/hw/devices.h          |  7 -------
>>  include/hw/display/blizzard.h | 21 +++++++++++++++++++++
>>  5 files changed, 24 insertions(+), 8 deletions(-)
>>  create mode 100644 include/hw/display/blizzard.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dff4b98401..156ce9a698 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -640,6 +640,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>>  L: qemu-arm@nongnu.org
>>  S: Odd Fixes
>>  F: hw/arm/nseries.c
>> +F: include/hw/display/blizzard.h
> 
> While you're at it, also add an entry for hw/display/blizzard.c here?

Good idea :)

> 
>>  Palm
>>  M: Andrzej Zaborowski <balrogg@gmail.com>
>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>> index 906b7ca22d..9521be1cef 100644
>> --- a/hw/arm/nseries.c
>> +++ b/hw/arm/nseries.c
>> @@ -31,6 +31,7 @@
>>  #include "hw/boards.h"
>>  #include "hw/i2c/i2c.h"
>>  #include "hw/devices.h"
>> +#include "hw/display/blizzard.h"
>>  #include "hw/block/flash.h"
>>  #include "hw/hw.h"
>>  #include "hw/bt.h"
>> diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
>> index 291abe6fca..471bd0ed99 100644
>> --- a/hw/display/blizzard.c
>> +++ b/hw/display/blizzard.c
>> @@ -21,7 +21,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>>  #include "ui/console.h"
>> -#include "hw/devices.h"
>> +#include "hw/display/blizzard.h"
>>  #include "ui/pixel_ops.h"
>>  
>>  typedef void (*blizzard_fn_t)(uint8_t *, const uint8_t *, unsigned int);
>> diff --git a/include/hw/devices.h b/include/hw/devices.h
>> index 5ad134232c..25f895b330 100644
>> --- a/include/hw/devices.h
>> +++ b/include/hw/devices.h
>> @@ -28,13 +28,6 @@ void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
>>  /* stellaris_input.c */
>>  void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
>>  
>> -/* blizzard.c */
>> -void *s1d13745_init(qemu_irq gpio_int);
>> -void s1d13745_write(void *opaque, int dc, uint16_t value);
>> -void s1d13745_write_block(void *opaque, int dc,
>> -                void *buf, size_t len, int pitch);
>> -uint16_t s1d13745_read(void *opaque, int dc);
>> -
>>  /* cbus.c */
>>  typedef struct {
>>      qemu_irq clk;
>> diff --git a/include/hw/display/blizzard.h b/include/hw/display/blizzard.h
>> new file mode 100644
>> index 0000000000..8132557da1
>> --- /dev/null
>> +++ b/include/hw/display/blizzard.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Epson S1D13744/S1D13745 (Blizzard/Hailstorm/Tornado) LCD/TV controller.
>> + *
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Written by Andrzej Zaborowski <andrew@openedhand.com>
> 
> I don't think that this e-mail address is still valid since that company
> has been bought up > 10 years ago... so it likely does not make sense to
> mention it in new files anymore. So just mention the name?

Sure, I had no idea.

TIL: check email domain when moving emails.

>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +#ifndef HW_DISPLAY_BLIZZARD_H
>> +#define HW_DISPLAY_BLIZZARD_H
>> +
>> +#include "hw/irq.h"
>> +
>> +void *s1d13745_init(qemu_irq gpio_int);
>> +void s1d13745_write(void *opaque, int dc, uint16_t value);
>> +void s1d13745_write_block(void *opaque, int dc,
>> +                          void *buf, size_t len, int pitch);
>> +uint16_t s1d13745_read(void *opaque, int dc);
>> +
>> +#endif
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
