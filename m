Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB713C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765DA216C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="R3jqWC4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765DA216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADEa-0001wc-8K
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iADCy-0000Vw-50
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iADCv-0002hc-Bf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:51 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:41684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iADCu-0002gl-Oz; Tue, 17 Sep 2019 09:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLrzT76BGLWUQElAktBhQ8dZhxAWdzuSE2omautw7r4=; b=R3jqWC4AFwwxtojdDldUjSOJlQ
 Ly2oHO65WwThONaRHPflLbv+2ug9i0SbY5Z7Ch9OGwSyirv8I2Eps7FkkiKH89kJXO2r5zRYPUlfM
 ckr6rOVe6XvlzcbkuWIlzMgM59PUBHSUWcoyOGHsvZ4QN2Ji3oYd6iz57As0t3Ky4lXI=;
To: Peter Maydell <peter.maydell@linaro.org>,
 "Konopik, Andreas" <andreas.konopik@fau.de>
References: <9cf47438fa943b28ee987cea7b76a459@fau.de>
 <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <8ab962a1-e372-59bb-022a-9fff72841211@mail.uni-paderborn.de>
Date: Tue, 17 Sep 2019 15:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.17.130017, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.9.5650001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: Re: [Qemu-devel] [Qemu-discuss] Segmentation fault on target tricore
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andreas,

On 9/17/19 2:32 PM, Peter Maydell wrote:
> On Tue, 17 Sep 2019 at 13:24, Konopik, Andreas <andreas.konopik@fau.de> wrote:
>> Hello,
>>
>> I am wondering why the "Hello world"-program available in TASKING
>> (v6.2r1) generates a segfault.
>>
>> I compiled the program for the 'TC1796' Processor (Infineon TriCore 1
>> Family -> AUDO NextGeneration Family).
>> QEMU was built with gcc 9.1.0 and I added a memory region, that was
>> necessary [1].
>> Running QEMU with following options:
>> `./qemu/build/tricore-softmmu/qemu-system-tricore -nographic -M
>> tricore_testboard -cpu tc1796 -kernel hello.elf`
>> led to a segfault in a short time
> Hi -- I'm cc'ing the qemu-devel list and the TriCore maintainer;
> not everybody reads the -discuss mailing list.
>
>> Using gdb and valgrind I found out that:
>> - 'gen_mtcr()' and 'gen_mfcr()' access uninitialized values, i.e. CSFRs,
>> which leads to the Segfault
>> - The uninitialised values were created by stack allocation of
>> DisasContext in 'gen_intermediate_code()'


Sounds like a thing we already fixed (see 
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05496.html). 
However, I see that you used a version already containing the fix.


> This definitely sounds like a bug: do you have a stack
> backtrace from valgrind or gdb of the bad access and the
> segfault?


Yes, or a small reproducer program.


>>> diff --git a/hw/tricore/tricore_testboard.c
>>> b/hw/tricore/tricore_testboard.c
>>> index aef3289f8c..c287e0e7f5 100644
>>> --- a/hw/tricore/tricore_testboard.c
>>> +++ b/hw/tricore/tricore_testboard.c
>>> @@ -59,6 +59,7 @@ static void tricore_testboard_init(MachineState
>>> *machine, int board_id)
>>>      CPUTriCoreState *env;
>>>
>>>      MemoryRegion *sysmem = get_system_memory();
>>> +    MemoryRegion *pflash = g_new(MemoryRegion, 1);
>>>      MemoryRegion *ext_cram = g_new(MemoryRegion, 1);
>>>      MemoryRegion *ext_dram = g_new(MemoryRegion, 1);
>>>      MemoryRegion *int_cram = g_new(MemoryRegion, 1);
>>> @@ -68,6 +69,8 @@ static void tricore_testboard_init(MachineState
>>> *machine, int board_id)
>>>
>>>      cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
>>>      env = &cpu->env;
>>> +    memory_region_init_ram(pflash, NULL, "pflash",
>>> +                           2 * MiB, &error_fatal);
>>>      memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
>>>                             2 * MiB, &error_fatal);
>>>      memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram",
>>> @@ -81,6 +84,7 @@ static void tricore_testboard_init(MachineState
>>> *machine, int board_id)
>>>      memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram",
>>>                             32 * KiB, &error_fatal);
>>>
>>> +    memory_region_add_subregion(sysmem, 0xa0000000, pflash);
>>>      memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
>>>      memory_region_add_subregion(sysmem, 0xa1000000, ext_dram);
>>>      memory_region_add_subregion(sysmem, 0xd4000000, int_cram);
> I don't know enough about TriCore or the board QEMU is
> emulating here to know whether this is the right thing;
> Bastian?


As the name suggest this is just a Testboard (and thus is not linked to 
any real board) that initializes the minimal amount of memory that is 
needed to run a binary. If you're interested you can implement a real 
board. I'm happy to take such a patch :)


Cheers,

Bastian


