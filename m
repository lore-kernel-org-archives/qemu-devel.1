Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E875C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA249206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA249206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8u4-0003W3-MP
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic3uI-0002vX-71
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic3uD-0007R4-Fc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:51:39 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:44122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Harish_Kandiga@mentor.com>)
 id 1ic3uD-0007H2-5Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:51:37 -0500
IronPort-SDR: t0BeAo8JjLRuoJpZZgLEZSXTPdSQIBDeUwk+NlEnAQYaY/dCcLVHLQO0E51/DIeAn91+p+Ewf3
 c33baJUCQJZrsrMsBajY3VV/aGCilygQpBS64sUpRngMviAIXkERrqYTl0k6H1VxMzEmlMB5Xl
 lr/5oap7UiuGjkKm+a0QzrzVeVb/5aDarjdH/YPIKrXb3Y+6uGrTgRoVgM4CHBs950G/Fpb33p
 RBCiyVJF4UMQVFaG5mHjHoX0DoCO8ruWiHEXBF/kaAPFF9rptEbQLEIet7t6ukipGMBC6Xnbe0
 uw4=
X-IronPort-AV: E=Sophos;i="5.69,272,1571731200"; d="scan'208";a="43651534"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 03 Dec 2019 00:51:33 -0800
IronPort-SDR: V31aPAlTL4Jd77N/4vFkI/ULg0cF5PBYkzlUKlSwB5TqW2oengXeZXGIIUezjAPeS45uGXetRj
 k8fdcbh6lAth0z2rEc/o8A8Yjx1Gs9FJcj8ClHn/v7e9trEbTEqyktunDgxc+NGMNzDE3uUt+H
 tVPkPMHeGKWmqIn4OYYFVSQrHux/WyXhsdu22AjmEmoi5aXIBAP1OBiJIM2OD+5+c39ZCXjbpa
 5nlSWx1IxowCPCDsJce0jzoNxMJv4XdCFGcMxbpF2S+x4ddCnnoky/Je4mZZIOCotBY7rKE4oJ
 6+w=
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <585c4ad9-31fc-e87e-07c4-b8d6aa09c7e4@mentor.com>
 <CAMuHMdW-n8ao7t7156WYxRg7v8+ojXsRgHGUOax=9nBo2F5xOw@mail.gmail.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <d44598a5-184e-078c-1d6c-a99b522f7e26@mentor.com>
Date: Tue, 3 Dec 2019 14:21:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW-n8ao7t7156WYxRg7v8+ojXsRgHGUOax=9nBo2F5xOw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.98
X-Mailman-Approved-At: Tue, 03 Dec 2019 09:05:26 -0500
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
 TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>, "open
 list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 03/12/19 1:47 PM, Geert Uytterhoeven wrote:
> Hi Harish,
>
> On Tue, Dec 3, 2019 at 6:42 AM Harish Jenny K N
> <harish_kandiga@mentor.com> wrote:
>>> +static int gpio_aggregator_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct gpio_desc **descs;
>>> +     struct gpiochip_fwd *fwd;
>>> +     int i, n;
>>> +
>>> +     n = gpiod_count(dev, NULL);
>>> +     if (n < 0)
>>> +             return n;
>>> +
>>> +     descs = devm_kmalloc_array(dev, n, sizeof(*descs), GFP_KERNEL);
>>> +     if (!descs)
>>> +             return -ENOMEM;
>>> +
>>> +     for (i = 0; i < n; i++) {
>>> +             descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
>> can you please add this check as well as we need to return EPROBE_DEFER.
>>
>> if (desc[i] == ERR_PTR(-ENOENT))
>> <                 return -EPROBE_DEFER;
> So gpiod_get_index() nevers return -EPROBE_DEFER, but returns -ENOENT
> instead?
> How can a driver distinguish between "GPIO not found" and "gpiochip driver
> not yet initialized"?
> Worse, so the *_optional() variants will return NULL in both cases, too, so
> the caller will always fall back to optional GPIO not present?
>
> Or am I missing something?
>
> Gr{oetje,eeting}s,
>
>                         Geert


We had earlier tested our changes on 4.14 kernel and the explicit return of -EPROBE_DEFER was needed in the inverter driver.

probably the commit 6662ae6af82df10259a70c7569b4c12ea7f3ba93 ( gpiolib: Keep returning EPROBE_DEFER when we should)

has fixed the issue and now it returns -EPROBE_DEFER.  you can ignore this comment as of now. I will test and let you know if needed.


Thanks,

Harish


