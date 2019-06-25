Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC13C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D357420652
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D357420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfe8J-0002ac-Hj
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 01:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hfe7I-0001u7-Gj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hfe7H-0004KD-Ae
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:35:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:45728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hfe7H-0003um-1L
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:35:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 22:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="161822640"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.228])
 ([10.239.196.228])
 by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2019 22:35:18 -0700
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-7-ehabkost@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <ace5bfc8-7b05-d1ab-bada-271cf82ec4ae@intel.com>
Date: Tue, 25 Jun 2019 13:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625050008.12789-7-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH 6/6] i386: Add Cascadelake-Server-4.1.1 CPU
 model
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, jingqi.liu@intel.com, "Lai,
 Paul C" <paul.c.lai@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Hu, Robert" <robert.hu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/2019 1:00 PM, Eduardo Habkost wrote:
> Add new version of Cascadelake-Server CPU model, setting
> stepping=5 and enabling the IA32_ARCH_CAPABILITIES MSR.
> 
> The new feature will introduce a new host software requirement,
> breaking our CPU model runnability promises.  This means we can't
> enable the new CPU model version by default in QEMU 4.1, because
> management software isn't ready yet to resolve CPU model aliases.
> This is why the feature is being enabled in a
> Cascadelake-Server-4.1.1 CPU model instead of
> Cascadelake-Server-4.1.
> 
> Includes a test case to ensure the right combinations of
> machine-type + CPU model + command-line feature flags will work
> as expected.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Hu, Robert" <robert.hu@intel.com>
> Cc: Tao Xu <tao3.xu@intel.com>
> Cc: jingqi.liu@intel.com,
> Cc: "Lai, Paul C" <paul.c.lai@intel.com>
> ---
>   target/i386/cpu.c                          | 15 +++++
>   tests/acceptance/x86_cpu_model_versions.py | 71 ++++++++++++++++++++++
>   2 files changed, 86 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 121f568954..8edae04161 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2607,6 +2607,21 @@ static X86CPUDefinition builtin_x86_defs[] = {
...
> +        # versioned CPU model overrides machine-type:
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server-4.1,x-force-features=on,check=off,enforce=off')
> +        vm.launch()
> +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server-4.1 should not have arch-capabilities')
> +
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server-4.1.1,x-force-features=on,check=off,enforce=off')
> +        vm.launch()
> +        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server-4.1 should have arch-capabilities')
Hi Eduardo

Could me ask why here the error show "Cascadelake-Server-4.1" instead of 
"Cascadelake-Server-4.1.1"?

And will you add the MSR_ARCH_CAP_RDCL_NO, MSR_ARCH_CAP_IBRS_ALL, and 
MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY into .features[FEAT_ARCH_CAPABILITIES]?

Tao


