Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91385C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C672087E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C672087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpX4-0006X8-Hc
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQpVT-0004s2-Nx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQpVP-000461-GS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:47:55 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46258
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jQpVO-000430-ST
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:47:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 632E181339;
 Tue, 21 Apr 2020 11:47:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFXyb7h4Xy9W; Tue, 21 Apr 2020 11:47:47 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 18308812EF;
 Tue, 21 Apr 2020 11:47:47 +0200 (CEST)
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
To: Laurent Vivier <laurent@vivier.eu>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
 <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
 <16709c4c-afe1-f6d6-8535-a0717483cc88@vivier.eu>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <68a84047-113e-bec4-7f25-800b83c5c5d0@adacore.com>
Date: Tue, 21 Apr 2020 11:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <16709c4c-afe1-f6d6-8535-a0717483cc88@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.98.77.210;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 05:47:47
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
Cc: huth@tuxfamily.org, alex.bennee@linaro.org, f4bug@amsat.org,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pierre@freepascal.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/20/20 à 10:43 PM, Laurent Vivier a écrit :
> Le 20/04/2020 à 21:08, KONRAD Frederic a écrit :
>>
>>
>> Le 4/20/20 à 5:46 PM, Laurent Vivier a écrit :
>>> Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
>>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>>
>>>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.
>>>> Thing is
>>>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then
>>>> expects
>>>> a coldfire FPU instead of the default m68881 FPU.
>>>
>>>
>>> I checked in gdb sources and there is no cf definition.
>>>
>>> Moreover if I change only the cf to m68k in QEMU it seems to work in
>>> both cases:
>>>
>>> diff --git a/gdb-xml/cf-core.xml b/gdb-xml/cf-core.xml
>>> index b90af3042c..5b092d26de 100644
>>> --- a/gdb-xml/cf-core.xml
>>> +++ b/gdb-xml/cf-core.xml
>>> @@ -5,7 +5,7 @@
>>>         are permitted in any medium without royalty provided the copyright
>>>         notice and this notice are preserved.  -->
>>>    <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>> -<feature name="org.gnu.gdb.coldfire.core">
>>> +<feature name="org.gnu.gdb.m68k.core">
>>>      <reg name="d0" bitsize="32"/>
>>>      <reg name="d1" bitsize="32"/>
>>>      <reg name="d2" bitsize="32"/>
>>
>> Doesn't that break gdb with coldfire?
>>
>>> diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
>>> index 64290d1630..0ef74f7488 100644
>>> --- a/gdb-xml/m68k-fp.xml
>>> +++ b/gdb-xml/m68k-fp.xml
>>> @@ -5,7 +5,7 @@
>>>         are permitted in any medium without royalty provided the copyright
>>>         notice and this notice are preserved.  -->
>>>    <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>> -<feature name="org.gnu.gdb.coldfire.fp">
>>> +<feature name="org.gnu.gdb.m68k.fp">
>>>      <reg name="fp0" bitsize="96" type="float" group="float"/>
>>>      <reg name="fp1" bitsize="96" type="float" group="float"/>
>>>      <reg name="fp2" bitsize="96" type="float" group="float"/>
>>>
>>> As I have not checked the gdb sources for that, I'd like to have your
>>> opinion.
>>
>> In the GDB 8.3 sources: m68k-tdep.c:1091:
>>
>>        feature = tdesc_find_feature (info.target_desc,
>>                      "org.gnu.gdb.m68k.core");
>>        if (feature == NULL)
>>      {
>>        feature = tdesc_find_feature (info.target_desc,
>>                      "org.gnu.gdb.coldfire.core");
>>        if (feature != NULL)
>>          flavour = m68k_coldfire_flavour;
>>      }
>>
>> Hence the change I suggested.  Little later it has also:
>>
>>        feature = tdesc_find_feature (info.target_desc,
>>                      "org.gnu.gdb.coldfire.fp");
>>        if (feature != NULL)
>>      {
>>        valid_p = 1;
>>        for (i = M68K_FP0_REGNUM; i <= M68K_FPI_REGNUM; i++)
>>          valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
>>                          m68k_register_names[i]);
>>        if (!valid_p)
>>          {
>>            tdesc_data_cleanup (tdesc_data);
>>            return NULL;
>>          }
>>      }
>>        else
>>      has_fp = 0;
>>
>> Which is why I didn't made the change you suggested about the
>> m68k-fp.xml but I
>> just tried with this additional change and it doesn't seem to hurt.
> 
> Thank you for your analysis, it seems a simpler patch works with
> coldfire and m68k.

Hi Laurent,

Arg sorry I though I said that in an other email but apparently I forgot to hit
the send button.  The issue with this simpler patch is that GDB will not set:

   flavour = m68k_coldfire_flavour

