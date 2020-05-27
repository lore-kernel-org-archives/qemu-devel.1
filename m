Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C34C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10945207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMPgCDht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10945207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduBe-000159-5l
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jduAa-0007l0-Eg
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:24:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jduAY-0006PU-Dd
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590578660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wXK5keqVzLVKsV98Q1CIzeEZ1VY8hzdxiB1xh8Y7CJk=;
 b=QMPgCDhtvZMgVQds91c7PTjeMERtde+nql1IK/3QEQCyOjdH0wTwwl+fFskvTAdx35Ddk8
 lbsnbhLWgkHnfbBqct1J8W5MjFkRjff9J5uVCgZwRZpwoZ4yFXMEW0/7i3P35awzsULCYf
 lRaRk0eqTgM2icw2opB35fbkmuHC86Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-a-8-YYoxM3O4dK7ogL-Kow-1; Wed, 27 May 2020 07:24:19 -0400
X-MC-Unique: a-8-YYoxM3O4dK7ogL-Kow-1
Received: by mail-ej1-f72.google.com with SMTP id s13so8721286ejc.18
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 04:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wXK5keqVzLVKsV98Q1CIzeEZ1VY8hzdxiB1xh8Y7CJk=;
 b=dITfh+EJeuxCZ6+oQ1wHpBebreRVtIKr/IS8YaAnFxDEJMBLlsPtIAaWeKA+oRMZn/
 3sPEIhDRAs+8nhBhKihi31Z+5CjEElzSqhW3h2qFXnhGeoLYhP7dS7vXRQOOBpB5G9eT
 dVAJ75C1tdG0q9WI+a1TFvaOIOTeZ8bR8DI2kup31Z3ygFRzKMTGs9MAZrNHmDmLT9Qq
 U6BophoCG7Zh8Kn9NoqtTpPVyRk6P39T/yM3lO+JhU+iCb495QPQ7XCxlw+3yNLll0MA
 0Rbqh+/G/p60CbcQIPHETnNm0CF/MeHrodIQYFydK9NwpJ8vi5/1vLZhSQR5Izo/h1ks
 Yz4g==
X-Gm-Message-State: AOAM530/AIhzl29gxbCaQTNtZRl5YeVl/N9GyBWNyphPrGHORSDNr9Pq
 aN36mvYPcdZCNpWJT+NEh7n2EpjG1lc9O/KRDNf4Za8MOslfVc6MGFL7jsQ3/SUT43MMl1w8CVk
 UtCYEYLltUCXE9i8=
X-Received: by 2002:a50:fb1a:: with SMTP id d26mr23569716edq.83.1590578657947; 
 Wed, 27 May 2020 04:24:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsN/f0jKHlkQjBBGv+JXJ7+k1EPDuYrCDuJGndLdPsnIEvEm7g49vyOWbb3ISI499D3eYFDA==
X-Received: by 2002:a50:fb1a:: with SMTP id d26mr23569688edq.83.1590578657522; 
 Wed, 27 May 2020 04:24:17 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o21sm2487237ejb.31.2020.05.27.04.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 04:24:17 -0700 (PDT)
