Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAF5CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB8E20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB8E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc5G-0000T2-6G
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNbb3-00030i-OD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNbb2-0007hC-FC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNbb1-0007gb-TI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:48:04 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE3A459451
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:48:02 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k9so874036wmb.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RodsIxNVedoLZrS91xhgv1KPAkM9KvsVpg2mvRylzXQ=;
 b=PQngWDzB+p3Wa+bCuUb+jMe7tVjinQvWNZRfJSoWNLMOzat8TRWW/VkVBbDbG8+KBz
 80v5ateYIeI7+/k80cm7aKRA+9tU/mlg0i0z5hRMe9MV9oRDD/CK4yguvhSQ918a8k91
 qD/kUzG4eZpAhQxzBrFcK1UUbC2xO9eMOAQa2ZyIyCk7sn9HMJt+GaQQNctKx4rUlFcX
 wAfxI5rniNQ8y9byeSOMT6J+kgIYspb56/UFd+gIWMF5xrw8MafHfi255gz56tvwbot8
 zoveAlt8zqpplDn9ORcvgX+z5P8FnEJ28gw3so7Vr0naVQP7MJcgVsqwlmDAfdVzGpwO
 229g==
X-Gm-Message-State: APjAAAVRvPIZRGA6W4bPne+FsowJA9Nil2fXX1I6KPk7nkRsQVbSd8Kx
 UiNyBY+22vTQSUZCVPpY5ZVfVbJh7UPMA2rRTKSaVA8ZLdRd2F3RRWAIurgcIiOEfYCbDZWvReS
 tPyp0Fyvs13aoVY4=
X-Received: by 2002:a1c:610b:: with SMTP id v11mr4484150wmb.156.1571917678624; 
 Thu, 24 Oct 2019 04:47:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxfMiFP2BKmH4lLaTaZOdZYDg0x2EMewze60npzmA4eQFPdo+dKfAnsbEhlPwavUKl0ucKnQ==
X-Received: by 2002:a1c:610b:: with SMTP id v11mr4484105wmb.156.1571917678380; 
 Thu, 24 Oct 2019 04:47:58 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id e3sm2084103wme.36.2019.10.24.04.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 04:47:57 -0700 (PDT)
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
 <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
 <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
Date: Thu, 24 Oct 2019 13:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 1:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
>=20
> On Thu, Oct 24, 2019 at 1:01 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/dma/sparc32_dma.c | 2 +-
>>>    hw/net/lance.c       | 5 ++---
>>>    hw/net/pcnet-pci.c   | 2 +-
>>>    hw/net/pcnet.h       | 2 +-
>>>    4 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
>>> index 0e5bbcdc7f..3e4da0c47f 100644
>>> --- a/hw/dma/sparc32_dma.c
>>> +++ b/hw/dma/sparc32_dma.c
>>> @@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceSt=
ate *dev, Error **errp)
>>>        d =3D qdev_create(NULL, TYPE_LANCE);
>>>        object_property_add_child(OBJECT(dev), "lance", OBJECT(d), err=
p);
>>>        qdev_set_nic_properties(d, nd);
>>> -    qdev_prop_set_ptr(d, "dma", dev);
>>> +    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
>>>        qdev_init_nofail(d);
>>>    }
>>>
>>> diff --git a/hw/net/lance.c b/hw/net/lance.c
>>> index 6631e2a4e0..4d96299041 100644
>>> --- a/hw/net/lance.c
>>> +++ b/hw/net/lance.c
>>> @@ -138,7 +138,8 @@ static void lance_instance_init(Object *obj)
>>>    }
>>>
>>>    static Property lance_properties[] =3D {
>>> -    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
>>> +    DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
>>> +                     TYPE_DEVICE, DeviceState *),
>>>        DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>> @@ -153,8 +154,6 @@ static void lance_class_init(ObjectClass *klass, =
void *data)
>>>        dc->reset =3D lance_reset;
>>>        dc->vmsd =3D &vmstate_lance;
>>>        dc->props =3D lance_properties;
>>> -    /* Reason: pointer property "dma" */
>>> -    dc->user_creatable =3D false;
>>
>> But we still can not start it with the -device option and set the dma,
>> can we?
>=20
> This is a sysbus device, so you can't. I'll add a commit comment.

Ah OK, understood now.

With comment:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> In theory, link property allows you to pass a QOM path to reference a
> QOM instance from -device.

Just wondering, if we had a "bus_address" property to the abstract=20
SysBus class (and eventually "bus_name" for later) we could create/map
sysbus devices from command line?

>>
>>>    }
>>>
>>>    static const TypeInfo lance_info =3D {
>>> diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
>>> index 4723c30c79..d067d21e2c 100644
>>> --- a/hw/net/pcnet-pci.c
>>> +++ b/hw/net/pcnet-pci.c
>>> @@ -231,7 +231,7 @@ static void pci_pcnet_realize(PCIDevice *pci_dev,=
 Error **errp)
>>>        s->irq =3D pci_allocate_irq(pci_dev);
>>>        s->phys_mem_read =3D pci_physical_memory_read;
>>>        s->phys_mem_write =3D pci_physical_memory_write;
>>> -    s->dma_opaque =3D pci_dev;
>>> +    s->dma_opaque =3D DEVICE(pci_dev);
>>>
>>>        pcnet_common_init(DEVICE(pci_dev), s, &net_pci_pcnet_info);
>>>    }
>>> diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
>>> index 28d19a5c6f..f49b213c57 100644
>>> --- a/hw/net/pcnet.h
>>> +++ b/hw/net/pcnet.h
>>> @@ -50,7 +50,7 @@ struct PCNetState_st {
>>>                             uint8_t *buf, int len, int do_bswap);
>>>        void (*phys_mem_write)(void *dma_opaque, hwaddr addr,
>>>                              uint8_t *buf, int len, int do_bswap);
>>> -    void *dma_opaque;
>>> +    DeviceState *dma_opaque;
>>>        int tx_busy;
>>>        int looptest;
>>>    };
>>>

