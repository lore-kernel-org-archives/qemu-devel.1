Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC6C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B79420B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B79420B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huxWB-0005oB-JD
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 07:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1huxVn-0005JT-ED
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1huxVl-0007YT-Lf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:20:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54192 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1huxVh-0007T2-C0; Tue, 06 Aug 2019 07:20:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A08A8FDEB713B425BF00;
 Tue,  6 Aug 2019 19:19:55 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 19:19:46 +0800
Date: Tue, 6 Aug 2019 12:19:37 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <20190806121937.00000c4a@huawei.com>
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] qemu: CCIX pcie config space
 emulation
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 linuxarm@huawei.com, jcm@redhat.com, Auger Eric <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For reference alongside this patch set.

Evaluation version of the CCIX 1.0a base specification now available,
(though there is a form to complete and license agreement)..

https://www.ccixconsortium.com/ccix-library/download-form/

Thanks,

Jonathan

On Tue, 25 Jun 2019 19:27:45 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> CCIX topologies are 'layered' on top of PCIe tree topologies.
> This is done primarily by allowing a single CCIX device to appear as
> multiple disjoint nodes in the PCIe tree.
>=20
> This layering is described via extensive PCIe DVSEC extended
> capabilities in PCIe config space across all the functions that
> are present in the device (some placement rules apply).
>=20
> The extremely flexible nature of allowed topologies makes the
> development of generic firmware and OS software difficult if we rely
> on actual hardware setups, due to the large test set that is necessary.
>=20
> To enable the ongoing work on EDK2 and within the Linux kernel and
> userspace, this series provides the bare bones of what is necessary
> to be able to test 'configuration' of a CCIX topology.  Note
> that no actual CCIX data flow is being emulated within this patchset,
> merely a substantial subset of the interface that allows the topologies
> to be configured.  Testing has to rely on verification based on
> the result rather than true emulation of the coherency protocol.
> (that is a very different form of emulation for which other tools
> are perhaps better suited).
>=20
> For information on how to do the coherency protocol configuration,
> see the forthcoming CCIX SW guide, in conjunction with the CCIX 1.0
> Base Specification.
>=20
> An example of a 2x2 mesh with a spur to the host can be run with:
>=20
> qemu-system-aarch64 -M virt -m 1024 -cpu cortex-a53 \
> ...
>  -device ioh3420,id=3Droot_port1 \
>  -device ccix-upstream-port,num_links=3D4,primaryport=3Dtrue,rsam_entries=
=3D4,ccix_device=3D"ccix_dev1",bus=3Droot_port1,addr=3D0.0,multifunction=3D=
"on",id=3Dup0,port_id=3D0 \
>  -device ccix-downstream-port,ccix_device=3D"ccix_dev1",bus=3Dup0,slot=3D=
0,chassis=3D2,id=3Dbus_top,port_id=3D1 \
>  -device ccix-downstream-port,ccix_device=3D"ccix_dev1",bus=3Dup0,slot=3D=
1,chassis=3D2,id=3Dbus_left,port_id=3D2 \
>  -device ccix-ep,primaryport=3Dfalse,home_agents=3D1,request_agents=3D1,c=
cix_device=3D"ccix_dev1",bus=3Droot_port1,addr=3D0.1,multifunction=3D"on" \
>  -device ccix-upstream-port,num_links=3D4,primaryport=3Dtrue,rsam_entries=
=3D4,ccix_device=3D"ccix_dev2",bus=3Dbus_top,addr=3D0.0,multifunction=3D"on=
",id=3Dup1,port_id=3D0 \
>  -device ccix-downstream-port,ccix_device=3D"ccix_dev2",bus=3Dup1,slot=3D=
0,chassis=3D3,id=3Dbus_right,port_id=3D1 \
>  -device ccix-ep,primaryport=3Dfalse,request_agents=3D2,ccix_device=3D"cc=
ix_dev2",bus=3Dbus_top,addr=3D0.1,multifunction=3D"on" \
>  -device ccix-upstream-port,num_links=3D4,primaryport=3Dtrue,rsam_entries=
=3D4,ccix_device=3D"ccix_dev3",bus=3Dbus_left,addr=3D0.0,multifunction=3D"o=
n",id=3Dup2,port_id=3D0 \
>  -device ccix-downstream-port,ccix_device=3D"ccix_dev3",bus=3Dup2,slot=3D=
0,chassis=3D4,id=3Dbus_bottom,port_id=3D1,multifunciton=3D"on" \
>  -device ccix-ep,primaryport=3Dfalse,request_agents=3D2,ccix_device=3D"cc=
ix_dev3",bus=3Dbus_left,addr=3D0.1,multifunction=3D"on" \
>  -device ccix-ep,primaryport=3Dtrue,request_agents=3D2,ccix_device=3D"cci=
x_dev4",bus=3Dbus_right,addr=3D0.0,port_id=3D0 \
>  -device ccix-ep,primaryport=3Dtrue,request_agents=3D2,ccix_device=3D"cci=
x_dev4",bus=3Dbus_bottom,addr=3D0.0,port_id=3D1
>=20
>=20
> I'm not going to try drawing all the detail (it's bad enough
> trying to draw these in inkscape, but in a very much simplifed
> fashion, this generates.
>=20
> -----------------
> |     Host      |
> |               |=20
> --- root_port1--
>         |
>         |
>         v
> -----------------          ---------------
> |  ccix_dev1    | -------> |  ccix_dev2  |
> -----------------          ---------------
>         |                         |
>         V                         V
> -----------------          ---------------
> |  ccix_dev3    | -------> |  ccix_dev4  |
> -----------------          ---------------
>=20
> $lspci -t
> -[0000:00]-+-00.0
>            +-01.0-[01-08]--+-00.0-[02-08]--+-00.0-[03-05]--+-00.0-[04-05]=
----00.0-[05]----00.0
>                            |               |               |             =
  \-00.1
