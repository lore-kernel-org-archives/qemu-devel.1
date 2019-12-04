Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F9C2D0CB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28F92053B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28F92053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icO6n-0005O7-66
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 01:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1icNzl-0003jV-OY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1icNzd-0000ie-Qd
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:18:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45878 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1icNzU-0007np-BZ; Wed, 04 Dec 2019 01:18:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9EB029CEB8646D368816;
 Wed,  4 Dec 2019 14:18:14 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 14:18:06 +0800
Subject: Re: [PATCH 0/5] tests: Enable fw_cfg tests on AArch64
To: Thomas Huth <thuth@redhat.com>, <peter.maydell@linaro.org>,
 <lvivier@redhat.com>
References: <20191203122753.19792-1-zhengxiang9@huawei.com>
 <b5ef73c8-fa23-8efe-ef03-1d223a49bb93@redhat.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <b8ac6a18-36d6-20a1-4c04-f6742572c7c7@huawei.com>
Date: Wed, 4 Dec 2019 14:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b5ef73c8-fa23-8efe-ef03-1d223a49bb93@redhat.com>
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
Cc: lersek@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kraxel@redhat.com, wanghaibin.wang@huawei.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/3 21:01, Thomas Huth wrote:
> On 03/12/2019 13.27, Xiang Zheng wrote:
>> There are quite a few tests disabled on AArch64 such as fw_cfg-tests.
>> This patch series fix some problems in test code and adapt it to
>> virt machine.
>>
>> Xiang Zheng (5):
>>   tests: fw_cfg: Rename pc_fw_cfg_* to fw_cfg_*
>>   tests: fw_cfg: Support read/write of fw_cfg registers on aarch64
>>   tests: fw_cfg: Use virt as default machine in fw_cfg-test.c
>>   hw/arm/virt: Add FW_CFG_RAM_SIZE and FW_CFG_MAX_CPUS into fw_cfg
>>   tests: Enable fw_cfg test on aarch64
> 
>  Hi,
> 
> this breaks "make check-qtest-ppc64":
> 
>   TEST    check-qtest-ppc64: tests/boot-order-test
> **
> ERROR:tests/boot-order-test.c:40:test_a_boot_order: assertion failed
> (actual == expected_boot): (0x00000000 == 0x00000063)
> 
> Please make sure that "make check" continuous to work with all other
> targets, too.
> 

Hi Thomas,

Thanks for your suggestion, I will make sure for that. :)

-- 

Thanks,
Xiang


