Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E01FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6164C20575
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6164C20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdHG-00040v-IQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 16:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQdGJ-0003DN-NI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 16:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQdGI-0005jQ-Nh
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 16:43:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jQdGI-0005iZ-3C
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 16:43:26 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MF39M-1jSsJT0Jaq-00FS5R; Mon, 20 Apr 2020 22:43:19 +0200
To: KONRAD Frederic <frederic.konrad@adacore.com>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
 <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
Message-ID: <16709c4c-afe1-f6d6-8535-a0717483cc88@vivier.eu>
Date: Mon, 20 Apr 2020 22:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pt9JwYeUrvOcNbGf3z3T2pcW/85UETdUPtHQPMT3eB9Vdc21smC
 2YUI4k4LIFDXBJxWBpY5pgmiD+nvwNqj703pds6Qm1k7DI89eOhY9JwpzhPkxH9I07bVYdb
 Osjrmb48XnSUZ8CTNfa+Gkt8CE7kCYa8wCcly+k6ZumRko3/oCsOpSlzB7RUXjNblZn8auh
 ENbo4DwFUMZZW+k6HifTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ZldvtjNV9E=:Nek8jAuUVpQDYI9VDjWUjY
 U/qkiSqMOrrqN9+lflE2zHWjTG/hRZv6XVOUPSC5hkLrT/cLeGbmi2sKqe5mLdANNgsNsqP+4
 iqEXLOM082ksWaQUI9daqlRLM8rn4bGCNq7rXD8dxCcmoZtbEHTvUy5ttSNJdmqKd/12DXRuZ
 0XsMI/5mLEXro0DvaFDZNVptg8u6Ighl0qO0OIIXm1mEQrvYPD9Wq1RtSYYN7HKmsiGC/J+y/
 cDywZXKxy/2jsMv9QxcO1FTe1lfweBiKKesnNScbdaxZBA5q1APD/+nvsX8x4j1EskCNvrzvF
 CI+2hPgFv9OYlJNQnZAQ2j1kXyQWdAZZl9xTCOapMWamCUPAKSyjj+QRwFu0300NEhOUxtSfV
 BEA/QPwcY4Np4GUREEieBlRX6LyUvBt9qtqaNZ5F3H3fENJd7nDmZwDirCiGVTmr0gftQOgTt
 DvWSWOXvN3vARP6TxH5rvMyzuyAIK8qILyDdanXnUwmwO3OZtZHk5+KLyPExXuMQDQcINXVwW
 sffzSO2XOoG0T80m3FqhFG0wX7oKfQPvGwTSW0UQPaL6IeUUEpIgxd4MeSBu84tLFPmmqYMTX
 m05wFUxxkOE8BoR3bUhnIO4SxFuGm/hep1VluGJhrL0q4WeUZRhuNUzZNbVexK6LcZf+x4atm
 /CB5skdLT0CuBPiWv1Exwv7QryCm0UAaISQ/n4kwRJ/0RoaUEhPsFTRwE/nHlDqFJnPUNV+KT
 Va/fhm90Qf00frIn3qL94LiL6n3fsyDvKyQDOlk31PzHyMeEsWwAW1m3Rn5cunYZbGaGx5xqZ
 edWfUa7wWcjgp7u2nsHWTwOC9mI1fPUKgb+HXmgvTaVwKcCkJtJBrJPRNa3x3QNm1NZYQ4Y
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 16:43:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.133
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

Le 20/04/2020 à 21:08, KONRAD Frederic a écrit :
> 
> 
> Le 4/20/20 à 5:46 PM, Laurent Vivier a écrit :
>> Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>
>>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor. 
>>> Thing is
>>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then
>>> expects
>>> a coldfire FPU instead of the default m68881 FPU.
>>
>>
>> I checked in gdb sources and there is no cf definition.
>>
>> Moreover if I change only the cf to m68k in QEMU it seems to work in
>> both cases:
>>
>> diff --git a/gdb-xml/cf-core.xml b/gdb-xml/cf-core.xml
>> index b90af3042c..5b092d26de 100644
>> --- a/gdb-xml/cf-core.xml
>> +++ b/gdb-xml/cf-core.xml
>> @@ -5,7 +5,7 @@
>>        are permitted in any medium without royalty provided the copyright
>>        notice and this notice are preserved.  -->
>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> -<feature name="org.gnu.gdb.coldfire.core">
>> +<feature name="org.gnu.gdb.m68k.core">
>>     <reg name="d0" bitsize="32"/>
>>     <reg name="d1" bitsize="32"/>
>>     <reg name="d2" bitsize="32"/>
> 
> Doesn't that break gdb with coldfire?
> 
>> diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
>> index 64290d1630..0ef74f7488 100644
>> --- a/gdb-xml/m68k-fp.xml
>> +++ b/gdb-xml/m68k-fp.xml
>> @@ -5,7 +5,7 @@
>>        are permitted in any medium without royalty provided the copyright
>>        notice and this notice are preserved.  -->
>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> -<feature name="org.gnu.gdb.coldfire.fp">
>> +<feature name="org.gnu.gdb.m68k.fp">
>>     <reg name="fp0" bitsize="96" type="float" group="float"/>
>>     <reg name="fp1" bitsize="96" type="float" group="float"/>
>>     <reg name="fp2" bitsize="96" type="float" group="float"/>
>>
>> As I have not checked the gdb sources for that, I'd like to have your
>> opinion.
> 
> In the GDB 8.3 sources: m68k-tdep.c:1091:
> 
>       feature = tdesc_find_feature (info.target_desc,
>                     "org.gnu.gdb.m68k.core");
>       if (feature == NULL)
>     {
>       feature = tdesc_find_feature (info.target_desc,
>                     "org.gnu.gdb.coldfire.core");
>       if (feature != NULL)
>         flavour = m68k_coldfire_flavour;
>     }
> 
> Hence the change I suggested.  Little later it has also:
> 
>       feature = tdesc_find_feature (info.target_desc,
>                     "org.gnu.gdb.coldfire.fp");
>       if (feature != NULL)
>     {
>       valid_p = 1;
>       for (i = M68K_FP0_REGNUM; i <= M68K_FPI_REGNUM; i++)
>         valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
>                         m68k_register_names[i]);
>       if (!valid_p)
>         {
>           tdesc_data_cleanup (tdesc_data);
>           return NULL;
>         }
>     }
>       else
>     has_fp = 0;
> 
> Which is why I didn't made the change you suggested about the
> m68k-fp.xml but I
> just tried with this additional change and it doesn't seem to hurt.

