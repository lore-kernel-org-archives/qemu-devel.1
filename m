Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9CFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BF3206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BF3206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOvE-0007YI-0N
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgOuf-0006yo-Tu; Wed, 03 Jun 2020 04:38:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2102 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgOue-0005o3-K8; Wed, 03 Jun 2020 04:38:17 -0400
Received: from lhreml706-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 82256929B881A35E64F9;
 Wed,  3 Jun 2020 09:38:07 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 09:38:07 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Wed, 3 Jun 2020 09:38:06 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: RE: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Topic: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Index: AdY3+/mIYt1+TQdDQmymnxAa7PkUWwBhLxBA
Date: Wed, 3 Jun 2020 08:38:06 +0000
Message-ID: <97cd83a6eee449779c193ac9fd3bbea3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.64.231]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:38:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Gavin Shan <gshan@redhat.com>,
 "drjones@redhat.com" <drjones@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
Any comments on this would be really helpful & much appreciated.


Thanks in anticipation!

Best regards
Salil
> -----Original Message-----
> From: Salil Mehta
> Sent: Monday, June 1, 2020 4:00 PM
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>; mst@redhat.com; Igor Mammed=
ov
> <imammedo@redhat.com>
> Subject: [Question] Regarding PMU initialization within the QEMU for ARM =
VCPUs
>=20
> Hello,
> I could see below within function fdt_add_pmu_nodes() part of
> hw/arm/virt.c during virt machine initialization time:
>=20
> Observation:
> In below function, support of PMU feature is being checked for
> each vcpu and if the PMU is found part of the features then PMU
> is initialized with in the host/KVM. But if there is even one
> vcpu which is found to not support the PMU then loop is exited
> and PMU is not initialized for the rest of the vcpus as well.
>=20
> static void fdt_add_pmu_nodes(const VirtMachineState *vms)
> {
>     CPUState *cpu;
>     ARMCPU *armcpu;
>     uint32_t irqflags =3D GIC_FDT_IRQ_FLAGS_LEVEL_HI;
>=20
>     CPU_FOREACH(cpu) {
>         armcpu =3D ARM_CPU(cpu);
>         if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>             return; ------> Here, loop exits & function returns
>         }
>         if (kvm_enabled()) {
>             if (kvm_irqchip_in_kernel()) {
>                 kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
>             }
>             kvm_arm_pmu_init(cpu);
>         }
>     }
>=20
>     if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>         irqflags =3D deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
>                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
>                              (1 << vms->smp_cpus) - 1);
>     }
>=20
>     armcpu =3D ARM_CPU(qemu_get_cpu(0));
>     qemu_fdt_add_subnode(vms->fdt, "/pmu");
>     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
>         const char compat[] =3D "arm,armv8-pmuv3";
>         qemu_fdt_setprop(vms->fdt, "/pmu", "compatible",
>                          compat, sizeof(compat));
>         qemu_fdt_setprop_cells(vms->fdt, "/pmu", "interrupts",
>                                GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_PMU_IRQ, irq=
flags);
>     }
> }
>=20
> Questions:
> Q1. Not sure what is the logic of the premature exit and not
>     continuing with further checks and initialization of other
>     VCPU PMUs?
> Q2. Does it even makes sense to have PMUs initialized for some
>     vcpus and not for others unless we have heterogeneous system?
> Q3. Also, there is a per virt machine knob of vcc->no_pmu.
>     This is something which user could specify at the init time
>     and perhaps only once but we don't use it for ARM. Perhaps
>     should have been used even before entering this function
>     to enable or disable the support as per user config?
> Q4. This function  fdt_* looks to be wrongly named. The info
>     being initialized here shall be used even when ACPI is
>     being used. Initialization part and FDT info looked
>     mixed up here if I am right?
>=20
>=20
> Best regards
> Salil
>=20


