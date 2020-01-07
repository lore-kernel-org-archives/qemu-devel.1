Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6AC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6222077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6222077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomGA-0003Pi-Vj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1iol5D-0005h3-Tg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1iol56-000821-JD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:23:27 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:47449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Harish_Kandiga@mentor.com>)
 id 1iol56-0007yf-9S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:23:20 -0500
IronPort-SDR: MsiyhxAUdPwO7UhyXZFP3Ee45MXsFVAM4/TNPRM3s4gBad4PeSCvRCZYpRk8+CRw6/ENl6WJ+x
 ernM25eUFsNwnd+sGYBX3eGKhP7YLt9RQ/IK3i2SLh/HX5qGFPaGVDVCouj4ckWE74pQrERhJ7
 NVA0rhHZjIM6VuvlEUSh7B3U8dxiQZDSv3AxEMd3YkpjhKaoII7mi90IKFSVIbVvdKhkmrzVc0
 aecg3d3uQTARQaNA2ArOjgNVNz2GPzUU+sRHeGCZDzOOVqSeK4u2H7R/eUnCR+sJug5193Dxpq
 m10=
X-IronPort-AV: E=Sophos;i="5.69,405,1571731200"; d="scan'208";a="46529102"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 07 Jan 2020 01:23:12 -0800
IronPort-SDR: tplytpQIcwlbIf6KWtUbVKFft0awdS/aTQTvzBBS5nfk2+yF+nNPt/gKw3Bp71JWpuXBjDgttE
 ou1DhX9GL7maq4Zt5tL3WB5lEug62wNjDQ0Hf5D9pPSCdaw1Y9rbyeUHtGVD2TjUdPc9PBiXKo
 UVxCnDd8dmEOwk2n/far46XKA96RK92eSVdaRRC80sjVtkIX25JWz5QUy8HK2/aVsudoVSRlCF
 kKLKCz+exnrzdiTz5LU5QWud31JtVK56w8RQptKsfehgn286N8ErL2Qu9zAFY69vhCdFJagpm0
 WSE=
Subject: Re: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-5-geert+renesas@glider.be>
 <20191205210653.GA29969@bogus>
 <CAMuHMdXKPC7-XaezodwL1Dhvke6PUVSZEbvN-sm3Uh6T61qbhQ@mail.gmail.com>
 <CAL_JsqJLJPSYroX0mbBUpgWPV0oEvKEUNC-VZt4XFDF8tLuNFA@mail.gmail.com>
 <CAMuHMdXOJSZUDmn8aeTynN0TKCS5hJR+uMSinOmgbmA8YmsQjw@mail.gmail.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <bb5fb539-0d0d-6356-35c2-8ba47cb9fcbf@mentor.com>