Subject: Re: [PATCH 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
To: Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair23@gmail.com>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-2-armbru@redhat.com>
 <CAKmqyKOun2FyT+JR8cyrP9eQn9xFDAppFb4W12ym-TPGt9h7Hg@mail.gmail.com>
 <87d0707bri.fsf@dusky.pond.sub.org>
 <CAKmqyKM3oOLfAxupqfabrj_epQCCE_YbwnkU4cRd5mtg8+7_yg@mail.gmail.com>
 <87blm9ralp.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <4d5649f0-df3c-d075-5c82-c80ecde08f95@redhat.com>
Date: Wed, 27 May 2020 13:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87blm9ralp.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 11:27 AM, Markus Armbruster wrote:
> Alistair Francis <alistair23@gmail.com> writes:
> 
>> On Mon, May 18, 2020 at 10:08 PM Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Alistair Francis <alistair23@gmail.com> writes:
>>>
>>>> On Sun, May 17, 2020 at 10:06 PM Markus Armbruster <armbru@redhat.com> wrote:
>>>>>
>>>>> stm32f405_soc_initfn() creates six such devices, but
>>>>> stm32f405_soc_realize() realizes only one.  Affects machine
>>>>> netduinoplus2.
>>>>>
>>>>> I wonder how this ever worked.  If the "device becomes real only on
>>>>> realize" thing actually works, then we've always been missing five of
>>>>> six such devices, yet nobody noticed.
>>>>
>>>> I must have just been testing the first ADC.
>>>>
>>>>>
>>>>> Fix stm32f405_soc_realize() to realize all six.  Visible in "info
>>>>> qtree":
>>>>>
>>>>>      bus: main-system-bus
>>>>>        type System
>>>>>        dev: stm32f405-soc, id ""
>>>>>          cpu-type = "cortex-m4-arm-cpu"
>>>>>        dev: stm32f2xx-adc, id ""
>>>>>          gpio-out "sysbus-irq" 1
>>>>>     -    mmio ffffffffffffffff/00000000000000ff
>>>>>     +    mmio 0000000040012000/00000000000000ff
>>>>>        dev: stm32f2xx-adc, id ""
>>>>>          gpio-out "sysbus-irq" 1
>>>>>     -    mmio ffffffffffffffff/00000000000000ff
>>>>>     +    mmio 0000000040012000/00000000000000ff
>>>>>        dev: stm32f2xx-adc, id ""
>>>>>          gpio-out "sysbus-irq" 1
>>>>>     -    mmio ffffffffffffffff/00000000000000ff
>>>>>     +    mmio 0000000040012000/00000000000000ff
>>>>>        dev: stm32f2xx-adc, id ""
>>>>>          gpio-out "sysbus-irq" 1
>>>>>     -    mmio ffffffffffffffff/00000000000000ff
>>>>>     +    mmio 0000000040012000/00000000000000ff
>>>>>        dev: stm32f2xx-adc, id ""
>>>>>          gpio-out "sysbus-irq" 1
>>>>>          mmio 0000000040012000/00000000000000ff
>>>>>        dev: stm32f2xx-adc, id ""
>>>>>          gpio-out "sysbus-irq" 1
>>>>>     -    mmio ffffffffffffffff/00000000000000ff
>>>>>     +    mmio 0000000040012000/00000000000000ff
>>>>>        dev: armv7m, id ""
>>>>>
>>>>> The mmio addresses look suspicious.
>>>>
>>>> Good catch, thanks :)
>>>
>>> I'd love to squash in corrections, but I don't know the correct
>>> addresses.  Can you help?
>>
>> Yep, thanks for squashing it in.
>>
>> The three addresses are:
>>
>> 0x40012000
>> 0x40012100
>> 0x40012200
>>
>> and they all share interrupt number 18.
> 
> An the other three?  There are six devices in total...

Alistair looked at the stm32f205, which has 3 ADCs (and seems correct).

> 
>> Let me know if you want me to do it.

Alistair, the problem is the stm32f405. I guess the bug come from
copy/pasting then modifying for the shared IRQ.

    /* Timer 2 to 5 */
    for (i = 0; i < STM_NUM_TIMERS; i++) {
       ...
    }
    ...
    /* ADC device, the IRQs are ORed together */
    ...
    dev = DEVICE(&(s->adc[i])); <=== i = STM_NUM_TIMERS = 4
    object_property_set_bool(OBJECT(&s->adc[i]),
                             true, "realized", &err);

Only ADC#3 is realized, then mapped at 0x40012000.

You need to unparent the others anyway, so it is easier to realize
adc[0] and unparent the rest:

    for (i = 1; i < STM_NUM_ADCS; i++) {
       ...
    }


