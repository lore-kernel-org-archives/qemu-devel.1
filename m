Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC941C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC76206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC76206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCZYw-0000JG-SF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jCZYG-0008F1-4t
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jCZYF-0003wF-4B
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:55:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39564 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jCZYB-0003cq-HU; Thu, 12 Mar 2020 21:55:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3CC268047441D80DBB2B;
 Fri, 13 Mar 2020 09:55:38 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 09:55:31 +0800
Subject: Re: [kvm-unit-tests PATCH v5 10/13] arm/arm64: ITS: INT functional
 tests
To: Auger Eric <eric.auger@redhat.com>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-11-eric.auger@redhat.com>
 <d3f651a0-2344-4d6e-111b-be133db7e068@huawei.com>
 <46f0ed1d-3bda-f91b-e2b0-addf1c61c373@redhat.com>
 <301a8b402ff7e480e927b0f8f8b093f2@kernel.org>
 <7fb9f81f-6520-526d-7031-d3d08cb1dd6a@huawei.com>
 <acc652b7-f331-1e48-160c-f07e0e5283b3@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <160015aa-f5d7-2fdc-8d06-1322af241896@huawei.com>
Date: Fri, 13 Mar 2020 09:55:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <acc652b7-f331-1e48-160c-f07e0e5283b3@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2020/3/12 17:59, Auger Eric wrote:
> Hi Zenghui,
> 
> On 3/12/20 10:19 AM, Zenghui Yu wrote:
>> On 2020/3/11 22:00, Marc Zyngier wrote:
>>> That is still a problem with the ITS. There is no architectural way
>>> to report an error, even if the error numbers are architected...
>>>
>>> One thing we could do though is to implement the stall model (as
>>> described
>>> in 5.3.2). It still doesn't give us the error, but at least the command
>>> queue would stop on detecting an error.
>>
>> It would be interesting to see the buggy guest's behavior under the
>> stall mode. I've used the following diff (absolutely *not* a formal
>> patch, don't handle CREADR.Stalled and CWRITER.Retry at all) to have
>> a try, and caught another command error in the 'its-trigger' test.
>>
>> logs/its-trigger.log:
>> " INT dev_id=2 event_id=20
>> lib/arm64/gic-v3-its-cmd.c:194: assert failed: false: INT timeout! "
>>
>> dmesg:
>> [13297.711958] ------------[ cut here ]------------
>> [13297.711964] ITS command error encoding 0x10307
>>
>> It's the last INT test in test_its_trigger() who has triggered this
>> error, Eric?
> 
> Yes it may be the culprit. Anyway I removed the collection unmap in v6.

I forgot to mention that this is based on your v6. I'll reply to it.

> 
> By the way are you OK now with v6? I think Drew plans to send a pull
> request by the end of this week.

Sorry I haven't looked at it yet (v5 already looks good except for
some minor issues).


Thanks,
Zenghui


