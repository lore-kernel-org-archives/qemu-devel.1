Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF3BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 02:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CAD20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 02:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CAD20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih2aH-0003TZ-C0
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 21:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1ih2Zh-00034t-2R
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 21:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1ih2Ze-0003oc-UG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 21:27:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:26773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1ih2Ze-0003mf-Lh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 21:26:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 18:26:49 -0800
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; d="scan'208";a="209533238"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 16 Dec 2019 18:26:47 -0800
Subject: Re: [PULL 3/4] i386: Add new CPU model Cooperlake
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191216193825.1794153-1-ehabkost@redhat.com>
 <20191216193825.1794153-4-ehabkost@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <2fe2f699-699a-6ee5-1323-b092757822e5@intel.com>
Date: Tue, 17 Dec 2019 10:26:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191216193825.1794153-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Bruce Rogers <brogers@suse.com>, Cathy Zhang <cathy.zhang@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/2019 3:38 AM, Eduardo Habkost wrote:
> From: Cathy Zhang <cathy.zhang@intel.com>
> 
> Cooper Lake is intel's successor to Cascade Lake, the new
> CPU model inherits features from Cascadelake-Server, while
> add one platform associated new feature: AVX512_BF16. Meanwhile,
> add STIBP for speculative execution.
> 
> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Tao Xu <tao3.xu@intel.com>
> Message-Id: <1571729728-23284-4-git-send-email-cathy.zhang@intel.com>
> Reviewed-by: Bruce Rogers <brogers@suse.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   target/i386/cpu.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69f518a21a..de828e29d8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3159,6 +3159,66 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               { /* end of list */ }
>           }
>       },
> +    {
> +        .name = "Cooperlake",
> +        .level = 0xd,
> +        .vendor = CPUID_VENDOR_INTEL,
> +        .family = 6,
> +        .model = 85,
> +        .stepping = 10,
> +        .features[FEAT_1_EDX] =
> +            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
> +            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
> +            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
> +            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
> +            CPUID_DE | CPUID_FP87,
> +        .features[FEAT_1_ECX] =
> +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
> +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
> +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
> +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
> +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
> +            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> +        .features[FEAT_8000_0001_EDX] =
> +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
> +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> +        .features[FEAT_8000_0001_ECX] =
> +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
> +        .features[FEAT_7_0_EBX] =
> +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> +            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
> +            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
> +            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
> +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
> +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
> +        .features[FEAT_7_0_ECX] =
> +            CPUID_7_0_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512VNNI,
> +        .features[FEAT_7_0_EDX] =
> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_STIBP |
> +            CPUID_7_0_EDX_SPEC_CTRL_SSBD | CPUID_7_0_EDX_ARCH_CAPABILITIES,
> +        .features[FEAT_ARCH_CAPABILITIES] =
> +            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO,
> +        .features[FEAT_7_1_EAX] =
> +            CPUID_7_1_EAX_AVX512_BF16,
> +        /*
> +         * Missing: XSAVES (not supported by some Linux versions,
> +         * including v4.1 to v4.12).
> +         * KVM doesn't yet expose any XSAVES state save component,
> +         * and the only one defined in Skylake (processor tracing)
> +         * probably will block migration anyway.
> +         */
> +        .features[FEAT_XSAVE] =
> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> +            CPUID_XSAVE_XGETBV1,
> +        .features[FEAT_6_EAX] =
> +            CPUID_6_EAX_ARAT,
> +        .xlevel = 0x80000008,
> +        .model_id = "Intel Xeon Processor (Cooperlake)",
> +    },
>       {
>           .name = "Icelake-Client",
>           .level = 0xd,
> 

Hi Eduardo,

Since this CPU model has been hold for a while, it misses the VMX 
features added by Paolo recently.

Besides, there are two bits PSCHANGE_MC_NO(bit 6) and TAA_NO(bit 8) of 
MSR_IA32_ARCH_CAPABILITIES disclosed recently, that are also missed in 
this CPU model.

Should we hold off this and update a new patch with the above features 
added?
Or we make this merged and send a new patch to add a new version for the 
above?



