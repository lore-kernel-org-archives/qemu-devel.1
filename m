Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9ABC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 01:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C428120732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 01:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C428120732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iynG8-0006Sc-Ru
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 20:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iynFZ-0005v6-RW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 20:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iynFY-0003SO-KS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 20:43:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2749 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iynFV-00035X-5N; Mon, 03 Feb 2020 20:43:33 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7104A1C2F3DB9C057A7D;
 Tue,  4 Feb 2020 09:43:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 4 Feb 2020 09:43:20 +0800
Subject: Re: [PATCH v2 0/7] Some cleanup in arm/virt/acpi
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203014246-mutt-send-email-mst@kernel.org>
 <455d16a4-e7b6-af9b-0b7e-43be70e22f7b@huawei.com>
 <CAFEAcA_g3XXnxiV2O37zpj7gw8For042hg0Vau44qm=ByOuXdw@mail.gmail.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <32e63add-da4b-ed26-98dc-2ab69f3ab007@huawei.com>
Date: Tue, 4 Feb 2020 09:43:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_g3XXnxiV2O37zpj7gw8For042hg0Vau44qm=ByOuXdw@mail.gmail.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E5=9C=A8 2020/2/3 22:03, Peter Maydell =E5=86=99=E9=81=93:
> On Mon, 3 Feb 2020 at 13:33, Heyi Guo <guoheyi@huawei.com> wrote:
>>
>> =E5=9C=A8 2020/2/3 14:43, Michael S. Tsirkin =E5=86=99=E9=81=93:
>>> On Mon, Feb 03, 2020 at 08:14:58AM +0800, Heyi Guo wrote:
>>>> Remove conflict _ADR objects, and fix and refine PCI device definiti=
on in
>>>> ACPI/DSDT.
>>>>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>>>> Cc: qemu-arm@nongnu.org
>>>> Cc: qemu-devel@nongnu.org
>>> Series
>>>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> merge through ARM tree pls.
>> Thanks, Michael :)
>>
>>
>> Hi Peter,
>>
>> Do I need to send v3 to update the commit message of patch 4/7 as
>> Michael suggested?
> This patchset seems to be corrupt somehow:
>
> e104462:bionic:qemu$ patches apply -s
> id:20200203001505.52573-1-guoheyi@huawei.com
> Applying: bios-tables-test: prepare to change ARM virt ACPI DSDT
> Applying: arm/virt/acpi: remove meaningless sub device "RP0" from PCI0
> Applying: arm/virt/acpi: remove _ADR from devices identified by _HID
> Applying: arm/acpi: fix PCI _PRT definition
> Applying: arm/acpi: fix duplicated _UID of PCI interrupt link devices
> Applying: arm/acpi: simplify the description of PCI _CRS
> Applying: virt/acpi: update golden masters for DSDT update
> error: corrupt patch at line 68
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch' to see the failed patch
> Patch failed at 0007 virt/acpi: update golden masters for DSDT update
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Patchew didn't like it either:
> https://patchew.org/QEMU/20200203001505.52573-1-guoheyi@huawei.com/
>
> I think the problem here is the quoting of the diff in
> the commit message of patch 7: git am and friends think
> that is part of the actual patch body and get confused.
> You might be able to avoid that by not putting the
>    diff --git a/DSDT.dsl.orig b/DSDT.dsl
>    index ed3e5f0fa9..10cf70c886 100644
>    --- a/DSDT.dsl.orig
>    +++ b/DSDT.dsl
>
> part in the commit message, but I haven't tested that.
>
> So resending a v4 would probably be a good idea anyway.

Sorry for trouble. I should have tried locally before sending the patch.

Yes, removing the above 4 lines help git am success.

I'll send a v3.

Thanks,

Heyi

>
> thanks
> -- PMM
>
> .


