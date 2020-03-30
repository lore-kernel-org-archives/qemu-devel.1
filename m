Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84780C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577FE2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577FE2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuJu-0002E3-EZ
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jIuIq-00018Q-C1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jIuIp-0006SU-9U
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:18:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3731 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jIuIi-0006Dn-V3; Mon, 30 Mar 2020 09:18:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6D6481EB6A23AB42A64A;
 Mon, 30 Mar 2020 21:17:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 21:17:48 +0800
Subject: Re: [kvm-unit-tests PATCH v7 13/13] arm/arm64: ITS: pending table
 migration test
To: Auger Eric <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-14-eric.auger@redhat.com>
 <296c574b-810c-9c90-a613-df732a9ac193@huawei.com>
 <ea74559c-2ab4-752c-e587-2bf40eab14b0@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <0e73fd13-ca18-2d17-2267-fd5d852e3ac8@huawei.com>
Date: Mon, 30 Mar 2020 21:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ea74559c-2ab4-752c-e587-2bf40eab14b0@redhat.com>
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/3/30 20:38, Auger Eric wrote:
> Hi Zenghui,

[...]

>>> +
>>> +=C2=A0=C2=A0=C2=A0 ptr =3D gicv3_data.redist_base[pe0] + GICR_PENDBA=
SER;
>>> +=C2=A0=C2=A0=C2=A0 pendbaser =3D readq(ptr);
>>> +=C2=A0=C2=A0=C2=A0 writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ptr =3D gicv3_data.redist_base[pe1] + GICR_PENDBA=
SER;
>>> +=C2=A0=C2=A0=C2=A0 pendbaser =3D readq(ptr);
>>> +=C2=A0=C2=A0=C2=A0 writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_rdist_enable(pe0);
>>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_rdist_enable(pe1);
>>
>> I don't know how the migration gets implemented in kvm-unit-tests.
>> But is there any guarantee that the LPIs will only be triggered on the
>> destination side? As once the EnableLPIs bit becomes 1, VGIC will star=
t
>> reading the pending bit in guest memory and potentially injecting LPIs
>> into the target vcpu (in the source side).
>=20
> I expect some LPIs to hit on source and some others to hit on the
> destination. To me, this does not really matter as long as the handlers
> gets called and accumulate the stats. Given the number of LPIs, we will
> at least test the migration of some of the pending bits and especially
> adjacent ones. It does work as it allows to test your fix:
>=20
> ca185b260951  KVM: arm/arm64: vgic: Don't rely on the wrong pending tab=
le

Fair enough. Thanks for your explanation!


Zenghui