>                            |               |               \-01.0-[06-08]=
--+-00.0-[07-08]----00.0-[08]----00.0
>                            |               |                             =
  \-00.1
>                            |               \-00.1
> 						      =20
> RFC questions:
>=20
> 1.  The nature of CCIX devices is that we need to extend normal
>     PCI devices, slots, and ports.  I could not find an elegant way of
>     doing this without lots of code replication.  The current solution
>     just exposes some internal functions from xio3130 port implementation=
s.
>     Is there a better way to do this?
>=20
> 2.  The association of the different PCIDevices to a given CCIX device is
>     currently somewhat of a hack. Can anyone suggest a cleaner solution
>     for this?  I can improved the current implementation, but don't really
>     like that we basically search for all the parts whenever a cross
>     device implementation is needed.
>=20
> 3.  Is emulation via a large number of PCIe devices like this a good
>     approach or is there a nicer way to handle it?  Given we need to
>     be able to 'spread' the CCIX device configuration across multiple
>     PCIe functions anyway perhaps this is the most sensible approach.
>=20
> 4.  I've cut and paste a 100+ lines of code from each of the xio3130_*
>     modules as we are also implemening PCIE up and downstream ports
>     and as this is a emulation only device, we might as well use the
>     same register set.  There are various possible ways to avoid this:
>     * Add a library with the shared code in it.
>     * Add an xio3130_upstream.h header and similar to allow the CCIX
>       port modules to call those functions directly.
>     * Don't worry about the replication in the interests of keeping
>       the code structure simple.
>=20
> 5.  I'm not that familiar with qemu 'style' yet, so pointers on structures
>     to use etc most welcome.
>=20
> Note that not all elements of CCIX are supported by the current implement=
ation,
> for example slave agents and error records are missing.  These will follow
> either in later revisions or as follow patches.  We also have no actual
> accelerator functions in the current design and hence no mapping to RAs.
>=20
> Only a subset of configuration constraints are currently implemented.
> This will want tightenning up in future.
>=20
> As we don't have any actual chunks of the spec in here so I haven't
> added the statement from the trademark grant that follows.
>=20
> Thanks,
>=20
> Jonathan
>=20
> This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> you and other parties that are paticipating (the "participants") in
> qemu with the understanding that the participants will use CCIX's
> name and trademark only when this patch is used in association with
> qemu.
>=20
> CCIX is also distributing this patch to these participants with the
> understanding that if any portion of the CCIX specification will be
> used or referenced in qemu, the participants will not modify the cited
> portion of the CCIX specification and will give CCIX propery copyright
> attribution by including the following copyright notice with
> the cited part of the CCIX specification:
> "=A9 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."
>=20
> Jonathan Cameron (7):
>   Temp: Add the PCI_EXT_ID_DVSEC definition to the qemu pci_regs.h copy.
>   pci: Add Huawei vendor ID and Huawei Emulated CCIX Device IDs.
>   pci: CCIX config space emulation library.
>   pci-bridge: CCIX capable PCIE/CCIX switch upstream port.
>   pci-bridge: CCIX capable PCIE/CCIX switch downstream port
>   misc: CCIX endpoint function
>   Temp: Add to ARM64 makefiles for testing
>=20
>  default-configs/arm-softmmu.mak           |    3 +-
>  hw/misc/Kconfig                           |    5 +
>  hw/misc/Makefile.objs                     |    1 +
>  hw/misc/ccix-ep.c                         |  112 ++
>  hw/pci-bridge/Kconfig                     |    5 +
>  hw/pci-bridge/Makefile.objs               |    1 +
>  hw/pci-bridge/ccix_downstream.c           |  222 ++++
>  hw/pci-bridge/ccix_upstream.c             |  197 ++++
>  hw/pci/Kconfig                            |    3 +
>  hw/pci/Makefile.objs                      |    1 +
>  hw/pci/ccix_lib.c                         | 1299 +++++++++++++++++++++
>  include/hw/misc/ccix.h                    |   28 +
>  include/hw/pci/pci_ids.h                  |    7 +
>  include/standard-headers/linux/pci_regs.h |    3 +-
>  14 files changed, 1885 insertions(+), 2 deletions(-)
>  create mode 100644 hw/misc/ccix-ep.c
>  create mode 100644 hw/pci-bridge/ccix_downstream.c
>  create mode 100644 hw/pci-bridge/ccix_upstream.c
>  create mode 100644 hw/pci/ccix_lib.c
>  create mode 100644 include/hw/misc/ccix.h
>=20



