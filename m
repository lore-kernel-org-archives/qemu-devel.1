Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216FC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BCD2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BCD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2Qi-00008V-5t
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iD2Pt-00082f-Vg
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iD2Ps-0005aU-Kw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:12:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2177 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iD2Pp-0005Xp-Fq; Wed, 25 Sep 2019 04:12:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EF74175CD047DB4EC037;
 Wed, 25 Sep 2019 16:12:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 16:12:35 +0800
Subject: Re: [RFC PATCH 01/12] linux-headers: import arm_sdei.h
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-2-git-send-email-guoheyi@huawei.com>
 <20190924113640-mutt-send-email-mst@kernel.org>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <f0096ac1-e7d4-78d2-9e8a-21a7f6f266ad@huawei.com>
Date: Wed, 25 Sep 2019 16:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190924113640-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/24 23:39, Michael S. Tsirkin wrote:
> On Tue, Sep 24, 2019 at 11:21:40PM +0800, Heyi Guo wrote:
>> Import Linux header file include/uapi/linux/arm_sdei.h from kernel
>> v5.3 release.
>>
>> This is to prepare for qemu SDEI emulation.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Some issues with this.  First linux-headers is for linux as a host.
> This is for linux as a guest, so belongs in include/standard-headers.
>
> Second, please add to scripts/update-linux-headers.sh in a 1st patch,
> then add the file in the second patch.

Thanks; now I understand the differences. I'll do that in next version.

HG

>
>
>
>> ---
>>   linux-headers/linux/arm_sdei.h | 73 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 linux-headers/linux/arm_sdei.h
>>
>> diff --git a/linux-headers/linux/arm_sdei.h b/linux-headers/linux/arm_sdei.h
>> new file mode 100644
>> index 0000000..af0630b
>> --- /dev/null
>> +++ b/linux-headers/linux/arm_sdei.h
>> @@ -0,0 +1,73 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/* Copyright (C) 2017 Arm Ltd. */
>> +#ifndef _UAPI_LINUX_ARM_SDEI_H
>> +#define _UAPI_LINUX_ARM_SDEI_H
>> +
>> +#define SDEI_1_0_FN_BASE			0xC4000020
>> +#define SDEI_1_0_MASK				0xFFFFFFE0
>> +#define SDEI_1_0_FN(n)				(SDEI_1_0_FN_BASE + (n))
>> +
>> +#define SDEI_1_0_FN_SDEI_VERSION			SDEI_1_0_FN(0x00)
>> +#define SDEI_1_0_FN_SDEI_EVENT_REGISTER			SDEI_1_0_FN(0x01)
>> +#define SDEI_1_0_FN_SDEI_EVENT_ENABLE			SDEI_1_0_FN(0x02)
>> +#define SDEI_1_0_FN_SDEI_EVENT_DISABLE			SDEI_1_0_FN(0x03)
>> +#define SDEI_1_0_FN_SDEI_EVENT_CONTEXT			SDEI_1_0_FN(0x04)
>> +#define SDEI_1_0_FN_SDEI_EVENT_COMPLETE			SDEI_1_0_FN(0x05)
>> +#define SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME	SDEI_1_0_FN(0x06)
>> +#define SDEI_1_0_FN_SDEI_EVENT_UNREGISTER		SDEI_1_0_FN(0x07)
>> +#define SDEI_1_0_FN_SDEI_EVENT_STATUS			SDEI_1_0_FN(0x08)
>> +#define SDEI_1_0_FN_SDEI_EVENT_GET_INFO			SDEI_1_0_FN(0x09)
>> +#define SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET		SDEI_1_0_FN(0x0A)
>> +#define SDEI_1_0_FN_SDEI_PE_MASK			SDEI_1_0_FN(0x0B)
>> +#define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
>> +#define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
>> +#define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
>> +#define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
>> +#define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
>> +
>> +#define SDEI_VERSION_MAJOR_SHIFT			48
>> +#define SDEI_VERSION_MAJOR_MASK				0x7fff
>> +#define SDEI_VERSION_MINOR_SHIFT			32
>> +#define SDEI_VERSION_MINOR_MASK				0xffff
>> +#define SDEI_VERSION_VENDOR_SHIFT			0
>> +#define SDEI_VERSION_VENDOR_MASK			0xffffffff
>> +
>> +#define SDEI_VERSION_MAJOR(x)	(x>>SDEI_VERSION_MAJOR_SHIFT & SDEI_VERSION_MAJOR_MASK)
>> +#define SDEI_VERSION_MINOR(x)	(x>>SDEI_VERSION_MINOR_SHIFT & SDEI_VERSION_MINOR_MASK)
>> +#define SDEI_VERSION_VENDOR(x)	(x>>SDEI_VERSION_VENDOR_SHIFT & SDEI_VERSION_VENDOR_MASK)
>> +
>> +/* SDEI return values */
>> +#define SDEI_SUCCESS		0
>> +#define SDEI_NOT_SUPPORTED	-1
>> +#define SDEI_INVALID_PARAMETERS	-2
>> +#define SDEI_DENIED		-3
>> +#define SDEI_PENDING		-5
>> +#define SDEI_OUT_OF_RESOURCE	-10
>> +
>> +/* EVENT_REGISTER flags */
>> +#define SDEI_EVENT_REGISTER_RM_ANY	0
>> +#define SDEI_EVENT_REGISTER_RM_PE	1
>> +
>> +/* EVENT_STATUS return value bits */
>> +#define SDEI_EVENT_STATUS_RUNNING	2
>> +#define SDEI_EVENT_STATUS_ENABLED	1
>> +#define SDEI_EVENT_STATUS_REGISTERED	0
>> +
>> +/* EVENT_COMPLETE status values */
>> +#define SDEI_EV_HANDLED	0
>> +#define SDEI_EV_FAILED	1
>> +
>> +/* GET_INFO values */
>> +#define SDEI_EVENT_INFO_EV_TYPE			0
>> +#define SDEI_EVENT_INFO_EV_SIGNALED		1
>> +#define SDEI_EVENT_INFO_EV_PRIORITY		2
>> +#define SDEI_EVENT_INFO_EV_ROUTING_MODE		3
>> +#define SDEI_EVENT_INFO_EV_ROUTING_AFF		4
>> +
>> +/* and their results */
>> +#define SDEI_EVENT_TYPE_PRIVATE			0
>> +#define SDEI_EVENT_TYPE_SHARED			1
>> +#define SDEI_EVENT_PRIORITY_NORMAL		0
>> +#define SDEI_EVENT_PRIORITY_CRITICAL		1
>> +
>> +#endif /* _UAPI_LINUX_ARM_SDEI_H */
>> -- 
>> 1.8.3.1
> .
>



