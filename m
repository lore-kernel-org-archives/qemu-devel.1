Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912EC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151F0206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcGXUHaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151F0206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3xJ-0007NP-A9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:35:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hi3E3-0001iD-4C
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hi3Dz-0001X1-4V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hi3Dx-0001UM-AA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so916833wma.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PQtdfdvjDNjyZMyzq32TniWt5+kWl9txn0BgJz7FBho=;
 b=LcGXUHaT7WcE1TkeiDNQROyg8EsfrOfJ8CIAFfrXRhlwP0sYijw94zR/uWgcBk0mo1
 ma54TW7I3CmtmFZACgH3VdltoWc82EDYo92PzUY9CpwIoYwntZk518cgcs/guc2G61jl
 TZoKOOOOPbyjJ3r/2sgGR9vRgfLvn54+aAb8PZrRGULtqlk9HBc/0HHRJqsUhjlHpjgi
 q1bzokRlomvA6Xy2UDaiyurjfEDKgJcnPGx8g9/nmBZ6xZAJU/h61MZ7ANs6HzSEwAfA
 KlvfmjhGlNh0wRplC5BUU6uQTPoQMHQk5OnDNWhLB7zue4dcxuNIC0WDQOqhAy59AuhS
 /sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PQtdfdvjDNjyZMyzq32TniWt5+kWl9txn0BgJz7FBho=;
 b=oi/37KiAqR2w1MNMVyBvgJE4W2p/vBbCW9GO5ZrX3vBuPJmbKHhKqHKvSad//EYbgZ
 G8A/QKE2J0fEW4bQTNiiQv9nBMv8oS+Adotkai2mk1CryGS/6e+xQ4EaMNEYShQwtXiA
 TcaxW6sBlbDnPltfgjAoeVNWuerEEXZ4WvW4IP9U+dsK+bXAUvQekmd6Wb7Uz87WNAle
 ENccrd0+ag7+/kCFCEmMpWg5JdE6oeaF0/yW2x0qLcZcAO4q62caxHTT4INobK0V0oIW
 ieilQb5e7JnV8b1QBfjnZrOoaA+Oc4MaCbSyYzmRtNguUymntiTybxK2dwS2SA9oRLMi
 Dodg==
X-Gm-Message-State: APjAAAXqi38nvz8IX9StxFtkZ+NkPfbJUQyFKxFs8ci7WLXsyjeYoVJ7
 To7Qu7FjnoFjH7rJZN1t7+WwoA8x
X-Google-Smtp-Source: APXvYqwA0DwEBidKUV+82bLur2Lj+JlmLUF4QBI8uRlJ9XaREK+twVTQLJ2hZCxPXG62hnui60uzfQ==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr262229wmc.33.1562003161729;
 Mon, 01 Jul 2019 10:46:01 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id g10sm9918607wrw.60.2019.07.01.10.45.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 10:46:00 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <CAL1e-=iLAKe+FunE2p9L3Ds8fPS2a8nf3hc=ga7CX6E2bjw0Uw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <8ad999d7-fec4-079f-dbed-454afe127899@amsat.org>
Date: Mon, 1 Jul 2019 19:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iLAKe+FunE2p9L3Ds8fPS2a8nf3hc=ga7CX6E2bjw0Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/1/19 7:16 PM, Aleksandar Markovic wrote:
> 
> On Jun 25, 2019 12:31 AM, "Philippe Mathieu-Daudé" <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
>>
>> Hi,
>>
>> This series clean the gt64120 device.
>> It is no more target-dependent, and tracing is improved.
>>
> 
> If nobody objects, I am going to select majority of the patches for mips
> queue scheduled tomorrow. Those that remain will be those that Philippe
> still didn't make his mind.

Which ones remain?

For "pci-host/gt64120: Clean the decoded address space", I'd like a
review from someone comfortable with MEMTXATTRS and address spaces.
I'll ping on the patch.

> Thanks thousand times, Philippe!
> 
> Aleksandar
> 
>> Regards,
>>
>> Phil.
>>
>> Based-on: 20190624220056.25861-1-f4bug@amsat.org
> <mailto:20190624220056.25861-1-f4bug@amsat.org>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05304.html
>>
>> Philippe Mathieu-Daudé (10):
>>   hw/mips/gt64xxx_pci: Fix multiline comment syntax
>>   hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues
>>   hw/mips/gt64xxx_pci: Fix 'braces' coding style issues
>>   hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues
>>   hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()
>>   hw/mips/gt64xxx_pci: Convert debug printf()s to trace events
>>   hw/mips/gt64xxx_pci: Align the pci0-mem size
>>   hw/mips/gt64xxx_pci: Add a 'cpu_big_endian' qdev property
>>   hw/mips/gt64xxx_pci: Move it to hw/pci-host/
>>   hw/pci-host/gt64120: Clean the decoded address space
>>
>>  Makefile.objs                                 |   1 +
>>  include/hw/mips/mips.h                        |   2 +-
>>  hw/mips/mips_malta.c                          |   8 +-
>>  hw/{mips/gt64xxx_pci.c => pci-host/gt64120.c} | 542 ++++++++++--------
>>  MAINTAINERS                                   |   2 +-
>>  hw/mips/Makefile.objs                         |   2 +-
>>  hw/mips/trace-events                          |   0
>>  hw/pci-host/Makefile.objs                     |   2 +-
>>  hw/pci-host/trace-events                      |   5 +
>>  9 files changed, 307 insertions(+), 257 deletions(-)
>>  rename hw/{mips/gt64xxx_pci.c => pci-host/gt64120.c} (68%)
>>  create mode 100644 hw/mips/trace-events
>>
>> --
>> 2.19.1
>>
>>
> 

