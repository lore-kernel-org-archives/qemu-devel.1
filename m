Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B32C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1E920863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1E920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuj6-0006mp-0J
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hctME-0007FP-Np
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hctMB-0005RA-DD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:15:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hctMB-0005AS-56
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:15:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so10359186wrw.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 08:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IUG05o5G9Nt8c60YurpAvAgTrPq2rAeREeIjLbzEtHM=;
 b=juu5EbQitCbFy/5wGNSkFmJWsTP7D3sqcyUnW8xJy2z8IRHfSq37UQcqI6UTwvAWNB
 Sjqb+xFCADPtrx0zaNijboAzUnbPIH5elSZpl1bIifJmQ6gpO2zf3QAJlshmAI0RoPM6
 By/0/g9mKBtNYWrWU6mRatxRa4F0NngZCQt6jCbKS+LxKPvCNLv01PYukNtgqtb5zE0U
 9Y2ZTAUTdhYyRsFzZ7qgTdzAHvfzfxUrBMv35ZV+/URS1DGyKQnZ44lIXpLhyWEoOU3I
 3nHagEg0D7DhOaPKOXS4vigWTmA7LkuskVb5eBvHrrlu0hFtXcZFiUghBiQRcdZT9bFc
 bXeQ==
X-Gm-Message-State: APjAAAWB0aWDDfPKq1XSmoxfVTXi7qjfVomRrFpQRRjK9ups++Z67oUJ
 4zc+/+SRC7yRDpKRnjNv9zV7RLsIiOw=
X-Google-Smtp-Source: APXvYqw66SlgRWFqoAeVye92oYxexDZS9kZ4ikSpnc9AMyTtD5opuT3Si8/T4ZEbgwNqycr1PYDBtA==
X-Received: by 2002:adf:fb47:: with SMTP id c7mr40513409wrs.116.1560784522780; 
 Mon, 17 Jun 2019 08:15:22 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f197sm16902587wme.39.2019.06.17.08.15.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 08:15:22 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
 <56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
 <20180202182326.GB22556@localhost.localdomain>
 <20180205122235.03fdeaad@redhat.com>
 <20180205135401.GA3300@localhost.localdomain>
 <20180205154202.7d1269a9@redhat.com>
 <20180205224205.GA3291@localhost.localdomain>
 <20180206154320.288acdc2@redhat.com>
 <62d7649e-e85d-43a2-2df8-85e2a0953e89@redhat.com>
 <20190617170106.48d776ca@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0a31228d-4d32-2c54-649b-6aef9953fffc@redhat.com>
