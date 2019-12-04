Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F80C0044D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9398224665
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9398224665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icO4P-0004bZ-On
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 01:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1icNvj-0002Rn-8q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1icNvc-0005rs-R3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:14:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2210 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1icNvT-0004YT-Te; Wed, 04 Dec 2019 01:14:16 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6A12D230597084F36CD4;
 Wed,  4 Dec 2019 14:14:00 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 14:13:54 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH 1/5] tests: fw_cfg: Rename pc_fw_cfg_* to fw_cfg_*
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203122753.19792-1-zhengxiang9@huawei.com>
 <20191203122753.19792-2-zhengxiang9@huawei.com>
 <CAFEAcA_TbC2haopmmbLChuE1bxA2KV74fximNu5kQ1pQB9VmYA@mail.gmail.com>
Message-ID: <76a92f2e-bf55-77e1-7691-30d76298aeca@huawei.com>
Date: Wed, 4 Dec 2019 14:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TbC2haopmmbLChuE1bxA2KV74fximNu5kQ1pQB9VmYA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/3 20:34, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 12:29, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> Rename pc_fw_cfg_* to fw_cfg_* to make them common for other
>> architectures so that we can run fw_cfg tests on aarch64.
>>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> 
>> -static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>> +static inline QFWCFG *fw_cfg_init(QTestState *qts)
>>  {
>> -    return io_fw_cfg_init(qts, 0x510);
>> +    const char *arch = qtest_get_arch();
>> +
>> +    if (!strcmp(arch, "aarch64")) {
>> +        return mm_fw_cfg_init(qts, 0x09020000);
>> +    } else {
>> +        return io_fw_cfg_init(qts, 0x510);
>> +    }
> 
> Presence and address of the fw_cfg device depends
> on the machine type, not the architecture, so is
> it possible to write this so that it varies by
> machine type, rather than by guest arch ?
> There should also presumably be a fallback path
> for "fw_cfg not present here", I suppose.
> 

Yes, "0x09020000" is the address of the fw_cfg device on virt machine, I
should have noticed it. I will have a try for varying the addresses
by machine type.

-- 

Thanks,
Xiang


