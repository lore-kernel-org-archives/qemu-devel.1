Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEC7C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B0020659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B0020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izMbi-0001ek-R2
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1izMb3-0000tb-Rv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1izMb2-0002VR-Bx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:28:09 -0500
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:46509)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1izMb2-0002Mg-6Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:28:08 -0500
Received: from player760.ha.ovh.net (unknown [10.110.208.89])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 932888EED8
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 16:28:05 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id F3713F0B3A4A;
 Wed,  5 Feb 2020 15:27:56 +0000 (UTC)
Subject: Re: [PULL 19/35] ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
 <20200203061123.59150-20-david@gibson.dropbear.id.au>
 <bbb36281-287b-70cf-80ab-9ac54eeca8de@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ba1e6cd7-083d-5d98-e802-1e828a13c467@kaod.org>
Date: Wed, 5 Feb 2020 16:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bbb36281-287b-70cf-80ab-9ac54eeca8de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16070250849180093297
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrhedugdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeitddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.150
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 2:26 PM, Laurent Vivier wrote:
> On 03/02/2020 07:11, David Gibson wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> These changes introduces models for the PCIe Host Bridge (PHB4) of the
>> POWER9 processor. It includes the PowerBus logic interface (PBCQ),
>> IOMMU support, a single PCIe Gen.4 Root Complex, and support for MSI
>> and LSI interrupt sources as found on a POWER9 system using the XIVE
>> interrupt controller.
>>
>> POWER9 processor comes with 3 PHB4 PEC (PCI Express Controller) and
>> each PEC can have several PHBs. By default,
>>
>>   * PEC0 provides 1 PHB  (PHB0)
>>   * PEC1 provides 2 PHBs (PHB1 and PHB2)
>>   * PEC2 provides 3 PHBs (PHB3, PHB4 and PHB5)
>>
>> Each PEC has a set  "global" registers and some "per-stack" (per-PHB)
>> registers. Those are organized in two XSCOM ranges, the "Nest" range
>> and the "PCI" range, each range contains both some "PEC" registers and
>> some "per-stack" registers.
>>
>> No default device layout is provided and PCI devices can be added on
>> any of the available PCIe Root Port (pcie.0 .. 2 of a Power9 chip)
>> with address 0x0 as the firwware (skiboot) only accepts a single
>> device per root port. To run a simple system with a network and a
>> storage adapters, use a command line options such as :
>>
>>   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,ad=
dr=3D0x0
>>   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=
=3Dvirbr0,id=3Dhostnet0
>>
>>   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
>>   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,=
cache=3Dnone
>>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3D=
drive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
>>
>> If more are needed, include a bridge.
>>
>> Multi chip is supported, each chip adding its set of PHB4 controllers
>> and its PCI busses. The model doesn't emulate the EEH error handling.
>>
>> This model is not ready for hotplug yet.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> [ clg: - numerous cleanups
>>        - commit log
>>        - fix for broken LSI support
>>        - PHB pic printinfo
>>        - large QOM rework ]
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Message-Id: <20200127144506.11132-2-clg@kaod.org>
>> [dwg: Use device_class_set_props()]
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/pci-host/Makefile.objs           |    1 +
>>  hw/pci-host/pnv_phb4.c              | 1438 ++++++++++++++++++++++++++=
+
>>  hw/pci-host/pnv_phb4_pec.c          |  593 +++++++++++
>>  hw/ppc/Kconfig                      |    2 +
>>  hw/ppc/pnv.c                        |  107 ++
>>  include/hw/pci-host/pnv_phb4.h      |  230 +++++
>>  include/hw/pci-host/pnv_phb4_regs.h |  553 ++++++++++
>>  include/hw/pci/pcie_port.h          |    1 +
>>  include/hw/ppc/pnv.h                |    7 +
>>  include/hw/ppc/pnv_xscom.h          |   11 +
>>  10 files changed, 2943 insertions(+)
>>  create mode 100644 hw/pci-host/pnv_phb4.c
>>  create mode 100644 hw/pci-host/pnv_phb4_pec.c
>>  create mode 100644 include/hw/pci-host/pnv_phb4.h
>>  create mode 100644 include/hw/pci-host/pnv_phb4_regs.h
>>
> ...
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index e27efe9a24..354828bf13 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -135,6 +135,8 @@ config XIVE_SPAPR
>>      default y
>>      depends on PSERIES
>>      select XIVE
>> +    select PCI
>> +    select PCIE_PORT
>=20
> This patch is about PowerNV, why do we add dependencies for pseries
> configuration?

Bogus leftovers from the past. I think we can drop them.

Thanks,

C.


