Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBB2C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B4F20705
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B4F20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNqz-00025b-PA
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prime.zeng@hisilicon.com>) id 1ipNq3-0001Of-Ha
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prime.zeng@hisilicon.com>) id 1ipNpz-0007dh-TQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:46:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2486 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prime.zeng@hisilicon.com>)
 id 1ipNpq-000795-8U; Wed, 08 Jan 2020 21:46:11 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 070A3DA1FA3698751B62;
 Thu,  9 Jan 2020 10:46:00 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 10:45:58 +0800
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
 node_id ascending order
Thread-Topic: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
 node_id ascending order
Thread-Index: AQHVxTwQeBqIZ8yXtEyanioq6c3U06feal4AgACT4nD//9VlAIABTx2wgABQygCAARsxQA==
Date: Thu, 9 Jan 2020 02:45:58 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340BD19F@dggemm526-mbx.china.huawei.com>
References: <1578388729-55540-1-git-send-email-prime.zeng@hisilicon.com>
 <20200107042918-mutt-send-email-mst@kernel.org>
 <678F3D1BB717D949B966B68EAEB446ED340B608D@dggemm526-mbx.china.huawei.com>
 <20200107164958.7811777d@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED340B8B24@dggemm526-mbx.china.huawei.com>
 <20200108173832.61508f8b@redhat.com>
In-Reply-To: <20200108173832.61508f8b@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.188
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Thursday, January 09, 2020 12:39 AM
> To: Zengtao (B)
> Cc: Michael S. Tsirkin; qemu-devel@nongnu.org; qemu-trivial@nongnu.org;
> Shannon Zhao; Peter Maydell; qemu-arm@nongnu.org
> Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
> node_id ascending order
>=20
> On Wed, 8 Jan 2020 04:02:10 +0000
> "Zengtao (B)" <prime.zeng@hisilicon.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: Tuesday, January 07, 2020 11:50 PM
> > > To: Zengtao (B)
> > > Cc: Michael S. Tsirkin; qemu-devel@nongnu.org;
> qemu-trivial@nongnu.org;
> > > Shannon Zhao; Peter Maydell; qemu-arm@nongnu.org
> > > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors structure
> by
> > > node_id ascending order
> > >
> > > On Tue, 7 Jan 2020 10:29:22 +0000
> > > "Zengtao (B)" <prime.zeng@hisilicon.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > > Sent: Tuesday, January 07, 2020 5:33 PM
> > > > > To: Zengtao (B)
> > > > > Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org; Shannon
> > > Zhao;
> > > > > Peter Maydell; Igor Mammedov; qemu-arm@nongnu.org
> > > > > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors
> structure
> > > by
> > > > > node_id ascending order
> > > > >
> > > > > On Tue, Jan 07, 2020 at 05:18:49PM +0800, Zeng Tao wrote:
> > > > > > When booting the guest linux with the following numa
> configuration:
> > > > > > -numa node,node_id=3D1,cpus=3D0-3
> > > > > > -numa node,node_id=3D0,cpus=3D4-7
> > > > > > We can get the following numa topology in the guest system:
> > > > > > Architecture:          aarch64
> > > > > > Byte Order:            Little Endian
> > > > > > CPU(s):                8
> > > > > > On-line CPU(s) list:   0-7
> > > > > > Thread(s) per core:    1
> > > > > > Core(s) per socket:    8
> > > > > > Socket(s):             1
> > > > > > NUMA node(s):          2
> > > > > > L1d cache:             unknown size
> > > > > > L1i cache:             unknown size
> > > > > > L2 cache:              unknown size
> > > > > > NUMA node0 CPU(s):     0-3
> > > > > > NUMA node1 CPU(s):     4-7
> > > > > > The Cpus 0-3 is assigned with NUMA node 1 in QEMU while it get
> > > NUMA
> > > > > node
> > > > > > 0 in the guest.
> > > > > >
> > > > > > In fact, In the linux kernel, numa_node_id is allocated per the
> ACPI
> > > > > > SRAT processors structure order,so the cpu 0 will be the first =
one
> to
> > > > > > allocate its NUMA node id, so it gets the NUMA node 0.
> > > > > >
> > > > > > To fix this issue, we pack the SRAT processors structure in num=
a
> node
> > > id
> > > > > > order but not the default cpu number order.
> > > > > >
> > > > > > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > > > >
> > > > >
> > > > > Does this matter? If yes fixing linux to take node id from proxim=
ity
> > > > > field in ACPI seems cleaner ...
> > > > >
> > > >
> > > > In fact, I just want to align the node_id concept in QEMU and Linux=
.
> > > > If we fix the kernel side, we need to align with all platforms.
> > > > i think maybe not a good idea.
> > > if linux makes up node ID's on it's own, it would be hard for it to
> > > map SRAT entries to other tables that use proximity id as well.
> > >
> > > So it would need to maintain map of [proximity id] -> [node id] (and
> reverse)
> > > somewhere to resolve mappings on other tables.
> > > If it doesn't do this then it's broken and works just by accident,
> > > if it does the fix probably should be in that code and not in QEMU.
> > >
> >
> > Hmm, the problem is how to understand the concept of node id.
> > 1. In dts, there is node id. Both the QEMU and Linux can use it
> > directly, so no conflict.
> > 2. In ACPI, there is only proximity domain, but no node id, there
> >  should be a mapping between them, while kernel and QEMU maintain
> >  their own rule, and unfortunately they conflict with each other
> >  sometimes.
> >
> > There is no specification to indicate what we should do to maintain the
> > mapping, so it's hard to align the QEMU and Linux.
> >
> > Any suggestion, or we just accept it as a rule since it don't affect mu=
ch?
>=20
> If node id generation is driven by SRAT content, it might be reasonable t=
o
> ask for SRAT parser in kernel to create node ids using proximity value
> instead of the order ACPI_SRAT_PROCESSOR_GICC structures are
> enumerated.
> That way node id would match ACPI spec.
>=20

