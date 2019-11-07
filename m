Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0986FA372C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4C121848
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4C121848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSWoF-00068S-Qr
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 20:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iSWnY-0005al-4o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iSWnX-0003Le-2f
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:41:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2262 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iSWnU-0003JA-Cj; Wed, 06 Nov 2019 20:41:16 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F013C599A94ECF9C075C;
 Thu,  7 Nov 2019 09:41:07 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 7 Nov 2019
 09:40:58 +0800
Subject: Re: [RFC v2 02/14] standard-headers: import arm_sdei.h
To: Cornelia Huck <cohuck@redhat.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-3-guoheyi@huawei.com>
 <20191106185240.3f5e2c2a.cohuck@redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <059c6396-bbfb-2dd3-f7cc-7c64bc2d3ccb@huawei.com>
Date: Thu, 7 Nov 2019 09:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191106185240.3f5e2c2a.cohuck@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/11/7 1:52, Cornelia Huck wrote:
> On Tue, 5 Nov 2019 17:10:44 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> Import Linux header file include/uapi/linux/arm_sdei.h from kernel v5.4-rc5.
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
>> ---
>>
>> Notes:
>>      v2:
>>      - Import arm_sdei.h by running update-linux-headers.sh
>>
>>   include/standard-headers/linux/arm_sdei.h | 73 +++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 include/standard-headers/linux/arm_sdei.h
> Just a remark that I find it a bit odd that that a header that looks
> arm-specific is in the generic linux/ directory (already in the kernel,
> I know.) Is this for sharing between arm and arm64, maybe?
I don't think arm platforms will use this header. In section 4.1 of SDEI 
spec, it says " Both the client and dispatcher of SDEI must execute in 
AArch64 state."
So shall we move it to include/standard-headers/asm-arm64/?

Thanks,
HG

>
>
> .
>



