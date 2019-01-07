Received: from eggs.gnu.org ([209.51.188.92]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPto-0006db-CM
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPta-0006oj-St
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:04:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggPtW-0006mj-VH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:04:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so42251449wrr.0
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 00:04:22 -0800 (PST)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-13-philmd@redhat.com>
	<222c7009-e950-c27d-89a1-674ada91b1e2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <649326a8-64ef-0914-b52c-6fc1b3a7e7ef@redhat.com>
Date: Mon, 7 Jan 2019 09:04:19 +0100
MIME-Version: 1.0
In-Reply-To: <222c7009-e950-c27d-89a1-674ada91b1e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/16] hw/devices: Move LAN9118
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

On 1/7/19 8:29 AM, Thomas Huth wrote:
> On 2019-01-04 18:58, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/arm/kzm.c             |  2 +-
>>  hw/arm/mps2.c            |  2 +-
>>  hw/arm/realview.c        |  1 +
>>  hw/arm/vexpress.c        |  2 +-
>>  hw/net/lan9118.c         |  2 +-
>>  include/hw/devices.h     |  3 ---
>>  include/hw/net/lan9118.h | 21 +++++++++++++++++++++
>>  7 files changed, 26 insertions(+), 7 deletions(-)
>>  create mode 100644 include/hw/net/lan9118.h
>>
>> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
>> index 864c7bd411..139934c4ec 100644
>> --- a/hw/arm/kzm.c
>> +++ b/hw/arm/kzm.c
>> @@ -22,7 +22,7 @@
>>  #include "qemu/error-report.h"
>>  #include "exec/address-spaces.h"
>>  #include "net/net.h"
>> -#include "hw/devices.h"
>> +#include "hw/net/lan9118.h"
>>  #include "hw/char/serial.h"
>>  #include "sysemu/qtest.h"
>>  
>> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
>> index e3d698ba6c..54b7395849 100644
>> --- a/hw/arm/mps2.c
>> +++ b/hw/arm/mps2.c
>> @@ -36,7 +36,7 @@
>>  #include "hw/timer/cmsdk-apb-timer.h"
>>  #include "hw/timer/cmsdk-apb-dualtimer.h"
>>  #include "hw/misc/mps2-scc.h"
>> -#include "hw/devices.h"
>> +#include "hw/net/lan9118.h"
>>  #include "net/net.h"
>>  
>>  typedef enum MPS2FPGAType {
>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>> index 242f5a87b6..e9983c8763 100644
>> --- a/hw/arm/realview.c
>> +++ b/hw/arm/realview.c
>> @@ -15,6 +15,7 @@
>>  #include "hw/arm/arm.h"
>>  #include "hw/arm/primecell.h"
>>  #include "hw/devices.h"
>> +#include "hw/net/lan9118.h"
>>  #include "hw/pci/pci.h"
>>  #include "net/net.h"
>>  #include "sysemu/sysemu.h"
>> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
>> index c02d18ee61..12e2c3986f 100644
>> --- a/hw/arm/vexpress.c
>> +++ b/hw/arm/vexpress.c
>> @@ -28,7 +28,7 @@
>>  #include "hw/sysbus.h"
>>  #include "hw/arm/arm.h"
>>  #include "hw/arm/primecell.h"
>> -#include "hw/devices.h"
>> +#include "hw/net/lan9118.h"
>>  #include "hw/i2c/i2c.h"
>>  #include "net/net.h"
>>  #include "sysemu/sysemu.h"
>> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
>> index a6269d9463..a428b16eda 100644
>> --- a/hw/net/lan9118.c
>> +++ b/hw/net/lan9118.c
>> @@ -14,7 +14,7 @@
>>  #include "hw/sysbus.h"
>>  #include "net/net.h"
>>  #include "net/eth.h"
>> -#include "hw/devices.h"
>> +#include "hw/net/lan9118.h"
>>  #include "sysemu/sysemu.h"
>>  #include "hw/ptimer.h"
>>  #include "qemu/log.h"
>> diff --git a/include/hw/devices.h b/include/hw/devices.h
>> index ba9034050b..ebc45c8799 100644
>> --- a/include/hw/devices.h
>> +++ b/include/hw/devices.h
>> @@ -8,7 +8,4 @@
>>  /* smc91c111.c */
>>  void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
>>  
>> -/* lan9118.c */
>> -void lan9118_init(NICInfo *, uint32_t, qemu_irq);
>> -
>>  #endif
>> diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
>> new file mode 100644
>> index 0000000000..340d6681b7
>> --- /dev/null
>> +++ b/include/hw/net/lan9118.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * SMSC LAN9118 Ethernet interface emulation
>> + *
>> + * Copyright (c) 2009 CodeSourcery, LLC.
>> + * Written by Paul Brook
>> + *
>> + * This code is licensed under the GNU GPL v2
>> + *
>> + * Contributions after 2012-01-13 are licensed under the terms of the
>> + * GNU GPL, version 2 or (at your option) any later version.
> 
> Since your contribution here is after 2012 and the file content is also
> just a trivial one-line prototype, please change the license code to say
> GPLv2+ only right from the start. We should avoid these v2 + v2+
> statements in new files.

OK.

> 
>> + */
>> +
>> +#ifndef HW_NET_LAN9118_H
>> +#define HW_NET_LAN9118_H
>> +
>> +#include "hw/irq.h"
>> +#include "net/net.h"
>> +
>> +void lan9118_init(NICInfo *, uint32_t, qemu_irq);
>> +
>> +#endif
>>
> 
>  Thomas
> 
