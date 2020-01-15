Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54956C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 02:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A35E222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 02:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A35E222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irY2j-0006oO-JL
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 21:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1irY1r-0005we-1Y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 21:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1irY1p-0000UM-Te
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 21:03:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47968 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1irY1n-0000NH-9m; Tue, 14 Jan 2020 21:03:27 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A6DF7FA05AC0B4B78E44;
 Wed, 15 Jan 2020 10:03:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 10:03:15 +0800
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
Date: Wed, 15 Jan 2020 10:03:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Corey Minyard <cminyard@mvista.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Igor
 Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter, Michael,

Have we come to conclusion on how to submit patches for ARM ACPI tables?

Some rough thoughts: is it possible to use the disassembled ASL file as=20
the 'golden master' data? One problem I can imagine is that this may=20
introduce dependency on the version of iASL tool. If so, how about=20
adding acpica source code as a submodule, just like what we did for the=20
device tree compile "dtc".

There may be much more which I missed; looking forward to your comments.

Thanks,

Heyi

=E5=9C=A8 2020/1/6 23:51, Peter Maydell =E5=86=99=E9=81=93:
> On Sun, 5 Jan 2020 at 12:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Dec 19, 2019 at 02:47:59PM +0800, Heyi Guo wrote:
>>>   hw/arm/virt-acpi-build.c          |   8 --------
>>>   tests/data/acpi/virt/DSDT         | Bin 18449 -> 18426 bytes
>>>   tests/data/acpi/virt/DSDT.memhp   | Bin 19786 -> 19763 bytes
>>>   tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
>>>   4 files changed, 8 deletions(-)
>> Please do not include binary changes in acpi patches.
>>
>> See comment at the top of tests/bios-tables-test.c for documentation
>> on how to update these.
> If you want the patches not to include binary changes then
> you will need to take these yourself through your own tree.
> As the Arm subtree maintainer I am not going to follow a
> specific process for acpi related patches that requires me
>   to do anything other than "apply patches from email, test
> them, send pull request". I also have no way to
> identify whether any differences that I might see if I
> disassembled the ACPI tables make sense, as that comment
> suggests I should be doing. The differences in the tables need
> to be checked by the people reviewing the patches, which will
> not be me for anything ACPI related -- I just don't know
> enough about the ACPI specs.
>
> Patches should be self contained, including updating test
> cases as required. The underlying problem here is that
> the 'golden master' data for the acpi tests is a pile
> of binary blobs rather than something that's human
> readable and reviewable as part of a patch.
>
> thanks
> -- PMM
>
> .


