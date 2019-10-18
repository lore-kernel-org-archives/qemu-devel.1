Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B527CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5054D2082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5054D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVJA-0006aG-EI
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iLVI5-0005aS-1D
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iLVI3-00052R-Mh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iLVI0-00050F-94; Fri, 18 Oct 2019 12:39:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16A533090FD6;
 Fri, 18 Oct 2019 16:39:43 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44E305D9CC;
 Fri, 18 Oct 2019 16:39:40 +0000 (UTC)
Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
Date: Fri, 18 Oct 2019 18:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 16:39:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, lersek@redhat.com, linuxarm@huawei.com,
 xuwei5@hisilicon.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 10/4/19 5:52 PM, Shameer Kolothum wrote:
> This series adds NVDIMM support to arm/virt platform.
> This has a dependency on [0] and make use of the GED
> device for NVDIMM hotplug events. The series reuses
> some of=C2=A0the=C2=A0patches posted by Eric in his earlier
> attempt here[1].
>=20
> Patch 1/5 is a fix to the Guest reboot issue on NVDIMM
> hot add case described here[2].
>=20
> I have done basic sanity testing of NVDIMM deviecs with
devcies
> both ACPI and DT Guest boot. Further testing is always
> welcome.
>=20
> Please let me know your feedback.

I tested it on my side. Looks to work pretty well.

one question: I noticed that when a NVDIMM slot is hotplugged one get
the following trace on guest:

nfit ACPI0012:00: found a zero length table '0' parsing nfit
pmem0: detected capacity change from 0 to 1073741824

Have you experienced the 0 length trace?

Besides when we reset the system we find the namespaces again using
"ndctl list -u" so the original bug seems to be fixed.

Did you try to mount a DAX FS. I can mount but with DAX forced off.

sudo mkdir /mnt/mem0
mkfs.xfs -f -m reflink=3D0 /dev/pmem0
sudo mount -o dax /dev/pmem0 /mnt/mem0
[ 2610.051830] XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at
your own risk
[ 2610.178580] XFS (pmem0): DAX unsupported by block device. Turning off
DAX.
[ 2610.180871] XFS (pmem0): Mounting V5 Filesystem
[ 2610.189797] XFS (pmem0): Ending clean mount

I fail to remember if it was the case months ago. I am not sure if it is
an issue in my guest .config or if there is something not yet supported
on aarch64? Did you try on your side?

Also if you forget to put the ",nvdimm" to the machvirt options you get,
on hotplug:
{"error": {"class": "GenericError", "desc": "nvdimm is not yet supported"=
}}
which is not correct anymore ;-)

Thanks

Eric


>=20
> Thanks,
> Shameer
>=20
> [0] https://patchwork.kernel.org/cover/11150345/
> [1] https://patchwork.kernel.org/cover/10830777/
> [2] https://patchwork.kernel.org/patch/11154757/
>=20
> Eric Auger (1):
>   hw/arm/boot: Expose the pmem nodes in the DT
>=20
> Kwangwoo Lee (2):
>   nvdimm: Use configurable ACPI IO base and size
>   hw/arm/virt: Add nvdimm hot-plug infrastructure
>=20
> Shameer Kolothum (2):
>   hw/arm: Align ACPI blob len to PAGE size
>   hw/arm/virt: Add nvdimm hotplug support
>=20
>  docs/specs/acpi_hw_reduced_hotplug.rst |  1 +
>  hw/acpi/generic_event_device.c         | 13 ++++++++
>  hw/acpi/nvdimm.c                       | 32 ++++++++++++------
>  hw/arm/Kconfig                         |  1 +
>  hw/arm/boot.c                          | 45 ++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c               | 20 ++++++++++++
>  hw/arm/virt.c                          | 42 ++++++++++++++++++++----
>  hw/i386/acpi-build.c                   |  6 ++++
>  hw/i386/acpi-build.h                   |  3 ++
>  hw/i386/pc_piix.c                      |  2 ++
>  hw/i386/pc_q35.c                       |  2 ++
>  hw/mem/Kconfig                         |  2 +-
>  include/hw/acpi/generic_event_device.h |  1 +
>  include/hw/arm/virt.h                  |  1 +
>  include/hw/mem/nvdimm.h                |  3 ++
>  15 files changed, 157 insertions(+), 17 deletions(-)
>=20

