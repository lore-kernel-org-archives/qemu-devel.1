Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC9DC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2CC20728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2CC20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSybS-0004F7-NC
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 03:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSyaY-0003UN-B6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSyaU-0006mt-Oc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:54:02 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jSyaU-0006mm-65
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:53:58 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MRBWU-1jnxNo42h2-00N928; Mon, 27 Apr 2020 09:53:49 +0200
To: frederic.konrad@adacore.com
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
Message-ID: <41ff1564-36ee-1028-b377-9bf9a82de689@vivier.eu>
Date: Mon, 27 Apr 2020 09:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BnOnwmftiJbtC8SZd6kilmZCjR8QoldIMTwoDRW4ZwrTX7W63q7
 P9Y1gcHV4KisjoVd1GTpfRpIzYv8OTUjWowTnfr1P95S0/qGFh7UAQXg4e2lpKp0cMBT+5D
 d5cfz1JNKlXN6/Bf5e9NvCF9HoMWrYBLL079qE6gRBY6DPlrL4AK6OlQ58m3V06BDEMos+X
 5fkrFYed4IQC1V40kQXaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NhLErODbXrc=:Ufyw2KOE9vSFV5e7GSZrg6
 Z/Aa5dzNIyoU5liNV/Rvw/q0/RmRncxIRuHFrqfc2hBQufgGJUYIaht1sM5VGqz86P9AUJb0X
 J1FU9s0iUTOWofKu4WtSJu0yIThJQQiSEc2iF2A+mAF0VJN0gKHFY4dAiVpP6kZSI/cCE4ktD
 xY7MqlDk1ZCCXQdzUwys2nQ6NZu2kCDc6iN+03uBNPf1CYJCwba6zG/SNkTnoqT2t0B8zBBkW
 vc5xHoYH1SXUpAE0lucoXPaYs9PrsPtcqrRqz/S/2gSDcIM8oZZpoy7eai2qlXMRnnEljcbjX
 hlAe8h0vTsOgEiGvepRm3EnKg7IbI0x1k7K/SHVS4gYPn6GHBiIJgGgNcM+MTX0SH6D3U7q61
 DvbDK0ZqsYHYZuITFoTfLAJwO2u4yX7LTX4gghGKcqlfn1FxUH3wo4LMs4t3ytDolWGGIYBYP
 a0eghhMxCauL7+eqj31/80Z5nVxKoQ3XADK39P/1aNrimdfDxbK7fghuthd+ehfXkLNtUSxro
 pV9W6/3/q8vFWvsYpDIr8wx3x+3gYc9oRXkT+wVwsHWlrD1s/HHvtJz3DNZF5wLEXPI1nZW9W
 Lcc5/P+TUm6fMAuWnauO1SZCuZsABgS+fhdPv9hb2F+4/ikXK8e10M2p0P/8GGSqBt02OPh9C
 L8xFfown0xoOUtQTZYd9nQClrdWxnBvvJ/2s8Des1XwG8qUjS3rjVuW0dLLi6eCpx440EFHM9
 V3FEzfDhobwarAMVNWHt1dBX6ayz8u+3B5iFGoE1AbwiBFS9jeJwhKgs9uoT8ZfCY6OVf3/HU
 BZXCdb6mgFiS5UTxAQHXxMMHrfO83XSxObQUUQO+hw+Bmd2qxBghSFeqtD7NfiSgl/UdI0q
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 03:53:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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

Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
> a coldfire FPU instead of the default m68881 FPU.
> 
> This is not OK because the m68881 floats registers are 96 bits wide so it
> crashes GDB with the following error message:
> 
> (gdb) target remote localhost:7960
> Remote debugging using localhost:7960
> warning: Register "fp0" has an unsupported size (96 bits)
> warning: Register "fp1" has an unsupported size (96 bits)
> ...
> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
>   00000000000[...]0000
> 
> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
> 
> (gdb) tar rem :1234
> Remote debugging using :1234
> warning: No executable has been specified and target does not support
> determining executable automatically.  Try using the "file" command.
> 0x00000000 in ?? ()
> (gdb) p $fp0
> $1 = nan(0xffffffffffffffff)
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  configure             |  2 +-
>  gdb-xml/m68k-core.xml | 29 +++++++++++++++++++++++++++++
>  target/m68k/cpu.c     | 30 +++++++++++++++++++++++++-----
>  3 files changed, 55 insertions(+), 6 deletions(-)
>  create mode 100644 gdb-xml/m68k-core.xml
> 
> diff --git a/configure b/configure
> index 23b5e93..2b07b85 100755
> --- a/configure
> +++ b/configure
> @@ -7825,7 +7825,7 @@ case "$target_name" in
>    ;;
>    m68k)
>      bflt="yes"
> -    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
> +    gdb_xml_files="cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
>      TARGET_SYSTBL_ABI=common
>    ;;
>    microblaze|microblazeel)
> diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
> new file mode 100644
> index 0000000..5b092d2
> --- /dev/null
> +++ b/gdb-xml/m68k-core.xml
> @@ -0,0 +1,29 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2008 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.m68k.core">
> +  <reg name="d0" bitsize="32"/>
> +  <reg name="d1" bitsize="32"/>
> +  <reg name="d2" bitsize="32"/>
> +  <reg name="d3" bitsize="32"/>
> +  <reg name="d4" bitsize="32"/>
> +  <reg name="d5" bitsize="32"/>
> +  <reg name="d6" bitsize="32"/>
> +  <reg name="d7" bitsize="32"/>
> +  <reg name="a0" bitsize="32" type="data_ptr"/>
> +  <reg name="a1" bitsize="32" type="data_ptr"/>
> +  <reg name="a2" bitsize="32" type="data_ptr"/>
> +  <reg name="a3" bitsize="32" type="data_ptr"/>
> +  <reg name="a4" bitsize="32" type="data_ptr"/>
> +  <reg name="a5" bitsize="32" type="data_ptr"/>
> +  <reg name="fp" bitsize="32" type="data_ptr"/>
> +  <reg name="sp" bitsize="32" type="data_ptr"/>
> +
> +  <reg name="ps" bitsize="32"/>
> +  <reg name="pc" bitsize="32" type="code_ptr"/>
> +
> +</feature>
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 9445fcd..976e624 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -297,6 +297,21 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>      dc->vmsd = &vmstate_m68k_cpu;
>  }
>  
> +static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
> +{
> +    CPUClass *cc = CPU_CLASS(c);
> +
> +    cc->gdb_core_xml_file = "m68k-core.xml";
> +}

