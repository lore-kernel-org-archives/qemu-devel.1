Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0245C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD82A2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD82A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiN1W-0007Wq-4t
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiM8p-0003vR-3w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiM8n-0005QP-5U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:00:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiM8m-0005PK-Uz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:00:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id e3so9138324wrs.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 10:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fMhjUBszIrEjyyu4IyeLoSfp6Qi5xqaef0VPVrzvfUY=;
 b=ll1O334kpBVqBMn36VDadVN36yV5l9iaL309He2pE9PavwJyREHVDI8npeQuKGEtui
 vs4gjjLjUSY3HjNRLl0LTv72539dupx3fwmQpYBF6pRMvaRnqtwABdOAHOAx8qQTnsCp
 x/Pk2TkJHWI7iQUVvgtN1oBZAWJ2Ih4pQkiR6iW2/dR1QJ9A7NqEK3lN/NZQl2B6Q8QP
 HFXoyYFrRASnAFLAZnQCIzCcmWgUCo+g56ppGDVbmKWDxXhDRvFHA2L4xdZ/pNQNrAtS
 QNwYyYC7YpMux8oZYRGk+pngE//Jw8P1yQ0oAKf9MTDf29VM1HMpiAGu1KbyGY4/qwoB
 C2qQ==
X-Gm-Message-State: APjAAAX0L2c3UbMIK7X/0t2GFHnmu2NqOkHMShbFmLJ+KDujJ4nObG6y
 4R3C+AwTa8+79oKxuC5C0Rj9BA==
X-Google-Smtp-Source: APXvYqyGdJSX4FzZdFGZlY25p4y0JheEFo8E2/OeF96j7hfydhq2sfALF8z5eeMZEnqbl/ujtCZ6Sw==
X-Received: by 2002:adf:ed50:: with SMTP id u16mr12166638wro.108.1562086823166; 
 Tue, 02 Jul 2019 10:00:23 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id q20sm20515867wra.36.2019.07.02.10.00.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 10:00:22 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-6-philmd@redhat.com>
 <CAKmqyKMWb5LE=gtdDpbEUcceGD9T3V9gNAXfo16sOuQh2hCVgg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c4ea506-edd8-521d-b75f-31362a75f392@redhat.com>
Date: Tue, 2 Jul 2019 19:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMWb5LE=gtdDpbEUcceGD9T3V9gNAXfo16sOuQh2hCVgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/dma/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 6:18 PM, Alistair Francis wrote:
> On Mon, Jul 1, 2019 at 5:32 AM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> As explained in commit aff39be0ed97:
>>
>>   Both functions, object_initialize() and object_property_add_child()
>>   increase the reference counter of the new object, so one of the
>>   references has to be dropped afterwards to get the reference
>>   counting right. Otherwise the child object will not be properly
>>   cleaned up when the parent gets destroyed.
>>   Thus let's use now object_initialize_child() instead to get the
>>   reference counting here right.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
> 
>> ---
>>  hw/dma/xilinx_axidma.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
>> index 921be178d9..91f5ec587f 100644
>> --- a/hw/dma/xilinx_axidma.c
>> +++ b/hw/dma/xilinx_axidma.c
>> @@ -563,14 +563,14 @@ static void xilinx_axidma_init(Object *obj)
>>      XilinxAXIDMA *s = XILINX_AXI_DMA(obj);
>>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>
>> -    object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
>> -                      TYPE_XILINX_AXI_DMA_DATA_STREAM);
>> -    object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
>> -                      TYPE_XILINX_AXI_DMA_CONTROL_STREAM);
>> -    object_property_add_child(OBJECT(s), "axistream-connected-target",
>> -                              (Object *)&s->rx_data_dev, &error_abort);
>> -    object_property_add_child(OBJECT(s), "axistream-control-connected-target",
>> -                              (Object *)&s->rx_control_dev, &error_abort);
>> +    object_initialize_child(OBJECT(s), "axistream-connected-target",
>> +                            &s->rx_data_dev, sizeof(s->rx_data_dev),
>> +                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_abort,
>> +                            NULL);
>> +    object_initialize_child(OBJECT(s), "axistream-control-connected-target",
>> +                            &s->rx_control_dev, sizeof(s->rx_control_dev),
>> +                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM, &error_abort,
>> +                            NULL);
>>
>>      sysbus_init_irq(sbd, &s->streams[0].irq);
>>      sysbus_init_irq(sbd, &s->streams[1].irq);
>> --
>> 2.20.1

As GCC suggested, this patch requires this snippet squashed:

-- >8 --
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
@@ -565,11 +565,11 @@ static void xilinx_axidma_init(Object *obj)

     object_initialize_child(OBJECT(s), "axistream-connected-target",
                             &s->rx_data_dev, sizeof(s->rx_data_dev),
-                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_abort,
+                            TYPE_XILINX_AXI_DMA_DATA_STREAM, &error_abort,
                             NULL);
     object_initialize_child(OBJECT(s),
"axistream-control-connected-target",
                             &s->rx_control_dev, sizeof(s->rx_control_dev),
-                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
&error_abort,
+                            TYPE_XILINX_AXI_DMA_CONTROL_STREAM,
&error_abort,
                             NULL);

     sysbus_init_irq(sbd, &s->streams[0].irq);
---

Since it was commented in reply to the cover, I assume your R-b stands
with the snippet applied.

Thanks for reviewing,

Phil.

