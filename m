Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BACC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3272084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3272084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBdC-0000n2-Ql
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prime.zeng@hisilicon.com>) id 1irBcC-0008TU-Ds
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prime.zeng@hisilicon.com>) id 1irBcA-00010f-QK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:07:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2488 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prime.zeng@hisilicon.com>)
 id 1irBc6-0000kV-Iv; Mon, 13 Jan 2020 21:07:27 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id A1C7A4FF9EA7A95670F1;
 Tue, 14 Jan 2020 10:07:13 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0439.000;
 Tue, 14 Jan 2020 10:07:11 +0800
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
 node_id ascending order
Thread-Topic: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
 node_id ascending order
Thread-Index: AQHVxTwQeBqIZ8yXtEyanioq6c3U06feal4AgACT4nD//9VlAIABTx2wgABQygCAARsxQIAABgAAgAGgPNCABJunAIABoHhg
Date: Tue, 14 Jan 2020 02:07:11 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340E5A34@DGGEMM506-MBX.china.huawei.com>
References: <1578388729-55540-1-git-send-email-prime.zeng@hisilicon.com>
 <20200107042918-mutt-send-email-mst@kernel.org>
 <678F3D1BB717D949B966B68EAEB446ED340B608D@dggemm526-mbx.china.huawei.com>
 <20200107164958.7811777d@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED340B8B24@dggemm526-mbx.china.huawei.com>
 <20200108173832.61508f8b@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED340BD19F@dggemm526-mbx.china.huawei.com>
 <20200109105336.4932267b@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED340C1B23@dggemm526-mbx.china.huawei.com>
 <20200113100530.0bae41a3@redhat.com>
In-Reply-To: <20200113100530.0bae41a3@redhat.com>
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
> Sent: Monday, January 13, 2020 5:06 PM
> To: Zengtao (B)
> Cc: Peter Maydell; Michael S. Tsirkin; qemu-trivial@nongnu.org;
> qemu-devel@nongnu.org; Shannon Zhao; qemu-arm@nongnu.org
> Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors structure
> by node_id ascending order
>=20
> On Fri, 10 Jan 2020 02:56:35 +0000
> "Zengtao (B)" <prime.zeng@hisilicon.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: Thursday, January 09, 2020 5:54 PM
> > > To: Zengtao (B)
> > > Cc: Michael S. Tsirkin; qemu-devel@nongnu.org;
> qemu-trivial@nongnu.org;
> > > Shannon Zhao; Peter Maydell; qemu-arm@nongnu.org
> > > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors
> structure by
> > > node_id ascending order
> > >
> > > On Thu, 9 Jan 2020 02:45:58 +0000
> > > "Zengtao (B)" <prime.zeng@hisilicon.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > > Sent: Thursday, January 09, 2020 12:39 AM
> > > > > To: Zengtao (B)
> > > > > Cc: Michael S. Tsirkin; qemu-devel@nongnu.org;
> > > qemu-trivial@nongnu.org;
> > > > > Shannon Zhao; Peter Maydell; qemu-arm@nongnu.org
> > > > > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors
> structure
> > > by
> > > > > node_id ascending order
> > > > >
> > > > > On Wed, 8 Jan 2020 04:02:10 +0000
> > > > > "Zengtao (B)" <prime.zeng@hisilicon.com> wrote:
> > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > > > > Sent: Tuesday, January 07, 2020 11:50 PM
> > > > > > > To: Zengtao (B)
> > > > > > > Cc: Michael S. Tsirkin; qemu-devel@nongnu.org;
> > > > > qemu-trivial@nongnu.org;
> > > > > > > Shannon Zhao; Peter Maydell; qemu-arm@nongnu.org
> > > > > > > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors
> > > structure
> > > > > by
> > > > > > > node_id ascending order
> > > > > > >
> > > > > > > On Tue, 7 Jan 2020 10:29:22 +0000
> > > > > > > "Zengtao (B)" <prime.zeng@hisilicon.com> wrote:
> > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > > > > > > Sent: Tuesday, January 07, 2020 5:33 PM
> > > > > > > > > To: Zengtao (B)
> > > > > > > > > Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org;
> > > Shannon
> > > > > > > Zhao;
> > > > > > > > > Peter Maydell; Igor Mammedov; qemu-arm@nongnu.org
> > > > > > > > > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT
> processors
> > > > > structure
> > > > > > > by
> > > > > > > > > node_id ascending order
> > > > > > > > >
> > > > > > > > > On Tue, Jan 07, 2020 at 05:18:49PM +0800, Zeng Tao
> wrote:
> > > > > > > > > > When booting the guest linux with the following numa
> > > > > configuration:
> > > > > > > > > > -numa node,node_id=3D1,cpus=3D0-3
> > > > > > > > > > -numa node,node_id=3D0,cpus=3D4-7
> > > > > > > > > > We can get the following numa topology in the guest
> system:
> > > > > > > > > > Architecture:          aarch64
> > > > > > > > > > Byte Order:            Little Endian
> > > > > > > > > > CPU(s):                8
> > > > > > > > > > On-line CPU(s) list:   0-7
> > > > > > > > > > Thread(s) per core:    1
> > > > > > > > > > Core(s) per socket:    8
> > > > > > > > > > Socket(s):             1
> > > > > > > > > > NUMA node(s):          2
> > > > > > > > > > L1d cache:             unknown size
> > > > > > > > > > L1i cache:             unknown size
> > > > > > > > > > L2 cache:              unknown size
> > > > > > > > > > NUMA node0 CPU(s):     0-3
> > > > > > > > > > NUMA node1 CPU(s):     4-7
> > > > > > > > > > The Cpus 0-3 is assigned with NUMA node 1 in QEMU
> while it
> > > get
> > > > > > > NUMA
> > > > > > > > > node
> > > > > > > > > > 0 in the guest.
> > > > > > > > > >
> > > > > > > > > > In fact, In the linux kernel, numa_node_id is allocated
> per the
> > > > > ACPI
> > > > > > > > > > SRAT processors structure order,so the cpu 0 will be th=
e
> first
> > > one
> > > > > to
> > > > > > > > > > allocate its NUMA node id, so it gets the NUMA node 0.
> > > > > > > > > >
> > > > > > > > > > To fix this issue, we pack the SRAT processors structur=
e
> in
> > > numa
> > > > > node
> > > > > > > id
> > > > > > > > > > order but not the default cpu number order.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Does this matter? If yes fixing linux to take node id fro=
m
> > > proximity
> > > > > > > > > field in ACPI seems cleaner ...
> > > > > > > > >
> > > > > > > >
> > > > > > > > In fact, I just want to align the node_id concept in QEMU
> and
> > > Linux.
> > > > > > > > If we fix the kernel side, we need to align with all platfo=
rms.
> > > > > > > > i think maybe not a good idea.
> > > > > > > if linux makes up node ID's on it's own, it would be hard for=
 it
