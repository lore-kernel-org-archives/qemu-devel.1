Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AF1C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4894720782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4894720782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbZo-0007RM-9z
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48462 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQbZ0-0006s0-T4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:54:39 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQbYw-0007Ze-2H
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:54:36 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:37396
 helo=smtp.eu.adacore.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jQbYv-0007W9-GW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:54:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 6FE2381345;
 Mon, 20 Apr 2020 20:54:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EvNwWjprxfhN; Mon, 20 Apr 2020 20:54:31 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 1D53281339;
 Mon, 20 Apr 2020 20:54:31 +0200 (CEST)
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <877dyadtje.fsf@linaro.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <52816d2b-9ace-9933-34d0-1434bc91861f@adacore.com>
Date: Mon, 20 Apr 2020 20:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <877dyadtje.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.98.77.210;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 14:54:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org, laurent@vivier.eu,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pierre@freepascal.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/20/20 à 6:13 PM, Alex Bennée a écrit :
> 
> frederic.konrad@adacore.com writes:
> 
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
> 
> Well it solves the connection issue - but the FP values are still
> hopelessly broken, from float_convs:
> 
>    from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
> 
> in gdb
> 
>    fp0            <invalid float value> (raw 0x8c3a5900000000004066)

Hi Alex, do you have a reproducer?

With this simple example:
=========================

.global _start
.text
_start:
         lea val, %a0
         fmoves (%a0),%fp0
         fmoves 4(%a0), %fp1
end:
         bra end

.align 0x4
val:
         .float 0.12345678
         .float 3.141592653589793

$ m68k-linux-gnu-gcc -g -Wl,-Ttext=0 main.S -mcpu=68020 -nostdlib -o main.elf
$ m68k-linux-gnu-objdump -d main.elf

main.elf:     file format elf32-m68k

Disassembly of section .text:

00000000 <_start>:
    0:	41fa 0012      	lea %pc@(14 <val>),%a0
    4:	f210 4400      	fmoves %a0@,%fp0
    8:	f228 4480 0004 	fmoves %a0@(4),%fp1

0000000e <end>:
    e:	6000 fffe      	braw e <end>
	...

00000014 <val>:
   14:	3dfc           	.short 0x3dfc
   16:	d6e9 4049      	addaw %a1@(16457),%a3
   1a:	0fdb           	bset %d7,%a3@+

I can run the executable in 5.0-rc3 + the patch:
================================================

$ xxx/qemu-for-upstream.git/m68k-softmmu/qemu-system-m68k --kernel main.elf \
     -cpu m68020 -s -S -nographic

And a GDB 8.3 I just built:
===========================

$ xxx/bin/m68k-elf-gdb main.elf
GNU gdb (GDB) 8.3
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "--host=x86_64-pc-linux-gnu --target=m68k-elf".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from main.elf...
(gdb) tar rem :1234
Remote debugging using :1234
_start () at main.S:5
5	        lea val, %a0
(gdb) b end
Breakpoint 1 at 0xe: file main.S, line 9.
(gdb) c
Continuing.

Breakpoint 1, end () at main.S:9
9	        bra end
(gdb) info registers all
d0             0x0                 0
d1             0x0                 0
d2             0x0                 0
d3             0x0                 0
d4             0x0                 0
d5             0x0                 0
d6             0x0                 0
d7             0x0                 0
a0             0x14                0x14 <val>
a1             0x0                 0x0 <_start>
a2             0x0                 0x0 <_start>
a3             0x0                 0x0 <_start>
a4             0x0                 0x0 <_start>
a5             0x0                 0x0 <_start>
fp             0x0                 0x0 <_start>
sp             0x0                 0x0 <_start>
ps             0x2700              9984
pc             0xe                 0xe <end>
fp0            0.123456783592700958252 (raw 0x3ffb0000fcd6e90000000000)
fp1            3.14159274101257324219 (raw 0x40000000c90fdb0000000000)
fp2            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp3            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp4            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp5            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp6            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp7            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fpcontrol      0x0                 0
fpstatus       0x0                 0
fpiaddr        0x0                 0x0 <_start>

The value doesn't seems to much broken, the monitor gives me:

(qemu) info registers
D0 = 00000000   A0 = 00000014   F0 = 3ffb fcd6e90000000000  (    0.123457)
D1 = 00000000   A1 = 00000000   F1 = 4000 c90fdb0000000000  (     3.14159)
D2 = 00000000   A2 = 00000000   F2 = 7fff ffffffffffffffff  (         nan)
D3 = 00000000   A3 = 00000000   F3 = 7fff ffffffffffffffff  (         nan)
D4 = 00000000   A4 = 00000000   F4 = 7fff ffffffffffffffff  (         nan)
D5 = 00000000   A5 = 00000000   F5 = 7fff ffffffffffffffff  (         nan)
D6 = 00000000   A6 = 00000000   F6 = 7fff ffffffffffffffff  (         nan)
D7 = 00000000   A7 = 00000000   F7 = 7fff ffffffffffffffff  (         nan)

Did I miss anything?

Cheers,
Fred

> 
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
>> +
>> +#define DEFINE_M68K_CPU_TYPE_WITH_CLASS(cpu_model, initfn, classinit)      \
>> +    {                                                                      \
>> +        .name = M68K_CPU_TYPE_NAME(cpu_model),                             \
>> +        .instance_init = initfn,                                           \
>> +        .parent = TYPE_M68K_CPU,                                           \
>> +        .class_init = classinit,                                           \
>> +    }
>> +
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
> 
> 

