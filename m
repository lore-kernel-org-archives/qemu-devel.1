Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6051A20674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgRqi-0003Wa-MB
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 07:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgRpp-0002x7-Oo; Wed, 03 Jun 2020 07:45:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2103 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgRpn-0002Wk-6u; Wed, 03 Jun 2020 07:45:29 -0400
Received: from lhreml703-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id A641A849E07C51F2A10C;
 Wed,  3 Jun 2020 12:45:22 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 12:45:22 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Wed, 3 Jun 2020 12:45:22 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Andrew Jones <drjones@redhat.com>
Subject: RE: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Topic: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Index: AdY3+/mIYt1+TQdDQmymnxAa7PkUWwBhkdKAAAS79tA=
Date: Wed, 3 Jun 2020 11:45:22 +0000
Message-ID: <6bacdd359e504ed8924e67ed125bf15d@huawei.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
In-Reply-To: <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.30.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 07:45:22
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Igor
 Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,
Many thanks for the reply.

> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Wednesday, June 3, 2020 10:38 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Peter Maydell
> <peter.maydell@linaro.org>; Igor Mammedov <imammedo@redhat.com>;
> mst@redhat.com
> Subject: Re: [Question] Regarding PMU initialization within the QEMU for =
ARM
> VCPUs
>=20
> On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:
> > Hello,
> > I could see below within function fdt_add_pmu_nodes() part of
> > hw/arm/virt.c during virt machine initialization time:
> >
> > Observation:
> > In below function, support of PMU feature is being checked for
> > each vcpu and if the PMU is found part of the features then PMU
> > is initialized with in the host/KVM. But if there is even one
> > vcpu which is found to not support the PMU then loop is exited
> > and PMU is not initialized for the rest of the vcpus as well.
> >
> > Questions:
> > Q1. Not sure what is the logic of the premature exit and not
> >     continuing with further checks and initialization of other
> >     VCPU PMUs?
>=20
> KVM requires all VCPUs to have a PMU if one does. If the ARM ARM
> says it's possible to have PMUs for only some CPUs, then, for TCG,
> the restriction could be relaxed. I expect it will take more than
> just removing the check for things to work though.

Got it. Many thanks for this info.

During virt machine init we take cpu type from (-cpu <cpu-type>)
option and it should apply evenly to all of the vcpus. Therefore,
I can assume all of the processors to be identical for now. This
combined with the KVM restriction you mentioned above means for
PMU we could only have Enable-for-All OR Enable-for-none config
for all of the vcpus being booted even though we at different
places do have per-vcpu specific check like below available

/* MADT */
static void
build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
{
[...]

    for (i =3D 0; i < vms->smp_cpus; i++) {
        AcpiMadtGenericCpuInterface *gicc =3D acpi_data_push(table_data,
                                                           sizeof(*gicc));
        [...]

        if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {---> This check
            gicc->performance_interrupt =3D cpu_to_le32(PPI(VIRTUAL_PMU_IRQ=
));
        }
 [...]
}

Do per-vcpu feature check for PMU even makes sense till we allow
heterogeneous support of processors or relax the PMU enablement
on the per-vcpu basis within the KVM?



>=20
> > Q2. Does it even makes sense to have PMUs initialized for some
> >     vcpus and not for others unless we have heterogeneous system?
>=20
> I don't know, but it doesn't sound like a configuration I'd like
> to see.


sure. but in the existing code we do prematurely exit after we
discover first vcpu amongst the possible vcpus not supporting
PMU feature. This looks abnormal as well?


>=20
> > Q3. Also, there is a per virt machine knob of vcc->no_pmu.
> >     This is something which user could specify at the init time
> >     and perhaps only once but we don't use it for ARM. Perhaps
> >     should have been used even before entering this function
> >     to enable or disable the support as per user config?
>=20
> It's purpose is to keep users from doing 'pmu=3Don' on 2.6 machine
> types. On 2.7 and later machine types if you don't want a PMU
> you should use 'pmu=3Doff'.

sure. so by default on latest machines PMU is on.=20

>=20
> > Q4. This function  fdt_* looks to be wrongly named. The info
> >     being initialized here shall be used even when ACPI is
> >     being used. Initialization part and FDT info looked
> >     mixed up here if I am right?
>=20
> Agreed. The function has the wrong name. mach-virt has many functions tha=
t
> mix the initialization and fdt building together, but those functions are
> named something like create_foo(). Patches welcome.


Will do. I have created one already. Will float soon.


>=20
> Thanks,
> drew


