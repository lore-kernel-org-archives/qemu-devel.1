Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC485C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897C22054F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897C22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43987 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIWI-0005Mu-Pk
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hyIVP-0004ux-D0
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hyIVH-0004lN-TJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:21:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hyIVH-0004l7-N3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:21:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so2726304wrr.5
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 09:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0NnnyLAZl8sqrxHu4b/221KYMc1jXMKtn8iJbHOPjs4=;
 b=CbRrY3abGsIh+TcfwsIPJlgBm0Q4sinD1i9E3wB9dHb7mXIAJIfnTyv+/Kljl4w2RS
 oMWlWzwhMyG+F5rl+kIUEceyqDigx5AxO6Y/PyuONYOBudJmwyZVXrhVxb9J5jhAPJwL
 Hxhm5GgtcLBc016u1RYNBFTGdbH7cckfFKmvVwEj4Jxs0vXHpSArtqya7j+TUk9n0bF7
 OcwKITEl3h7bHiDYhtwnNhmTLQ7csVeb/wJvQRetFmGyICicWbQ2/+7cVY3kpjunI6Q4
 Wm2KmwwGSbok0mZs8DPySqytXYmBtKPmteUUN1HG7k8CHohqsvH2QCsuEy9w544PgvGM
 fc9w==
X-Gm-Message-State: APjAAAXfOtyARbcej7gQgeWc/mtgZwlMQUaCKNQUHhIq5/h18r54yK5G
 wGfNnGp96+wbUaLnQeKd1rRe2g==
X-Google-Smtp-Source: APXvYqxDjCalPqFnWeza9wR4BtPSi9Xqqfhjg4f/c/CIK+SoRJz8EiEUXuZLjNS4qYqugpf3lA+p+w==
X-Received: by 2002:adf:c594:: with SMTP id m20mr6778454wrg.126.1565886090547; 
 Thu, 15 Aug 2019 09:21:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cae:66cd:dd43:92d9?
 ([2001:b07:6468:f312:2cae:66cd:dd43:92d9])
 by smtp.gmail.com with ESMTPSA id i66sm2018975wmg.2.2019.08.15.09.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2019 09:21:30 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, devel@edk2.groups.io,
 "Yao, Jiewen" <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
Date: Thu, 15 Aug 2019 18:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
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

On 15/08/19 17:00, Laszlo Ersek wrote:
> On 08/14/19 16:04, Paolo Bonzini wrote:
>> On 14/08/19 15:20, Yao, Jiewen wrote:
>>>> - Does this part require a new branch somewhere in the OVMF SEC code?
>>>>   How do we determine whether the CPU executing SEC is BSP or
>>>>   hot-plugged AP?
>>> [Jiewen] I think this is blocked from hardware perspective, since the first instruction.
>>> There are some hardware specific registers can be used to determine if the CPU is new added.
>>> I don’t think this must be same as the real hardware.
>>> You are free to invent some registers in device model to be used in OVMF hot plug driver.
>>
>> Yes, this would be a new operation mode for QEMU, that only applies to
>> hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SMI, in
>> fact it doesn't reply to anything at all.
>>
>>>> - How do we tell the hot-plugged AP where to start execution? (I.e. that
>>>>   it should execute code at a particular pflash location.)
>>> [Jiewen] Same real mode reset vector at FFFF:FFF0.
>>
>> You do not need a reset vector or INIT/SIPI/SIPI sequence at all in
>> QEMU.  The AP does not start execution at all when it is unplugged, so
>> no cache-as-RAM etc.
>>
>> We only need to modify QEMU so that hot-plugged APIs do not reply to
>> INIT/SIPI/SMI.
>>
>>> I don’t think there is problem for real hardware, who always has CAR.
>>> Can QEMU provide some CPU specific space, such as MMIO region?
>>
>> Why is a CPU-specific region needed if every other processor is in SMM
>> and thus trusted.
> 
> I was going through the steps Jiewen and Yingwen recommended.
> 
> In step (02), the new CPU is expected to set up RAM access. In step
> (03), the new CPU, executing code from flash, is expected to "send board
> message to tell host CPU (GPIO->SCI) -- I am waiting for hot-add
> message." For that action, the new CPU may need a stack (minimally if we
> want to use C function calls).
> 
> Until step (03), there had been no word about any other (= pre-plugged)
> CPUs (more precisely, Jiewen even confirmed "No impact to other
> processors"), so I didn't assume that other CPUs had entered SMM.
> 
> Paolo, I've attempted to read Jiewen's response, and yours, as carefully
> as I can. I'm still very confused. If you have a better understanding,
> could you please write up the 15-step process from the thread starter
> again, with all QEMU customizations applied? Such as, unnecessary steps
> removed, and platform specifics filled in.

Sure.

(01a) QEMU: create new CPU.  The CPU already exists, but it does not
     start running code until unparked by the CPU hotplug controller.

(01b) QEMU: trigger SCI

(02-03) no equivalent

(04) Host CPU: (OS) execute GPE handler from DSDT

(05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New CPU
     will not enter CPU because SMI is disabled)

(06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
     rebase code.

(07a) Host CPU: (SMM) Write to CPU hotplug controller to enable
     new CPU

(07b) Host CPU: (SMM) Send INIT/SIPI/SIPI to new CPU.

(08a) New CPU: (Low RAM) Enter protected mode.

(08b) New CPU: (Flash) Signals host CPU to proceed and enter cli;hlt loop.

(09) Host CPU: (SMM) Send SMI to the new CPU only.

(10) New CPU: (SMM) Run SMM code at 38000, and rebase SMBASE to
     TSEG.

(11) Host CPU: (SMM) Restore 38000.

(12) Host CPU: (SMM) Update located data structure to add the new CPU
     information. (This step will involve CPU_SERVICE protocol)

(13) New CPU: (Flash) do whatever other initialization is needed

(14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.

(15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in..


In other words, the cache-as-RAM phase of 02-03 is replaced by the
INIT-SIPI-SIPI sequence of 07b-08a-08b.


>> The QEMU DSDT could be modified (when secure boot is in effect) to OUT
>> to 0xB2 when hotplug happens.  It could write a well-known value to
>> 0xB2, to be read by an SMI handler in edk2.
> 
> I dislike involving QEMU's generated DSDT in anything SMM (even
> injecting the SMI), because the AML interpreter runs in the OS.
> 
> If a malicious OS kernel is a bit too enlightened about the DSDT, it
> could willfully diverge from the process that we design. If QEMU
> broadcast the SMI internally, the guest OS could not interfere with that.
> 
> If the purpose of the SMI is specifically to force all CPUs into SMM
> (and thereby force them into trusted state), then the OS would be
> explicitly counter-interested in carrying out the AML operations from
> QEMU's DSDT.

But since the hotplug controller would only be accessible from SMM,
there would be no other way to invoke it than to follow the DSDT's
instruction and write to 0xB2.  FWIW, real hardware also has plenty of
0xB2 writes in the DSDT or in APEI tables (e.g. for persistent store
access).

Paolo

