Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC6C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A528A2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMzBnYCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A528A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZRH-0004MX-Jc
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZAS-0007Ot-DE; Wed, 30 Sep 2020 06:17:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZAQ-0006JX-O6; Wed, 30 Sep 2020 06:17:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so1149112wrt.3;
 Wed, 30 Sep 2020 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mQ4zkt5fbex5IpwN676Z7zynsHhcMMWVl8k6oyU7Mf4=;
 b=aMzBnYCIAkKV3MrvK/o0b1M87OI2b16xb7NiTlHgWwyaZj/WwNstzBuilgZUf4Z+wC
 SsnjbFA3I05HVCBecsbNLyPI0GId0A2tLLVaUuDjkA/mtI2Eu0ySpRTOq96egeQgV9Ux
 2X+tnsTU+VmixWxrHbbbiA5bXcV6z1o1s5rA03dmB/a0MAmKA9f5ixINaUCpJFmgDPda
 73AF00t6HWFQ23MhxqrcZXBBVQ9e7x05RN5fqnk8eTfMMBezyW7kNq993oZwL9I6Go98
 mxnc0x1g0lyhOzyn1qlHziEo9t/Redg++QIzuEMscCt94s8sQLiaIElvXDTiq2qt/3Xe
 HWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mQ4zkt5fbex5IpwN676Z7zynsHhcMMWVl8k6oyU7Mf4=;
 b=CdtlYkwksyk3xpMdKqH+i1Fjx3Yj71ot8pv9FLBBRW/7p8ojiXiaPW+KWdI5s32fpg
 ypwldU50g0Wp3mkvAXb+n5PUG6rxcvT1AeYXIiawuriMUhIC69osuAZ90dEKA/0/Oh2M
 Bi44I9PVxVZh5aHXYHCvT9h6WW6ORtfNg6jNrq9K8CyCvsp1N32UyE4hrrt/3PzkHugI
 FCQZS/aqL6FbtnekMxTEmP9vSUaImw9OPsGjeJdp70lwqLi7DCjhzvMdbMl2HWnclAF4
 D9dILrpgKbXa1WqGjmkSgVhelszja1hTAfVawSf+y3SFeOMtNPgD8LUZDhkrmkXWmxza
 6LeQ==
X-Gm-Message-State: AOAM533iD0CJtdx+ax+3qCNIGRmqnHZazfa8Vf4Kq2pG5YkG24z8jnkZ
 oPG6K1lvLmgaSNPuOuOxHHjgzn5fGDQ=
X-Google-Smtp-Source: ABdhPJz4ZFgqEzfwlBUmPFOkNITtiiGGwRpTp1JBE7pskTT8xXXolQBji0fXXLXD7gcpJSvtGgOq4A==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr2278116wrc.293.1601461015844; 
 Wed, 30 Sep 2020 03:16:55 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i14sm2016572wml.24.2020.09.30.03.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:16:55 -0700 (PDT)
Subject: Re: [PATCH 01/16] hw/core/cpu: Let CPU object have a clock source
To: Igor Mammedov <imammedo@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-2-f4bug@amsat.org>
 <20200930094313.1120a040@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da7248f7-5098-188b-d274-e122c87bb498@amsat.org>
Date: Wed, 30 Sep 2020 12:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930094313.1120a040@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+arm/ppc/riscv folks

On 9/30/20 9:43 AM, Igor Mammedov wrote:
> On Mon, 28 Sep 2020 19:15:24 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Let CPUState have a clock source (named 'clk') and CPUClass
>> have a clock_update() callback. The clock can be optionally
>> set Using qdev_connect_clock_in() from the Clock API.
>> If the clock changes, the optional clock_update() will be
>> called.
> 
> the sole user of it is mips cpu, so question is why
> you are making it part of generic CPUm instead of
> MIPSCPUClass/MIPSCPU?

This is a feature of the CPU, regardless its architecture.

I expect the other archs to start using it soon.

> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/core/cpu.h |  5 +++++
>>  hw/core/cpu.c         | 12 ++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 6c34798c8b3..6989d90c193 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -31,6 +31,7 @@
>>  #include "qemu/thread.h"
>>  #include "qemu/plugin.h"
>>  #include "qom/object.h"
>> +#include "hw/clock.h"
>>  
>>  typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
>>                                       void *opaque);
>> @@ -155,6 +156,7 @@ struct TranslationBlock;
>>   * @disas_set_info: Setup architecture specific components of disassembly info
>>   * @adjust_watchpoint_address: Perform a target-specific adjustment to an
>>   * address before attempting to match it against watchpoints.
>> + * @clock_update: Callback for input clock changes
>>   *
>>   * Represents a CPU family or model.
>>   */
>> @@ -176,6 +178,7 @@ struct CPUClass {
>>                                    unsigned size, MMUAccessType access_type,
>>                                    int mmu_idx, MemTxAttrs attrs,
>>                                    MemTxResult response, uintptr_t retaddr);
>> +    void (*clock_update)(CPUState *cpu);
>>      bool (*virtio_is_big_endian)(CPUState *cpu);
>>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>>                             uint8_t *buf, int len, bool is_write);
>> @@ -316,6 +319,7 @@ struct qemu_work_item;
>>   *   QOM parent.
>>   * @nr_cores: Number of cores within this CPU package.
>>   * @nr_threads: Number of threads within this CPU.
>> + * @clock: this CPU source clock (an output clock of another device)
>>   * @running: #true if CPU is currently running (lockless).
>>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>>   * valid under cpu_list_lock.
>> @@ -400,6 +404,7 @@ struct CPUState {
>>      int num_ases;
>>      AddressSpace *as;
>>      MemoryRegion *memory;
>> +    Clock *clock;
>>  
>>      void *env_ptr; /* CPUArchState */
>>      IcountDecr *icount_decr_ptr;
>> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
>> index c55c09f734c..37fcff3ec64 100644
>> --- a/hw/core/cpu.c
>> +++ b/hw/core/cpu.c
>> @@ -30,6 +30,7 @@
>>  #include "qemu/qemu-print.h"
>>  #include "sysemu/tcg.h"
>>  #include "hw/boards.h"
>> +#include "hw/qdev-clock.h"
>>  #include "hw/qdev-properties.h"
>>  #include "trace/trace-root.h"
>>  #include "qemu/plugin.h"
>> @@ -247,6 +248,16 @@ void cpu_reset(CPUState *cpu)
>>      trace_guest_cpu_reset(cpu);
>>  }
>>  
>> +static void cpu_clk_update(void *opaque)
>> +{
>> +    CPUState *cpu = opaque;
>> +    CPUClass *cc = CPU_GET_CLASS(cpu);
>> +
>> +    if (cc->clock_update) {
>> +        cc->clock_update(cpu);
>> +    }
>> +}
>> +
>>  static void cpu_common_reset(DeviceState *dev)
>>  {
>>      CPUState *cpu = CPU(dev);
>> @@ -367,6 +378,7 @@ static void cpu_common_initfn(Object *obj)
>>      /* the default value is changed by qemu_init_vcpu() for softmmu */
>>      cpu->nr_cores = 1;
>>      cpu->nr_threads = 1;
>> +    cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk", cpu_clk_update, cpu);
>>  
>>      qemu_mutex_init(&cpu->work_mutex);
>>      QSIMPLEQ_INIT(&cpu->work_list);
> 

