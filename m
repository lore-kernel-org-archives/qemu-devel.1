Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2906C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9964C2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9964C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxtuB-0003MN-QL
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hxttX-0002mu-1C
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxttV-0003Ei-Fq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:04:54 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxttV-0003EF-9T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:04:53 -0400
Received: by mail-wr1-f42.google.com with SMTP id y8so5272641wrn.10
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 07:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e5B/QYpBjOvkfg+CHjR5ydDGjq2dCwH9aAtX9XHyZ+Q=;
 b=H7HYSkNkmg7p/W9XwZApjKAO8Qin8o6+goQC30BLLlbCJaBqHHTRVT/c/UT7rKvQDl
 /5Rvw8z9BThq2EaaG8jLCW/aUbv6011iOpZtx3XKpTuLFpkqCZ2vdSvJ2NG/S/DkbXQJ
 oie6cgOUHJNCgXplWIGFOaLNi2r36aiDF5Kyu3Z4WlgrrgRUOkjXZlZFxzdPVKzhY0YJ
 I5Y56Ks7zNbmCC1b3I/apDucJv4Op/UWjht87ZgtJ5LPrj1nx8x+HKoql1uFatgy3jfE
 dk+tMIM5yjs5R/oX8KOZroWqLn2xQA1UTHUHnNRU0+CZu9lpV07dxHThx6WvCZrdyW9x
 Ti2g==
X-Gm-Message-State: APjAAAWpCNMzuGpFSRbx6NblOdiLa32IZtfAG4L0Y4mApl/bnkOJcFfe
 7fpVeIdO5s8blPHM1hcYfra7nQ==
X-Google-Smtp-Source: APXvYqyOfjFFQKQ2/fR0mwqEnYihNDDLJQK/RLFQT6RSfWWcib9QsRw62ay7Qla1KEE1wayk6NLgRg==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr51739845wrn.54.1565791492061; 
 Wed, 14 Aug 2019 07:04:52 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g12sm154134861wrv.9.2019.08.14.07.04.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 07:04:51 -0700 (PDT)
To: "Yao, Jiewen" <jiewen.yao@intel.com>, Laszlo Ersek <lersek@redhat.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
Date: Wed, 14 Aug 2019 16:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.42
Subject: Re: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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

On 14/08/19 15:20, Yao, Jiewen wrote:
>> - Does this part require a new branch somewhere in the OVMF SEC code?
>>   How do we determine whether the CPU executing SEC is BSP or
>>   hot-plugged AP?
> [Jiewen] I think this is blocked from hardware perspective, since the first instruction.
> There are some hardware specific registers can be used to determine if the CPU is new added.
> I don’t think this must be same as the real hardware.
> You are free to invent some registers in device model to be used in OVMF hot plug driver.

Yes, this would be a new operation mode for QEMU, that only applies to
hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SMI, in
fact it doesn't reply to anything at all.

>> - How do we tell the hot-plugged AP where to start execution? (I.e. that
>>   it should execute code at a particular pflash location.)
> [Jiewen] Same real mode reset vector at FFFF:FFF0.

You do not need a reset vector or INIT/SIPI/SIPI sequence at all in
QEMU.  The AP does not start execution at all when it is unplugged, so
no cache-as-RAM etc.

We only need to modify QEMU so that hot-plugged APIs do not reply to
INIT/SIPI/SMI.

> I don’t think there is problem for real hardware, who always has CAR.
> Can QEMU provide some CPU specific space, such as MMIO region?

Why is a CPU-specific region needed if every other processor is in SMM
and thus trusted.

>>   Does CPU hotplug apply only at the socket level? If the CPU is
>>   multi-core, what is responsible for hot-plugging all cores present in
>>   the socket?

I can answer this: the SMM handler would interact with the hotplug
controller in the same way that ACPI DSDT does normally.  This supports
multiple hotplugs already.

Writes to the hotplug controller from outside SMM would be ignored.

>>> (03) New CPU: (Flash) send board message to tell host CPU (GPIO->SCI)
>>>      -- I am waiting for hot-add message.
>>
>> Maybe we can simplify this in QEMU by broadcasting an SMI to existent
>> processors immediately upon plugging the new CPU.

The QEMU DSDT could be modified (when secure boot is in effect) to OUT
to 0xB2 when hotplug happens.  It could write a well-known value to
0xB2, to be read by an SMI handler in edk2.


>>
>>>                                        (NOTE: Host CPU can only
>> send
>>>      instruction in SMM mode. -- The register is SMM only)
>>
>> Sorry, I don't follow -- what register are we talking about here, and
>> why is the BSP needed to send anything at all? What "instruction" do you
>> have in mind?
> [Jiewen] The new CPU does not enable SMI at reset.
> At some point of time later, the CPU need enable SMI, right?
> The "instruction" here means, the host CPUs need tell to CPU to enable SMI.

Right, this would be a write to the CPU hotplug controller

>>> (04) Host CPU: (OS) get message from board that a new CPU is added.
>>>      (GPIO -> SCI)
>>>
>>> (05) Host CPU: (OS) All CPUs enter SMM (SCI->SWSMI) (NOTE: New CPU
>>>      will not enter CPU because SMI is disabled)
>>
>> I don't understand the OS involvement here. But, again, perhaps QEMU can
>> force all existent CPUs into SMM immediately upon adding the new CPU.
> [Jiewen] OS here means the Host CPU running code in OS environment, not in SMM environment.

See above.

>>> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>>>      rebase code.
>>>
>>> (07) Host CPU: (SMM) Send message to New CPU to Enable SMI.
>>
>> Aha, so this is the SMM-only register you mention in step (03). Is the
>> register specified in the Intel SDM?
> [Jiewen] Right. That is the register to let host CPU tell new CPU to enable SMI.
> It is platform specific register. Not defined in SDM.
> You may invent one in device model.

See above.

>>> (10) New CPU: (SMM) Response first SMI at 38000, and rebase SMBASE to
>>>      TSEG.
>>
>> What code does the new CPU execute after it completes step (10)? Does it
>> halt?
>
> [Jiewen] The new CPU exits SMM and return to original place - where it is
> interrupted to enter SMM - running code on the flash.

So in our case we'd need an INIT/SIPI/SIPI sequence between (06) and (07).

>>> (11) Host CPU: (SMM) Restore 38000.
>>
>> These steps (i.e., (06) through (11)) don't appear RAS-specific. The
>> only platform-specific feature seems to be SMI masking register, which
>> could be extracted into a new SmmCpuFeaturesLib API.
>>
>> Thus, would you please consider open sourcing firmware code for steps
>> (06) through (11)?
>>
>> Alternatively -- and in particular because the stack for step (01)
>> concerns me --, we could approach this from a high-level, functional
>> perspective. The states that really matter are the relocated SMBASE for
>> the new CPU, and the state of the full system, right at the end of step
>> (11).
>>
>> When the SMM setup quiesces during normal firmware boot, OVMF could
>> use
>> existent (finalized) SMBASE infomation to *pre-program* some virtual
>> QEMU hardware, with such state that would be expected, as "final" state,
>> of any new hotplugged CPU. Afterwards, if / when the hotplug actually
>> happens, QEMU could blanket-apply this state to the new CPU, and
>> broadcast a hardware SMI to all CPUs except the new one.

I'd rather avoid this and stay as close as possible to real hardware.

Paolo

