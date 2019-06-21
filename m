Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E3C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C8B2085A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C8B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he7qZ-0003qL-ER
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 20:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1he7o0-0002js-2M
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1he7ny-0004GX-5A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:53:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:42145)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1he7nv-00045F-96; Thu, 20 Jun 2019 20:53:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 17:53:18 -0700
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; d="scan'208";a="154297615"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.171])
 ([10.239.196.171])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 20 Jun 2019 17:53:16 -0700
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
 <20190518205428.90532-6-like.xu@linux.intel.com>
 <20190620145204.GB1542@habkost.net>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <eeb97218-da68-6736-42e8-d8fa6d84e601@linux.intel.com>
Date: Fri, 21 Jun 2019 08:53:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620145204.GB1542@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v3 05/10] hw/riscv: Replace global smp
 variables with machine smp properties
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/6/20 22:52, Eduardo Habkost wrote:
> On Sun, May 19, 2019 at 04:54:23AM +0800, Like Xu wrote:
>> The global smp variables in riscv are replaced with smp machine properties.
>>
>> A local variable of the same name would be introduced in the declaration
>> phase if it's used widely in the context OR replace it on the spot if it's
>> only used once. No semantic changes.
>>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>>   hw/riscv/sifive_e.c    | 6 ++++--
>>   hw/riscv/sifive_plic.c | 3 +++
>>   hw/riscv/sifive_u.c    | 6 ++++--
>>   hw/riscv/spike.c       | 2 ++
>>   hw/riscv/virt.c        | 1 +
>>   5 files changed, 14 insertions(+), 4 deletions(-)
> 
> This was incomplete, I had to apply the following fixup.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Like Xu <like.xu@linux.intel.com>

> ---
>   hw/riscv/spike.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 9e95f2c13c..d91d49dcae 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -172,6 +172,7 @@ static void spike_board_init(MachineState *machine)
>       MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>       int i;
> +    unsigned int smp_cpus = machine->smp.cpus;
>   
>       /* Initialize SOC */
>       object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> 


