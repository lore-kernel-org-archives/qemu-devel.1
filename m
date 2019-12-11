Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043CDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC14B214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC14B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3R0-0004rM-17
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prime.zeng@hisilicon.com>) id 1if3QI-0004Jp-OJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prime.zeng@hisilicon.com>) id 1if3QH-0008Vv-AH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:57:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2425 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prime.zeng@hisilicon.com>)
 id 1if3QD-0008H3-Vj; Wed, 11 Dec 2019 09:57:02 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 43DB7CF27CCA2C6CCBDD;
 Wed, 11 Dec 2019 19:10:54 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Dec 2019 19:10:53 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.101]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Wed, 11 Dec 2019 19:10:45 +0800
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: Andrew Jones <drjones@redhat.com>
Subject: RE: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu
 topology support
Thread-Topic: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu
 topology support
Thread-Index: AdQTlaRpUFkm+EncK0mrDnlTRz6dtGan2sPQADKVqIAARGvRgA==
Date: Wed, 11 Dec 2019 11:10:45 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED34066A4F@dggemm526-mbx.china.huawei.com>
References: <20180704124923.32483-1-drjones@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED3405A26F@dggemm526-mbx.china.huawei.com>
 <20191210101323.q7dn2f3pkx3ya5s4@kamzik.brq.redhat.com>
In-Reply-To: <20191210101323.q7dn2f3pkx3ya5s4@kamzik.brq.redhat.com>
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
X-Received-From: 45.249.212.187
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
Cc: "wei@redhat.com" <wei@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 huangdaode <huangdaode@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew:

Thanks for your reply.
It 's fine for me if you are still tracking the thread. And I can help to t=
est
 if needed ^_^.

> -----Original Message-----
> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, December 10, 2019 6:13 PM
> To: Zengtao (B)
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; wei@redhat.com;
> peter.maydell@linaro.org; eric.auger@redhat.com;
> imammedo@redhat.com; xuwei (O); huangdaode
> Subject: Re: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu
> topology support
>=20
> On Mon, Dec 09, 2019 at 02:14:09AM +0000, Zengtao (B) wrote:
> > Hi Andrew:
> >
> > Any update for this patch series? I have met the same issue, and if the
> > topology guessed by linux MPIDR conflicts with qemu specified numa, it
> > will failed to boot (sched domain initialization will fall into deadloo=
p).
>=20
> Hi Zeng,
>=20
> This has been on my TODO list a long time, but it keeps getting preempted=
.
> We need to start by giving userspace control over the MPIDRs, including
> when KVM is in use. The earliest I can return to this will be mid/late
> January. If you'd like to jump in on it now, then feel free.
>=20
> Thanks,
> drew
>=20
> >
> > Thanks.
> >
> > > -----Original Message-----
> > > From: Qemu-devel
> > >
> [mailto:qemu-devel-bounces+incoming=3Dpatchwork.ozlabs.org@nongnu.or
> > > g] On Behalf Of Andrew Jones
> > > Sent: Thursday, July 05, 2018 4:49 AM
> > > To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> > > Cc: wei@redhat.com; peter.maydell@linaro.org;
> eric.auger@redhat.com;
> > > imammedo@redhat.com
> > > Subject: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu
> > > topology support
> > >
> > > This series provides support for booting mach-virt machines with
> > > non-flat cpu topology, i.e. enabling the extended options of the
> > > '-smp' command line parameter (sockets,cores,threads). Both DT and
> > > ACPI description generators are added. We only apply the new feature
> > > to 3.1 and later machine types, as the change is guest visible, even
> > > when no command line change is made. This is because the basic
> > > '-smp <N>' parameter makes the assumption that <N> refers to the
> > > number of sockets, but when no topology description is provided,
> > > Linux will use the MPIDR to guess. Neither the MPIDR exposed to
> > > the guest when running with KVM nor TCG currently provides socket
> > > information, leaving Linux to assume all processing elements are
> > > cores in the same socket. For example, before this series '-smp 4'
> > > would show up in the guest as
> > >
> > >  CPU(s):                4
> > >  On-line CPU(s) list:   0-3
> > >  Thread(s) per core:    1
> > >  Core(s) per socket:    4
> > >  Socket(s):             1
> > >
> > > and after it shows up as
> > >
> > >  CPU(s):                4
> > >  On-line CPU(s) list:   0-3
> > >  Thread(s) per core:    1
> > >  Core(s) per socket:    1
> > >  Socket(s):             4
> > >
> > > It's not expected that this should be a problem, but it's worth
> > > considering. The only way to avoid the silent change is for QEMU to
> > > provide boards a way to override the default '-smp' parsing function.
> > > Otherwise, if a user wants to avoid a guest visible change, but still
> > > use a 3.1 or later mach-virt machine type, then they must ensure the
> > > command line specifies a single socket, e.g. '-smp sockets=3D1,cores=
=3D4'
> > >
> > > Thanks,
> > > drew
> > >
> > >
> > > Andrew Jones (6):
> > >   hw/arm/virt: Add virt-3.1 machine type
> > >   device_tree: add qemu_fdt_add_path
> > >   hw/arm/virt: DT: add cpu-map
> > >   hw/arm/virt-acpi-build: distinguish possible and present cpus
> > >   virt-acpi-build: add PPTT table
> > >   hw/arm/virt: cpu topology: don't allow threads
> > >
> > >  device_tree.c                | 24 +++++++++++++
> > >  hw/acpi/aml-build.c          | 50 ++++++++++++++++++++++++++
> > >  hw/arm/virt-acpi-build.c     | 25 ++++++++++---
> > >  hw/arm/virt.c                | 69
> > > +++++++++++++++++++++++++++++++++---
> > >  include/hw/acpi/aml-build.h  |  2 ++
> > >  include/hw/arm/virt.h        |  1 +
> > >  include/sysemu/device_tree.h |  1 +
> > >  7 files changed, 162 insertions(+), 10 deletions(-)


