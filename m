Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22031C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB792067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB792067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLDKt-0003Q7-4d
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 16:57:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLDJp-0002ws-9j
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLDJo-0006ks-6L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:56:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLDJo-0006je-09
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:56:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so1058910wml.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BEMr4HbLOWMg3VTbSJU5yEbI0WrJuAavWVGkqW17nUg=;
	b=E9OjAWXw6cTC13G+rJTqeZPC8kKTqIvr895MgVaOMz8p6+mhyQw8NZUypesWdHAjZW
	GCUDpgufPDQynIxn4bfqQ0sVFEieDr0xxgOqQppgcVQuybCcqgifuCzVO1N5G2mSFjnT
	KIZ7iwK9b5WY1q1gwVULug1fxULYn5D09LIvLkmKczYOBSBhJHHs37tw5SBN/4jI+v5r
	pUTG2mSL7VJBOsAZ1hZLxqqa19t/0/Pld6+y6XqFwgRGrpNjhDFTgFBNAdGF/C0bqeaJ
	KaVRz75BtRXatTsMyJXVrWqSzYW0rl5WH+tpV5dPGvsXJc1VBzOgHVRyVRIoodE5VAqG
	lZwA==
X-Gm-Message-State: APjAAAVyHGqThUBNQik4vcSlRCf+720MBfhQzKXTsyP4nxASpdDfJpEo
	/bGMSDdRK32HTb67Hu77Dak5Yw==
X-Google-Smtp-Source: APXvYqwAc+sVcvV6PGUw8hbXANPpp4eRbHm8eX4OBOZuMnhsdt99p0PzvB8x5ZpsmcixN+W+F3K8Ww==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr671049wmh.136.1556571366678;
	Mon, 29 Apr 2019 13:56:06 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r29sm3417914wra.56.2019.04.29.13.56.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 13:56:05 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
	qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-11-thuth@redhat.com>
	<377a2033-504b-a84d-0eb0-765de81af730@redhat.com>
	<fe977ebc-3ec7-fbf5-7a72-c9418286f0f1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d06a1288-277f-050e-e16f-e62b82a284c9@redhat.com>
Date: Mon, 29 Apr 2019 22:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fe977ebc-3ec7-fbf5-7a72-c9418286f0f1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 10/29] hw/arm: Express
 dependencies of stellaris with Kconfig
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429205604.dNqmi-9b_GDw9wEmWlsVu3YnqJ68GzuVHqPXiD9vU2Q@z>

On 4/29/19 9:25 PM, Thomas Huth wrote:
> On 25/04/2019 23.41, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 4/18/19 8:00 PM, Thomas Huth wrote:
>>> This patch is slightly based on earlier work by Ákos Kovács (i.e.
>>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  default-configs/arm-softmmu.mak |  7 +------
>>>  hw/arm/Kconfig                  | 10 ++++++++++
>>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>> index b7ed3c530b..3f82d635e4 100644
>>> --- a/default-configs/arm-softmmu.mak
>>> +++ b/default-configs/arm-softmmu.mak
>>> @@ -16,6 +16,7 @@ CONFIG_MUSCA=y
>>>  CONFIG_CHEETAH=y
>>>  CONFIG_SX1=y
>>>  CONFIG_NSERIES=y
>>> +CONFIG_STELLARIS=y
>>>  
>>>  CONFIG_VGA=y
>>>  CONFIG_NAND=y
>>> @@ -24,16 +25,10 @@ CONFIG_SERIAL=y
>>>  CONFIG_MAX7310=y
>>>  CONFIG_TMP421=y
>>>  CONFIG_PCA9552=y
>>> -CONFIG_STELLARIS=y
>>> -CONFIG_STELLARIS_INPUT=y
>>> -CONFIG_STELLARIS_ENET=y
>>> -CONFIG_SSD0303=y
>>> -CONFIG_SSD0323=y
>>>  CONFIG_DDC=y
>>>  CONFIG_SII9022=y
>>>  CONFIG_ADS7846=y
>>>  CONFIG_MAX111X=y
>>> -CONFIG_SSI_SD=y
>>>  CONFIG_SSI_M25P80=y
>>>  CONFIG_ALLWINNER_EMAC=y
>>>  CONFIG_IMX_FEC=y
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index 71126254ff..b91503f5a6 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -91,6 +91,16 @@ config REALVIEW
>>>  
>>>  config STELLARIS
>>>      bool
>>> +    select ARM_V7M
>>> +    select I2C
>>> +    select PL011 # UART
>>> +    select PL022 # Serial port
>>> +    select PL061 # GPIO
>>> +    select SSD0303 # OLED display
>>> +    select SSD0323 # OLED display
>>> +    select SSI_SD
>>> +    select STELLARIS_INPUT
>>> +    select STELLARIS_ENET # ethernet
>>
>> This one misses CMSDK_APB_WATCHDOG:
>>
>> $ qemu-system-aarch64 -M lm3s811evb
>> qemu-system-aarch64: Unknown device 'luminary-watchdog' for default sysbus
>> Aborted (core dumped)
> 
> Oh, well, looks like this has just been added recently in commit
> 566528f823d1a2e9e, likely after I assembled and tested the initial
> version of this patch...

Ah yes, correct! This happens when we take too long to review a series,
and since this one is huge, I was keeping procrastinating...

> Thanks for catching it, I'll apply your fix in v6!
> 
>  Thomas
> 

