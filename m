Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C400C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EF42074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT/3yk3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EF42074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfREL-00085z-IG
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jfR2o-0007Q5-IP
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:42:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jfR2n-0008EV-Ap
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:42:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id x6so9001093wrm.13
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=rseQoM8S/ilqhsOjzIqn6qyFwjwe1nbpud1Jd9Oo5qQ=;
 b=NT/3yk3AKcuA6pvXovLnyNkO2Y7YiAUsGW/M49227UWZPafVEWOyUK9RAaAH0DBZ1s
 IAG4xp8QVGCddPXYU8yT6krns5va1qvvJcpLBCugUFziQNn1/XhS9SCwfrBqSMsbx2Xy
 cn1v3pFHH7pi/bnZv2t+42QZqSvqANojZx5fWG6Bk5Q6KNsyDWH5Wk8kSM7KNN6wPUQV
 eRUExah1wmuhDOskeX2bQNtMaGt1I1Tvq+wtDXsi8NMMFy7Q7oaB7yapKc5c3Yu7KRL6
 gnT/3PXP7VqcQMG0xgZTkNF+3tpeSqZHgaS723Y/8sNY84kd33LFec+MOpWU5D6GYIXi
 I9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rseQoM8S/ilqhsOjzIqn6qyFwjwe1nbpud1Jd9Oo5qQ=;
 b=NrF9htMFNi8bMJ7eOQ0FLTLWo57TBdtI/VvUmchVMfIe68+I0M8HNy7yQqIQoJbukM
 wgobhhMh1g+RciQ31+vBLeylcdwJQu0agtIOk7NnJ5dygrOAjxOv9oHklfuoiU8nsJQw
 2WFKdYxF5dPKky0q+967wdxTE0xiMpSE80IUWRgtBatqnkyEUj+O9c1K/q5sM9CiRkUU
 P8NK5Bq92di5+9zPUw2lkPKZVBfyTS0zDaNvhGfqLoNekKmlnX5Km9nfr6P44K9Rjf46
 HdPehElRWDXTNgd+1y5xn+zux90DRgyoX9+QlaqnUY0NZVO3ZMlCcq98llB94uQ72es5
 Pcgg==
X-Gm-Message-State: AOAM531LfF43E9+uCJeX8eJh7CY1gItdkCpM1RMfAvNVw3RzKLDZ7qg9
 090rHWHiM/i4R+xbZSZ1tfg=
X-Google-Smtp-Source: ABdhPJzVlZq1xqvk2sOUzbP1LcHX4bVDsD1qlnWofMZF3Z6EuMpigF8olYmfw4iafoGWaslDw0CqZg==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr19701481wrq.153.1590943358948; 
 Sun, 31 May 2020 09:42:38 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id k14sm17753437wrq.97.2020.05.31.09.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:42:38 -0700 (PDT)
Date: Sun, 31 May 2020 19:42:36 +0300
From: Jon Doron <arilou@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
Message-ID: <20200531164236.GF3071@jondnuc>
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
 <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
 <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/05/2020, Philippe Mathieu-Daudé wrote:
