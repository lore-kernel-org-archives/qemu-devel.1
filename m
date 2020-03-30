Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C440220732
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C440220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItQa-0003oj-Vk
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jItPo-0003Hr-OR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jItPn-0005sI-Ph
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:21:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3730 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jItPj-0005pJ-1L; Mon, 30 Mar 2020 08:21:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4EDC38D557AA0DF61F53;
 Mon, 30 Mar 2020 20:21:05 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 20:20:58 +0800
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
To: Andrew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
 <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
 <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <9f3951c9-8ff6-531f-e9a5-abafdab5fef8@huawei.com>
Date: Mon, 30 Mar 2020 20:20:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 andre.przywara@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 maz@kernel.org, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 2020/3/30 17:11, Andrew Jones wrote:
> On Mon, Mar 30, 2020 at 10:46:57AM +0200, Auger Eric wrote:
>> Hi Zenghui,
>>
>> On 3/30/20 10:30 AM, Zenghui Yu wrote:

[...]

>>> Otherwise I think we will end-up with memory corruption when writing
>>> the command queue.=C2=A0 But it seems that everything just works fine=
 ...
>>> So I'm really confused here :-/
>> I was told by Paolo that the VA/PA memory map is flat in kvmunit test.
>=20
> What does flat mean? kvm-unit-tests, at least arm/arm64, does prepare
> an identity map of all physical memory, which explains why the above
> is working. It's doing virt_to_phys(some-virt-addr), which gets a
> phys addr, but when the ITS uses it as a virt addr it works because
> we *also* have a virt addr =3D=3D phys addr mapping in the default page
> table, which is named "idmap" for good reason.

Thanks for the explanation :-). I will have a look at the arm/arm64 mm
code to learn it.


Thanks,
Zenghui


