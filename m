Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6844C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B78208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B78208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqmW-0008VM-Le
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsqlc-0007nC-AQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsqla-0005Lk-Im
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:43:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsqlT-00056B-T9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:43:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so70198169wrf.11
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BmtWFEQ71ckZRKFzlwHzJVzOsYbJhCGLypGFKaN+G10=;
 b=kvpg8Q16fW0hwaPHdY73BqCkDXFlp3jXbz2krSt03y7nIm2zAtDVX3riN2vTlj51Nf
 BwA4B/3kwfZ2ClHp+hDnnnAFfFN/fHsasI7BPIxZTjaz9RE+49NKCNxLoZW1Xb8U07Kg
 KZsZUxoo73QnhUn18JboZfV/Rt9PwPjlka8qi2JiHOATZBW4d1ObyVQP0zLn+VGIi5mx
 KVaZFbEUGqI0/ICZBCQiQQQWmYZBsPPE5MBw9/HbyleZU8Dx9F2OYsKcNJhtCjrChafQ
 4kG4b2qoq0gd75yIUpthoGGXxR4ZQMk971EdacTCZqX0QZy44Ew/HE17oqJNetTWLJLd
 1h6g==
X-Gm-Message-State: APjAAAVUUsvmM62VLAJICpUJpwyB1yGWC15gzhLE6RbyMqmii0Kw0hTr
 p2xZ+OjAyB1aUW7lJrZjZxNSsg==
X-Google-Smtp-Source: APXvYqxF8F55/T+H30x82b0Kp7oR5Ld8A0a9J64aXgcjfj2cVZkWemdWSRfL0NS6uITR/4Zi1k+OJQ==
X-Received: by 2002:a5d:6389:: with SMTP id p9mr110195451wru.297.1564587815967; 
 Wed, 31 Jul 2019 08:43:35 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id b15sm84899155wrt.77.2019.07.31.08.43.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 08:43:35 -0700 (PDT)
To: Damien Hedde <damien.hedde@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e979936e-3545-87fb-eec6-e3a098785113@redhat.com>
Date: Wed, 31 Jul 2019 17:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] RFC raspberry pi sd-card reset
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 f4bug@amsat.org, Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 4:21 PM, Damien Hedde wrote:
> Hi,
> 
> Concerning the reset on the raspi2/3 machine, I ran into an issue with
> the sd-card.
> 
> Here follows a subset of the qbus/qdev tree of the raspi2&3 machine as
> it is initialized:
>  + System
>    * bcm2835_gpio
>      + sd-bus
>        * sd-card
>    * bcm2835-sdhost
>      + bcm2835-sdhost-bus
>    * generic-sdhci
>      + sdhci-bus
> 
> raspi_init does 2 things:
>  + it creates the soc
>  + then it explicitly creates the sd-card on the bcm2835_gpio's sd-bus
> 
> As it happens, the reset moves the sd-card on another bus: the
> sdhci-bus. More precisely the bcm2835_gpio reset method does it (the
> sd-card can be mapped on bcm2835-sdhost-bus or sdhci-bus depending on
> bcm2835_gpio registers, reset configuration corresponds to the sdhci-bus).
> 
> Reset call order is the following (it follows children-before-parent order):
>  1 sd-card
>  2 sd-bus
>  3 bcm2835_gpio -> move the sd-card
>  4 bcm2835-sdhost-bus
>  5 bcm2835-sdhost
>  6 sd-card  (again)
>  7 sdhci-bus
>  8 generic-sdhci
> 
> In the end, the sd-card is reset twice, which is no big-deal in itself.

The machine cold reset implicitly cold resets the sd-card.

IIRC the sd-bus shouldn't (cold/warm)-reset the sd-card.

Only SDBusClass::set_inserted() can cold-reset the card.

> But it only depends on the bcm2835_gpio tree being reset before the
> generic-sdhci (probably depends on the machine creation code).
> 
> I checked and it seems this is the only platform where such things
> happen during master reset.
> 
> IMO this is a bit hazardous because reset is based on the qdev/qbus
> tree (and with the multi-phase I'm working on, even if it still works,
> it's worse).
> I'm not sure what we should do to avoid this (and if there's is
> something to be done).
> 
> The easiest solution would be to initialize the platform with the
> sd-card at the right initial place (I do not really understand why it is
> created in the bcm2835_gpio in the first place since we move it just
> after). But it won't solve the issue if a reset is done afterwards.
> 
> Or maybe we could move the sd-card on the proper bus in a machine
> reset code so that it's on the right place when we do the sysbus tree
> reset just after.
> 
> What do you think ?

There is only 1 bus, the SDHCI bus lines are muxed with the GPIO ones.

bcm2835-sdhost-bus should not be child of bcm2835-sdhost, the sdbus
might be child of bcm2835-peripherals and shared by both sdhost and gpio
(as a link property?).

I tried to do that 2 years ago. I thought I posted the series and Peter
rejected it but can't find it, maybe we had an IRC chat. I won't have
time until next week to dig for it.

> 
> --
> Damien
> 

