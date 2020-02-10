Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1064C2BA83
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863BC20870
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863BC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0wzE-0001PJ-JN
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 19:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j0wyM-0000rh-38
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 19:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j0wyL-000575-3h
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 19:30:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58826 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1j0wyI-0004yF-EU; Sun, 09 Feb 2020 19:30:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3C093DF6E8F6169F310C;
 Mon, 10 Feb 2020 08:30:35 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 10 Feb 2020 08:30:24 +0800
Subject: Re: [PATCH v3 0/7] Some cleanup in arm/virt/acpi
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200204014325.16279-1-guoheyi@huawei.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <03b1f20b-6b65-0856-a1e8-5aff14154ad6@huawei.com>
Date: Mon, 10 Feb 2020 08:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200204014325.16279-1-guoheyi@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Do you have any other comments? If not, could you help to merge into 
your tree?

Thanks,

Heyi

On 2020/2/4 9:43, Heyi Guo wrote:
> Remove conflict _ADR objects, and fix and refine PCI device definition in
> ACPI/DSDT.
>
> History:
>
> v3 -> v2:
> - update commit message for patch 4/7.
> - remove diff keywords in commit message of patch 7/7 to avoid applying patch
>    failure.
>
> v1 -> v2:
> - flow the work flow in tests/qtest/bios-table-test.c to post ACPI related
>    patches.
> - update commit messages for removing "RP0" and "_ADR".
> - add 3 more cleanup patches.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
>
> Heyi Guo (7):
>    bios-tables-test: prepare to change ARM virt ACPI DSDT
>    arm/virt/acpi: remove meaningless sub device "RP0" from PCI0
>    arm/virt/acpi: remove _ADR from devices identified by _HID
>    arm/acpi: fix PCI _PRT definition
>    arm/acpi: fix duplicated _UID of PCI interrupt link devices
>    arm/acpi: simplify the description of PCI _CRS
>    virt/acpi: update golden masters for DSDT update
>
>   hw/arm/virt-acpi-build.c          |  25 ++++++-------------------
>   tests/data/acpi/virt/DSDT         | Bin 18462 -> 5307 bytes
>   tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 6644 bytes
>   tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 5307 bytes
>   4 files changed, 6 insertions(+), 19 deletions(-)
>


