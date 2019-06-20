Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E57C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 02:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403D52084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 02:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403D52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdmbu-0001yK-3j
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 22:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hdmZ9-00007l-82
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hdmQ0-0005st-J7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:03:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:21005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hdmQ0-0005rV-9F
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:03:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 19:03:14 -0700
X-IronPort-AV: E=Sophos;i="5.63,395,1557212400"; d="scan'208";a="153975950"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.88])
 ([10.239.196.88])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 19 Jun 2019 19:03:12 -0700
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
 <20190612084104.34984-8-like.xu@linux.intel.com>
 <20190619191546.GD26409@habkost.net> <20190619233613.GG26409@habkost.net>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <19a0b69b-2421-de88-51b1-0b0e37f66006@linux.intel.com>
Date: Thu, 20 Jun 2019 10:03:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619233613.GG26409@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v3 7/9] target/i386: Support multi-dies
 when host doesn't support CPUID.1F
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/6/20 7:36, Eduardo Habkost wrote:
> On Wed, Jun 19, 2019 at 04:15:46PM -0300, Eduardo Habkost wrote:
>> On Wed, Jun 12, 2019 at 04:41:02PM +0800, Like Xu wrote:
>>> In guest CPUID generation process, the cpuid_min_level would be adjusted to
>>> the maximum passed value for basic CPUID configuration and it should not be
>>> restricted by the limited value returned from cpu_x86_cpuid(). After the basic
>>> cpu_x86_cpuid() loop is finished, the cpuid_0_entry.eax needs to be configured
>>> again by the last adjusted cpuid_min_level value.
>>>
>>> If a user wants to expose CPUID.1F by passing dies > 1 for any reason without
>>> host support, a per-cpu smp topology warning will appear but it's not blocked.
>>>
>>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>>
>> This code doesn't look at host CPUID at all, as far as I can see.
>> Isn't it simpler to just make cpuid_x86_cpuid() return the
>> correct data?
> 
> I suggest the following change instead.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Hi Eduardo,

Your code is more reasonable and concise than mine on this
so let's not break cpuid_x86_cpuid().

I'll remove the use of enable_cpuid_0x1f in next version, and should I 
resend the patch series "Refactor cpu topo into machine properties" 
because rebase-fix may distract you ?

> ---
>   target/i386/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6db38e145b..d05a224092 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5152,6 +5152,10 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>               x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
>           }
>   
> +        if (env->nr_dies > 1) {
> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
> +        }
> +
>           /* SVM requires CPUID[0x8000000A] */
>           if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>               x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
> 


