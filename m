Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13AAC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25CA20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25CA20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLkK-00044i-PN
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1izLiq-0002KU-SS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1izLip-0003R4-CZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:32:08 -0500
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:49334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1izLip-0003Cy-6B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:32:07 -0500
Received: from player795.ha.ovh.net (unknown [10.110.208.220])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id A73968EF89
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 15:31:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 315D8EE835B8;
 Wed,  5 Feb 2020 14:31:49 +0000 (UTC)
Date: Wed, 5 Feb 2020 15:31:47 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 19/35] ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
Message-ID: <20200205153147.7d505504@bahia.lan>
In-Reply-To: <bbb36281-287b-70cf-80ab-9ac54eeca8de@redhat.com>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
 <20200203061123.59150-20-david@gibson.dropbear.id.au>
 <bbb36281-287b-70cf-80ab-9ac54eeca8de@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15122243123806181670
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrhedugdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.53.132
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Feb 2020 14:26:41 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 03/02/2020 07:11, David Gibson wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > These changes introduces models for the PCIe Host Bridge (PHB4) of the
> > POWER9 processor. It includes the PowerBus logic interface (PBCQ),
> > IOMMU support, a single PCIe Gen.4 Root Complex, and support for MSI
> > and LSI interrupt sources as found on a POWER9 system using the XIVE
> > interrupt controller.
> >=20
> > POWER9 processor comes with 3 PHB4 PEC (PCI Express Controller) and
> > each PEC can have several PHBs. By default,
> >=20
> >   * PEC0 provides 1 PHB  (PHB0)
> >   * PEC1 provides 2 PHBs (PHB1 and PHB2)
> >   * PEC2 provides 3 PHBs (PHB3, PHB4 and PHB5)
> >=20
> > Each PEC has a set  "global" registers and some "per-stack" (per-PHB)
> > registers. Those are organized in two XSCOM ranges, the "Nest" range
> > and the "PCI" range, each range contains both some "PEC" registers and
> > some "per-stack" registers.
> >=20
> > No default device layout is provided and PCI devices can be added on
> > any of the available PCIe Root Port (pcie.0 .. 2 of a Power9 chip)
> > with address 0x0 as the firwware (skiboot) only accepts a single
> > device per root port. To run a simple system with a network and a
> > storage adapters, use a command line options such as :
> >=20
> >   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,add=
r=3D0x0
> >   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=
=3Dvirbr0,id=3Dhostnet0
> >=20
> >   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
> >   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,c=
ache=3Dnone
> >   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
> >=20
> > If more are needed, include a bridge.
> >=20
> > Multi chip is supported, each chip adding its set of PHB4 controllers
> > and its PCI busses. The model doesn't emulate the EEH error handling.
> >=20
> > This model is not ready for hotplug yet.
> >=20
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > [ clg: - numerous cleanups
> >        - commit log
> >        - fix for broken LSI support
> >        - PHB pic printinfo
> >        - large QOM rework ]
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Message-Id: <20200127144506.11132-2-clg@kaod.org>
> > [dwg: Use device_class_set_props()]
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci-host/Makefile.objs           |    1 +
> >  hw/pci-host/pnv_phb4.c              | 1438 +++++++++++++++++++++++++++
> >  hw/pci-host/pnv_phb4_pec.c          |  593 +++++++++++
> >  hw/ppc/Kconfig                      |    2 +
> >  hw/ppc/pnv.c                        |  107 ++
> >  include/hw/pci-host/pnv_phb4.h      |  230 +++++
> >  include/hw/pci-host/pnv_phb4_regs.h |  553 ++++++++++
> >  include/hw/pci/pcie_port.h          |    1 +
> >  include/hw/ppc/pnv.h                |    7 +
> >  include/hw/ppc/pnv_xscom.h          |   11 +
> >  10 files changed, 2943 insertions(+)
> >  create mode 100644 hw/pci-host/pnv_phb4.c
> >  create mode 100644 hw/pci-host/pnv_phb4_pec.c
> >  create mode 100644 include/hw/pci-host/pnv_phb4.h
> >  create mode 100644 include/hw/pci-host/pnv_phb4_regs.h
> >=20
> ...
> > diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> > index e27efe9a24..354828bf13 100644
> > --- a/hw/ppc/Kconfig
> > +++ b/hw/ppc/Kconfig
> > @@ -135,6 +135,8 @@ config XIVE_SPAPR
> >      default y
> >      depends on PSERIES
> >      select XIVE
> > +    select PCI
> > +    select PCIE_PORT
>=20
> This patch is about PowerNV, why do we add dependencies for pseries
> configuration?
>=20

This looks like an error. These should rather be added to config POWERNV
I guess.

> Thanks,
> Laurent
>=20


