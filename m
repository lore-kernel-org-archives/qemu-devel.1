Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D31C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF7120838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJBv/uBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF7120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03E1-0004ak-O3
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j03DJ-00045d-Ph
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j03DI-0006AM-Ms
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:58:29 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j03DI-00069m-GU; Fri, 07 Feb 2020 07:58:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id k29so1232428pfp.13;
 Fri, 07 Feb 2020 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fVJ/lNKCbvS/EN1US49rpyBiCuO505cnmOErQECnowo=;
 b=YJBv/uBEqKXGTA7FSTiB7tl0r3MavseDq820o3j8btnbEGTRydSptXIcgAbGnoBkdR
 +54/UQdLlNc0mPYq1HrZQhA1sJGzdCSIRp0EC2zaJ57SqVThz+6Scc4iTXkEcW7XUl/w
 C2lkVVG/7oDUwCIDsyKZLgGKpWk3j0rp/K/VUOEo87y9PhEqhEy8HIuxr4Fnf7091iPf
 RF+a4N9S9xG2ZDDtPNwSuOIIAaMGsWAFtiZvLUS0nOI8MYJC4sPMIKBj2zWES4LTmz3q
 c5xrx6wtze9qRCsXz0hmfpujsA3GofdYzGeNBKsl3aTO6dpiABwCZnJAX9A/yrlzvREJ
 kYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fVJ/lNKCbvS/EN1US49rpyBiCuO505cnmOErQECnowo=;
 b=SWg+6lstkWYYnLQ2ELiipPwft7aKPRfV4oY9QljCnx5EWQEJk7fNoHX6T7P0nRcOVI
 rA/0i4qFn0wa3q5vN3jBkwxnix7ZBlLJFrQs9WufhQ5V1CKRt643Kr5wM04ZDWHOA1GT
 5z77QskLfl5CBpaa98KWWK5Y3PCnyjGpJMOzZYucxoj8W5hiWUAaqnvEJOefiDIT3po1
 bKvI25A6cXpJqkAJ6jrMeRbKLsYBjZSNs+6b57sEmMF25jmVArHIifVZFUcBXyqwBud7
 q1gmdZc5rwDoXHq6V2U6eqF5b/5Z6RC2hXdqvu1dpCGzUSo/YEAYtIrXyxZ/IeX01/LP
 jAHg==
X-Gm-Message-State: APjAAAV7fI6GWFFeTgqdvYn5GbuEegeVmEoL9j4nmhOXYvoeYq3uQXuc
 agZkcmYnpqabq/2UUW+v/xYhRzfx
X-Google-Smtp-Source: APXvYqyQHmkBSmzAiLhbntvyEZHf3rXRyACHAbvp8qK6iXzI2FJGgwD/AadyZAA654TEZNrugaUVWg==
X-Received: by 2002:aa7:9e0b:: with SMTP id y11mr10249439pfq.182.1581080306998; 
 Fri, 07 Feb 2020 04:58:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 r66sm3295375pfc.74.2020.02.07.04.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 04:58:26 -0800 (PST)
Subject: Re: [PATCH] hw/arm: ast2400/ast2500: Wire up EHCI controllers
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20200206183437.3979-1-linux@roeck-us.net>
 <e9f490fe-34d3-6830-832c-155f6fa63482@kaod.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1605922b-2aa0-dd8e-720a-031e74bc9872@roeck-us.net>
Date: Fri, 7 Feb 2020 04:58:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e9f490fe-34d3-6830-832c-155f6fa63482@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 12:16 AM, Cédric Le Goater wrote:
> On 2/6/20 7:34 PM, Guenter Roeck wrote:
>> Initialize EHCI controllers on AST2400 and AST2500 using the existing
>> TYPE_PLATFORM_EHCI. After this change, booting ast2500-evb into Linux
>> successfully instantiates a USB interface.
>>
>> ehci-platform 1e6a3000.usb: EHCI Host Controller
>> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
>> ehci-platform 1e6a3000.usb: irq 21, io mem 0x1e6a3000
>> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
>> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.05
>> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> usb usb1: Product: EHCI Host Controller
> 
> Cool. Have you tried to plug any devices ?
> 

Yes, booting from USB drive works just fine. I already added it to my
test suite at kerneltests.org.

>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> 
> This looks good. Could you add the AST2600 also ?
> 

I thought about that, but how would I test it ? None of the ast2600
systems in the Linux kernel enables it. The devicetree include file for
ast2600 doesn't even have an entry for it. I could cook something up,
but that would not reflect real hardware.

Thanks,
Guenter

