Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBFC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C18E20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkFd2gkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C18E20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04Wg-0001zN-Ia
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j04Vo-0000S9-NH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j04Vn-0005YD-Bc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:21:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j04Vn-0005Ws-63; Fri, 07 Feb 2020 09:21:39 -0500
Received: by mail-pf1-x442.google.com with SMTP id y73so1373599pfg.2;
 Fri, 07 Feb 2020 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MXTE7+VG/fuavlzhWWW8cwSsMcmiVYN8chLv/BbuYRQ=;
 b=kkFd2gkKjMscBWiifoMvICLDUUe0b+TXzqK+vYbSmMVeVdAd7WQ3ZOfVDQ+aRJUN/v
 NA80XNatBQay2t+1im7LqUcoVG+di1lnczx2reer3aNmTDzEvQ7GJQHwHa3hj3GF0Zrg
 OyYRvWtgFmRiMIKOc4pnzYa+vSXF6Q17ZCzuX+6RPkMqWP/69WmkRPMbycNKiC06baau
 NvvFLr5GBP3p7Tz1Q6ttKO6MXCZDunTnKi/OH152+Vv3hnyBiieioanNaQdqPr5Xk5+x
 iWBxhAeAzxQhBc2sVeLC+X0LAl0rEO67DCY2zHZxUAOUuiQuRBvykAUhzH434NNckwgx
 MDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MXTE7+VG/fuavlzhWWW8cwSsMcmiVYN8chLv/BbuYRQ=;
 b=bLBotZrVNG6/XpcdFDIkeK/v92glaQI210lDuVMhoH2uScDlZUtCecc8L4kuzihCMA
 ZxMb8Mya6US9F/vroa1/QeQ+hfF0hRxCXL9KTCYxASPiwAFyn2jwzmypLdck00GK56en
 cgToOBY3R0QU/xUNSYrLROu+sQBofs2PkDH9vw8rDt9VPTgBAJDIBKLYnvNcfWQ+kqMx
 nw5zaYdvi/yhDlKlQ8J4LJg/TIV90iszrWV4LR+cYRIthT3cgy1rfhXvJpvPPvlxwDmf
 Xh8O0/hO0rHu2cbg3r3FMq/2C5kN6dfqJGyTAOoO/866GDudMyAbqsREVdehnGKyuk1H
 jnZw==
X-Gm-Message-State: APjAAAXUy1/RVEJmb0NEHzoDz+1FWhH5ABfpHQhzM5KnwVXjdTxEwtfy
 beKcWhP0GGYT7Qolr1lh0M8SBEWd
X-Google-Smtp-Source: APXvYqz4If7rG4zHDO6LToOOKrOIwikXyNY8VeRMOjA3rT618aIjtTh3tuw37+JKBX/WnGBOwXogVw==
X-Received: by 2002:a63:a541:: with SMTP id r1mr9753236pgu.118.1581085294415; 
 Fri, 07 Feb 2020 06:21:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 e19sm3174475pgn.86.2020.02.07.06.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:21:33 -0800 (PST)
Subject: Re: [PATCH] hw/arm: ast2400/ast2500: Wire up EHCI controllers
To: Joel Stanley <joel@jms.id.au>
References: <20200206183437.3979-1-linux@roeck-us.net>
 <e9f490fe-34d3-6830-832c-155f6fa63482@kaod.org>
 <1605922b-2aa0-dd8e-720a-031e74bc9872@roeck-us.net>
 <CACPK8XdADQwGnsX=YR0n_zm_WMv532bAmR3O-CfyJ23ytT9bpA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ebcfceea-2f70-7e88-0996-b072ec81f59e@roeck-us.net>
Date: Fri, 7 Feb 2020 06:21:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACPK8XdADQwGnsX=YR0n_zm_WMv532bAmR3O-CfyJ23ytT9bpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 5:09 AM, Joel Stanley wrote:
> On Fri, 7 Feb 2020 at 12:58, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/7/20 12:16 AM, Cédric Le Goater wrote:
>>> On 2/6/20 7:34 PM, Guenter Roeck wrote:
>>>> Initialize EHCI controllers on AST2400 and AST2500 using the existing
>>>> TYPE_PLATFORM_EHCI. After this change, booting ast2500-evb into Linux
>>>> successfully instantiates a USB interface.
>>>>
>>>> ehci-platform 1e6a3000.usb: EHCI Host Controller
>>>> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
>>>> ehci-platform 1e6a3000.usb: irq 21, io mem 0x1e6a3000
>>>> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
>>>> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.05
>>>> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>>>> usb usb1: Product: EHCI Host Controller
>>>
>>> Cool. Have you tried to plug any devices ?
>>>
>>
>> Yes, booting from USB drive works just fine. I already added it to my
>> test suite at kerneltests.org.
> 
> Nice!
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
>>> This looks good. Could you add the AST2600 also ?
>>>
>>
>> I thought about that, but how would I test it ? None of the ast2600
>> systems in the Linux kernel enables it. The devicetree include file for
>> ast2600 doesn't even have an entry for it. I could cook something up,
>> but that would not reflect real hardware.
> 
> FYI, there are patches on the linux-aspeed list to enable USB:
> 
>   https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=156260
> 
> They have not yet been merged into the kernel, but I will merge the
> device tree changes once -rc1 is out.
> 

Excellent. With the above series, and after enabling ehci1 for ast2600-evb
and adding the necessary code to qemu, I get

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ehci-platform 1e6a3000.usb: EHCI Host Controller
ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd

and I can mount a USB drive. Is that good enough for a follow-up patch,
or should I wait until the code finds its way into the Linux kernel ?

Thanks,
Guenter