>On 3/30/20 6:41 PM, Peter Maydell wrote:
>> On Mon, 30 Mar 2020 at 17:21, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>> On 3/30/20 6:08 PM, Peter Maydell wrote:
>>>> On Mon, 30 Mar 2020 at 16:30, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>
>>>>> Since commit 3f940dc98, we added support for vAttach packet
>>>>> to select a particular thread/cpu/core. However when using
>>>>> the GDB physical memory mode, it is not clear which CPU
>>>>> address space is used.
>>>>> Since the CPU address space is stored in CPUState::as, use
>>>>> address_space_rw() instead of cpu_physical_memory_rw().
>>>>>
>>>>> Fixes: ab4752ec8d9
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> ---
>>>>>   gdbstub.c | 7 ++-----
>>>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/gdbstub.c b/gdbstub.c
>>>>> index 013fb1ac0f..3baaef50e3 100644
>>>>> --- a/gdbstub.c
>>>>> +++ b/gdbstub.c
>>>>> @@ -69,11 +69,8 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
>>>>>
>>>>>   #ifndef CONFIG_USER_ONLY
>>>>>       if (phy_memory_mode) {
>>>>> -        if (is_write) {
>>>>> -            cpu_physical_memory_write(addr, buf, len);
>>>>> -        } else {
>>>>> -            cpu_physical_memory_read(addr, buf, len);
>>>>> -        }
>>>>> +        address_space_rw(cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
>>>>> +                         buf, len, is_write);
>>>>>           return 0;
>>>>
>>>> There's an argument here for using
>>>>     int asidx = cpu_asidx_from_attrs(cpu, MEMTXATTRS_UNSPECIFIED);
>>>>     AddressSpace *as = cpu_get_address_space(cpu, asidx);
>>>>
>>>> though it will effectively boil down to the same thing in the end
>>>> as there's no way for the gdbstub to specify whether it wanted
>>>> eg the Arm secure or non-secure physical address space.
>>>
>>> https://static.docs.arm.com/ihi0074/a/debug_interface_v6_0_architecture_specification_IHI0074A.pdf
>>>
>>> * Configuration of hypervisor noninvasive debug.
>>>
>>> This field can have one of the following values:
>>>
>>> - 0b00
>>> Separate controls for hypervisor noninvasive debug are not implemented,
>>> or no hypervisor is implemented. For ARMv7 PEs that implement the
>>> Virtualization Extensions, and for ARMv8 PEs that implement EL2, if
>>> separate controls for hypervisor debug visibility are not implemented,
>>> the hypervisor debug visibility is indicated by the relevant Non-secure
>>> debug visibility fields NSNID and NSID.
>>>
>>> OK so for ARM "noninvasive debug is not implemented" and we would use
>>> the core secure address space?
>>
>> I'm not very familiar with the debug interface (we don't model
>> it in QEMU), but I think that is the wrong end of it. These
>> are bits in AUTHSTATUS, which is a read-only register provided
>> by the CPU to the debugger. It basically says "am I, the CPU,
>> going to permit you, the debugger, to debug code running
>> in secure mode, or in EL2". (The CPU gets to decide this:
>> for security some h/w will not want any random with access
>> to the jtag debug port to be able to just read out code from
>> the secure world, for instance.)
>>
>> What the debugger gets to control is bits in the CSW register
>> in the "MEM-AP"; it can use these to specify the size of
>> a memory access it wants to make to the guest, and also
>> the 'type', which is IMPDEF but typically lets the debugger
>> say "code access vs data access", "privileged vs usermode"
>> and "secure vs non-secure".
>>
>> The equivalent in the QEMU world is that the debugger can
>> specify the memory transaction attributes. The question is
>> whether the gdb protocol provides any equivalent of that:
>> if it doesn't then gdbstub.c has to make up an attribute and
>> use that.
>>
>>> Instead of MEMTXATTRS_UNSPECIFIED I should use a crafted MemTxAttrs with
>>> .secure = 1, .unspecified = 1?
>>
>> You shouldn't set 'unspecified = 1', because that indicates
>> "this is MEMTXATTRS_UNSPECIFIED". The default set of
>> unspecified-attributes are probably good enough,
>> though, so you can just use MEMTXATTRS_UNSPECIFIED.
>>
>>> The idea of this command is to use the
>>> CPU AS but not the MMU/MPU, maybe it doesn't make sense...
>>
>> The trouble is that the command isn't precise enough.
>> "read/write to physical memory" is fine if the CPU has
>> exactly one physical address space, but it's ambiguous if the CPU
>> has more than one physical address space. Either we need the
>> user to be able to tell us which one they wanted somehow
>> (which for QEMU more or less means that they should tell
>> us what tx attributes they wanted), or we need to make an
>> arbitrary decision.
>>
>> PS: do we have any documentation of this new command ?
>> ab4752ec8d9 has the implementation but no documentation...
>
>Jon, do you have documentation on the Qqemu.PhyMemMode packet?
>
>>
>> thanks
>> -- PMM
>>

Hi, there is no documentation for this mode, but in general the idea was 
very simple.

I want to have GDB the option to see the physical memory and examine it 
and have this option toggled.

This was useful to me when I was working on nested virtual machine and I 
wanted to examine different states of the VMCS12 and EPTs.

I used this in the following commands:
// Enable
maint packet Qqemu.PhyMemMode:1

// Disable
maint packet Qqemu.PhyMemMode:0

It was mostly used part of a GDB script I played with to help me find 
the VMCS12 and EPTs.

The architecture was x86_64.

Let me know if you have any further questions.

Cheers,
-- Jon.

