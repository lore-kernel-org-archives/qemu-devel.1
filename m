Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B90AC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A88206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A88206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zfR-0006Bw-3h
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1j6zeV-0005Qg-Ui
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1j6zeU-00022h-Tg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:35:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3170 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1j6zeR-0001Mg-4O; Wed, 26 Feb 2020 11:35:11 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A81A06B3A77E2ABFB80C;
 Thu, 27 Feb 2020 00:34:59 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Feb 2020
 00:34:53 +0800
Subject: Re: [PATCH v24 00/10] Add ARMv8 RAS virtualization support in QEMU
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217131248.28273-1-gengdongjiu@huawei.com>
 <CAFEAcA9xd8fHiigZFFM7Symh0Mkm-jQ_aGJ7ifRCrXZvFY4DqQ@mail.gmail.com>
 <acd194e5-81d8-afa7-fb6d-6b7d744b5d81@huawei.com>
 <20200225175918.5a81506f@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <5bceff96-8681-e33e-8edd-70fd121c055a@huawei.com>
Date: Thu, 27 Feb 2020 00:34:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20200225175918.5a81506f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/26 0:59, Igor Mammedov wrote:
> On Mon, 24 Feb 2020 16:37:44 +0800
> gengdongjiu <gengdongjiu@huawei.com> wrote:
> 
>> On 2020/2/21 22:09, Peter Maydell wrote:
>>> On Mon, 17 Feb 2020 at 13:10, Dongjiu Geng <gengdongjiu@huawei.com> wrote:  
>>>>
>>>> In the ARMv8 platform, the CPU error types includes synchronous external abort(SEA) and SError Interrupt (SEI). If exception happens in guest, host does not know the detailed information of guest, so it is expected that guest can do the recovery.
>>>> For example, if an exception happens in a guest user-space application, host does
>>>> not know which application encounters errors, only guest knows it.
>>>>
>>>> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
>>>> After user space gets the notification, it will record the CPER into guest GHES
>>>> buffer and inject an exception or IRQ to guest.
>>>>
>>>> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
>>>> treat it as a synchronous exception, and notify guest with ARMv8 SEA
>>>> notification type after recording CPER into guest.  
>>>
>>> Hi; I have reviewed the remaining arm bit of this series (patch 9),
>>> and made some comments on patch 1. Still to be reviewed are
>>> patches 4, 5, 6, 8: I'm going to assume that Michael or Igor
>>> will look at those.  
>>
>> Thanks very much for Peter's review.
>> Michael/Igor, hope you can review patches 4, 5, 6, 8, thank you very much in advance.
> 
> done

Thanks a lot, do you think whether it is ready to merge if the comments that you mentioned are fixed?
If there are some other places that still needs to modify, hope you can pointed it out, so that in next patch series it can be ready to merge. thanks.

> 
>>>
>>> thanks
>>> -- PMM
>>>
>>> .
>>>   
>>
> 
> .
> 


