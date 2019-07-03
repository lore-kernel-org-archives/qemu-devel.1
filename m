Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B535C5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A1E2064A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A1E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiTuk-0007AU-Kj
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 21:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <xiaoyao.li@intel.com>) id 1hiTtV-0006iS-KH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1hiTtT-0007SY-OQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:17:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:46816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1hiTtQ-0007O2-HH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:17:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 18:17:00 -0700
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="157814276"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 02 Jul 2019 18:16:59 -0700
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
References: <20190702153535.9851-1-ehabkost@redhat.com>
 <20190702153535.9851-41-ehabkost@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <3ac827c6-6a54-2755-3189-156cae3d4a89@intel.com>
Date: Wed, 3 Jul 2019 09:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702153535.9851-41-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PULL v3 40/42] i386: Add Cascadelake-Server-v2
 CPU model
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

Hi, Eduardo

On 7/2/2019 11:35 PM, Eduardo Habkost wrote:
> Add new version of Cascadelake-Server CPU model, setting
> stepping=5 and enabling the IA32_ARCH_CAPABILITIES MSR
> with some flags.
> 
> The new feature will introduce a new host software requirement,
> breaking our CPU model runnability promises.  This means we can't
> enable the new CPU model version by default in QEMU 4.1, because
> management software isn't ready yet to resolve CPU model aliases.
> This is why "pc-*-4.1" will keep returning Cascadelake-Server-v1
> if "-cpu Cascadelake-Server" is specified.
> 
> Includes a test case to ensure the right combinations of
> machine-type + CPU model + command-line feature flags will work
> as expected.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20190628002844.24894-10-ehabkost@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   target/i386/cpu.c                          | 14 +++++
>   tests/acceptance/x86_cpu_model_versions.py | 73 ++++++++++++++++++++++
>   2 files changed, 87 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9b16cffb22..0298396a91 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2343,6 +2343,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               CPUID_6_EAX_ARAT,
>           .xlevel = 0x80000008,
>           .model_id = "Intel Xeon Processor (Cascadelake)",
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            { .version = 2,
> +              .props = (PropValue[]) {
> +                  { "stepping", "5" },
> +                  { "arch-capabilities", "on" },
> +                  { "rdctl-no", "on" },
> +                  { "ibrs-all", "on" },
> +                  { "skip-l1dfl-vmentry", "on" },
> +                  { /* end of list */ }
> +              },
> +            },
> +            { /* end of list */ }
> +        }

seems you forgot to fix the stepping and add feature "mds-no".

