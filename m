Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A862AC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFE820883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFE820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiCh-0002lD-Qg
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfiBb-0001mT-18
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfiBa-0005Af-22
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:56:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2177 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1hfiBX-00055t-L7; Tue, 25 Jun 2019 05:56:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B42DE6DEBFE07697B51F;
 Tue, 25 Jun 2019 17:56:14 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 17:56:04 +0800
To: Igor Mammedov <imammedo@redhat.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
 <20190620141052.370788fb@redhat.com>
 <f4f94ecb-200c-3e18-1a09-5fb6bc761834@huawei.com>
 <20190620170934.39eae310@redhat.com>
 <ec089c94-589b-782c-1bdc-1b2c74e0ea46@huawei.com>
 <20190624131629.7f586861@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <623d8454-6d9a-43ff-dd34-f5e0d1896f01@huawei.com>
Date: Tue, 25 Jun 2019 17:56:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190624131629.7f586861@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [PATCH v17 02/10] ACPI: add some GHES structures
 and macros definition
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



On 2019/6/24 19:16, Igor Mammedov wrote:
>>>> On 2019/6/20 20:10, Igor Mammedov wrote:  
>>>>>> + */
>>>>>> +struct AcpiGenericErrorStatus {
>>>>>> +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
>>>>>> +    uint32_t block_status;
>>>>>> +    uint32_t raw_data_offset;
>>>>>> +    uint32_t raw_data_length;
>>>>>> +    uint32_t data_length;
>>>>>> +    uint32_t error_severity;
>>>>>> +} QEMU_PACKED;
>>>>>> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;    
>>>>> there shouldn't be packed structures,
>>>>> is it a leftover from previous version?    
>>>> I remember some people suggest to add QEMU_PACKED before, anyway I will remove it in my next version patch.  
>>> Question is why it's  there and where it is used?  
>> sorry, it is my carelessness. it should be packed structures.
>>
>> I used this structures to get its actual total size and member offset in [PATCH v17 10/10].
>> If it is not packed structures, the total size and member offset may be not right.
> I'd suggest to drop these typedefs and use a macro with size for that purpose,
> Also it might be good to make it local to the file that would use it.
so you mean we also use macro for the  member offset  in the structures?  such as the offset of data_length,
may be there is many hardcode.

> 
>>> BTW:
>>> series doesn't apply to master anymore.


