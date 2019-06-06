Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDADC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4318A20872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4318A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYkll-0001TF-9M
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 01:16:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYkkq-00010J-9w
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYkko-0004Ng-Ez
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:16:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hYkkm-00045Z-IE
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:15:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 22:15:46 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.163])
	([10.239.196.163])
	by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 22:15:44 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-5-tao3.xu@intel.com>
	<20190524143534.7dfdcd57@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <8f765b45-c67e-b6cc-e8eb-8a8a291aeb50@intel.com>
Date: Thu, 6 Jun 2019 13:15:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190524143534.7dfdcd57@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH v4 04/11] acpi: introduce
 AcpiDeviceIfClass.build_mem_ranges hook
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/2019 8:35 PM, Igor Mammedov wrote:
> On Wed,  8 May 2019 14:17:19 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> Add build_mem_ranges callback to AcpiDeviceIfClass and use
>> it for generating SRAT and HMAT numa memory ranges.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Co-developed-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
...
>> diff --git a/stubs/pc_build_mem_ranges.c b/stubs/pc_build_mem_ranges.c
>> new file mode 100644
>> index 0000000000..0f104ba79d
>> --- /dev/null
>> +++ b/stubs/pc_build_mem_ranges.c
>> @@ -0,0 +1,6 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/i386/pc.h"
>> +
>> +void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *machine)
>> +{
>> +}
> 
> why do you need stub?
> 
Hi Igor,

I have questions here, I use stub here because we add hook pointer in 
piix4.c but other arch such mips use piix4. Without stub, it will failed 
when compile, like pc_madt_cpu_entry.
Or there are other way to make it use just in pc?

Thank you!


