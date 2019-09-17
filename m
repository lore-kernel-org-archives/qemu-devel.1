Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE69C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8214421852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8214421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAyM-0002DV-Sx
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAAiS-00050X-RA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAAiQ-0000AC-Ev
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAAiQ-00009r-7r
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:28:10 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D8904E924
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:28:09 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f11so1131719wrt.18
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OAIO2nB+ybo/H9XjI3W4Br3K0hK/KnUOApJNbYvZkuQ=;
 b=fdetkmPTuaKGbWxhPB4OLbwV89NF1df8tsVrVfwvWaKL3UOD55qVZe86P2xkIOzXJ+
 JmMhoE+POAL/EeIgNIbKK83FAEDKlQNsCIdqYSRDVbjSp835rHWw0om2x872npZnkM2A
 eS6+5XVKK+57c0HnbmEy3oaVrrfVpJMx3Z6zxjMNPliqcwxPZRvYMDUdQwPDxo1Gej3M
 Ggb/LF0S/MtGJowV5uVe11ANZQWvYS9RVo8Ojr+fgbj+ZWlB5BulYb3YhyHOWYXeyrWO
 vqaSS4ItLhrxBtAu4NNaospRUZxPKGmTYMt42xKjQ5ifma/t/Coa453BcCfg/Lj449je
 bWHg==
X-Gm-Message-State: APjAAAXPdpxG6ZypsRMp4SEjvU9PXSkxAkeRoUKbuqFFZ0NekXx3bYx4
 iaKbJ/MqbkQF46K7dlLnSnFMCnXegBEM3xBg+uap8APVzola01V5vC2GrRV4dlmyz+y248o4OFX
 EWajCSiX8lyheFsE=
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr2274876wro.83.1568716085602; 
 Tue, 17 Sep 2019 03:28:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjB7j5DKXlyMufCT/sPEjp8EuB4FBlhyZw/AmBleju3+cediVMV7b0aBUJyF3eZ2zZbujjCw==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr2274845wro.83.1568716085372; 
 Tue, 17 Sep 2019 03:28:05 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a144sm2307006wme.13.2019.09.17.03.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:28:04 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-10-philmd@redhat.com>
 <CAKmqyKPtRbU5X-72+HfNNbaV46LOD6D+JLQoGiBROB+zJczNgA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7a48ec0e-c386-7022-b7ab-00f0cb53fa82@redhat.com>
Date: Tue, 17 Sep 2019 12:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPtRbU5X-72+HfNNbaV46LOD6D+JLQoGiBROB+zJczNgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 09/13] hw: Move Xilinx ZynqMP RTC from
 hw/timer/ to hw/rtc/ subdirectory
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 9/16/19 11:44 PM, Alistair Francis wrote:
> On Mon, Sep 16, 2019 at 8:56 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Move RTC devices under the hw/rtc/ subdirectory.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  hw/rtc/Makefile.objs                        | 1 +
>>  hw/rtc/trace-events                         | 3 +++
>>  hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.c         | 2 +-
>>  hw/timer/Makefile.objs                      | 1 -
>>  hw/timer/trace-events                       | 3 ---
>>  include/hw/arm/xlnx-zynqmp.h                | 2 +-
>>  include/hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.h | 6 +++---
>>  7 files changed, 9 insertions(+), 9 deletions(-)
>>  rename hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.c (99%)
>>  rename include/hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.h (95%)
>>
>> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
>> index b195863291..543a550a0f 100644
>> --- a/hw/rtc/Makefile.objs
>> +++ b/hw/rtc/Makefile.objs
>> @@ -6,5 +6,6 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
>>  endif
>>  common-obj-$(CONFIG_PL031) +=3D pl031.o
>>  common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>> +common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
>> index ac9e0e0fba..7f1945ad4c 100644
>> --- a/hw/rtc/trace-events
>> +++ b/hw/rtc/trace-events
>> @@ -4,6 +4,9 @@
>>  sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64=
 " value 0x%" PRIx64