Date: Tue, 7 Jan 2020 14:52:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXOJSZUDmn8aeTynN0TKCS5hJR+uMSinOmgbmA8YmsQjw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.129.153
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Alexander Graf <graf@amazon.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 06/01/20 1:42 PM, Geert Uytterhoeven wrote:
> Hi Rob,
>
> On Fri, Dec 6, 2019 at 4:04 PM Rob Herring <robh@kernel.org> wrote:
>> On Fri, Dec 6, 2019 at 3:17 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Thu, Dec 5, 2019 at 10:06 PM Rob Herring <robh@kernel.org> wrote:
>>>> On Wed, Nov 27, 2019 at 09:42:50AM +0100, Geert Uytterhoeven wrote:
>>>>> Add Device Tree bindings for a GPIO repeater, with optional translation
>>>>> of physical signal properties.  This is useful for describing explicitly
>>>>> the presence of e.g. an inverter on a GPIO line, and was inspired by the
>>>>> non-YAML gpio-inverter bindings by Harish Jenny K N
>>>>> <harish_kandiga@mentor.com>[1].
>>>>>
>>>>> Note that this is different from a GPIO Nexus Node[2], which cannot do
>>>>> physical signal property translation.
>>>> It can't? Why not? The point of the passthru mask is to not do
>>>> translation of flags, but without it you are always doing translation of
>>>> cells.
>>> Thanks for pushing me deeper into nexuses!
>>> You're right, you can map from one type to another.
>>> However, you cannot handle the "double inversion" of an ACTIVE_LOW
>>> signal with a physical inverter added:
>>>
>>>         nexus: led-nexus {
>>>                 #gpio-cells = <2>;
>>>                 gpio-map = <0 0 &gpio2 19 GPIO_ACTIVE_LOW>,     // inverted
>>>                            <1 0 &gpio2 20 GPIO_ACTIVE_HIGH>,    // noninverted
>>>                            <2 0 &gpio2 21 GPIO_ACTIVE_LOW>;     // inverted
>>>                 gpio-map-mask = <3 0>;
>>>                 // default gpio-map-pass-thru = <0 0>;
>>>         };
>>>
>>>         leds {
>>>                 compatible = "gpio-leds";
>>>                 led6-inverted {
>>>                         gpios = <&nexus 0 GPIO_ACTIVE_HIGH>;
>>>                 };
>>>                 led7-noninverted {
>>>                         gpios = <&nexus 1 GPIO_ACTIVE_HIGH>;
>>>                 };
>>>                 led8-double-inverted {  // FAILS: still inverted
>>>                         gpios = <&nexus 2 GPIO_ACTIVE_LOW>;
>>>                 };
>>>         };
>>>
>>> It "works" if the last entry in gpio-map is changed to GPIO_ACTIVE_HIGH.
>>> Still, the consumer would see the final translated polarity, and not the
>>> actual one it needs to program the consumer for.
>> I'm not really following. Why isn't a double inversion just the same
>> as no inversion?
> Because the nexus can only mask and/or substitute bits.
> It cannot do a XOR operation on the GPIO flags.
>
>>>>> While an inverter can be described implicitly by exchanging the
>>>>> GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags, this has its limitations.
>>>>> Each GPIO line has only a single GPIO_ACTIVE_* flag, but applies to both
>>>>> th provider and consumer sides:
>>>>>   1. The GPIO provider (controller) looks at the flags to know the
>>>>>      polarity, so it can translate between logical (active/not active)
>>>>>      and physical (high/low) signal levels.
>>>>>   2. While the signal polarity is usually fixed on the GPIO consumer
>>>>>      side (e.g. an LED is tied to either the supply voltage or GND),
>>>>>      it may be configurable on some devices, and both sides need to
>>>>>      agree.  Hence the GPIO_ACTIVE_* flag as seen by the consumer must
>>>>>      match the actual polarity.
>>>>>      There exists a similar issue with interrupt flags, where both the
>>>>>      interrupt controller and the device generating the interrupt need
>>>>>      to agree, which breaks in the presence of a physical inverter not
>>>>>      described in DT (see e.g. [3]).
>>>> Adding an inverted flag as I've suggested would also solve this issue.
>>> As per your suggestion in "Re: [PATCH V4 2/2] gpio: inverter: document
>>> the inverter bindings"?
>>> https://lore.kernel.org/linux-devicetree/CAL_JsqLp___2O-naU+2PPQy0QmJX6+aN3hByz-OB9+qFvWgN9Q@mail.gmail.com/
>>>
>>> Oh, now I understand. I was misguided by Harish' interpretation
>>> https://lore.kernel.org/linux-devicetree/dde73334-a26d-b53f-6b97-4101c1cdc185@mentor.com/
>>> which assumed an "inverted" property, e.g.
>>>
>>>     inverted = /bits/ 8 <0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0>;
>>>
>>> But you actually meant a new GPIO_INVERTED flag, to be ORed into the 2nd
>>> cell of a GPIO specifier? I.e. add to include/dt-bindings/gpio/gpio.h"
>>>
>>>     /* Bit 6 expresses the presence of a physical inverter */
>>>     #define GPIO_INVERTED 64
>> Exactly.
> OK, makes sense.


The reason I went for "inverted" property is because, we can specify this for gpios at provider side.

The usecase needed to define the polarity which did not have kernel space consumer driver.


I am not sure how do we achieve this using GPIO_INVERTED flag. We need some sort of node/gpio-hog to specify these

type of properties? Otherwise gpio-pin will be held by kernel or the module using the hog property and the user space application will not be able to access pin.


or please let me know if I am missing something.


>
>>> We need to be very careful in defining to which side the GPIO_ACTIVE_*
>>> applies to (consumer?), and which side the GPIO_INVERTED flag (provider?).
>>> Still, this doesn't help if e.g. a FET is used instead of a push-pull
>>> inverter, as the former needs translation of other flags (which the
>>> nexus can do, the caveats above still applies, though).
>> Yes. Historically the cells values are meaningful to the provider and
>> opaque to the consumer. Standardized cell values changes that
>> somewhat. I think we want the active flag to be from the provider's
>> prospective because the provider always needs to know. The consumer
>> often doesn't need to know. That also means things work without the
>> GPIO_INVERTED flag if the consumer doesn't care which is what we have
>> today already and we can't go back in time.
>>

Things will work without GPIO_INVERTED flag for consumers which can specify GPIO_ACTIVE_* flags.



>>> Same for adding IRQ_TYPE_INVERTED.
>> I suppose so, yes.
>>
>>> Related issue: how to handle physical inverters on SPI chip select lines,
>>> if the SPI slave can be configured for both polarities?
>> Good question. Perhaps in a different way because we have to handle
>> both h/w controlled and gpio chip selects.
>>
>> However, how would one configure the polarity in the device in the
>> first place? You have to assert the CS first to give a command to
>> reprogram it.
> That's indeed true for a simple SPI slave.
> But if it is a smarter device (e.g. a generic micro controller), it may use the
> system's DTB to configure itself.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

