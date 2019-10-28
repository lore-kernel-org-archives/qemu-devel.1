Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B903ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 03:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CBA20679
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 03:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CBA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOvXX-0002OP-LN
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 23:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iOvWs-0001az-F9
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 23:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iOvWr-0005e7-EX
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 23:17:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37100 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iOvWn-0005b9-L4; Sun, 27 Oct 2019 23:17:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 732D27EEE96640117F5;
 Mon, 28 Oct 2019 11:17:00 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 11:16:53 +0800
Subject: Re: [PATCH v20 0/5] Add ARMv8 RAS virtualization support in QEMU
To: "Michael S. Tsirkin" <mst@redhat.com>, <peter.maydell@linaro.org>
References: <20191026032447.20088-1-zhengxiang9@huawei.com>
 <20191027061450-mutt-send-email-mst@kernel.org>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <b4cba864-6689-a425-af8e-4fb4a95d4482@huawei.com>
Date: Mon, 28 Oct 2019 11:16:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191027061450-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, wanghaibin.wang@huawei.com,
 mtosatti@redhat.com, linuxarm@huawei.com, qemu-devel@nongnu.org,
 gengdongjiu@huawei.com, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 james.morse@arm.com, jonathan.cameron@huawei.com, imammedo@redhat.com,
 pbonzini@redhat.com, xuwei5@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/10/27 18:17, Michael S. Tsirkin wrote:
> On Sat, Oct 26, 2019 at 11:24:42AM +0800, Xiang Zheng wrote:
>> In the ARMv8 platform, the CPU error types are synchronous external abort(SEA)
>> and SError Interrupt (SEI). If exception happens in guest, sometimes it's better
>> for guest to perform the recovery, because host does not know the detailed
>> information of guest. For example, if an exception happens in a user-space
>> application within guest, host does not know which application encounters
>> errors.
>>
>> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
>> After user space gets the notification, it will record the CPER into guest GHES
>> buffer and inject an exception or IRQ into guest.
>>
>> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
>> treat it as a synchronous exception, and notify guest with ARMv8 SEA
>> notification type after recording CPER into guest.
>>
>> This series of patches are based on Qemu 4.1, which include two parts:
>> 1. Generate APEI/GHES table.
>> 2. Handle the SIGBUS signal, record the CPER in runtime and fill it into guest
>>    memory, then notify guest according to the type of SIGBUS.
>>
>> The whole solution was suggested by James(james.morse@arm.com); The solution of
>> APEI section was suggested by Laszlo(lersek@redhat.com).
>> Show some discussions in [1].
>>
>> This series of patches have already been tested on ARM64 platform with RAS
>> feature enabled:
>> Show the APEI part verification result in [2].
>> Show the BUS_MCEERR_AR SIGBUS handling verification result in [3].
> 
> 
> This looks mostly OK to me.  I sent some minor style comments but they
> can be addressed by follow up patches.
> 
> Maybe it's a good idea to merge this before soft freeze to make sure it
> gets some testing.  I'll leave this decision to the ARM maintainer.  For
> ACPI parts:
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 

Hi Peter,

I can address the style comments and send the series of patches before soft
freeze if needed. And if there is no window before soft freeze, I can also
address them by follow up patches. :)

-- 

Thanks,
Xiang


