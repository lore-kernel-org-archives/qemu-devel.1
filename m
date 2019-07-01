Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F077C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4CE2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4CE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhqwC-00042P-66
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 03:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <xiaoyao.li@linux.intel.com>) id 1hhqvI-0003PD-Ix
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@linux.intel.com>) id 1hhqvH-0002mP-6P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:40:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:62574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@linux.intel.com>)
 id 1hhqvG-0002kN-TT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:40:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jul 2019 00:23:35 -0700
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; d="scan'208";a="157208308"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 01 Jul 2019 00:23:32 -0700
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190628002844.24894-1-ehabkost@redhat.com>
 <20190628002844.24894-10-ehabkost@redhat.com>
From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Message-ID: <612a3fdf-6525-a428-ebd5-b951c333bf2f@linux.intel.com>
Date: Mon, 1 Jul 2019 15:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628002844.24894-10-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v2 9/9] i386: Add Cascadelake-Server-v2 CPU
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, jingqi.liu@intel.com,
 Tao Xu <tao3.xu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Hu, Robert" <robert.hu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "Lai, Paul C" <paul.c.lai@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/2019 8:28 AM, Eduardo Habkost wrote:
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
> ---
> Changes v1 -> v2:
> * Enable rdctl-no, ibrs-all, skip-l1dfl-vmentry
>    (Suggested by Tao Xu)
> 
> Cc: "Hu, Robert" <robert.hu@intel.com>
> Cc: Tao Xu <tao3.xu@intel.com>
> Cc: jingqi.liu@intel.com,
> Cc: "Lai, Paul C" <paul.c.lai@intel.com>
> ---
>   target/i386/cpu.c                          | 14 +++++
>   tests/acceptance/x86_cpu_model_versions.py | 73 ++++++++++++++++++++++
>   2 files changed, 87 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 10a09c971a..570890a7dd 100644
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

Stepping should be 6?

> +                  { "arch-capabilities", "on" },
> +                  { "rdctl-no", "on" },
> +                  { "ibrs-all", "on" },
> +                  { "skip-l1dfl-vmentry", "on" },

rdmsr 0x10AH returns 0x2b from host Cascadelake, we'd better add feature 
"mds-no" too. Otherwise we will need another version for that feature.

> +                  { /* end of list */ }
> +              },
> +            },
> +            { /* end of list */ }
> +        }
>       },
>       {
>           .name = "Icelake-Client",
> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
> index 165c0c7601..1c9fd6a56e 100644
> --- a/tests/acceptance/x86_cpu_model_versions.py
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -25,6 +25,10 @@
>   import avocado_qemu
>   import re
>   
> +def get_cpu_prop(vm, prop):
> +    cpu_path = vm.command('query-cpus')[0].get('qom_path')
> +    return vm.command('qom-get', path=cpu_path, property=prop)
> +
>   class X86CPUModelAliases(avocado_qemu.Test):
>       """
>       Validation of PC CPU model versions and CPU model aliases
> @@ -229,3 +233,72 @@ class X86CPUModelAliases(avocado_qemu.Test):
>                            'qemu64-v1 must not be an alias')
>   
>           self.validate_aliases(cpus)
> +
> +    def test_Cascadelake_arch_capabilities_result(self):
> +        # machine-type only:
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.1')
> +        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off')
> +        vm.launch()
> +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server should not have arch-capabilities')
> +
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off')
> +        vm.launch()
> +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.0 + Cascadelake-Server should not have arch-capabilities')
> +
> +        # command line must override machine-type if CPU model is not versioned:
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,+arch-capabilities')
> +        vm.launch()
> +        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> +                        'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabilities should have arch-capabilities')
> +
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.1')
> +        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,-arch-capabilities')
> +        vm.launch()
> +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
> +
> +        # versioned CPU model overrides machine-type:
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=on,check=off,enforce=off')
> +        vm.launch()
> +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should not have arch-capabilities')
> +
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=on,check=off,enforce=off')
> +        vm.launch()
> +        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should have arch-capabilities')
> +
> +        # command line must override machine-type and versioned CPU model:
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.0')
> +        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,+arch-capabilities')
> +        vm.launch()
> +        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capabilities should have arch-capabilities')
> +
> +        vm = self.get_vm()
> +        vm.add_args('-S')
> +        vm.set_machine('pc-i440fx-4.1')
> +        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=on,check=off,enforce=off,-arch-capabilities')
> +        vm.launch()
> +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +                         'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
> 

