Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E9C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AF12070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AF12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnq2-0007jx-2g
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHnou-0006il-3x
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHnos-000422-DI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHnoq-0003yi-Cl
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:38:20 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6206269061
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 11:38:19 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so1252093wmb.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+IpbVCrzLcmTZlMF6+ThTArGfMe9+73zUiYPDmX1XSU=;
 b=YhlhVFjwZlOcuEkZAlaFEQQE5+N88wfi6Uj1O7XRwqPUsTqa2pkUrsSuecmTa7OtfV
 r9r4O6noZbLjmNHnypWIWyoS37RSaVZmaZy8ZK37+hsnKby94okaqdlKPP6kGHiTfmbS
 yizwkqVSyg9xapBpbHyvcBydx8ODAjX3kBbQGK7E3um5vFlRQl+OUHYcm4bQeSgmKQer
 UORdFVl3X8npeWcO2u4ZWTs8mxxzUPL1hJUF4AoYIB5EHi2mXqxWlvvd+So7HonVtg3v
 SQRuutt8rLfnM2NJOXUbHZkcHaClHmjHfNPov/CxLuWjwLhkxXXCDg/BzQFuSfa8xPGL
 ReLQ==
X-Gm-Message-State: APjAAAUI83c1voclanhE5rNzxJSzYinklbLc+Asq4k+UPq7O979Uu4NB
 hQ4Jw0Zf+mudAvj25cCvd2qDgJ9eB+2IkgttjA12A7ZXtpmTNuYGwzevpJU+3Xwv92SQivu3Q/z
 zKewxjxCJSGjNzmQ=
X-Received: by 2002:a1c:6609:: with SMTP id a9mr3654410wmc.127.1570534698133; 
 Tue, 08 Oct 2019 04:38:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqywi5W3ZgL1290IfVe569IqNturPFo8B96m0YvILPzmD/nrbckNqOn9/TfnBtY9YDv2adfGCA==
X-Received: by 2002:a1c:6609:: with SMTP id a9mr3654393wmc.127.1570534697909; 
 Tue, 08 Oct 2019 04:38:17 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id e9sm3782463wme.3.2019.10.08.04.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 04:38:17 -0700 (PDT)
Subject: Re: [PATCH 07/19] hw/misc/bcm2835_mbox: Add trace events
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-8-f4bug@amsat.org> <87wodfiibn.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bff44a43-6fae-e5bc-c965-94a2a3b02c3a@redhat.com>
Date: Tue, 8 Oct 2019 13:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87wodfiibn.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:32 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> Add trace events for read/write accesses and IRQ.
>>
>> Properties are structures used for the ARM particular MBOX.
>> Since one call in bcm2835_property.c concerns the mbox block,
>> name this trace event in the same bcm2835_mbox* namespace.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/misc/bcm2835_mbox.c     | 5 +++++
>>   hw/misc/bcm2835_property.c | 2 ++
>>   hw/misc/trace-events       | 6 ++++++
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
>> index 77285624c9..77d2d80706 100644
>> --- a/hw/misc/bcm2835_mbox.c
>> +++ b/hw/misc/bcm2835_mbox.c
>> @@ -15,6 +15,7 @@
>>   #include "migration/vmstate.h"
>>   #include "qemu/log.h"
>>   #include "qemu/module.h"
>> +#include "trace.h"
>>
>>   #define MAIL0_PEEK   0x90
>>   #define MAIL0_SENDER 0x94
>> @@ -123,6 +124,7 @@ static void bcm2835_mbox_update(BCM2835MboxState *=
s)
>>               set =3D true;
>>           }
>>       }
>> +    trace_bcm2835_mbox_irq(set);
>>       qemu_set_irq(s->arm_irq, set);
>=20
> I'm kind surprised we don't have a common trace point for all IRQs.

Trace event names are used for filtering. You usually don't want to=20
display all the IRQs, but rather a filtered set of devices you are=20
working on/analyzing.

>>   }
>>
>> @@ -178,8 +180,10 @@ static uint64_t bcm2835_mbox_read(void *opaque, h=
waddr offset, unsigned size)
>>       default:
>>           qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_=
PRIx"\n",
>>                         __func__, offset);
>> +        trace_bcm2835_mbox_read(size, offset, res);
>>           return 0;
>>       }
>> +    trace_bcm2835_mbox_read(size, offset, res);
>>
>>       bcm2835_mbox_update(s);
>>
>> @@ -195,6 +199,7 @@ static void bcm2835_mbox_write(void *opaque, hwadd=
r offset,
>>
>>       offset &=3D 0xff;
>>
>> +    trace_bcm2835_mbox_write(size, offset, value);
>>       switch (offset) {
>>       case MAIL0_SENDER:
>>           break;
>> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
>> index 43a5465c5d..0eea2e20f7 100644
>> --- a/hw/misc/bcm2835_property.c
>> +++ b/hw/misc/bcm2835_property.c
>> @@ -13,6 +13,7 @@
>>   #include "sysemu/dma.h"
>>   #include "qemu/log.h"
>>   #include "qemu/module.h"
>> +#include "trace.h"
>>
>>   /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-int=
erface */
>>
>> @@ -283,6 +284,7 @@ static void bcm2835_property_mbox_push(BCM2835Prop=
ertyState *s, uint32_t value)
>>               break;
>>           }
>>
>> +        trace_bcm2835_mbox_property(tag, bufsize, resplen);
>>           if (tag =3D=3D 0) {
>>               break;
>>           }
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 74276225f8..1deb1d08c1 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -143,3 +143,9 @@ armsse_mhu_write(uint64_t offset, uint64_t data, u=
nsigned size) "SSE-200 MHU wri
>>
>>   # aspeed_xdma.c
>>   aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offse=
t 0x%" PRIx64 " data 0x%" PRIx64
>> +
>> +# bcm2835_mbox.c
>> +bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) =
"mbox write sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
>> +bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "=
mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
>> +bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
>> +bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen)=
 "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
>=20
> Anyway:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks!

