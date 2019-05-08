Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE822C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A271520578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A271520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34313 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJdQ-0000B1-VF
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 06:17:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hOJcV-0008F0-1Q
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hOJcT-0005ae-Tv
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:16:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45400 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hOJcR-0005X5-BE; Wed, 08 May 2019 06:16:11 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 1AD5B8EA87B25B67F17B;
	Wed,  8 May 2019 11:16:01 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.137]) by
	lhreml703-cah.china.huawei.com ([10.201.108.44]) with mapi id
	14.03.0415.000; Wed, 8 May 2019 11:15:51 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Anshuman
	Khandual" <anshuman.khandual@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>
Thread-Topic: [Question] Memory hotplug clarification for Qemu ARM/virt 
Thread-Index: AdUFf3K/4T6J1HYjRj6wDE9hxn3APQ==
Date: Wed, 8 May 2019 10:15:50 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F1B6A66@lhreml524-mbs.china.huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: [Qemu-devel] [Question] Memory hotplug clarification for Qemu
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

Hi,

This series here[0] attempts to add support for PCDIMM in QEMU for
ARM/Virt platform and has stumbled upon an issue as it is not clear(at leas=
t
from Qemu/EDK2 point of view) how in physical world the hotpluggable
memory is handled by kernel.

The proposed implementation in Qemu, builds the SRAT and DSDT parts
and uses GED device to trigger the hotplug. This works fine.

But when we added the DT node corresponding to the PCDIMM(cold plug
scenario), we noticed that Guest kernel see this memory during early boot
even if we are booting with ACPI. Because of this, hotpluggable memory
may end up in zone normal and make it non-hot-un-pluggable even if Guest
boots with ACPI.

Further discussions[1] revealed that, EDK2 UEFI has no means to interpret t=
he
ACPI content from Qemu(this is designed to do so) and uses DT info to
build the GetMemoryMap(). To solve this, introduced "hotpluggable" property
to DT memory node(patches #7 & #8 from [0]) so that UEFI can differentiate
the nodes and exclude the hotpluggable ones from GetMemoryMap().

But then Laszlo rightly pointed out that in order to accommodate the change=
s
into UEFI we need to know how exactly Linux expects/handles all the=20
hotpluggable memory scenarios. Please find the discussion here[2].

For ease, I am just copying the relevant comment from Laszlo below,

/******
"Given patches #7 and #8, as I understand them, the firmware cannot disting=
uish
 hotpluggable & present, from hotpluggable & absent. The firmware can only
 skip both hotpluggable cases. That's fine in that the firmware will hog ne=
ither
 type -- but is that OK for the OS as well, for both ACPI boot and DT boot?

Consider in particular the "hotpluggable & present, ACPI boot" case. Assumi=
ng
we modify the firmware to skip "hotpluggable" altogether, the UEFI memmap
will not include the range despite it being present at boot. Presumably, AC=
PI
will refer to the range somehow, however. Will that not confuse the OS?

When Igor raised this earlier, I suggested that hotpluggable-and-present sh=
ould
be added by the firmware, but also allocated immediately, as EfiBootService=
sData
type memory. This will prevent other drivers in the firmware from allocatin=
g AcpiNVS
or Reserved chunks from the same memory range, the UEFI memmap will contain
the range as EfiBootServicesData, and then the OS can release that allocati=
on in
one go early during boot.

But this really has to be clarified from the Linux kernel's expectations. P=
lease
formalize all of the following cases:

OS boot (DT/ACPI)  hotpluggable & ...  GetMemoryMap() should report as  DT/=
ACPI should report as
-----------------  ------------------  -------------------------------  ---=
---------------------
DT                 present             ?                                ?
DT                 absent              ?                                ?
ACPI               present             ?                                ?
ACPI               absent              ?                                ?

Again, this table is dictated by Linux."

******/

Could you please take a look at this and let us know what is expected here =
from
a Linux kernel view point.

(Hi Laszlo/Igor/Eric, please feel free to add/change if I have missed any v=
alid
points above).

Thanks,
Shameer
[0] https://patchwork.kernel.org/cover/10890919/
[1] https://patchwork.kernel.org/patch/10863299/
[2] https://patchwork.kernel.org/patch/10890937/



