Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED55C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 21:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3216217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 21:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3216217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOqus-0006f8-4o
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 17:49:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hOqty-0006HO-E7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 17:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hOqtw-0000P2-IR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 17:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hOqtr-0000L0-W6; Thu, 09 May 2019 17:48:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E63A81112;
	Thu,  9 May 2019 21:48:22 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-234.rdu2.redhat.com
	[10.10.120.234])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14BC65DF49;
	Thu,  9 May 2019 21:48:15 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F1B6A66@lhreml524-mbs.china.huawei.com>
	<ca5f7231-6924-0720-73a5-766eb13ee331@arm.com>
	<190831a5-297d-addb-ea56-645afb169efb@redhat.com>
	<20190509183520.6dc47f2e@Igors-MacBook-Pro>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cd2aa867-5367-b470-0a2b-33897697c23f@redhat.com>
Date: Thu, 9 May 2019 23:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190509183520.6dc47f2e@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 09 May 2019 21:48:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	"xuwei \(O\)" <xuwei5@huawei.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, linux-mm <linux-mm@kvack.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/09/19 18:35, Igor Mammedov wrote:
> On Wed, 8 May 2019 22:26:12 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
>=20
>> On 05/08/19 14:50, Robin Murphy wrote:
>>> Hi Shameer,
>>>
>>> On 08/05/2019 11:15, Shameerali Kolothum Thodi wrote:
>>>> Hi,
>>>>
>>>> This series here[0] attempts to add support for PCDIMM in QEMU for
>>>> ARM/Virt platform and has stumbled upon an issue as it is not clear(=
at
>>>> least
>>>> from Qemu/EDK2 point of view) how in physical world the hotpluggable
>>>> memory is handled by kernel.
>>>>
>>>> The proposed implementation in Qemu, builds the SRAT and DSDT parts
>>>> and uses GED device to trigger the hotplug. This works fine.
>>>>
>>>> But when we added the DT node corresponding to the PCDIMM(cold plug
>>>> scenario), we noticed that Guest kernel see this memory during early=
 boot
