Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D73AC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4256F20989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4256F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOM3W-0005B9-KU
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:52:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robin.murphy@arm.com>) id 1hOM22-0003sY-DT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robin.murphy@arm.com>) id 1hOM20-0005la-CH
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:50:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58144
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robin.murphy@arm.com>)
	id 1hOM1s-0005OA-Mp; Wed, 08 May 2019 08:50:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F5380D;
	Wed,  8 May 2019 05:50:33 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2459A3F575;
	Wed,  8 May 2019 05:50:30 -0700 (PDT)
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>
References: <5FC3163CFD30C246ABAA99954A238FA83F1B6A66@lhreml524-mbs.china.huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca5f7231-6924-0720-73a5-766eb13ee331@arm.com>
Date: Wed, 8 May 2019 13:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F1B6A66@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [Question] Memory hotplug clarification for Qemu
 ARM/virt
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Linuxarm <linuxarm@huawei.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"xuwei \(O\)" <xuwei5@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 08/05/2019 11:15, Shameerali Kolothum Thodi wrote:
> Hi,
> 
> This series here[0] attempts to add support for PCDIMM in QEMU for
> ARM/Virt platform and has stumbled upon an issue as it is not clear(at least
> from Qemu/EDK2 point of view) how in physical world the hotpluggable
> memory is handled by kernel.
> 
> The proposed implementation in Qemu, builds the SRAT and DSDT parts
> and uses GED device to trigger the hotplug. This works fine.
> 
> But when we added the DT node corresponding to the PCDIMM(cold plug
> scenario), we noticed that Guest kernel see this memory during early boot
> even if we are booting with ACPI. Because of this, hotpluggable memory
> may end up in zone normal and make it non-hot-un-pluggable even if Guest
> boots with ACPI.
> 
> Further discussions[1] revealed that, EDK2 UEFI has no means to interpret the
> ACPI content from Qemu(this is designed to do so) and uses DT info to
> build the GetMemoryMap(). To solve this, introduced "hotpluggable" property
> to DT memory node(patches #7 & #8 from [0]) so that UEFI can differentiate
> the nodes and exclude the hotpluggable ones from GetMemoryMap().
> 
> But then Laszlo rightly pointed out that in order to accommodate the changes
> into UEFI we need to know how exactly Linux expects/handles all the
> hotpluggable memory scenarios. Please find the discussion here[2].
> 
> For ease, I am just copying the relevant comment from Laszlo below,
> 
> /******
> "Given patches #7 and #8, as I understand them, the firmware cannot distinguish
>   hotpluggable & present, from hotpluggable & absent. The firmware can only
>   skip both hotpluggable cases. That's fine in that the firmware will hog neither
>   type -- but is that OK for the OS as well, for both ACPI boot and DT boot?
> 
> Consider in particular the "hotpluggable & present, ACPI boot" case. Assuming
> we modify the firmware to skip "hotpluggable" altogether, the UEFI memmap
> will not include the range despite it being present at boot. Presumably, ACPI
> will refer to the range somehow, however. Will that not confuse the OS?
> 
> When Igor raised this earlier, I suggested that hotpluggable-and-present should
> be added by the firmware, but also allocated immediately, as EfiBootServicesData
> type memory. This will prevent other drivers in the firmware from allocating AcpiNVS
> or Reserved chunks from the same memory range, the UEFI memmap will contain
> the range as EfiBootServicesData, and then the OS can release that allocation in
> one go early during boot.
> 
> But this really has to be clarified from the Linux kernel's expectations. Please
> formalize all of the following cases:
> 
> OS boot (DT/ACPI)  hotpluggable & ...  GetMemoryMap() should report as  DT/ACPI should report as
> -----------------  ------------------  -------------------------------  ------------------------
> DT                 present             ?                                ?
> DT                 absent              ?                                ?
> ACPI               present             ?                                ?
> ACPI               absent              ?                                ?
> 
> Again, this table is dictated by Linux."
> 
> ******/
> 
> Could you please take a look at this and let us know what is expected here from
> a Linux kernel view point.

For arm64, so far we've not even been considering DT-based hotplug - as 
far as I'm aware there would still be a big open question there around 
notification mechanisms and how to describe them. The DT stuff so far 
has come from the PowerPC folks, so it's probably worth seeing what 
their ideas are.

ACPI-wise I've always assumed/hoped that hotplug-related things should 
be sufficiently well-specified in UEFI that "do whatever x86/IA-64 do" 
would be enough for us.

Robin.

> (Hi Laszlo/Igor/Eric, please feel free to add/change if I have missed any valid
> points above).
> 
> Thanks,
> Shameer
> [0] https://patchwork.kernel.org/cover/10890919/
> [1] https://patchwork.kernel.org/patch/10863299/
> [2] https://patchwork.kernel.org/patch/10890937/
> 
> 

