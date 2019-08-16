Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF21C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8842133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8842133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyWYe-0007eF-S3
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hyWXJ-0006vE-Vy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hyWXH-00047s-2B
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:20:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hyWXG-00047D-Qo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:20:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so564963wru.13
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 00:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vu7zsJGIAIkEevTa7V9vSfl8BKlpIou4VHiXR7sMf/Y=;
 b=kgQr2RQ1DQ4brvRlu/GCKedbvyoqZpvMMOV8Nk3tSfpgvoocn5s5xBKxyJjMp0bCJ8
 2oHBGNJvqtOszsBZCkEOzvm5qbQ00S5np21W1kR3+ExenvHDbF4upzb26REHgRMWwzWp
 K6Del+C8pILWIWPw8/uX+rBkrwI5q+Uq1/URtVWD8ypdVF+5SkKzoPVmCtd44lzLT/j0
 tw7XDxIy6YUkLGNPKIQTI5bJaHXGmY/vFm9iyrCD0VfkcpHFPtdFxg97yk3yiodOj/KV
 q8uxZO15fkYmEYpYP2flBl5BXwBW0L1soYZkd6LgPZICuW513MK1c1ZVA5Ja2MU096Zy
 lBUg==
X-Gm-Message-State: APjAAAXk8TFAJEIYzFuJOdcOn9U6+Mvr4Bs373dw7H8otkhXZA2kdmrn
 w/lK62yoODGvI9RFfZGKKZqdtw==
X-Google-Smtp-Source: APXvYqxf1E8r7aBKpZKcY0Hl7blxs/qU72E+crvocqo1RAGHv9kb7sMM1mhlq3IzHFs0GrNZO0wn2Q==
X-Received: by 2002:adf:8183:: with SMTP id 3mr8913470wra.181.1565940029661;
 Fri, 16 Aug 2019 00:20:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id f134sm4306382wmg.20.2019.08.16.00.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2019 00:20:28 -0700 (PDT)