Could you also add a m68k_cpu_class_init_cf_core() and move the
cf-core.xml into it?

> +
> +#define DEFINE_M68K_CPU_TYPE_WITH_CLASS(cpu_model, initfn, classinit)      \
> +    {                                                                      \
> +        .name = M68K_CPU_TYPE_NAME(cpu_model),                             \
> +        .instance_init = initfn,                                           \
> +        .parent = TYPE_M68K_CPU,                                           \
> +        .class_init = classinit,                                           \
> +    }
> +

I would prefer to have two macros with no class parameter, something
like DEFINE_M68K_CPU_TYPE_M68K() and DEFINE_M68K_CPU_TYPE_CF().

>  #define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
>      {                                           \
>          .name = M68K_CPU_TYPE_NAME(cpu_model),  \
> @@ -314,11 +329,16 @@ static const TypeInfo m68k_cpus_type_infos[] = {
>          .class_size = sizeof(M68kCPUClass),
>          .class_init = m68k_cpu_class_init,
>      },
> -    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68000", m68000_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68020", m68020_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68030", m68030_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68040", m68040_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68060", m68060_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
>      DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),
> 

I think we can also have something like
DEFINE_M68K_CPU_TYPE_M68K(m68000) or DEFINE_M68K_CPU_TYPE_CF(m5206) and
deduce initfn function name from the macro parameter.

Thanks,
Laurent

