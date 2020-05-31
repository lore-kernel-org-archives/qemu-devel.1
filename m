Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 15:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844D6206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNizsghi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844D6206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfPsL-0005Lc-NB
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 11:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfPrd-0004v0-Q3
 for qemu-devel@nongnu.org; Sun, 31 May 2020 11:27:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfPrc-0007As-RT
 for qemu-devel@nongnu.org; Sun, 31 May 2020 11:27:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id d128so8957606wmc.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6N8JzG1MDH3h5xdlCs0KibX8zzucwbmcmfX6XO9nuuI=;
 b=aNizsghiQpfYnDlLo7uRrna6TO7SVsY+X5cFCNS7WB/HT5I4D1BE1PFTgt2vvqYdwY
 8yy6BctkTyzRxNZoFNaawbk6Lp+yPX6rpg1t7xkI+KvaMz+Rf2E0ZTtEc9TwTWFKAHeP
 OsiYz+4fF+pNGhhb6CR9U0OrCVTKuXuA/4WE3U9SejnXgkIh7MPW8H/p6bOwRCU89sG8
 t3a9YEtu+jbUVLVdb7j6Fs3D3v3KKO/joHea6LieH5o6LtXLp7AyWqfDDftQzex0T/09
 ocMu0KZkx1FKwsOqnsxZt9XKVsYyv131PW78G4WNh8CiCDsT27FLSamJobhxA8eQ0lQW
 bgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6N8JzG1MDH3h5xdlCs0KibX8zzucwbmcmfX6XO9nuuI=;
 b=FmH9YdflPOCuJw88OeIIuW+s7yv4BQKxQixpvjf6F7Y8Jg/fHAiiUo7t9UR+lnlh5h
 Qzl+dH9GxEgj3XH6/PM6r4ZJU603/ZHFRuSM2UYT9zyu6kCf6z7KhIoAa93CboPjpPCv
 L6U8BYqy1cn1M13KUSjKOZrIwozeSg3gQlYzNf2w2j8OoU9FsaBX/tldFr2wXuaMHguS
 Vl3ASTmf+C5/wSgseCe4dRMKX+iM5iUU95Mi46qw2CfxXu+K1jhbPBdxAAOSQRCXgNb6
 Satt0W/XuDicgkiNUuaEu65p983eiq8nmcjBYgf0IYjvw3/rxjEpCkM8iG1TVxSpxV+C
 Ngag==
X-Gm-Message-State: AOAM533imfZvT3EJ+Lx+idNbN08cmexZ0i0zZZcN1d7a8uCJBQI7Hdd5
 qVlyeUzacPfKRm4JIQJom3E=
X-Google-Smtp-Source: ABdhPJxHmTM3/kFcTZSvlPo+jVnEPnrlzccYQJ2yBrW4NAf8NYe3PBVoaHmBpvzuMVStJErNNX5reQ==
X-Received: by 2002:a1c:4c12:: with SMTP id z18mr5343291wmf.155.1590938823225; 
 Sun, 31 May 2020 08:27:03 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id w17sm15545615wra.71.2020.05.31.08.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 08:27:02 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
 <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