Thank you for your analysis, it seems a simpler patch works with
coldfire and m68k.

diff --git a/configure b/configure
index 23b5e93752..b3be6d9c4b 100755
--- a/configure
+++ b/configure
@@ -7825,7 +7825,7 @@ case "$target_name" in
   ;;
   m68k)
     bflt="yes"
-    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
+    gdb_xml_files="m68k-core.xml cf-fp.xml m68k-fp.xml"
     TARGET_SYSTBL_ABI=common
   ;;
   microblaze|microblazeel)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9445fcd6df..4e942a0a8e 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -292,7 +292,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void
*data)
     cc->tcg_initialize = m68k_tcg_init;

     cc->gdb_num_core_regs = 18;
-    cc->gdb_core_xml_file = "cf-core.xml";
+    cc->gdb_core_xml_file = "m68k-core.xml";

     dc->vmsd = &vmstate_m68k_cpu;
 }
diff --git a/gdb-xml/cf-core.xml b/gdb-xml/m68k-core.xml
similarity index 96%
rename from gdb-xml/cf-core.xml
rename to gdb-xml/m68k-core.xml
index b90af3042c..5b092d26de 100644
--- a/gdb-xml/cf-core.xml
+++ b/gdb-xml/m68k-core.xml
@@ -5,7 +5,7 @@
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.coldfire.core">
+<feature name="org.gnu.gdb.m68k.core">
   <reg name="d0" bitsize="32"/>
   <reg name="d1" bitsize="32"/>
   <reg name="d2" bitsize="32"/>
diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
index 64290d1630..0ef74f7488 100644
--- a/gdb-xml/m68k-fp.xml
+++ b/gdb-xml/m68k-fp.xml
@@ -5,7 +5,7 @@
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.coldfire.fp">
+<feature name="org.gnu.gdb.m68k.fp">
   <reg name="fp0" bitsize="96" type="float" group="float"/>
   <reg name="fp1" bitsize="96" type="float" group="float"/>
   <reg name="fp2" bitsize="96" type="float" group="float"/>

I have tested with both architectures:

* -M q800:

(gdb) info float
fp0            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp1            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp2            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp3            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp4            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp5            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp6            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fp7            nan(0xffffffffffffffff) (raw 0x7fff0000ffffffffffffffff)
fpcontrol      0x0                 0
fpstatus       0x0                 0
fpiaddr        0x0                 0x0
(gdb) info registers
d0             0x0                 0
d1             0x2                 2
d2             0x462a0             287392
d3             0x40                64
d4             0x0                 0
d5             0x0                 0
d6             0x0                 0
d7             0x0                 0
a0             0x3e0000            0x3e0000
a1             0x3e351c            0x3e351c
a2             0x3e351c            0x3e351c
a3             0x3e0000            0x3e0000
a4             0x46390             0x46390
a5             0x2eed7e            0x2eed7e
fp             0x2c65c             0x2c65c
sp             0x3e1fa4            0x3e1fa4
ps             0x2000              8192
pc             0x2f00              0x2f00
fpcontrol      0x0                 0
fpstatus       0x0                 0
fpiaddr        0x0                 0x0

* -cpu cfv4e

(gdb) info registers
d0             0x0                 0
d1             0x401c0b40          1075579712
d2             0x0                 0
d3             0x0                 0
d4             0x0                 0
d5             0x0                 0
d6             0x0                 0
d7             0x0                 0
a0             0x4015c008          0x4015c008
a1             0x40151092          0x40151092
a2             0x401146c8          0x401146c8
a3             0x4016b189          0x4016b189
a4             0x400ac60a          0x400ac60a
a5             0x40017078          0x40017078
fp             0x4015cff8          0x4015cff8
sp             0x4015cfcc          0x4015cfcc
ps             0x2000              8192
pc             0x40010a2a          0x40010a2a
fpcontrol      0x0                 0
fpstatus       0x0                 0
fpiaddr        0x0                 0x0
(gdb) info float
fp0            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp1            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp2            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp3            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp4            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp5            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp6            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fp7            nan(0xfffffffffffff) (raw 0x7fffffffffffffff)
fpcontrol      0x0                 0
fpstatus       0x0                 0
fpiaddr        0x0                 0x0


All with a native GDB from debian/sid (GNU gdb (Debian 9.1-3) 9.1).

Thanks,
Laurent

