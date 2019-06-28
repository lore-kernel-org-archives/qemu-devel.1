Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13260C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AF7205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AF7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrxl-0007Ue-0m
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgrrp-0004l7-4T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgrrm-0006i2-0p
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:28:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgrri-0006X9-BC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:28:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so6550265wrl.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 07:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6VRYjgDAZFMVKHjDQRlqRCAm6isgcbHXT46MfZZapNA=;
 b=KdGVDcK59wU4coAm8m9nlOnx8gS5t7dNKypEd6sdsLEd8Q1ThReKY2RfuQAhr/qltt
 Q+N7Xv6r+FcQR5Q/dZNgTKgNT23JA72BCNMPvdVmkCz40ZFAR9m+rkgJ9nobxzXcLYC0
 buS4HwRykjNm+NHdh3ZI3gN3Wr8IReTSqqhRFIfoIrdv+RGXjP54JkhYskUiABDfSAhI
 TWnebnvh0g6J+m/fB1vbWZmkJBcZmHH9yNQHAcnstRo4sAfYq3I9sjsObLvDJhCyOd6L
 fI1wUXMmySGWx8iYu5sGsY7JKTjr0u+yro8oh0N/Bj/cRCzBh2Pgnh54o63/V4K9AAL8
 Neyw==
X-Gm-Message-State: APjAAAW+mOg1/PfmT5fV5tca7Ai23dSHE506FxZ2aVLdame/2YHjD/qA
 rU6HG1fNjlKT3pvv34AfcqkFtA==
X-Google-Smtp-Source: APXvYqwICuJ/EIR6F0dHcvwgtWIW2ER1lU8B1+ujBc5UoOBvTxYqAB9mF4Yf/5vaeLQohiwsIela2A==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr7745106wrm.174.1561732108161; 
 Fri, 28 Jun 2019 07:28:28 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z19sm2549000wmi.7.2019.06.28.07.28.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 07:28:27 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190312085502.8203-1-david@gibson.dropbear.id.au>
 <20190312085502.8203-13-david@gibson.dropbear.id.au>
 <b693da29-0d2a-e739-17fb-9fd78894fd9e@redhat.com>
 <8416add1-453a-b8f7-5b43-fc31bf8e8fca@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <95942a3b-0202-9a9f-cc71-ec6dfeceff8d@redhat.com>
