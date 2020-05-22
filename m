Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347B4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144720723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuloy9oC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc4H8-0002lr-6K
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 05:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jc4GX-0002GZ-Qx; Fri, 22 May 2020 05:46:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jc4GW-0007cG-6z; Fri, 22 May 2020 05:46:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so8333978wrw.1;
 Fri, 22 May 2020 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6VOo3zCotFdbpokUud6waYxauSbsgfjI2O3WRMNQCf4=;
 b=Xuloy9oC/oWkTv+u4gJZmV/gkZT1zC8aL3sU0KdIWTzNjQJZnrDW3enPACmVfxygXJ
 +QQdMyowHuWniWviQ7Ix+yKaE5d0LH3fx+p23qK+9arXwvItfV6i+RyZs9H/E02TIB9g
 uMcYiUrOtVaOHzUcfJSFEHHMaraiiA8TCXcgVOW+pam7dNsE3h5EpxYLT4Rn3feyJUdI
 1aM40242ZsJXlB98j+wDxD0wyNMbu+AWbogVIGjM5GLNeB8Ksl4bwJskWY4MUE2wl+5L
 M8KAXDxHB5mAtTfcEAg1ENLUcbBglF4Pi9kgayFwTiF8/fhTTc3g4jutQqvnj7YsnzDU
 MmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6VOo3zCotFdbpokUud6waYxauSbsgfjI2O3WRMNQCf4=;
 b=j1HuERziaULqHxlZzRUYGVmq8xq03YbEOa09A3nl21iEQaOJFPriCi0bikzjlA2gQH
 QgmxDkC5SEWERBE+v47wpw7W8qv7gajaoIpVS1F8pUI6o6PUYQd7ls86NVsUz+rt9Jaf
 oDM5kPGNJEsP9XQeXvPdWC51wKKd8eA7UDnT0aD4VUKLS1lLSvCY7Uje1Z10hkG1XYy9
 OZpI27VRwN8q0EhY9jf+ZO5/x/ULYD3gVuW+PfCrDIYShekWraV2lkUa1+nosu+tBzU4
 N22dWxehmW7oLGNyM50ZQX0/9HHZBWwSXCyG1AgDgfWXMQIg9PrKDV8UOyDWDY8bPv/P
 OrLQ==
X-Gm-Message-State: AOAM531DbJSa1DHG21dGAfeXt57HNdeH1x5OJ7NCN8o6jovG+TxrgmzN
 ZaUaLUOklpf9suiPOm/Q3lIac2ZbWck=
X-Google-Smtp-Source: ABdhPJxInbsuKwk64tC8kByD/HzWPkllOs8Np23AEAtj377E+KCD1wnCMGFz4hnppdYXv0cWgobjvQ==
X-Received: by 2002:adf:f102:: with SMTP id r2mr2602913wro.376.1590140813725; 
 Fri, 22 May 2020 02:46:53 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n7sm9054929wro.94.2020.05.22.02.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 02:46:52 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/virt: Fix PL061 node name and properties
To: Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200519084904.1069-1-geert+renesas@glider.be>
 <CAFEAcA9-wQ72_M+ZY+EbEgw1L9LVchBgpLivexFXVZ3HuCtcZg@mail.gmail.com>
 <CAMuHMdWrTbWTrLvMnX=60F+UqH6DJ9kDU1FZ5TnT2=mbah1yfg@mail.gmail.com>
 <CAFEAcA9TzPcWWiJNTQ=EZzsSVy5qTPz5DXTePGmXWBTxZg7i7w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b14cde5-4e91-2f1a-95cd-13f051b10afa@amsat.org>
Date: Fri, 22 May 2020 11:46:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9TzPcWWiJNTQ=EZzsSVy5qTPz5DXTePGmXWBTxZg7i7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 11:30 AM, Peter Maydell wrote:
> On Fri, 22 May 2020 at 09:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, May 21, 2020 at 6:59 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Tue, 19 May 2020 at 09:49, Geert Uytterhoeven
>>> <geert+renesas@glider.be> wrote:
>>>> Make the created node comply with the PL061 Device Tree bindings:
>>>>    - Use generic node name "gpio" instead of "pl061",
>>>>    - Add missing "#interrupt-cells" and "interrupt-controller"
>>>>      properties.
>>>
[...]
>>> Since the devicetree spec says that the interrupt-controller
>>> property "defines a node as an interrupt controller node"
>>> and a GPIO chip isn't an interrupt controller, this seems
>>> like some kind of error in the dtb binding. Maybe I'm
>>> missing something...
>>
>> PL061 is an interrupt controller, as it can assert its interrupt output
>> based on activity on GPIO input lines.
> 
> By that logic the PL011 UART is an interrupt controller, because
> it can assert its interrupt output based on activity on the serial
> port input lines.

Yes :)

> A GPIO controller is not an interrupt controller inherently.
> Maybe you can use it in a system design as an interrupt
> controller if you want to, and in that system's dtb perhaps
> it would make sense to label it as one, but the virt board's
> PL061 is in no way an interrupt controller -- it's just a GPIO
> controller.
> 
>>> What actually goes wrong if QEMU doesn't specify these
>>> properties?
>>
>> It means that other devices that have their interrupt output connected
>> to a PL061 GPIO input won't work, as their driver in the guest OS cannot
>> find the interrupt.  Note that arm/virt.c currently doesn't instantiate
>> such devices.
> 
> OK. But why would we want to run an interrupt line through the GPIO
> controller when we have a perfectly good interrupt controller in
> the system already?

This is sometimes done on embedded devices when all the INTC lines are 
already wired. You'd use extra lines on free peripherals. Usually the 
peripheral offer a limited GPIO mode as passthru interrupt, else you use 
nasty hacks...

> 
> It might be reasonable to add the properties now to avoid setting
> a bear trap for ourselves in future; on the other hand if running
> interrupt lines through the GPIO controller doesn't work then it
> acts as a nudge to stop people adding devices that are wired
> up in a weird way.
[...]