> to
> > > > > > > map SRAT entries to other tables that use proximity id as
> well.
> > > > > > >
> > > > > > > So it would need to maintain map of [proximity id] -> [node
> id] (and
> > > > > reverse)
> > > > > > > somewhere to resolve mappings on other tables.
> > > > > > > If it doesn't do this then it's broken and works just by
> accident,
> > > > > > > if it does the fix probably should be in that code and not in
> QEMU.
> > > > > > >
> > > > > >
> > > > > > Hmm, the problem is how to understand the concept of node
> id.
> > > > > > 1. In dts, there is node id. Both the QEMU and Linux can use it
> > > > > > directly, so no conflict.
> > > > > > 2. In ACPI, there is only proximity domain, but no node id, the=
re
> > > > > >  should be a mapping between them, while kernel and QEMU
> > > maintain
> > > > > >  their own rule, and unfortunately they conflict with each
> other
> > > > > >  sometimes.
> > > > > >
> > > > > > There is no specification to indicate what we should do to
> maintain
> > > the
> > > > > > mapping, so it's hard to align the QEMU and Linux.
> > > > > >
> > > > > > Any suggestion, or we just accept it as a rule since it don't
> affect
> > > much?
> > > > >
> > > > > If node id generation is driven by SRAT content, it might be
> reasonable
> > > to
> > > > > ask for SRAT parser in kernel to create node ids using proximity
> value
> > > > > instead of the order ACPI_SRAT_PROCESSOR_GICC structures are
> > > > > enumerated.
> > > > > That way node id would match ACPI spec.
> > > > >
> > > >
> > > > I don't quite understand "That way node id would match ACPI
> spec."
> > > > I check the ACPI 6.3 spec, I didn't find any description that node =
id
> should
> > > > be equal to proximity value, in section 6.2.15, there is indeed an
> example
> > > > which node numbers equals to proximity value.
> > >
> > > There is only proximity id in spec (which conceptually is the same as
> node
> > > id).
> > > What I'm saying is that linux kernel ACPI parser could use it as node
> id
> > > instead of using counter for making up node ids.
> > >
> > > (issue with it is that proximity values could be sparse, so one
> > > would need to audit current node id users to make sure that using
> > > proximity id won't break anything)
> > >
> > I think that is really a problem, in linux kernel:
> > #if MAX_NUMNODEs > 256
> > #define MAX_PXM_DOMAINS MAX_NUMNODEs
> > #else
> > #define MAX_PXM_DOMAINS 256
> > #endif
> > It seems that using counter is a better choice.
>=20
> In QEMU case nodeid isn't sparse. So even if kernel uses counter, it will
> work fine as far as it sorts SRAT by proximity value (same thing you are
> trying
> to do in this patch but on kernel side).
> That way it would match what HW vendors think about node numbering
> in most cases.
>=20
> (We a comparing apples to oranges, so arguing for one case vs another is
> rather pointless)
>=20
> Another question, does this patch fixes anything?
> (if it is not, it might be better to just drop this idea)
>=20

:) I am not persist on this patch, but I think you have provide me an impor=
tant
clue. "Most HW vendors number pxm and node in the same way, and so does QEM=
U",=20
so i think it's reasonable for linux kernel to do the same.

So i think we can end the discussion and just ignore this patch.
Thanks very much.

Regards
Zengtao=20

