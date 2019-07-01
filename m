Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB7C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE876206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE876206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4QH-0006Yy-4J
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:05:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi3KU-00071e-Tb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi3KL-0004EU-Rw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:55:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hi3KF-0004CZ-DQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so15252898wrw.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1wfRyxHjaqIfCvUIJ03z9Pt6+BqqMhUX9dFlDyzKWS4=;
 b=WipddEPnDW1jTPgb4Hsa4X/Peddhsuy2/YZY3z5snlriqeoMySj825kbTKlehKxEwK
 W/7x06L1Enx6ZsVw7z7x5Iq5XVF5o/CinAEjy0/k8ch8RzCCvN3VVQQQ+omZInoO2TPy
 c9ezSh89tzMeM5NKVeXo4swH7DVooGkVrN6vgiQx0e67QXdc9bhihrP3f+nUmATpBnyz
 cLsPcosMIzWcwOn829235OOExj4iXITgU7q7BMjjk47qtpQBgmbBSfzonjDjlSDXZSS2
 OVoXczCMy9qYDxqDh3wRUvkqtloXbMutBmwGG2scZ8jm4dVZM6DJ6xKyVuZe1/EsIFXX
 eVug==
X-Gm-Message-State: APjAAAWILE1n1SDXmmVOCSnvD/6xd5W1B1lPQr3VJkvz6KijUZycc1pT
 kdGhZ6rnq35zJytuPEDvkVvwy7QYMGQ=
X-Google-Smtp-Source: APXvYqxSmcR30ge/EyBOXwxbAdhKB7iKdhT2IxmLNpMTB2qzCpAPeviMne5HP/Gg7blDKXCbYCWV9w==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr20819742wrw.8.1562010980796;
 Mon, 01 Jul 2019 12:56:20 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id e6sm1110355wrw.23.2019.07.01.12.56.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 12:56:19 -0700 (PDT)
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <20190701133536.28946-1-philmd@redhat.com>
 <20190701133536.28946-9-philmd@redhat.com> <m1d0ithhhv.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f3a567a4-496b-9158-1173-7c399a1fa3ee@redhat.com>
Date: Mon, 1 Jul 2019 21:56:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <m1d0ithhhv.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 08/15] hw/i386/pc: Let fw_cfg_init() use
 the generic MachineState
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:01 PM, Christophe de Dinechin wrote:
> Philippe Mathieu-Daudé writes:
> 
>> We removed the PCMachineState access, we can now let the fw_cfg_init()
>> function to take a generic MachineState object.
> 
> to take -> take
> 
>>
>> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/i386/pc.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 1e856704e1..60ee71924a 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -929,7 +929,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>>      }
>>  }
>>
>> -static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
>> +static FWCfgState *fw_cfg_arch_create(MachineState *ms,
> 
> I don't see where ms is used in the function. Maybe in a later patch,
> I did not receive patches 09-15 yet.

You are right, it is not used (even if the following patches).

>>                                        const CPUArchIdList *cpus,
>>                                        uint16_t boot_cpus,
>>                                        uint16_t apic_id_limit)
>> @@ -1667,6 +1667,7 @@ void pc_memory_init(PCMachineState *pcms,
>>      MemoryRegion *ram_below_4g, *ram_above_4g;
>>      FWCfgState *fw_cfg;
>>      MachineState *machine = MACHINE(pcms);
>> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>
>>      assert(machine->ram_size == pcms->below_4g_mem_size +
>> @@ -1763,7 +1764,7 @@ void pc_memory_init(PCMachineState *pcms,
>>                                          option_rom_mr,
>>                                          1);
>>
>> -    fw_cfg = fw_cfg_arch_create(pcms, mc->possible_cpu_arch_ids(machine),
>> +    fw_cfg = fw_cfg_arch_create(machine, mc->possible_cpu_arch_ids(machine),
>>                                  pcms->boot_cpus, pcms->apic_id_limit);
>>
>>      rom_set_fw(fw_cfg);

