Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD083C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81CB21473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81CB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbl4I-0004Pr-Kv
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hbl2L-0002YU-AI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hbl2J-0003tm-Ip
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:10:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hbl2J-0003gv-6d
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:10:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so2089020wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 05:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=HHmxPOXC/7BCycsETxDS9BYLXUGEb3sRUYUuk8X8HLk=;
 b=R26yM2oAtyT2bvZVKsIg1mji/iaR5WCaUMS+GxpcJid5/Dwp1LwvJhrN3bS5OJ++CT
 uQP+NAWq8hFXzPuhAetxzNTjRt1FckNjdRSRWmH1Iqhs5UOWrtGEt1yjcc0+iFiY0R2I
 c8oJu60C6RfA5xeyvlIYfH+QSw21IvQLdMo6g6Cp/DrNCq9r4QFaQ16UGFNHka56Mpbf
 QgLl0Xx8MEKVlYyW+6a2BE9pH5MbfI086kZE3p9a3POWB6x/VJDYu9umKdEEqUB2yFX/
 902jAr8CQBqh1Ujs44spMFvsGsd/McYg4ruJ2jVgw3NiPHBMnb2h5VXjlSyQknSvk7C/
 Sd7w==
X-Gm-Message-State: APjAAAUGvEe51V2mJaKU7Dhbtoqn4d5BIndCU7/YSI1OTkF4OullVftT
 em0I+/TQftKjsxRdRUK8Ze6B2g==
X-Google-Smtp-Source: APXvYqzW/Brcm6Lo8qlf2hPmdiAbiy/SJaKDnrPS0BUy97rjS7rGcXAhPBAa5tTwUZiBNMXF9BX1xw==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr7744690wmt.57.1560514212594; 
 Fri, 14 Jun 2019 05:10:12 -0700 (PDT)
Received: from localhost ([83.137.6.186])
 by smtp.gmail.com with ESMTPSA id p3sm4394672wrd.47.2019.06.14.05.10.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 05:10:12 -0700 (PDT)
Date: Fri, 14 Jun 2019 05:10:12 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Jun 2019 05:09:48 PDT (-0700)
In-Reply-To: <CAFEAcA-01sahAvfLRoe3e9RfCcgmk4+Ubceufg9hhmwQAFpbRQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-1958cec5-7d9d-483b-bb14-72e53bbde47f@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 01/29] SiFive RISC-V GPIO Device
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, chouteau@adacore.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 03:57:12 PDT (-0700), Peter Maydell wrote:
> On Sun, 26 May 2019 at 02:10, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> From: Fabien Chouteau <chouteau@adacore.com>
>>
>> QEMU model of the GPIO device on the SiFive E300 series SOCs.
>>
>> The pins are not used by a board definition yet, however this
>> implementation can already be used to trigger GPIO interrupts from the
>> software by configuring a pin as both output and input.
>>
>> Signed-off-by: Fabien Chouteau <chouteau@adacore.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Hi; this patch causes Coverity to complain about a memory
> leak (CID 1401707):
>
>>  static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>>  {
>>      const struct MemmapEntry *memmap = sifive_e_memmap;
>> +    Error *err = NULL;
>>
>>      SiFiveESoCState *s = RISCV_E_SOC(dev);
>>      MemoryRegion *sys_mem = get_system_memory();
>> @@ -184,8 +188,28 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
>>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
>>      sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
>> -    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
>> -        memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
>> +
>> +    /* GPIO */
>> +
>> +    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>
> This function allocated xip_mem and mask_rom via g_new() but
> then this error-exit doesn't free them.
>
> The best way to fix this is to stop doing separate memory
> allocations at all -- instead just have fields in the
> SiFiveESoCState struct
>    MemoryRegion xip_mem;
>    Memory_Region mask_rom;
>
> and pass &s->xip_mem etc where currently the code uses xip_mem.

Sorry this took a while to fix, I've just sent a patch to fix the memory leak.

