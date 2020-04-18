Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 02:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104D121927
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 02:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104D121927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPdTA-0003pk-76
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 22:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1jPdPc-0002DQ-Lf
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1jPdPa-0004lU-GR
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:40:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3744 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1jPdPX-0003h2-Hm; Fri, 17 Apr 2020 22:40:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C3B6C5F4BE3AE59A650B;
 Sat, 18 Apr 2020 10:40:39 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 10:40:33 +0800
Subject: Re: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <CAFEAcA9oNuDf=bdSSE8mZWrB23+FegD5NeSAmu8dGWhB=adBQg@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <e7812ab1-cfaa-de3e-3062-4576665dab54@huawei.com>
Date: Sat, 18 Apr 2020 10:40:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9oNuDf=bdSSE8mZWrB23+FegD5NeSAmu8dGWhB=adBQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: Fam Zheng <fam@euphon.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/4/17 21:32, Peter Maydell wrote:
> On Fri, 10 Apr 2020 at 12:46, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>
>> In the ARMv8 platform, the CPU error types includes synchronous external abort(SEA)
>> and SError Interrupt (SEI). If exception happens in guest, host does not know the detailed
>> information of guest, so it is expected that guest can do the recovery. For example, if an
>> exception happens in a guest user-space application, host does not know which application
>> encounters errors, only guest knows it.
>>
>> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
>> After user space gets the notification, it will record the CPER into guest GHES
>> buffer and inject an exception or IRQ to guest.
>>
>> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
>> treat it as a synchronous exception, and notify guest with ARMv8 SEA
>> notification type after recording CPER into guest.
> 
> Hi. I left a comment on patch 1. The other 3 patches unreviewed
> are 5, 6 and 8, which are all ACPI core code, so that's for
> MST, Igor or Shannon to review.

Hi MST, Igor or Shannon
    when you have time, could you review 5, 6 and 8? thanks very much in advance.
It seems this series of patches lasted a long time, hope they can be applied soon.

> 
> Once those have been reviewed, please ping me if you want this
> to go via target-arm.next>
> thanks
> -- PMM
> 
> .
> 