when we are running coldfire emulation, and that might break the ABI within GDB.
According to the comments there, float are returned within D0 for ColdFire and
not the other one.  That's why I cared to keep them separate ie: send the right
"feature name" for the right cpu we are modelling.

> 
> diff --git a/configure b/configure
> index 23b5e93752..b3be6d9c4b 100755
> --- a/configure
> +++ b/configure
> @@ -7825,7 +7825,7 @@ case "$target_name" in
>     ;;
>     m68k)
>       bflt="yes"
> -    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
> +    gdb_xml_files="m68k-core.xml cf-fp.xml m68k-fp.xml"
>       TARGET_SYSTBL_ABI=common
>     ;;
>     microblaze|microblazeel)
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 9445fcd6df..4e942a0a8e 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -292,7 +292,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void
> *data)
>       cc->tcg_initialize = m68k_tcg_init;
> 
>       cc->gdb_num_core_regs = 18;
> -    cc->gdb_core_xml_file = "cf-core.xml";
> +    cc->gdb_core_xml_file = "m68k-core.xml";
> 
>       dc->vmsd = &vmstate_m68k_cpu;
>   }
> diff --git a/gdb-xml/cf-core.xml b/gdb-xml/m68k-core.xml
> similarity index 96%
> rename from gdb-xml/cf-core.xml
> rename to gdb-xml/m68k-core.xml
> index b90af3042c..5b092d26de 100644
> --- a/gdb-xml/cf-core.xml
> +++ b/gdb-xml/m68k-core.xml
> @@ -5,7 +5,7 @@
>        are permitted in any medium without royalty provided the copyright
>        notice and this notice are preserved.  -->
>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> -<feature name="org.gnu.gdb.coldfire.core">
> +<feature name="org.gnu.gdb.m68k.core">
>     <reg name="d0" bitsize="32"/>
>     <reg name="d1" bitsize="32"/>
>     <reg name="d2" bitsize="32"/>
> diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
> index 64290d1630..0ef74f7488 100644
> --- a/gdb-xml/m68k-fp.xml
> +++ b/gdb-xml/m68k-fp.xml
> @@ -5,7 +5,7 @@
>        are permitted in any medium without royalty provided the copyright
>        notice and this notice are preserved.  -->
>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> -<feature name="org.gnu.gdb.coldfire.fp">
> +<feature name="org.gnu.gdb.m68k.fp">
>     <reg name="fp0" bitsize="96" type="float" group="float"/>
>     <reg name="fp1" bitsize="96" type="float" group="float"/>
>     <reg name="fp2" bitsize="96" type="float" group="float"/>
> 
> I have tested with both architectures:
> 
> * -M q800:
> 
> (gdb) info float
> fp0            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp1            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp2            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp3            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp4            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp5            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp6            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fp7            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
> fpcontrol      0x0                 0
> fpstatus       0x0                 0
> fpiaddr        0x0                 0x0
> (gdb) info registers
> d0             0x0                 0
> d1             0x2                 2
> d2             0x462a0             287392
> d3             0x40                64
> d4             0x0                 0
> d5             0x0                 0
> d6             0x0                 0
> d7             0x0                 0
> a0             0x3e0000            0x3e0000
> a1             0x3e351c            0x3e351c
> a2             0x3e351c            0x3e351c
> a3             0x3e0000            0x3e0000
> a4             0x46390             0x46390
> a5             0x2eed7e            0x2eed7e
> fp             0x2c65c             0x2c65c
> sp             0x3e1fa4            0x3e1fa4
> ps             0x2000              8192
> pc             0x2f00              0x2f00
> fpcontrol      0x0                 0
> fpstatus       0x0                 0
> fpiaddr        0x0                 0x0
> 
> * -cpu cfv4e
> 
> (gdb) info registers
> d0             0x0                 0
> d1             0x401c0b40          1075579712
> d2             0x0                 0
> d3             0x0                 0
> d4             0x0                 0
> d5             0x0                 0
> d6             0x0                 0
> d7             0x0                 0
> a0             0x4015c008          0x4015c008
> a1             0x40151092          0x40151092
> a2             0x401146c8          0x401146c8
> a3             0x4016b189          0x4016b189
> a4             0x400ac60a          0x400ac60a
> a5             0x40017078          0x40017078
> fp             0x4015cff8          0x4015cff8
> sp             0x4015cfcc          0x4015cfcc
> ps             0x2000              8192
> pc             0x40010a2a          0x40010a2a
> fpcontrol      0x0                 0
> fpstatus       0x0                 0
> fpiaddr        0x0                 0x0
> (gdb) info float
> fp0            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp1            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp2            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp3            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp4            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp5            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp6            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fp7            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
> fpcontrol      0x0                 0
> fpstatus       0x0                 0
> fpiaddr        0x0                 0x0
> 
> 
> All with a native GDB from debian/sid (GNU gdb (Debian 9.1-3) 9.1).
> 
> Thanks,
> Laurent
> 

