Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD7C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D82820715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D82820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfLp-0005Hy-HE
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 01:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ibfIf-0002Ip-Dt
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ibfIe-0001yd-4C
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:35:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:21081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ibfId-0001vz-SD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:35:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Dec 2019 22:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="200497451"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115])
 ([10.239.197.115])
 by orsmga007.jf.intel.com with ESMTP; 01 Dec 2019 22:35:08 -0800
Subject: Re: [PATCH] target/i386: Remove monitor from some CPU model
To: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
References: <20191202062852.27948-2-tao3.xu@intel.com>
 <20191115083345.22638-1-tao3.xu@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <648254aa-357e-9828-28dd-73cad9a872cd@intel.com>
Date: Mon, 2 Dec 2019 14:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115083345.22638-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am so forry for sending this old version patch by mistake.

Please ignore this patch.

On 12/2/2019 2:28 PM, Xu, Tao3 wrote:
> Add new version of Snowridge, Denverton, Opteron_G3, EPYC, and Dhyana
> CPU model to remove MONITOR/MWAIT feature.
> 
> After QEMU/KVM use "-overcommit cpu-pm=on" to expose MONITOR/MWAIT
> (commit id 6f131f13e68d648a8e4f083c667ab1acd88ce4cd), the MONITOR/MWAIT
> feature in these CPU model is unused.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>   target/i386/cpu.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a624163ac2..7c5f1e8fe0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2770,6 +2770,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
>           .xlevel = 0x80000008,
>           .model_id = "Intel Atom Processor (Denverton)",
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    { "monitor", "off" },
> +                    { "model-id",
> +                      "Intel Atom Processor (Denverton, no MONITOR)" },
> +                    { /* end of list */ },
> +                },
> +            },
> +            { /* end of list */ },
> +        },
>       },
>       {
>           .name = "Snowridge",
> @@ -2850,6 +2863,16 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ },
>                   },
>               },
> +            {
> +                .version = 3,
> +                .props = (PropValue[]) {
> +                    /* mpx was already removed by -v2 above */
> +                    { "monitor", "off" },
> +                    { "model-id",
> +                      "Intel Atom Processor (Snowridge, no MPX, no MONITOR)" },
> +                    { /* end of list */ },
> +                },
> +            },
>               { /* end of list */ },
>           },
>       },
> @@ -2961,6 +2984,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
>           .xlevel = 0x80000008,
>           .model_id = "AMD Opteron 23xx (Gen 3 Class Opteron)",
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    { "monitor", "off" },
> +                    { "model-id",
> +                      "AMD Opteron 23xx (Gen 3 Class Opteron, no MONITOR)" },
> +                    { /* end of list */ },
> +                },
> +            },
> +            { /* end of list */ },
> +        },
>       },
>       {
>           .name = "Opteron_G4",
> @@ -3085,6 +3121,16 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ }
>                   }
>               },
> +            {
> +                .version = 3,
> +                .props = (PropValue[]) {
> +                    /* ibpb was already enabled by -v2 above */
> +                    { "monitor", "off" },
> +                    { "model-id",
> +                      "AMD EPYC Processor (with IBPB, no MONITOR)" },
> +                    { /* end of list */ },
> +                },
> +            },
>               { /* end of list */ }
>           }
>       },
> @@ -3137,6 +3183,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
>           .xlevel = 0x8000001E,
>           .model_id = "Hygon Dhyana Processor",
>           .cache_info = &epyc_cache_info,
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    { "monitor", "off" },
> +                    { "model-id", "Hygon Dhyana Processor (no MONITOR)" },
> +                    { /* end of list */ },
> +                },
> +            },
> +            { /* end of list */ },
> +        },
>       },
>   };
>   
> 


