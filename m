Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0541CA9EC3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 07:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C928820830
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 07:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C928820830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPLbT-0005r4-1f
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 03:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1iPLaj-0005JY-Sk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1iPLaj-0002a9-0s
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:06:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45910 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1iPLag-0002VA-OO; Tue, 29 Oct 2019 03:06:55 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BA2A1F28D5842D3484E9;
 Tue, 29 Oct 2019 15:06:47 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 15:06:42 +0800
Subject: Re: [PATCH v20 0/5] Add ARMv8 RAS virtualization support in QEMU
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191026032447.20088-1-zhengxiang9@huawei.com>
 <20191027061450-mutt-send-email-mst@kernel.org>
 <6c44268a-2676-3fa1-226d-29877b21dbea@huawei.com>
 <20191028042645-mutt-send-email-mst@kernel.org>
 <1edda59a-8b3d-1eec-659a-05356d55ed22@huawei.com>
 <20191028104834-mutt-send-email-mst@kernel.org>
 <a16f00df-98cd-3469-1c64-d9d7a6ccaccf@huawei.com>
 <CAFEAcA9fTOoOpeHfnhgy1p-tXk3b8p-e8T02jWkhhBmjv3OnDA@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <371db98f-1412-818c-fb96-a75530cde4d0@huawei.com>
Date: Tue, 29 Oct 2019 15:06:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fTOoOpeHfnhgy1p-tXk3b8p-e8T02jWkhhBmjv3OnDA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU
 Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>, "xuwei
 \(O\)" <xuwei5@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 wanghaibin.wang@huawei.com, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/10/28 23:16, Peter Maydell wrote:
>> Hi Peter,
>>     what do you think about it?
> I suggest you just use R: for the moment. The code will all end up going
> through my tree or perhaps Michael's anyway, so it doesn't make much
> practical difference.

ok, got it, thanks.

> 
> thanks
> -- PMM
> .
> 