Date: Mon, 17 Jun 2019 17:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617170106.48d776ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu
 types to use cpu_model
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
Cc: marcel@redhat.com, peter.maydell@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>, alistair23@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 5:01 PM, Igor Mammedov wrote:
> On Mon, 17 Jun 2019 07:09:59 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Hi Igor, Eduardo,
>>
>> On 2/6/18 3:43 PM, Igor Mammedov wrote:
>>> On Mon, 5 Feb 2018 20:42:05 -0200
>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>   
>>>> On Mon, Feb 05, 2018 at 03:42:02PM +0100, Igor Mammedov wrote:  
>>>>> On Mon, 5 Feb 2018 11:54:01 -0200
>>>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>>     
>>>>>> On Mon, Feb 05, 2018 at 12:22:35PM +0100, Igor Mammedov wrote:    
>>>>>>> On Fri, 2 Feb 2018 16:23:26 -0200
>>>>>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>>>>       
>>>>>>>> On Thu, Feb 01, 2018 at 04:42:05PM -0800, Alistair Francis wrote:      
>>>>>>>>> As cpu_type is not a user visible string let's convert the
>>>>>>>>> valid_cpu_types to compare against cpu_model instead. This way we have a
>>>>>>>>> user friendly string to report back.
>>>>>>>>>
>>>>>>>>> Once we have a cpu_type to cpu_model conversion this patch should be
>>>>>>>>> reverted and we should use cpu_type instead.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>>  hw/core/machine.c | 11 +++++------
>>>>>>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>>>>> index cdc1163dc6..de5bac1c84 100644
>>>>>>>>> --- a/hw/core/machine.c
>>>>>>>>> +++ b/hw/core/machine.c
>>>>>>>>> @@ -776,13 +776,12 @@ void machine_run_board_init(MachineState *machine)
>>>>>>>>>      /* If the machine supports the valid_cpu_types check and the user
>>>>>>>>>       * specified a CPU with -cpu check here that the user CPU is supported.
>>>>>>>>>       */
>>>>>>>>> -    if (machine_class->valid_cpu_types && machine->cpu_type) {
>>>>>>>>> -        ObjectClass *class = object_class_by_name(machine->cpu_type);
>>>>>>>>> +    if (machine_class->valid_cpu_types && machine->cpu_model) {
>>>>>>>>>          int i;
>>>>>>>>>  
>>>>>>>>>          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
>>>>>>>>> -            if (object_class_dynamic_cast(class,
>>>>>>>>> -                                          machine_class->valid_cpu_types[i])) {
>>>>>>>>> +            if (!strcmp(machine->cpu_model,
>>>>>>>>> +                        machine_class->valid_cpu_types[i])) {        
>>>>>>>>
>>>>>>>> I would rename valid_cpu_types to valid_cpu_models to make the
>>>>>>>> new semantics clearer.
>>>>>>>>
>>>>>>>> Anyway, I have bad and good news:
>>>>>>>>
>>>>>>>> The bad news is Igor already sent patches last week that remove
>>>>>>>> MachineState::cpu_model, so this conflicts with his series.  Now
>>>>>>>> parse_cpu_model() will be the only place where the original CPU model name is
>>>>>>>> available, but the function needs to work on *-user too.  See:
>>>>>>>> "[PATCH v3 23/25] Use cpu_create(type) instead of cpu_init(cpu_model)".
>>>>>>>>
>>>>>>>> The good news is that I think we can fix this very easily if
>>>>>>>> validation is done at the same place where parse_cpu_model() is
>>>>>>>> called.  e.g.:
>>>>>>>>
>>>>>>>>     current_machine->cpu_type = machine_class->default_cpu_type;
>>>>>>>>     if (cpu_model) {
>>>>>>>>         current_machine->cpu_type = parse_cpu_model(cpu_model);
>>>>>>>>
>>>>>>>>         if (machine_class->valid_cpu_models) {
>>>>>>>>             ObjectClass *class = object_class_by_name(machine->cpu_type);
>>>>>>>>             int i;
>>>>>>>>
>>>>>>>>             for (i = 0; machine_class->valid_cpu_models[i]; i++) {
>>>>>>>>                 const char *valid_model = machine_class->valid_cpu_models[i];
>>>>>>>>                 ObjectClass *valid_class = cpu_class_by_name(machine->cpu_type, valid_model);
>>>>>>>>                 if (object_class_dynamic_cast(class,
>>>>>>>>                                               object_class_get_name(valid_class))) {
>>>>>>>>                      /* Valid CPU type, we're good to go */
>>>>>>>>                      break;
>>>>>>>>                 }
>>>>>>>>             }
>>>>>>>>             if (!machine_class->valid_cpu_models[i]) {
>>>>>>>>                 error_report("Invalid CPU model: %s", cpu_model);
>>>>>>>>                 error_printf("The valid CPU models are: %s",
>>>>>>>>                              machine_class->valid_cpu_models[0]);
>>>>>>>>                 for (i = 1; machine_class->valid_cpu_models[i]; i++) {
>>>>>>>>                     error_printf(", %s", machine_class->valid_cpu_models[i]);
>>>>>>>>                 }
>>>>>>>>                 error_printf("\n");
>>>>>>>>                 exit(1);
>>>>>>>>             }
>>>>>>>>         }
>>>>>>>>     }
>>>>>>>>
>>>>>>>> This can be done inside main(), or moved inside
>>>>>>>> machine_run_board_init() if main() pass cpu_model as argument to
>>>>>>>> the function.
>>>>>>>>
>>>>>>>> On either case, I think it's a good idea to do validation and
>>>>>>>> printing of error messages closer to the code that parses the
>>>>>>>> command-line options.  This way we separate parsing/validation
>>>>>>>> from initialization.      
>>>>>>> I agree it's better like you suggest as at least it prevents
>>>>>>> ms->cpu_model creeping back into boards code.
>>>>>>>
>>>>>>> But I still dislike (hate) an idea of new code adding non
>>>>>>> canonized cpu_model strings back in the boards code.
>>>>>>> It's just a matter of time when someone would use them
>>>>>>> and cpu_model parsing will creep back into boards.
>>>>>>>
>>>>>>> It would be much better to if we add 
>>>>>>>    char *MachineClass::cpu_name_by_type_name(char *cpu_type)
>>>>>>> callback and let machines in this patchset to set it,
>>>>>>> something along following lines which is not much of
>>>>>>> refactoring and allows for gradual conversion:
>>>>>>>
>>>>>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>>>>>> index 9631670..85cca84 100644
>>>>>>> --- a/target/arm/cpu.h
>>>>>>> +++ b/target/arm/cpu.h
>>>>>>> @@ -2885,4 +2885,6 @@ static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
>>>>>>>      return cpu->el_change_hook_opaque;
>>>>>>>  }
>>>>>>>  
>>>>>>> +char *arm_cpu_name_by_type_name(const char *typename);
>>>>>>> +
>>>>>>>  #endif
>>>>>>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>>>>>>> index f936017..ae6adb7 100644
>>>>>>> --- a/hw/arm/netduino2.c
>>>>>>> +++ b/hw/arm/netduino2.c
>>>>>>> @@ -46,6 +46,7 @@ static void netduino2_machine_init(MachineClass *mc)
>>>>>>>      mc->desc = "Netduino 2 Machine";
>>>>>>>      mc->init = netduino2_init;
>>>>>>>      mc->ignore_memory_transaction_failures = true;
>>>>>>> +    mc->cpu_name_by_type_name = arm_cpu_name_by_type_name:      
>>>>>>
>>>>>> I really don't want to introduce a new arch-specific hook just
>>>>>> for that.  We should move CPU type lookup logic to common code
>>>>>> and make it unnecessary to write new hooks.    
>>>>> unfortunately cpu_model (cpu name part) is target specific
>>>>> and it's translation to type and back is target specific mayhem.    
>>>>
>>>> Why can't the model<->type translation be represented as data?
>>>> We could have simple cpu_type_name_suffix + an alias table.
>>>>
>>>> We have at least 4 arches that return a constant at
>>>> class_by_name.  We have at least 10 arches that simply add a
>>>> suffix to the CPU model name.  We must make them use common code
>>>> instead of requiring them to implement yet another hook[1].  
>>> True, some of them could use generic hook and reduce
>>> code duplication greatly, we should do it regardless of whether
>>> table or target specific func approach is used.
>>>   
>>>> In addition to the ones above, we have 3 that seem to just need
>>>> an alias table (cris, superh, alpha).  ppc can probably also use
>>>> an alias table for the ppc_cpu_class_by_pvr() stuff.  sparc just
>>>> needs whitespaces translated to '-' (sparc), which can be done
>>>> using an alias table.
>>>>
>>>> In the end I couldn't find any example that can't be represented
>>>> by a suffix + alias table.  
>>>
>>> Table based approach is possible but it won't be as simple
>>> as you've just pictured it.
>>>
>>> From what I recall from cpu_class_by_name cleanups table should be able
>>> to describe cases like (sometimes combination of them):
>>>    * 1:1 mapping - where cpu_model == cpu_type
>>>    * cpu_model <==> cpu_model + suffix  - most common usecase
>>>    * cpu_model <==> prefix cpu_model  - riscv patches on list are trying to add such cpu types
>>>    * NULL => some_fixed type
>>>    * case (in) sensitive flag
>>>    * garbage => some_fixed type
>>>    * substitutions
>>>    * aliases (sometimes dynamic depending on --enable-kvm (PPC))
>>> Maybe something else.
>>>
>>> We can think about it at leisure but I can't say if new approach
>>> complexity it's worth of the effort.
>>>  
>>> It would be nice see impl, but it's a lot of refactoring that's
>>> clearly out of scope of this series.
>>> I'd prefer small incremental refactoring (if possible) that
>>> won't scare people of and easy to review vs a huge one.
>>>   
>>>>> So I'd prefer having both back and forth functions together in
>>>>> one place. And common code to call them when necessary.
>>>>>
>>>>> We could do global cpu_name_by_type_name() instead of hook,
>>>>> which I'd prefer even more but then conversion can't be done
>>>>> only for one target but rather for all targets at once.    
>>>>
>>>> I don't mind letting a few targets override default behavior with
>>>> a hook if really necessary, but I have a problem with requiring
>>>> all targets to implement what's basically the same boilerplate
>>>> code to add/remove a string suffix and translating aliases.  
>>> it could be generic helper if target does the same plus
>>> not mandatory at that (in case target/board doesn't care
>>> about valid cpus).
>>>   
>>>>>> I agree it would be better if we had a cpu_name_by_type_name()
>>>>>> function, but I would like to have it implemented cleanly.    
>>>>> In some cases(targets) it can be common helper, but in other
>>>>> cases it's not so.
>>>>> My suggestion though allows to do gradual conversion and
>>>>> avoid putting cpu_model names back in board's code (which I just manged to remove).
>>>>> Once all targets converted and relevant code is isolated
>>>>> we can attempt to generalize it if it's possible or at least
>>>>> make of it global per target helper to get rid of
>>>>> temporary machine hook.
>>>>>
>>>>> (seeing this series reposted with cpu_model names in boards code,
>>>>> it doesn't looks like author would like to implement tree-wide
>>>>> generalization first)    
>>>>
>>>> Well, if nobody is willing to generalize all target-specific code
>>>> right now, I don't see the harm in having cpu_model-based tables
>>>> in a few boards in the meantime (as this patch series does).  But
>>>> I do see harm in requiring all our 20 targets to implement yet
>>>> another hook and increasing the costs of cleaning up the mess
>>>> later.  
>>> If we use MachineClass hook then it might be done per target
>>> on demand, so no one would require that every target should
>>> implement it.
>>> Also there could be a generic helper for targets that do the same.
>>> Machine which needs to enable valid_cpus, will have to use generic
>>> hook impl or provide target specific if it's special case.
>>>
>>> Though I do see harm in adding cpu_model tables in boards code
>>> vs target specific hooks on demand as that will be copy-pasted
>>> in other boards afterwards (number of which is bigger compared
>>> to targets count) and ultimately it would duplicate cpu_name
>>> strings in every board vs hook approach where cpu_model could
>>> be calculated from cpu_type by a function (generic or
>>> target specific).
>>>
>>> Good thing about hook is that it's non intrusive and
>>> isolates(consolidates) existing cpu_type -> cpu_model
>>> conversion in multiple places into one place.
>>> Then later it would be easier to generalize if someone
>>> decides to do it.  
>>
>> I wonder how you want to proceed with this series, the first patch got
>> merged (c9cf636d48f) but after your "CPU model name" rework, this commit
>> seems now not very complete/usable.
>>
>> Rebasing this series, i.e. with this snippet:
>>
>> -- >8 --  
>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>> index f57fc38f92..cca4ec6648 100644
>> --- a/hw/arm/netduino2.c
>> +++ b/hw/arm/netduino2.c
>> @@ -34,7 +34,7 @@ static void netduino2_init(MachineState *machine)
>>      DeviceState *dev;
>>
>>      dev = qdev_create(NULL, TYPE_STM32F205_SOC);
>> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
>> +    qdev_prop_set_string(dev, "cpu-type", machine->cpu_type);
>>      object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
>>
>>      armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>> @@ -43,8 +43,14 @@ static void netduino2_init(MachineState *machine)
>>
>>  static void netduino2_machine_init(MachineClass *mc)
>>  {
>> +    static const char *valid_cpus[] = {
>> +        ARM_CPU_TYPE_NAME("cortex-m3"),
>> +        ARM_CPU_TYPE_NAME("cortex-m4"),
>> +        NULL
>> +    };
>>      mc->desc = "Netduino 2 Machine";
>>      mc->init = netduino2_init;
>> +    mc->valid_cpu_types = valid_cpus;
>>      mc->ignore_memory_transaction_failures = true;
>>  }
>> ---
>>
>> We get cpu names with suffix:
>>
>>   $ arm-softmmu/qemu-system-arm -M netduino2 -cpu arm926
>>   qemu-system-arm: Invalid CPU type: arm926-arm-cpu
>>   The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>>
>> I understand you won't want a global cpu_name_by_type_name, how do you
>> want to do then?
>>
>> Should we define an automatically expanded TARGET_CPU_TYPE_SUFFIX?
>> Then we could have generic machine code to parse the names.
> It would work only for some cases,
> problem is that we have a zoo of naming schemes.
> Considering that cpus models are used widely we probably can't
> deprecate it outright (for versioned machine types).  
> 
> Instead of wasting resources on translating cpu-type => 'cpu-name',
> (hook or lookup tables) how about simplifying code and making all
> boards accept full typenames?
> 
> It could be handled in generic way and then printing error with
> full type names would be acceptable since user would be able to feed it
> to -cpu.
> 
> '-cpu help' - would need some work to display types as well (also could be generic)
> 
> Perhaps with it we could deprecate cpu_models for non versioned
> machines/targets, which in most cases would allow us to drop special
> suffix/prefix/nonsense/case-sensitive/substitutions and whatever else
> is already existing and keep exiting translation routines (hooks) only
> for versioned machine types as necessary evil.

Yes. Eduardo and you should write some lines to explain this, and then
we will follow :)

I feel concerned because:
1/ Alistair series is very helpful to new users, and
2/ As the RX architecture series showed, today it is not very clear how
to correctly use cpu_models.

Eduardo is working on a series, I'll wait for his work.

Regards,

Phil.

