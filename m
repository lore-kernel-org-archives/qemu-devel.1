Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB7C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990AA2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990AA2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fe0-0001zs-Px
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1j2Fd7-0001RX-LK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1j2Fd6-0002cd-Hw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:38:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2706 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1j2Fd1-0002Ia-QY; Thu, 13 Feb 2020 09:38:08 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3819C89C6ADD71460F86;
 Thu, 13 Feb 2020 22:37:57 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.53) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 22:37:50 +0800
Subject: Re: [PATCH v2 0/4] arm64: Add the cpufreq device to show cpufreq info
 to guest
To: Andrew Jones <drjones@redhat.com>
References: <20200213073630.2125-1-fangying1@huawei.com>
 <20200213081854.ewkk23yhnog23upj@kamzik.brq.redhat.com>
From: fangying <fangying1@huawei.com>
Message-ID: <68b913c3-76d8-c559-ea71-1510635bcbbd@huawei.com>
Date: Thu, 13 Feb 2020 22:37:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213081854.ewkk23yhnog23upj@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, guoheyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/13 16:18, Andrew Jones wrote:
> On Thu, Feb 13, 2020 at 03:36:26PM +0800, Ying Fang wrote:
>> On ARM64 platform, cpu frequency is retrieved via ACPI CPPC.
>> A virtual cpufreq device based on ACPI CPPC is created to
>> present cpu frequency info to the guest.
>>
>> The default frequency is set to host cpu nominal frequency,
>> which is obtained from the host CPPC sysfs. Other performance
>> data are set to the same value, since we don't support guest
>> performance scaling here.
>>
>> Performance counters are also not emulated and they simply
>> return 1 if read, and guest should fallback to use desired
>> performance value as the current performance.
>>
>> Guest kernel version above 4.18 is required to make it work.
>>
>=20
> This is v2 of the series, but I don't see a changelog.
>=20
Hi Andrew, please forgive my carelessness, I forget to add the changelog =
here.
Actually v2 is slightly modified with a few fixes for compilation
warning and a commit message.

> Can you please describe the motivation for this? If I understand
> correctly, all of this is just to inform the guest of the host's
> CPU0 nominal or max (if nominal isn't present?) frequency. Why
> do that?=20

Yes, you are right.

The motivation is that there seems no other formal way than the CPPC
feature for arm64 to present cpu frequency info to the OS. However on
x86 platform we have the CPUID method to do that. Some of our VM customer=
s
and cloud developers want that information to do something. So we come up
with the virtual cpufreq device way.

> What happens if the guest migrates somewhere where the
> frequency is different?=20

If the guest is migrated to any host where the frequency is different,
a next read on the CPPC related register may return the new cpufreq info.

> If this is for a special use case, then
> why not come up with a different channel (guest agent?) to pass
> this information?

Maybe some userspace apps need it to do perf tuning or they
want to know the accurate cpu nominal frequency by using tools
like lshw.

We use the CPPC cpufreq way because we think this is a much more
standard way to do that.
>=20
> Thanks,
> drew
>=20
>=20
> .
>=20

Thanks=EF=BC=8C
Ying


