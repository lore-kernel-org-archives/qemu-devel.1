Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A021C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B3C2084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crML9qiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B3C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhCt-000332-69
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWhCD-00023Q-7Z; Thu, 07 May 2020 10:08:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWhCC-0003kP-3a; Thu, 07 May 2020 10:08:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so7000670wma.4;
 Thu, 07 May 2020 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WQpHWWtV7aov62Ssz/BNFT95zTeaJ0S20KmMXAJgRhM=;
 b=crML9qiIR16Xzonv0/ExGflj7VO6rcc3oA5mWz7nQ3c6519I9Jtac7gvUMunmnnmzc
 +zpBhYuFk0waNxBdjJsUOLcHflYBvi5GptrKkWn+oO7f2oY1jthWFFqKvIwGADmLUroV
 VgApi4Si7gJfJGszhvFboOWsdgcuz0Kb5frKL+kpUsMwjiL77LuO25G49pNoHVhZSYyS
 7KcFA02mMlj83kEYTkIiIh/CneYTBbslaRqiO2Y8WYhlg4ZbezHxC3EvNeCl4Ve6oujP
 r9IgAHZQpNm6t617uA+cYIKZ/p8LKlT0W0YhKUZckD2GOQ//bDURKQsJ0reIOjhs5l76
 xoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQpHWWtV7aov62Ssz/BNFT95zTeaJ0S20KmMXAJgRhM=;
 b=MN1/Ardtk5LZ/PFTskZOL4v8t5h4ZrATL4WtrhHsn0iyHyYlNewAhYwQyVyDqebHYI
 kqbTUddIe32+BgJ+3876iMSVtf3kwgFa/5E6UXaL23QN1Uv8rTSsz+tV/rJpprZUxSuh
 7ytQlpturmYBu6BsdBClezRiurRSKBkaOd+y0gXus2Ww11JfP0RHCe+OLaqA64XquNT/
 z7LJ+6ryyWthjK5j9F4HiOAsSrB6DvYU+92WcSY/vNLxoYKvmdKElH1clzoaXabV7pZn
 kNsb8bs2vn0xlDe2vHUXOth3MAsat94viKYhFChcbxd2Ti4Hm+7kcsJi2ZI8/V0kRaJT
 cUFg==
X-Gm-Message-State: AGi0Pua/abYcx7aLjYyosvRPrTo9XCb7R/0+CuekeaHDOkDoUZjspajh
 8pZnITFSRFJI/mKg5OAw7ejpOSXFDTE=
X-Google-Smtp-Source: APiQypLXD9rxMnzbVEzHP2UNB99ryGas4g/AzX8v4a5+wExQGP3vw/o9B5hXFKLYK/kG7FTacIlFgA==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr10283498wmc.22.1588860494044; 
 Thu, 07 May 2020 07:08:14 -0700 (PDT)
