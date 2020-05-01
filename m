Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83372C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B36E20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B36E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUX2K-00078E-D6
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jUWzv-0003w9-UV
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jUWwN-0002Hf-8g
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:50:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jUWwM-0002DG-I0
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:46:58 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MkHEN-1ikint3NMH-00kipP; Fri, 01 May 2020 16:46:53 +0200
Subject: Re: [PATCH v1 9/9] target/m68k: fix gdb for m68xxx
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-10-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b2cd8a9f-fa4a-e953-1950-537068fb4253@vivier.eu>
Date: Fri, 1 May 2020 16:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uoWAGwC2RJD21c408vXWzHrjCIkE3oIOY2dPSoyYLoDKzz5V0XQ
 81WHt5DJjUyPfiQ+XIvFy1F0AtQekqHlYxUM05jve3vhjHhFbTaoC+DF+S4nDCDmVrrrg0S
 8IV0tsKLhmD2ULK25XnAiKfXRNjwubx8sEnAikA6tc8ECEr1mZ8+tSB/uPr3Hjh+but0Vh8
 l1Kjuk2OiQmVVGOPx4lPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WQQHSAI3DsE=:qskP8e6JfVI9OeNXPGEje7
 LR9pb+Hkn/d6Ou4/tekn5HGxABe7daM6QJIEtMMlNaB3S03y72zXSxG2vZbg6tSGo9ySHMlgU
 MGlmalfLhTe12FOseRJTa4bkPrbCW3Lui2mmDDTC8lFNyFwCDDI4Hhq1qgM6Q96G4N9sp/zpT
 vPr2Lb6VvlzM245nTfow7tIkSKzOn7ZaPT82mcyX2ba5nzMOiYvYzAhyFYlJP1sIyMXvSP0Wu
 YtFlYabnS9LpvUn77+MdFQgl771IIBmfWWVxozGBwbuImFiBF/SDiUXBfcuVZfKnOx+ZV9a8d
 Z50SrU+7m8oHt2a3/BDEsWFCEp0GvhvpmwmMzJzf85enFVMATDf1C4jNPXMbemiIyaVLIiur/
 hR1rkuaDsz5ou4IT8cS0BH2MWEFX0z3B29HdgtUbYVJQOyQsQdlI+pTZinck4SvKye9MvbW+c
 3nekzewDB1K3TsB8/p5XA892mRdwS8hFj5fYAWSqA+J2p6U24PVqPb/MPYBS5jaAKd2TJhSKG
 telf97DES3yvmezzMBBGqJJKhD3hk7as8COa7DHhzJVq+3pz3nqrJSFQdWwj96mhC2tDzMXYA
 TCa92shSUqaArGSEUDgAmytvWgGk94OBbtm6E9SaVGqpf1E5xdDLqWyRIeu91vYXlLrez+C9o
 z9BC5091DCHqQJ+x8AYDgUQkbbRzDWxfCFg44Yc4ION2CudTFv6W+7JD/JiqJKPzp3iiLg4xH
 scMcK4Lw84jUSfc+AqAHUbuFqYPZfypXwaGImPeU3v8/n6rUk9MJSqsrECkqSvRiiQCd4BwpS
 frIPDCWcUkqQuPyU9MuaZew/fWRBvZl+y+vdkQFl4pRRMudC++IfIDL/tJ7Ru65hHL4I7Ah
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 10:02:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.17.10
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/04/2020 à 21:01, Alex Bennée a écrit :
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
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <1588094279-17913-3-git-send-email-frederic.konrad@adacore.com>
> ---
>  configure             |  2 +-
>  target/m68k/cpu.c     | 52 ++++++++++++++++++++++++++++++-------------
>  gdb-xml/m68k-core.xml | 29 ++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 16 deletions(-)
>  create mode 100644 gdb-xml/m68k-core.xml
> 
> diff --git a/configure b/configure
> index c58787100f..0d69c360c0 100755
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
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 9445fcd6df..72c545149e 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -292,16 +292,38 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>      cc->tcg_initialize = m68k_tcg_init;
>  
>      cc->gdb_num_core_regs = 18;
> -    cc->gdb_core_xml_file = "cf-core.xml";
>  
>      dc->vmsd = &vmstate_m68k_cpu;
>  }
>  
> -#define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
> -    {                                           \
> -        .name = M68K_CPU_TYPE_NAME(cpu_model),  \
> -        .instance_init = initfn,                \
> -        .parent = TYPE_M68K_CPU,                \
> +static void m68k_cpu_class_init_cf_core(ObjectClass *c, void *data)
> +{
> +    CPUClass *cc = CPU_CLASS(c);
> +
> +    cc->gdb_core_xml_file = "cf-core.xml";
> +}
> +
> +#define DEFINE_M68K_CPU_TYPE_CF(model)               \
> +    {                                                \
> +        .name = M68K_CPU_TYPE_NAME(#model),          \
> +        .instance_init = model##_cpu_initfn,         \
> +        .parent = TYPE_M68K_CPU,                     \
> +        .class_init = m68k_cpu_class_init_cf_core    \
> +    }
> +
> +static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
> +{
> +    CPUClass *cc = CPU_CLASS(c);
> +
> +    cc->gdb_core_xml_file = "m68k-core.xml";
> +}
> +
> +#define DEFINE_M68K_CPU_TYPE_M68K(model)             \
> +    {                                                \
> +        .name = M68K_CPU_TYPE_NAME(#model),          \
> +        .instance_init = model##_cpu_initfn,         \
> +        .parent = TYPE_M68K_CPU,                     \
> +        .class_init = m68k_cpu_class_init_m68k_core  \
>      }
>  
>  static const TypeInfo m68k_cpus_type_infos[] = {
> @@ -314,15 +336,15 @@ static const TypeInfo m68k_cpus_type_infos[] = {
>          .class_size = sizeof(M68kCPUClass),
>          .class_init = m68k_cpu_class_init,
>      },
> -    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("any", any_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE_M68K(m68000),
> +    DEFINE_M68K_CPU_TYPE_M68K(m68020),
> +    DEFINE_M68K_CPU_TYPE_M68K(m68030),
> +    DEFINE_M68K_CPU_TYPE_M68K(m68040),
> +    DEFINE_M68K_CPU_TYPE_M68K(m68060),
> +    DEFINE_M68K_CPU_TYPE_CF(m5206),
> +    DEFINE_M68K_CPU_TYPE_CF(m5208),
> +    DEFINE_M68K_CPU_TYPE_CF(cfv4e),
> +    DEFINE_M68K_CPU_TYPE_CF(any),
>  };
>  
>  DEFINE_TYPES(m68k_cpus_type_infos)
> diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
> new file mode 100644
> index 0000000000..5b092d26de
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
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

