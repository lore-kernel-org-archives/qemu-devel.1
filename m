Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA194C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B782064A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B782064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEWr-00054E-SW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiEV2-0003ip-BX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiEV1-0007bJ-9J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:50:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiEV1-0007aj-1n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:50:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so26165wms.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 01:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qAHmK64sjDnJAyB0MTcMKo9E0QNitVqtRSZGgzaJ9LI=;
 b=CR2f9QlSs+kjthVnBBdzvJ7fw32uwpWAMcxnECPf8hUxGjscMrjWkEvNWbUAKg5tqX
 IG3Ijx3ARq3YnD7SUh8WuT8sJm43VMRQajzQ2Scq8jfjaODRvFvlG2Mz8vRIyM581l0w
 LBataVOsCYUE2wgoM+XNriD6e/XHeDizP3jGCgl6oA1AOd0HiFJy4EV4YJ2pxhR/+zLR
 PltRRQhQ+aIl+uKPanYD7S6UnnZ3DNLx00J3Gs58abmWE3sqEzoZPcXnYoLSNQukpDRj
 ejUrj2cpFwD1PcQ/nXEOoiXZPAWW1TsIjLssS5suBcoVdFFrjyXs0sEEUrv6Sbjg8AlN
 GiOg==
X-Gm-Message-State: APjAAAURYgzblnj8Lvm74/HblzjchNqTUlGvWGhcHar9nJsdFLxKN858
 xa0AjmFZl/4Dd0lUItwuXw7l6g==
X-Google-Smtp-Source: APXvYqxkrg+rbLa5J/aXsZ9ycZ3hH5Z8LGmsPeDrz9SkCdkddcpc81pl0WTfZ36j3FyB/YhOz6feWg==
X-Received: by 2002:a1c:b146:: with SMTP id a67mr2537061wmf.124.1562057449977; 
 Tue, 02 Jul 2019 01:50:49 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id w6sm11526129wrp.67.2019.07.02.01.50.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 01:50:49 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <CAL1e-=iLAKe+FunE2p9L3Ds8fPS2a8nf3hc=ga7CX6E2bjw0Uw@mail.gmail.com>
 <8ad999d7-fec4-079f-dbed-454afe127899@amsat.org>
 <CAL1e-=h1=rNGC5quvmaOuNohXO60b=tiFEznMr11a3Asj9zgMg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <41890c19-53cf-93c1-ce77-af55d404e6db@redhat.com>
Date: Tue, 2 Jul 2019 10:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h1=rNGC5quvmaOuNohXO60b=tiFEznMr11a3Asj9zgMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 00/10] hw/pci-host: Clean the GT64120 north
 bridge
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 8:39 PM, Aleksandar Markovic wrote:
> On Jul 1, 2019 7:46 PM, "Philippe Mathieu-Daudé" <f4bug@amsat.org> wrote:
>>
>> Hi Aleksandar,
>>
>> On 7/1/19 7:16 PM, Aleksandar Markovic wrote:
>>>
>>> On Jun 25, 2019 12:31 AM, "Philippe Mathieu-Daudé" <f4bug@amsat.org
>>> <mailto:f4bug@amsat.org>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> This series clean the gt64120 device.
>>>> It is no more target-dependent, and tracing is improved.
>>>>
>>>
>>> If nobody objects, I am going to select majority of the patches for mips
>>> queue scheduled tomorrow. Those that remain will be those that Philippe
>>> still didn't make his mind.
>>
>> Which ones remain?
>>
>> For "pci-host/gt64120: Clean the decoded address space", I'd like a
>> review from someone comfortable with MEMTXATTRS and address spaces.
>> I'll ping on the patch.
>>
> 
> Don't worry, the addres space one was left for later.
> 
> Sorry for confusion, but these patches are already in main tree (this is
> from today):
> 
> Philippe Mathieu-Daudé (7):
> 
> hw/mips/gt64xxx_pci: Fix multiline comment syntax
> 
> hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues
> 
> hw/mips/gt64xxx_pci: Fix 'braces' coding style issues
> 
> hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues
> 
> hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()
> 
> hw/mips/gt64xxx_pci: Convert debug printf()s to trace events
> 
> hw/mips/gt64xxx_pci: Align the pci0-mem size
> 
> Let me know if you want more for tomorrow, otherwise I won't do anything.

Excellent, thank you!

patch #8 "hw/mips/gt64xxx_pci: Add a 'cpu_big_endian' qdev property"
needs R-b (Thomas/Paolo eventually).

patch #9 depends of #8

I pinged Linux kernel people for patch #10.

Regards,

Phil.

> Amicalement,
> Aleksandar

