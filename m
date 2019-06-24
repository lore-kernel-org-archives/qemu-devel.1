Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCDAC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0783E20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0783E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNzJ-00028g-3G
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfNwz-0000n6-HZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfNwy-0004wR-1B
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:19:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33050 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1hfNwg-00047W-Eh; Mon, 24 Jun 2019 08:19:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2BC7AF8DB1BAB1C616A2;
 Mon, 24 Jun 2019 20:19:28 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 20:19:21 +0800
To: Igor Mammedov <imammedo@redhat.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-2-git-send-email-gengdongjiu@huawei.com>
 <20190620140409.3c713760@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <fbd558d5-03b7-df5c-e781-549261207221@huawei.com>
Date: Mon, 24 Jun 2019 20:19:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190620140409.3c713760@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [PATCH v17 01/10] hw/arm/virt: Add RAS platform
 version for migration
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/6/20 20:04, Igor Mammedov wrote:
> On Tue, 14 May 2019 04:18:14 -0700
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
>> Support this feature since version 4.1, disable it by
>> default in the old version.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  hw/arm/virt.c         | 6 ++++++
>>  include/hw/arm/virt.h | 1 +
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 5331ab7..7bdd41b 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2043,8 +2043,14 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
>>  
>>  static void virt_machine_4_0_options(MachineClass *mc)
>>  {
>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>> +
>>      virt_machine_4_1_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>> +    /* Disable memory recovery feature for 4.0 as RAS support was
>> +     * introduced with 4.1.
>> +     */
>> +    vmc->no_ras = true;
> 
> So it would mean that the feature is enabled unconditionally for
> new machine types and consumes resources whether user needs it or not.
> 
> In light of the race for leaner QEMU and faster startup times,
> it might be better to make RAS optional and make user explicitly
> enable it using a machine option.

I will add a machine option to make RAS optional, do you think we should enable or disable it by default? I think it is better if we enable it by default.

> 
> 
>>  }
>>  DEFINE_VIRT_MACHINE(4, 0)
>>  
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 4240709..7f1a033 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -104,6 +104,7 @@ typedef struct {
>>      bool disallow_affinity_adjustment;
>>      bool no_its;
>>      bool no_pmu;
>> +    bool no_ras;
>>      bool claim_edge_triggered_timers;
>>      bool smbios_old_sys_ver;
>>      bool no_highmem_ecam;
> 
> .
> 