>>>> even if we are booting with ACPI. Because of this, hotpluggable memo=
ry
>>>> may end up in zone normal and make it non-hot-un-pluggable even if G=
uest
>>>> boots with ACPI.
>>>>
>>>> Further discussions[1] revealed that, EDK2 UEFI has no means to
>>>> interpret the
>>>> ACPI content from Qemu(this is designed to do so) and uses DT info t=
o
>>>> build the GetMemoryMap(). To solve this, introduced "hotpluggable"
>>>> property
>>>> to DT memory node(patches #7 & #8 from [0]) so that UEFI can
>>>> differentiate
>>>> the nodes and exclude the hotpluggable ones from GetMemoryMap().
>>>>
>>>> But then Laszlo rightly pointed out that in order to accommodate the
>>>> changes
>>>> into UEFI we need to know how exactly Linux expects/handles all the
>>>> hotpluggable memory scenarios. Please find the discussion here[2].
>>>>
>>>> For ease, I am just copying the relevant comment from Laszlo below,
>>>>
>>>> /******
>>>> "Given patches #7 and #8, as I understand them, the firmware cannot
>>>> distinguish
>>>> =C2=A0 hotpluggable & present, from hotpluggable & absent. The firmw=
are can
>>>> only
>>>> =C2=A0 skip both hotpluggable cases. That's fine in that the firmwar=
e will
>>>> hog neither
>>>> =C2=A0 type -- but is that OK for the OS as well, for both ACPI boot=
 and DT
>>>> boot?
>>>>
>>>> Consider in particular the "hotpluggable & present, ACPI boot" case.
>>>> Assuming
>>>> we modify the firmware to skip "hotpluggable" altogether, the UEFI m=
emmap
>>>> will not include the range despite it being present at boot.
>>>> Presumably, ACPI
>>>> will refer to the range somehow, however. Will that not confuse the =
OS?
>>>>
>>>> When Igor raised this earlier, I suggested that
>>>> hotpluggable-and-present should
>>>> be added by the firmware, but also allocated immediately, as
>>>> EfiBootServicesData
>>>> type memory. This will prevent other drivers in the firmware from
>>>> allocating AcpiNVS
>>>> or Reserved chunks from the same memory range, the UEFI memmap will
>>>> contain
>>>> the range as EfiBootServicesData, and then the OS can release that
>>>> allocation in
>>>> one go early during boot.
>>>>
>>>> But this really has to be clarified from the Linux kernel's
>>>> expectations. Please
>>>> formalize all of the following cases:
>>>>
>>>> OS boot (DT/ACPI)=C2=A0 hotpluggable & ...=C2=A0 GetMemoryMap() shou=
ld report
>>>> as=C2=A0 DT/ACPI should report as
>>>> -----------------=C2=A0 ------------------=C2=A0
>>>> -------------------------------=C2=A0 ------------------------
>>>> DT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 present=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ?
>>>> DT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 absent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ?
>>>> ACPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 present=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?
>>>> ACPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 absent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?
>>>>
>>>> Again, this table is dictated by Linux."
>>>>
>>>> ******/
>>>>
>>>> Could you please take a look at this and let us know what is expecte=
d
>>>> here from
>>>> a Linux kernel view point.
>>>
>>> For arm64, so far we've not even been considering DT-based hotplug - =
as
>>> far as I'm aware there would still be a big open question there aroun=
d
>>> notification mechanisms and how to describe them. The DT stuff so far
>>> has come from the PowerPC folks, so it's probably worth seeing what
>>> their ideas are.
>>>
>>> ACPI-wise I've always assumed/hoped that hotplug-related things shoul=
d
>>> be sufficiently well-specified in UEFI that "do whatever x86/IA-64 do=
"
>>> would be enough for us.
>>
>> As far as I can see in UEFI v2.8 -- and I had checked the spec before
>> dumping the table with the many question marks on Shameer --, all the
>> hot-plug language in the spec refers to USB and PCI hot-plug in the
>> preboot environment. There is not a single word about hot-plug at OS
>> runtime (regarding any device or component type), nor about memory
>> hot-plug (at any time).
>>
>> Looking to x86 appears valid -- so what does the Linux kernel expect o=
n
>> that architecture, in the "ACPI" rows of the table?
>=20
> I could only answer from QEMU x86 perspective.
> QEMU for x86 guests currently doesn't add hot-pluggable RAM into E820
> because of different linux guests tend to cannibalize it, making it non
> unpluggable. The last culprit I recall was KASLR.
>=20
> So I'd refrain from reporting hotpluggable RAM in GetMemoryMap() if
> it's possible (it's probably hack (spec deosn't say anything about it)
> but it mostly works for Linux (plug/unplug) and Windows guest also
> fine with plug part (no unplug there)).

I can accept this as a perfectly valid design. Which would mean, QEMU sho=
uld mark each hotpluggable RAM range in the DTB for the firmware with the=
 special new property, regardless of its initial ("cold") plugged-ness, a=
nd then the firmware will not expose the range in the GCD memory space ma=
p, and consequently in the UEFI memmap either.

IOW, our table is, thus far:

OS boot (DT/ACPI)  hotpluggable & ...  GetMemoryMap() should report as  D=
T/ACPI should report as
-----------------  ------------------  -------------------------------  -=
-----------------------
DT                 present             ABSENT                           ?
DT                 absent              ABSENT                           ?
ACPI               present             ABSENT                           P=
RESENT
ACPI               absent              ABSENT                           A=
BSENT

In the firmware, I only need to care about the GetMemoryMap() column, so =
I can work with this. Can someone please file a feature request at <https=
://bugzilla.tianocore.org/>, for the ArmVirtPkg Package, with these detai=
s?

Thanks
Laszlo

>=20
> As for physical systems, there are out there ones that do report
> hotpluggable RAM in GetMemoryMap().
>=20
>> Shameer: if you (Huawei) are represented on the USWG / ASWG, I suggest
>> re-raising the question on those lists too; at least the "ACPI" rows o=
f
>> the table.
>>
>> Thanks!
>> Laszlo
>>
>>>
>>> Robin.
>>>
>>>> (Hi Laszlo/Igor/Eric, please feel free to add/change if I have misse=
d
>>>> any valid
>>>> points above).
>>>>
>>>> Thanks,
>>>> Shameer
>>>> [0] https://patchwork.kernel.org/cover/10890919/
>>>> [1] https://patchwork.kernel.org/patch/10863299/
>>>> [2] https://patchwork.kernel.org/patch/10890937/
>>>>
>>>>
>>
>=20


