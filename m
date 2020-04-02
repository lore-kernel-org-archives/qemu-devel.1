Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB88C2BA15
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EEE20757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EEE20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzAL-0003yj-Aw
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jJz9b-0003N2-VE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jJz9a-00075m-RW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:41:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3222 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jJz9Y-0006zb-4l; Thu, 02 Apr 2020 08:41:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D905A6F00FF2ADCB7EC9;
 Thu,  2 Apr 2020 20:40:49 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 20:40:43 +0800
Subject: Re: [kvm-unit-tests PATCH v7 10/13] arm/arm64: ITS: INT functional
 tests
To: Auger Eric <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-11-eric.auger@redhat.com>
 <f7f1d7c4-2321-9123-2394-528af737bfa7@huawei.com>
 <fa4e14f6-20ee-982f-0eda-74b101cddf7a@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <114f8bba-a1e0-0367-a1b4-e875718d8dba@huawei.com>
Date: Thu, 2 Apr 2020 20:40:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fa4e14f6-20ee-982f-0eda-74b101cddf7a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2020/4/2 16:50, Auger Eric wrote:
> Hi Zenghui,
>=20
> On 3/30/20 12:43 PM, Zenghui Yu wrote:
>> Hi Eric,
>>
>> On 2020/3/20 17:24, Eric Auger wrote:
>>> Triggers LPIs through the INT command.
>>>
>>> the test checks the LPI hits the right CPU and triggers
>>> the right LPI intid, ie. the translation is correct.
>>>
>>> Updates to the config table also are tested, along with inv
>>> and invall commands.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> [...]
>>
>> So I've tested this series and found that the "INT" test will sometime=
s
>> fail.
>>
>> "not ok 12 - gicv3: its-migration: dev2/eventid=3D20 triggers LPI 8195=
 en
>> PE #3 after migration
>> not ok 13 - gicv3: its-migration: dev7/eventid=3D255 triggers LPI 8196=
 on
>> PE #2 after migration"
>>
>>  From logs:
>> "INFO: gicv3: its-migration: Migration complete
>> INT dev_id=3D2 event_id=3D20
>> INFO: gicv3: its-migration: No LPI received whereas (cpuid=3D3,
>> intid=3D8195) was expected
>> FAIL: gicv3: its-migration: dev2/eventid=3D20 triggers LPI 8195 en PE =
#3
>> after migration
>> INT dev_id=3D7 event_id=3D255
>> INFO: gicv3: its-migration: No LPI received whereas (cpuid=3D2,
>> intid=3D8196) was expected
>> FAIL: gicv3: its-migration: dev7/eventid=3D255 triggers LPI 8196 on PE=
 #2
>> after migration"
>>
>>> +static void check_lpi_stats(const char *msg)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 bool pass =3D false;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mdelay(100);
>>
>> After changing this to 'mdelay(1000)', the above error doesn't show up
>> anymore. But it sounds strange that 100ms is not enough to deliver a
>> single LPI. I haven't dig it further but will get back here later.
>=20
> Did you find some time to investigate this issue. Changing 100 to 1000
> has a huge impact on the overall test duration and I don't think it is
> sensible. Could you see what is your minimal value that pass the tests?

I can reproduce this issue with a very *low* probability so I failed
to investigate it :-(.  (It might because the LPI was delivered to a
busy vcpu...)

You can leave it as it is until someone else complain about it again.
Or take the similar approach as check_acked() - wait up to 5s for the
interrupt to be delivered, and bail out as soon as we see it.


Thanks,
Zenghui


