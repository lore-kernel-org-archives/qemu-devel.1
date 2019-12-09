Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5247C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9403F2073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9403F2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJnK-00032A-Po
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1ieJmd-0002Sx-JP
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1ieJmc-0007XT-JF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:13:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53060 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1ieJmZ-0007E9-Fr; Mon, 09 Dec 2019 09:13:04 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D162478339045A5766C6;
 Mon,  9 Dec 2019 22:12:42 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Dec 2019
 22:12:37 +0800
Subject: Re: [RESEND PATCH v21 5/6] target-arm: kvm64: handle SIGBUS signal
 from kernel or KVM
To: Beata Michalska <beata.michalska@linaro.org>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-6-zhengxiang9@huawei.com>
 <CADSWDztF=eaUDNnq8bhnPyTKW1YjAWm4UBaH-NBPkzjnzx0bxg@mail.gmail.com>
 <238ea7b3-9d6d-e3f7-40c9-e3e62b5fb477@huawei.com>
 <CADSWDzvFvS6mYiMhXu2J+u+sUxZaKcCE78EuSggv-VOY7zEN_w@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <650e26cf-e007-1e31-cd0a-4042bb9fa6a8@huawei.com>
Date: Mon, 9 Dec 2019 22:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CADSWDzvFvS6mYiMhXu2J+u+sUxZaKcCE78EuSggv-VOY7zEN_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, wanghaibin.wang@huawei.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, linuxarm@huawei.com,
 shannon.zhaosl@gmail.com, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, james.morse@arm.com, jonathan.cameron@huawei.com,
 Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, xuwei5@huawei.com,
 Laszlo Ersek <lersek@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/9 21:05, Beata Michalska wrote:
>> Here we set the FnV to not valid, not to set it to valid.
>> because Guest will use the physical address that recorded in APEI table.
>>
> To be precise : the FnV is  giving the status of FAR - so what you are setting
> here is status of 0b0 which means FAR is valid, not FnV on it's own.
> And my point was that you are changing the prototype for syn_data_abort_no_iss
> just for this case only so I was just thinking that it might not be
> worth that, instead
> you could just set it here ... or to be more flexible , provide a way
> to set specific bits
> on demand.

No, I set the FnV to 0b1, not 0b0, the whole esr_el1's value is 0x96000410, as shown below log:
I remember changing the prototype for syn_data_abort_no_iss is suggested by Peter Maydell.


[1]:
[   62.851830] Internal error: synchronous external abort: 96000410 [#1] PREEMPT SMP
[   62.854465] Modules linked in:



> 