Date: Sun, 31 May 2020 17:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 Jon Doron <arilou@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 6:41 PM, Peter Maydell wrote:
> On Mon, 30 Mar 2020 at 17:21, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 3/30/20 6:08 PM, Peter Maydell wrote:
>>> On Mon, 30 Mar 2020 at 16:30, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Since commit 3f940dc98, we added support for vAttach packet
>>>> to select a particular thread/cpu/core. However when using
>>>> the GDB physical memory mode, it is not clear which CPU
>>>> address space is used.
>>>> Since the CPU address space is stored in CPUState::as, use
>>>> address_space_rw() instead of cpu_physical_memory_rw().
>>>>
>>>> Fixes: ab4752ec8d9
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>   gdbstub.c | 7 ++-----
>>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/gdbstub.c b/gdbstub.c
>>>> index 013fb1ac0f..3baaef50e3 100644
>>>> --- a/gdbstub.c
>>>> +++ b/gdbstub.c
>>>> @@ -69,11 +69,8 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
>>>>
>>>>   #ifndef CONFIG_USER_ONLY
>>>>       if (phy_memory_mode) {
>>>> -        if (is_write) {
>>>> -            cpu_physical_memory_write(addr, buf, len);
>>>> -        } else {
>>>> -            cpu_physical_memory_read(addr, buf, len);
>>>> -        }
>>>> +        address_space_rw(cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
>>>> +                         buf, len, is_write);
>>>>           return 0;
>>>
>>> There's an argument here for using
>>>     int asidx = cpu_asidx_from_attrs(cpu, MEMTXATTRS_UNSPECIFIED);
>>>     AddressSpace *as = cpu_get_address_space(cpu, asidx);
>>>
>>> though it will effectively boil down to the same thing in the end
>>> as there's no way for the gdbstub to specify whether it wanted
>>> eg the Arm secure or non-secure physical address space.
>>
>> https://static.docs.arm.com/ihi0074/a/debug_interface_v6_0_architecture_specification_IHI0074A.pdf
>>
>> * Configuration of hypervisor noninvasive debug.
>>
>> This field can have one of the following values:
>>
>> - 0b00
>> Separate controls for hypervisor noninvasive debug are not implemented,
>> or no hypervisor is implemented. For ARMv7 PEs that implement the
>> Virtualization Extensions, and for ARMv8 PEs that implement EL2, if
>> separate controls for hypervisor debug visibility are not implemented,
>> the hypervisor debug visibility is indicated by the relevant Non-secure
>> debug visibility fields NSNID and NSID.
>>
>> OK so for ARM "noninvasive debug is not implemented" and we would use
>> the core secure address space?
> 
> I'm not very familiar with the debug interface (we don't model
> it in QEMU), but I think that is the wrong end of it. These
> are bits in AUTHSTATUS, which is a read-only register provided
> by the CPU to the debugger. It basically says "am I, the CPU,
> going to permit you, the debugger, to debug code running
> in secure mode, or in EL2". (The CPU gets to decide this:
> for security some h/w will not want any random with access
> to the jtag debug port to be able to just read out code from
> the secure world, for instance.)
> 
> What the debugger gets to control is bits in the CSW register
> in the "MEM-AP"; it can use these to specify the size of
> a memory access it wants to make to the guest, and also
> the 'type', which is IMPDEF but typically lets the debugger
> say "code access vs data access", "privileged vs usermode"
> and "secure vs non-secure".
> 
> The equivalent in the QEMU world is that the debugger can
> specify the memory transaction attributes. The question is
> whether the gdb protocol provides any equivalent of that:
> if it doesn't then gdbstub.c has to make up an attribute and
> use that.
> 
>> Instead of MEMTXATTRS_UNSPECIFIED I should use a crafted MemTxAttrs with
>> .secure = 1, .unspecified = 1?
> 
> You shouldn't set 'unspecified = 1', because that indicates
> "this is MEMTXATTRS_UNSPECIFIED". The default set of
> unspecified-attributes are probably good enough,
> though, so you can just use MEMTXATTRS_UNSPECIFIED.
> 
>> The idea of this command is to use the
>> CPU AS but not the MMU/MPU, maybe it doesn't make sense...
> 
> The trouble is that the command isn't precise enough.
> "read/write to physical memory" is fine if the CPU has
> exactly one physical address space, but it's ambiguous if the CPU
> has more than one physical address space. Either we need the
> user to be able to tell us which one they wanted somehow
> (which for QEMU more or less means that they should tell
> us what tx attributes they wanted), or we need to make an
> arbitrary decision.
> 
> PS: do we have any documentation of this new command ?
> ab4752ec8d9 has the implementation but no documentation...

Jon, do you have documentation on the Qqemu.PhyMemMode packet?

> 
> thanks
> -- PMM
> 

