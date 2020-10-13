Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD286C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71B52222A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71B52222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJC0-0004Hf-JS
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prime.zeng@hisilicon.com>)
 id 1kSJ9g-0003Ka-39; Tue, 13 Oct 2020 08:11:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:40882 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prime.zeng@hisilicon.com>)
 id 1kSJ9a-00080v-5I; Tue, 13 Oct 2020 08:11:47 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 37E67F9DAA1F706534B7;
 Tue, 13 Oct 2020 20:11:26 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.75]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Tue, 13 Oct 2020 20:11:20 +0800
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: fangying <fangying1@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache topology
 support
Thread-Topic: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache
 topology support
Thread-Index: AQHWjKJl5HIXIntHik2XLwAv/zxi0qmVk/YA
Date: Tue, 13 Oct 2020 12:11:20 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED49E0BB94@dggemm526-mbx.china.huawei.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
In-Reply-To: <20200917032033.2020-1-fangying1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=prime.zeng@hisilicon.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 08:11:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "drjones@redhat.com" <drjones@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 fangying <fangying1@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "valentin.schneider@arm.com" <valentin.schneider@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc valentin

> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+prime.zeng=3Dhisilicon.com@nongnu.org]
> On Behalf Of Ying Fang
> Sent: Thursday, September 17, 2020 11:20 AM
> To: qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; drjones@redhat.com; Zhanghailiang;
> Chenzhendong (alex); shannon.zhaosl@gmail.com;
> qemu-arm@nongnu.org; alistair.francis@wdc.com; fangying;
> imammedo@redhat.com
> Subject: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache
> topology support
>=20
> An accurate cpu topology may help improve the cpu scheduler's
> decision
> making when dealing with multi-core system. So cpu topology
> description
> is helpful to provide guest with the right view. Cpu cache information
> may
> also have slight impact on the sched domain, and even userspace
> software
> may check the cpu cache information to do some optimizations. Thus
> this patch
> series is posted to provide cpu and cache topology support for arm.
>=20
> To make the cpu topology consistent with MPIDR, an vcpu ioctl

For aarch64, the cpu topology don't depends on the MPDIR.
See https://patchwork.kernel.org/patch/11744387/=20

> KVM_ARM_SET_MP_AFFINITY is introduced so that userspace can set
> MPIDR
> according to the topology specified [1]. To describe the cpu topology
> both fdt and ACPI are supported. To describe the cpu cache
> information,
> a default cache hierarchy is given and can be made configurable later.
> The cpu topology is built according to processor hierarchy node
> structure.
> The cpu cache information is built according to cache type structure.
>=20
> This patch series is partially based on the patches posted by Andrew
> Jone
> years ago [2], I jumped in on it since some OS vendor cooperative
> partners
> are eager for it. Thanks for Andrew's contribution. Please feel free to
> reply
> to me if there is anything improper.
>=20
> [1] https://patchwork.kernel.org/cover/11781317
> [2]
> https://patchwork.ozlabs.org/project/qemu-devel/cover/2018070412
> 4923.32483-1-drjones@redhat.com
>=20
> Andrew Jones (2):
>   device_tree: add qemu_fdt_add_path
>   hw/arm/virt: DT: add cpu-map
>=20
> Ying Fang (10):
>   linux headers: Update linux header with
> KVM_ARM_SET_MP_AFFINITY
>   target/arm/kvm64: make MPIDR consistent with CPU Topology
>   target/arm/kvm32: make MPIDR consistent with CPU Topology
>   hw/arm/virt-acpi-build: distinguish possible and present cpus
>   hw/acpi/aml-build: add processor hierarchy node structure
>   hw/arm/virt-acpi-build: add PPTT table
>   target/arm/cpu: Add CPU cache description for arm
>   hw/arm/virt: add fdt cache information
>   hw/acpi/aml-build: build ACPI CPU cache topology information
>   hw/arm/virt-acpi-build: Enable CPU cache topology
>=20
>  device_tree.c                |  24 +++++++
>  hw/acpi/aml-build.c          |  68 +++++++++++++++++++
>  hw/arm/virt-acpi-build.c     |  99
> +++++++++++++++++++++++++--
>  hw/arm/virt.c                | 128
> ++++++++++++++++++++++++++++++++++-
>  include/hw/acpi/acpi-defs.h  |  14 ++++
>  include/hw/acpi/aml-build.h  |  11 +++
>  include/hw/arm/virt.h        |   1 +
>  include/sysemu/device_tree.h |   1 +
>  linux-headers/linux/kvm.h    |   3 +
>  target/arm/cpu.c             |  42 ++++++++++++
>  target/arm/cpu.h             |  27 ++++++++
>  target/arm/kvm32.c           |  46 ++++++++++---
>  target/arm/kvm64.c           |  46 ++++++++++---
>  13 files changed, 488 insertions(+), 22 deletions(-)
>=20
> --
> 2.23.0
>=20


