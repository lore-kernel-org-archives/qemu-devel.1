Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF844C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 01:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9041D20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 01:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9041D20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF6UV-0004RL-MR
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 21:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1jF6Tm-0003yc-Gd
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 21:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1jF6Tl-0003j8-5w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 21:29:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3724 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1jF6Tk-0003es-RJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 21:29:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 30023DAC8A817B4BD025;
 Fri, 20 Mar 2020 09:29:33 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0;
 Fri, 20 Mar 2020 09:29:25 +0800
Subject: Re: [PATCH v4 0/2] add new options to set smbios type 4 fields
To: Igor Mammedov <imammedo@redhat.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
 <20200319154626.551a7852@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <8ae04ed2-e81b-0aa6-f313-0be9bfd93c04@huawei.com>
Date: Fri, 20 Mar 2020 09:29:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200319154626.551a7852@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/19 22:46, Igor Mammedov wrote:
> On Wed, 18 Mar 2020 14:48:18 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> Common VM users sometimes care about CPU speed, so we add two new
>> options to allow VM vendors to present CPU speed to their users.
>> Normally these information can be fetched from host smbios.
> it's probably too late for this series due to soft-freeze,
> pls repost once 5.0 is released

Ah, I didn't pay enough attention to the merge window.

When will the soft-freeze be ended? Will it be announced in the mailing=20
list?

Thanks,

Heyi

>
>> v3 -> v4:
>> - Fix the default value when not specifying "-smbios type=3D4" option;
>>    it would be 0 instead of 2000 in previous versions
>> - Use uint64_t type to check value overflow
>> - Add test case to check smbios type 4 CPU speed
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Heyi Guo (2):
>>    hw/smbios: add options for type 4 max-speed and current-speed
>>    tests/bios-tables-test: add smbios cpu speed test
>>
>>   hw/smbios/smbios.c             | 36 +++++++++++++++++++++++++----
>>   qemu-options.hx                |  3 ++-
>>   tests/qtest/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++=
++
>>   3 files changed, 76 insertions(+), 5 deletions(-)
>>
>
> .