I don't quite understand "That way node id would match ACPI spec."
I check the ACPI 6.3 spec, I didn't find any description that node id shoul=
d
be equal to proximity value, in section 6.2.15, there is indeed an example
which node numbers equals to proximity value.=20

Thanks

> But even with that I'd wouldn't expect cpu ids match as its basically
> arbitrary numbers on both sided. One would need to use arch specific ids
> to reliably match cpus on both sides (MPIDR in ARM case or APICID in x86)=
.
>.=20
> > > >
> > > > > > ---
> > > > > >  hw/arm/virt-acpi-build.c | 23 +++++++++++++++--------
> > > > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.=
c
> > > > > > index bd5f771..497192b 100644
> > > > > > --- a/hw/arm/virt-acpi-build.c
> > > > > > +++ b/hw/arm/virt-acpi-build.c
> > > > > > @@ -520,7 +520,8 @@ build_srat(GArray *table_data,
> BIOSLinker
> > > > > *linker, VirtMachineState *vms)
> > > > > >      AcpiSystemResourceAffinityTable *srat;
> > > > > >      AcpiSratProcessorGiccAffinity *core;
> > > > > >      AcpiSratMemoryAffinity *numamem;
> > > > > > -    int i, srat_start;
> > > > > > +    int i, j, srat_start;
> > > > > > +    uint32_t node_id;
> > > > > >      uint64_t mem_base;
> > > > > >      MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> > > > > >      MachineState *ms =3D MACHINE(vms);
> > > > > > @@ -530,13 +531,19 @@ build_srat(GArray *table_data,
> BIOSLinker
> > > > > *linker, VirtMachineState *vms)
> > > > > >      srat =3D acpi_data_push(table_data, sizeof(*srat));
> > > > > >      srat->reserved1 =3D cpu_to_le32(1);
> > > > > >
> > > > > > -    for (i =3D 0; i < cpu_list->len; ++i) {
> > > > > > -        core =3D acpi_data_push(table_data, sizeof(*core));
> > > > > > -        core->type =3D ACPI_SRAT_PROCESSOR_GICC;
> > > > > > -        core->length =3D sizeof(*core);
> > > > > > -        core->proximity =3D
> > > > > cpu_to_le32(cpu_list->cpus[i].props.node_id);
> > > > > > -        core->acpi_processor_uid =3D cpu_to_le32(i);
> > > > > > -        core->flags =3D cpu_to_le32(1);
> > > > > > +    for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
> > > > > > +        for (j =3D 0; j < cpu_list->len; ++j) {
> > > > >
> > > > > Hmm O(n ^2) isn't great ...
> > > > Good suggestion, 3Q.
> > > > >
> > > > > > +            node_id =3D
> > > cpu_to_le32(cpu_list->cpus[j].props.node_id);
> > > > > > +            if (node_id !=3D i) {
> > > > > > +                continue;
> > > > > > +            }
> > > > > > +            core =3D acpi_data_push(table_data, sizeof(*core))=
;
> > > > > > +            core->type =3D ACPI_SRAT_PROCESSOR_GICC;
> > > > > > +            core->length =3D sizeof(*core);
> > > > > > +            core->proximity =3D node_id;
> > > > > > +            core->acpi_processor_uid =3D cpu_to_le32(j);
> > > > > > +            core->flags =3D cpu_to_le32(1);
> > > > > > +        }
> > > > > >      }
> > > > >
> > > > > is the issue arm specific? wouldn't it affect x86 too?
> > > > >
> > > > Good question, I think it will affect x86, but I need to confirm.
> > > >
> > > > > >      mem_base =3D vms->memmap[VIRT_MEM].base;
> > > > > > --
> > > > > > 2.8.1
> > > >
> >


