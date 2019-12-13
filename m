Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B25C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 01:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CD6206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 01:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CD6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifZqT-0007tg-Kz
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 20:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ifZpY-0007Kl-GZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 20:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ifZpX-0002iL-En
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 20:33:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:14945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1ifZpS-0002WF-93; Thu, 12 Dec 2019 20:33:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2019 17:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; d="scan'208";a="239148017"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.238])
 ([10.239.196.238])
 by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2019 17:33:10 -0800
Subject: Re: [PATCH 2/2] numa: properly check if numa is supported
To: Igor Mammedov <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
 <1576154936-178362-3-git-send-email-imammedo@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <bf9dc1f6-514a-67ac-d09b-0b515545bf22@intel.com>
Date: Fri, 13 Dec 2019 09:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1576154936-178362-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/2019 8:48 PM, Igor Mammedov wrote:
> Commit aa57020774b, by mistake used MachineClass::numa_mem_supported
> to check if NUMA is supported by machine and also as unrelated change
> set it to true for sbsa-ref board.
> 
> Luckily change didn't break machines that support NUMA, as the field
> is set to true for them.
> 
> But the field is not intended for checking if NUMA is supported and
> will be flipped to false within this release for new machine types.
> 
> Fix it:
>   - by using previously used condition
>        !mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id
>     the first time and then use MachineState::numa_state down the road
>     to check if NUMA is supported
>   - dropping stray sbsa-ref chunk
> 
> Fixes: aa57020774b690a22be72453b8e91c9b5a68c516
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Leif Lindholm <leif.lindholm@linaro.org>
> CC: qemu-arm@nongnu.org
> CC: qemu-stable@nongnu.org
> 
> 
>   hw/arm/sbsa-ref.c | 1 -
>   hw/core/machine.c | 4 ++--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 27046cc..c6261d4 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -791,7 +791,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>       mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
>       mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
> -    mc->numa_mem_supported = true;
>   }
>   
>   static const TypeInfo sbsa_ref_info = {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3..aa63231 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -958,7 +958,7 @@ static void machine_initfn(Object *obj)
>                                           NULL);
>       }
>   
> -    if (mc->numa_mem_supported) {
> +    if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
>           ms->numa_state = g_new0(NumaState, 1);
>       }

I am wondering if @numa_mem_supported is unused here, it is unused for 
QEMU, because the only usage of @numa_mem_supported is to initialize 
@numa_state. Or there is other usage? So should it be removed from 
struct MachineClass?



