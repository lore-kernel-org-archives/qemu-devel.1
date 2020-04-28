Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B10C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23D1206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23D1206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQBC-0007Pz-0H
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:21:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTQ9Y-0003wJ-Mn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTQ94-0006gS-Hc
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:20:00 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:54403
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jTQ93-0006fr-UC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:19:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 1ED6781343;
 Tue, 28 Apr 2020 15:19:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tMA8I0k2P5h0; Tue, 28 Apr 2020 15:19:26 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id A269281339;
 Tue, 28 Apr 2020 15:19:25 +0200 (CEST)
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
To: Laurent Vivier <laurent@vivier.eu>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <41ff1564-36ee-1028-b377-9bf9a82de689@vivier.eu>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <99b80245-4109-03c4-4c7c-e562477ec76b@adacore.com>
Date: Tue, 28 Apr 2020 15:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <41ff1564-36ee-1028-b377-9bf9a82de689@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2ab8:224:1::a0a:d2;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: huth@tuxfamily.org, alex.bennee@linaro.org, f4bug@amsat.org,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pierre@freepascal.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/27/20 à 9:53 AM, Laurent Vivier a écrit :
> Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>
>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
>> a coldfire FPU instead of the default m68881 FPU.
>>
>> This is not OK because the m68881 floats registers are 96 bits wide so it
>> crashes GDB with the following error message:
>>
>> (gdb) target remote localhost:7960
>> Remote debugging using localhost:7960
>> warning: Register "fp0" has an unsupported size (96 bits)
>> warning: Register "fp1" has an unsupported size (96 bits)
>> ...
>> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
>>    00000000000[...]0000
>>
>> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
>>
>> (gdb) tar rem :1234
>> Remote debugging using :1234
>> warning: No executable has been specified and target does not support
>> determining executable automatically.  Try using the "file" command.
>> 0x00000000 in ?? ()
>> (gdb) p $fp0
>> $1 = nan(0xffffffffffffffff)
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   configure             |  2 +-
>>   gdb-xml/m68k-core.xml | 29 +++++++++++++++++++++++++++++
>>   target/m68k/cpu.c     | 30 +++++++++++++++++++++++++-----
>>   3 files changed, 55 insertions(+), 6 deletions(-)
>>   create mode 100644 gdb-xml/m68k-core.xml
>>
>> diff --git a/configure b/configure
>> index 23b5e93..2b07b85 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7825,7 +7825,7 @@ case "$target_name" in
>>     ;;
>>     m68k)
>>       bflt="yes"
>> -    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
>> +    gdb_xml_files="cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
>>       TARGET_SYSTBL_ABI=common
>>     ;;
>>     microblaze|microblazeel)
>> diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
>> new file mode 100644
>> index 0000000..5b092d2
>> --- /dev/null
>> +++ b/gdb-xml/m68k-core.xml
>> @@ -0,0 +1,29 @@
>> +<?xml version="1.0"?>
>> +<!-- Copyright (C) 2008 Free Software Foundation, Inc.
>> +
>> +     Copying and distribution of this file, with or without modification,
>> +     are permitted in any medium without royalty provided the copyright
>> +     notice and this notice are preserved.  -->
>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> +<feature name="org.gnu.gdb.m68k.core">
>> +  <reg name="d0" bitsize="32"/>
>> +  <reg name="d1" bitsize="32"/>
>> +  <reg name="d2" bitsize="32"/>
>> +  <reg name="d3" bitsize="32"/>
>> +  <reg name="d4" bitsize="32"/>
>> +  <reg name="d5" bitsize="32"/>
>> +  <reg name="d6" bitsize="32"/>
>> +  <reg name="d7" bitsize="32"/>
>> +  <reg name="a0" bitsize="32" type="data_ptr"/>
>> +  <reg name="a1" bitsize="32" type="data_ptr"/>
>> +  <reg name="a2" bitsize="32" type="data_ptr"/>
>> +  <reg name="a3" bitsize="32" type="data_ptr"/>
>> +  <reg name="a4" bitsize="32" type="data_ptr"/>
>> +  <reg name="a5" bitsize="32" type="data_ptr"/>
>> +  <reg name="fp" bitsize="32" type="data_ptr"/>
>> +  <reg name="sp" bitsize="32" type="data_ptr"/>
>> +
>> +  <reg name="ps" bitsize="32"/>
>> +  <reg name="pc" bitsize="32" type="code_ptr"/>
>> +
>> +</feature>
>> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
>> index 9445fcd..976e624 100644
>> --- a/target/m68k/cpu.c
>> +++ b/target/m68k/cpu.c
>> @@ -297,6 +297,21 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>>       dc->vmsd = &vmstate_m68k_cpu;
>>   }
>>   
>> +static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
>> +{
>> +    CPUClass *cc = CPU_CLASS(c);
>> +
>> +    cc->gdb_core_xml_file = "m68k-core.xml";
>> +}
> 
> Could you also add a m68k_cpu_class_init_cf_core() and move the
> cf-core.xml into it?

Yes I can do that:
   - DEFINE_M68K_CPU_TYPE_M68K will use m68k_cpu_class_init_m68k_core.
   - DEFINE_M68K_CPU_TYPE_CF will use m68k_cpu_class_init_cf_core.
   - drop xxx_WITH_CLASS behind.

> 
>> +
>> +#define DEFINE_M68K_CPU_TYPE_WITH_CLASS(cpu_model, initfn, classinit)      \
>> +    {                                                                      \
>> +        .name = M68K_CPU_TYPE_NAME(cpu_model),                             \
>> +        .instance_init = initfn,                                           \
>> +        .parent = TYPE_M68K_CPU,                                           \
>> +        .class_init = classinit,                                           \
>> +    }
>> +
> 
> I would prefer to have two macros with no class parameter, something
> like DEFINE_M68K_CPU_TYPE_M68K() and DEFINE_M68K_CPU_TYPE_CF().
> 
>>   #define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
>>       {                                           \
>>           .name = M68K_CPU_TYPE_NAME(cpu_model),  \
>> @@ -314,11 +329,16 @@ static const TypeInfo m68k_cpus_type_infos[] = {
>>           .class_size = sizeof(M68kCPUClass),
>>           .class_init = m68k_cpu_class_init,
>>       },
>> -    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
>> -    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
>> -    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
>> -    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
>> -    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
>> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68000", m68000_cpu_initfn,
>> +                                    m68k_cpu_class_init_m68k_core),
>> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68020", m68020_cpu_initfn,
>> +                                    m68k_cpu_class_init_m68k_core),
>> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68030", m68030_cpu_initfn,
>> +                                    m68k_cpu_class_init_m68k_core),
>> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68040", m68040_cpu_initfn,
>> +                                    m68k_cpu_class_init_m68k_core),
>> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68060", m68060_cpu_initfn,
>> +                                    m68k_cpu_class_init_m68k_core),
>>       DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
>>       DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
>>       DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),

But what about the "any" which is out of context here?

     DEFINE_M68K_CPU_TYPE("any", any_cpu_initfn),

Should it be TYPE_M68K or TYPE_CF in which case which xml will it take?  I guess
we can take TYPE_CF so it doesn't change from what is done today.

>>
> 
> I think we can also have something like
> DEFINE_M68K_CPU_TYPE_M68K(m68000) or DEFINE_M68K_CPU_TYPE_CF(m5206) and
> deduce initfn function name from the macro parameter.
> 

Why not.

Fred

> Thanks,
> Laurent
> 