>>  sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx=
64 " value 0x%" PRIx64
>>
>> +# xlnx-zynqmp-rtc.c
>> +xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int m=
in, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>> +
>>  # pl031.c
>>  pl031_irq_state(int level) "irq state %d"
>>  pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>> diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
>> similarity index 99%
>> rename from hw/timer/xlnx-zynqmp-rtc.c
>> rename to hw/rtc/xlnx-zynqmp-rtc.c
>> index 5692db98c2..f9f09b7296 100644
>> --- a/hw/timer/xlnx-zynqmp-rtc.c
>> +++ b/hw/rtc/xlnx-zynqmp-rtc.c
>> @@ -36,7 +36,7 @@
>>  #include "qemu/cutils.h"
>>  #include "sysemu/sysemu.h"
>>  #include "trace.h"
>> -#include "hw/timer/xlnx-zynqmp-rtc.h"
>> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>>  #include "migration/vmstate.h"
>>
>>  #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 70b61b69c7..294465ef47 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -14,7 +14,6 @@ common-obj-$(CONFIG_IMX) +=3D imx_epit.o
>>  common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
>>  common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
>>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
>> -common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>>  common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
>>
>>  common-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
>> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
>> index ce34b967db..1459d07237 100644
>> --- a/hw/timer/trace-events
>> +++ b/hw/timer/trace-events
>> @@ -70,9 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer=
: reset"
>>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
>>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 "=
 value 0x%08" PRIx64
>>
>> -# xlnx-zynqmp-rtc.c
>> -xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int m=
in, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>> -
>>  # nrf51_timer.c
>>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read =
addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "writ=
e addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp=
.h
>> index d7483c3b42..53076fa29a 100644
>> --- a/include/hw/arm/xlnx-zynqmp.h
>> +++ b/include/hw/arm/xlnx-zynqmp.h
>> @@ -29,7 +29,7 @@
>>  #include "hw/dma/xlnx-zdma.h"
>>  #include "hw/display/xlnx_dp.h"
>>  #include "hw/intc/xlnx-zynqmp-ipi.h"
>> -#include "hw/timer/xlnx-zynqmp-rtc.h"
>> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>>  #include "hw/cpu/cluster.h"
>>  #include "target/arm/cpu.h"
>>
>> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-=
zynqmp-rtc.h
>> similarity index 95%
>> rename from include/hw/timer/xlnx-zynqmp-rtc.h
>> rename to include/hw/rtc/xlnx-zynqmp-rtc.h
>> index 97e32322ed..6fa1cb2f43 100644
>> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
>> +++ b/include/hw/rtc/xlnx-zynqmp-rtc.h
>> @@ -3,7 +3,7 @@
>>   *
>>   * Copyright (c) 2017 Xilinx Inc.
>>   *
>> - * Written-by: Alistair Francis <alistair.francis@xilinx.com>
>> + * Written-by: Alistair Francis
>=20
> Why remove the email address?

In https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00759.html
Thomas suggested to remove invalid email addresses:

  I don't think that this e-mail address is still valid since that
  company has been bought up > 10 years ago... so it likely does not
  make sense to mention it in new files anymore. So just mention the
  name?

In your case Xilinx still exists, but you warned us it might bounce:

$ git show c22e580c2ad
commit c22e580c2ad1cccef582e1490e732f254d4ac064 (tag:
pull-target-arm-20180301)
Author: Alistair Francis <alistair.francis@xilinx.com>
Date:   Thu Mar 1 11:05:58 2018 +0000

    MAINTAINERS: Update my email address

    I am leaving Xilinx, so to avoid having an email address that bounces
    update my maintainer address to point to my personal email address.

So I stripped your obsolete email.

Since the line is not "(c) Name <email>" but simply "Written by" and the
(C) remains to Xilinx, we could update the email by your personal one,
that seems fair (so if someone want to contact you to ask you question
about your code, he still can).

What do you prefer?

>=20
> Otherwise:
>=20
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

>=20
> Alistair
>=20
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>>   * of this software and associated documentation files (the "Software=
"), to deal
>> @@ -24,8 +24,8 @@
>>   * THE SOFTWARE.
>>   */
>>
>> -#ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
>> -#define HW_TIMER_XLNX_ZYNQMP_RTC_H
>> +#ifndef HW_RTC_XLNX_ZYNQMP_H
>> +#define HW_RTC_XLNX_ZYNQMP_H
>>
>>  #include "hw/register.h"
>>  #include "hw/sysbus.h"
>> --
>> 2.20.1
>>
>>