To: "Yao, Jiewen" <jiewen.yao@intel.com>, Laszlo Ersek <lersek@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
Date: Fri, 16 Aug 2019 09:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/08/19 04:46, Yao, Jiewen wrote:
> Comment below:
> 
> 
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Friday, August 16, 2019 12:21 AM
>> To: Laszlo Ersek <lersek@redhat.com>; devel@edk2.groups.io; Yao, Jiewen
>> <jiewen.yao@intel.com>
>> Cc: edk2-rfc-groups-io <rfc@edk2.groups.io>; qemu devel list
>> <qemu-devel@nongnu.org>; Igor Mammedov <imammedo@redhat.com>;
>> Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
>> <jun.nakajima@intel.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>;
>> Joao Marcal Lemos Martins <joao.m.martins@oracle.com>; Phillip Goerl
>> <phillip.goerl@oracle.com>
>> Subject: Re: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
>>
>> On 15/08/19 17:00, Laszlo Ersek wrote:
>>> On 08/14/19 16:04, Paolo Bonzini wrote:
>>>> On 14/08/19 15:20, Yao, Jiewen wrote:
>>>>>> - Does this part require a new branch somewhere in the OVMF SEC
>> code?
>>>>>>   How do we determine whether the CPU executing SEC is BSP or
>>>>>>   hot-plugged AP?
>>>>> [Jiewen] I think this is blocked from hardware perspective, since the first
>> instruction.
>>>>> There are some hardware specific registers can be used to determine if
>> the CPU is new added.
>>>>> I don’t think this must be same as the real hardware.
>>>>> You are free to invent some registers in device model to be used in
>> OVMF hot plug driver.
>>>>
>>>> Yes, this would be a new operation mode for QEMU, that only applies to
>>>> hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SMI, in
>>>> fact it doesn't reply to anything at all.
>>>>
>>>>>> - How do we tell the hot-plugged AP where to start execution? (I.e.
>> that
>>>>>>   it should execute code at a particular pflash location.)
>>>>> [Jiewen] Same real mode reset vector at FFFF:FFF0.
>>>>
>>>> You do not need a reset vector or INIT/SIPI/SIPI sequence at all in
>>>> QEMU.  The AP does not start execution at all when it is unplugged, so
>>>> no cache-as-RAM etc.
>>>>
>>>> We only need to modify QEMU so that hot-plugged APIs do not reply to
>>>> INIT/SIPI/SMI.
>>>>
>>>>> I don’t think there is problem for real hardware, who always has CAR.
>>>>> Can QEMU provide some CPU specific space, such as MMIO region?
>>>>
>>>> Why is a CPU-specific region needed if every other processor is in SMM
>>>> and thus trusted.
>>>
>>> I was going through the steps Jiewen and Yingwen recommended.
>>>
>>> In step (02), the new CPU is expected to set up RAM access. In step
>>> (03), the new CPU, executing code from flash, is expected to "send board
>>> message to tell host CPU (GPIO->SCI) -- I am waiting for hot-add
>>> message." For that action, the new CPU may need a stack (minimally if we
>>> want to use C function calls).
>>>
>>> Until step (03), there had been no word about any other (= pre-plugged)
>>> CPUs (more precisely, Jiewen even confirmed "No impact to other
>>> processors"), so I didn't assume that other CPUs had entered SMM.
>>>
>>> Paolo, I've attempted to read Jiewen's response, and yours, as carefully
>>> as I can. I'm still very confused. If you have a better understanding,
>>> could you please write up the 15-step process from the thread starter
>>> again, with all QEMU customizations applied? Such as, unnecessary steps
>>> removed, and platform specifics filled in.
>>
>> Sure.
>>
>> (01a) QEMU: create new CPU.  The CPU already exists, but it does not
>>      start running code until unparked by the CPU hotplug controller.
>>
>> (01b) QEMU: trigger SCI
>>
>> (02-03) no equivalent
>>
>> (04) Host CPU: (OS) execute GPE handler from DSDT
>>
>> (05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New CPU
>>      will not enter CPU because SMI is disabled)
>>
>> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>>      rebase code.
>>
>> (07a) Host CPU: (SMM) Write to CPU hotplug controller to enable
>>      new CPU
>>
>> (07b) Host CPU: (SMM) Send INIT/SIPI/SIPI to new CPU.
> [Jiewen] NOTE: INIT/SIPI/SIPI can be sent by a malicious CPU. There is no
> restriction that INIT/SIPI/SIPI can only be sent in SMM.

All of the CPUs are now in SMM, and INIT/SIPI/SIPI will be discarded
before 07a, so this is okay.

However I do see a problem, because a PCI device's DMA could overwrite
0x38000 between (06) and (10) and hijack the code that is executed in
SMM.  How is this avoided on real hardware?  By the time the new CPU
enters SMM, it doesn't run off cache-as-RAM anymore.

Paolo

>> (08a) New CPU: (Low RAM) Enter protected mode.
>
> [Jiewen] NOTE: The new CPU still cannot use any physical memory, because
> the INIT/SIPI/SIPI may be sent by malicious CPU in non-SMM environment.
> 
>> (08b) New CPU: (Flash) Signals host CPU to proceed and enter cli;hlt loop.
>>
>> (09) Host CPU: (SMM) Send SMI to the new CPU only.
>>
>> (10) New CPU: (SMM) Run SMM code at 38000, and rebase SMBASE to
>>      TSEG.
>>
>> (11) Host CPU: (SMM) Restore 38000.
>>
>> (12) Host CPU: (SMM) Update located data structure to add the new CPU
>>      information. (This step will involve CPU_SERVICE protocol)
>>
>> (13) New CPU: (Flash) do whatever other initialization is needed
>>
>> (14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.
>>
>> (15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in..
>>
>>
>> In other words, the cache-as-RAM phase of 02-03 is replaced by the
>> INIT-SIPI-SIPI sequence of 07b-08a-08b.
> [Jiewen] I am OK with this proposal.
> I think the rule is same - the new CPU CANNOT touch any system memory,
> no matter it is from reset-vector or from INIT/SIPI/SIPI.
> Or I would say: if the new CPU want to touch some memory before first SMI, the memory should be
> CPU specific or on the flash.
> 
> 
> 
>>>> The QEMU DSDT could be modified (when secure boot is in effect) to OUT
>>>> to 0xB2 when hotplug happens.  It could write a well-known value to
>>>> 0xB2, to be read by an SMI handler in edk2.
>>>
>>> I dislike involving QEMU's generated DSDT in anything SMM (even
>>> injecting the SMI), because the AML interpreter runs in the OS.
>>>
>>> If a malicious OS kernel is a bit too enlightened about the DSDT, it
>>> could willfully diverge from the process that we design. If QEMU
>>> broadcast the SMI internally, the guest OS could not interfere with that.
>>>
>>> If the purpose of the SMI is specifically to force all CPUs into SMM
>>> (and thereby force them into trusted state), then the OS would be
>>> explicitly counter-interested in carrying out the AML operations from
>>> QEMU's DSDT.
>>
>> But since the hotplug controller would only be accessible from SMM,
>> there would be no other way to invoke it than to follow the DSDT's
>> instruction and write to 0xB2.  FWIW, real hardware also has plenty of
>> 0xB2 writes in the DSDT or in APEI tables (e.g. for persistent store
>> access).
>>
>> Paolo