Received: from [192.168.1.39] (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id w83sm8601146wmb.37.2020.05.07.07.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 07:08:13 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Use correct GDB XML for M-profile cores
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200507134755.13997-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88812e26-b6a7-8f80-f9d1-cb51ed5721c9@amsat.org>
Date: Thu, 7 May 2020 16:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507134755.13997-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:47 PM, Peter Maydell wrote:
> GDB's remote protocol requires M-profile cores to use the feature
> name 'org.gnu.gdb.arm.m-profile' instead of the 'org.gnu.gdb.arm.core'
> feature used for A- and R-profile cores. We weren't doing this, which
> meant GDB treated our M-profile cores like A-profile ones. This mostly
> doesn't matter, but for instance means that it doesn't correctly
> handle backtraces where an M-profile exception frame is involved.
> 
> Ship a copy of GDB's arm-m-profile.xml and use it on the M-profile
> cores.  The integer registers have the same offsets as the
> arm-core.xml, but register 25 is the M-profile XPSR rather than the
> A-profile CPSR, so we need to update arm_cpu_gdb_read_register() and
> arm_cpu_gdb_write_register() to handle XSPR reads and writes.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1877136
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   configure                 |  4 ++--
>   target/arm/cpu.c          |  1 +
>   target/arm/gdbstub.c      | 22 ++++++++++++++++++----
>   gdb-xml/arm-m-profile.xml | 27 +++++++++++++++++++++++++++
>   4 files changed, 48 insertions(+), 6 deletions(-)
>   create mode 100644 gdb-xml/arm-m-profile.xml
> 
> diff --git a/configure b/configure
> index 0d69c360c0e..360e7e6a0a4 100755
> --- a/configure
> +++ b/configure
> @@ -7806,14 +7806,14 @@ case "$target_name" in
>       TARGET_SYSTBL_ABI=common,oabi
>       bflt="yes"
>       mttcg="yes"
> -    gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
> +    gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
>     ;;
>     aarch64|aarch64_be)
>       TARGET_ARCH=aarch64
>       TARGET_BASE_ARCH=arm
>       bflt="yes"
>       mttcg="yes"
> -    gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
> +    gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
>     ;;
>     cris)
>     ;;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5d64adfe76e..b386bbbfd12 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2179,6 +2179,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
>   #endif
>   
>       cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
> +    cc->gdb_core_xml_file = "arm-m-profile.xml";
>   }
>   
>   static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 063551df234..ecfa88f8e60 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -57,8 +57,12 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>           }
>           return gdb_get_reg32(mem_buf, 0);
>       case 25:
> -        /* CPSR */
> -        return gdb_get_reg32(mem_buf, cpsr_read(env));
> +        /* CPSR, or XPSR for M-profile */
> +        if (arm_feature(env, ARM_FEATURE_M)) {
> +            return gdb_get_reg32(mem_buf, xpsr_read(env));
> +        } else {
> +            return gdb_get_reg32(mem_buf, cpsr_read(env));
> +        }
>       }
>       /* Unknown register.  */
>       return 0;
> @@ -98,8 +102,18 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           }
>           return 4;
>       case 25:
> -        /* CPSR */
> -        cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
> +        /* CPSR, or XPSR for M-profile */
> +        if (arm_feature(env, ARM_FEATURE_M)) {
> +            /*
> +             * Don't allow writing to XPSR.Exception as it can cause
> +             * a transition into or out of handler mode (it's not
> +             * writeable via the MSR insn so this is a reasonable
> +             * restriction). Other fields are safe to update.
> +             */
> +            xpsr_write(env, tmp, ~XPSR_EXCP);
> +        } else {
> +            cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
> +        }
>           return 4;
>       }
>       /* Unknown register.  */
> diff --git a/gdb-xml/arm-m-profile.xml b/gdb-xml/arm-m-profile.xml
> new file mode 100644
> index 00000000000..5319d764eeb
> --- /dev/null
> +++ b/gdb-xml/arm-m-profile.xml
> @@ -0,0 +1,27 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2020 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.arm.m-profile">
> +  <reg name="r0" bitsize="32"/>
> +  <reg name="r1" bitsize="32"/>
> +  <reg name="r2" bitsize="32"/>
> +  <reg name="r3" bitsize="32"/>
> +  <reg name="r4" bitsize="32"/>
> +  <reg name="r5" bitsize="32"/>
> +  <reg name="r6" bitsize="32"/>
> +  <reg name="r7" bitsize="32"/>
> +  <reg name="r8" bitsize="32"/>
> +  <reg name="r9" bitsize="32"/>
> +  <reg name="r10" bitsize="32"/>
> +  <reg name="r11" bitsize="32"/>
> +  <reg name="r12" bitsize="32"/>
> +  <reg name="sp" bitsize="32" type="data_ptr"/>
> +  <reg name="lr" bitsize="32"/>
> +  <reg name="pc" bitsize="32" type="code_ptr"/>
> +  <reg name="xpsr" bitsize="32" regnum="25"/>
> +</feature>
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