Date: Fri, 28 Jun 2019 16:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8416add1-453a-b8f7-5b43-fc31bf8e8fca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL 12/62] target/ppc/spapr: Enable mitigations
 by default for pseries-4.0 machine type
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 4:14 PM, Laurent Vivier wrote:
> On 28/06/2019 13:27, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 3/12/19 9:54 AM, David Gibson wrote:
>>> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>>
>>> There are currently 3 mitigations the availability of which is controlled
>>> by the spapr-caps mechanism, cap-cfpc, cap-sbbc, and cap-ibs. Enable these
>>> mitigations by default for the pseries-4.0 machine type.
>>>
>>> By now machine firmware should have been upgraded to allow these
>>> settings.
>>>
>>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>> Message-Id: <20190301044609.9626-3-sjitindarsingh@gmail.com>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  hw/ppc/spapr.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 37fd7a1411..946bbcf9ee 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4307,9 +4307,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>>>      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
>>>      smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
>>> -    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>>> -    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>>> -    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>>> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
>>> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
>>> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
>>>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>> @@ -4389,6 +4389,9 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>>      smc->update_dt_enabled = false;
>>>      smc->dr_phb_enabled = false;
>>> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>>> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>>> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
>>>  }
>>
>> While trying auto-bisection for LP#1834613 [*] I found this commit break
>> clean bisection.
>>
>> ./configure --enable-debug
>>
>> $ qemu-system-ppc64 \
>>  -kernel vmlinuz-vanilla \
>>  -nographic -serial null
>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>> cap-cfpc=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>> cap-sbbc=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>> cap-ibs=workaround
>> Opcode 13 10 10 00 (4c400420) leaked temporaries
>>
>> More verbose log:
>>
>> $ qemu-system-ppc64 \
>>  -kernel vmlinuz-vanilla \
>>  -nographic -append "console=hvc0" \
>>  -d guest_errors,in_asm
>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>> cap-cfpc=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>> cap-sbbc=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>> cap-ibs=workaround
>>
>>
>> SLOF **********************************************************************
>> QEMU Starting
>>  Build Date = Jan 14 2019 18:00:39
>>  FW Version = git-a5b428e1c1eae703
>>  Press "s" to enter Open Firmware.
>> [...]
>> --------------
>> IN: __switch_to
>> 0xc00000000001aac0:  60000000  nop
>> 0xc00000000001aac4:  7f44d378  mr       r4, r26
>> 0xc00000000001aac8:  7f23cb78  mr       r3, r25
>> 0xc00000000001aacc:  4bff3235  bl       0xdd00
> 
> The kernel logs are:
> 
> [    0.044473] Oops: Exception in kernel mode, sig: 4 [#1]
> [    0.044899] BE PAGE_SIZE=64K MMU=Radix MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> [    0.045191] Modules linked in:
> [    0.045504] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0-rc4-00058-g582549e3fbe1-dirty #11
> [    0.045646] NIP:  c00000000000be00 LR: c00000000000e168 CTR: 0000000000007fff
> [    0.045747] REGS: c0000000011bb770 TRAP: 0700   Not tainted  (5.1.0-rc4-00058-g582549e3fbe1-dirty)
> [    0.045808] MSR:  8000000002089032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 24028822  XER: 00000000
> [    0.045971] CFAR: c00000000000bde4 IRQMASK: 1 
> [    0.045971] GPR00: c00000000001f390 c0000000011bba00 c0000000011bf800 c0000000010db830 
> [    0.045971] GPR04: c00000001e4041b0 0000000000000000 0000000000000000 00000000028a5d7a 
> [    0.045971] GPR08: 0000000000000000 0000000000007fff 0000000000000000 fffffffffffffffd 
> [    0.045971] GPR12: 0000000024028828 c0000000013b0000 000000001dc5ff00 00000000011d8e18 
> [    0.045971] GPR16: 00000000011d89e0 fffffffffffffffd 000000001dc5ff00 0000000000000014 
> [    0.045971] GPR20: 000000001daf0000 c0000000010da4e0 000000001eef0000 0000000024028822 
> [    0.045971] GPR24: c0000000010db830 c00000001e4041b0 000000001eef0000 c000000000ff5598 
> [    0.045971] GPR28: c0000000010db830 c0000000010d9d00 c00000001e402680 c0000000010d9d00 
> [    0.046505] NIP [c00000000000be00] flush_count_cache+0x120/0x2420
> [    0.046561] LR [c00000000000e168] ._switch+0x68/0x180
> [    0.046696] Call Trace:
> [    0.046865] [c0000000011bba00] [c0000000011bba90] init_stack+0x3a90/0x4000 (unreliable)
> [    0.046970] [c0000000011bbbe0] [c00000000001f390] .__switch_to+0x280/0x490
> [    0.047031] [c0000000011bbc90] [c000000000b62b5c] .__schedule+0x2bc/0xae0
> [    0.047075] [c0000000011bbd80] [c000000000b633c8] .schedule+0x48/0xb0
> [    0.047140] [c0000000011bbdf0] [c000000000b63918] .schedule_preempt_disabled+0x18/0x30
> [    0.047187] [c0000000011bbe60] [c00000000001065c] .rest_init+0xcc/0xf0
> [    0.047233] [c0000000011bbee0] [c000000000f04584] .start_kernel+0x604/0x648
> [    0.047276] [c0000000011bbf90] [c00000000000b260] start_here_common+0x1c/0x53c
> [    0.047409] Instruction dump:
> [    0.047647] 48000005 48000005 48000005 48000005 48000005 4800001c 60000000 60000000 
> [    0.047744] 60000000 60000000 60000000 60000000 <7d2803a6> 39207fff 7d2903a6 4c400420 
> [    0.048410] ---[ end trace 523b05d3a02887f6 ]---
> [    0.048523] 

How do you got the klogs?

> This is fixed by:
> 
> commit fa200c95f7f99ce14b8af25ea0be478c722d3cec
> Author: Greg Kurz <groug@kaod.org>
> Date:   Fri Mar 22 19:03:46 2019 +0100
> 
>     target/ppc: Enable "decrement and test CTR" version of bcctr
>     
>     Even if all ISAs up to v3 indeed mention:
>     
>         If the "decrement and test CTR" option is specified (BO2=0), the
>         instruction form is invalid.
>     
>     The UMs of all existing 64-bit server class processors say:
>     
>         If BO[2] = 0, the contents of CTR (before any update) are used as the
>         target address and for the test of the contents of CTR to resolve the
>         branch. The contents of the CTR are then decremented and written back
>         to the CTR.
>     
>     The linux kernel has spectre v2 mitigation code that relies on a
>     BO[2] = 0 variant of bcctr, which is now activated by default on
>     spapr, even with TCG. This causes linux guests to panic with
>     the default machine type under TCG.
>     
>     Since any CPU model can provide its own behaviour for invalid forms,
>     we could possibly introduce a new instruction flag to handle this.
>     In practice, since the behaviour is shared by all 64-bit server
>     processors starting with 970 up to POWER9, let's reuse the
>     PPC_SEGMENT_64B flag. Caveat: this may have to be fixed later if
>     POWER10 introduces a different behaviour.
>     
>     The existing behaviour of throwing a program interrupt is kept for
>     all other CPU models.
>     
>     Signed-off-by: Greg Kurz <groug@kaod.org>
>     Message-Id: <155327782604.1283071.10640596307206921951.stgit@bahia.lan>
>     Tested-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

So this commit misses:

Fixes: 2782ad4c4102d

This kind of hint is very helpful for post-merge reviews.

Thanks Laurent for your analysis :)

