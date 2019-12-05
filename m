Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF282C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9406424648
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9406424648
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmzh-0001qM-NJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 04:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1icmyu-0001On-Qf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1icmys-0007Dt-Ow
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:59:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:57332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1icmys-00077g-8o
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:59:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 00:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; d="scan'208";a="236602245"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2019 00:59:22 -0800
Date: Thu, 5 Dec 2019 03:51:11 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/9] Introduce mediate ops in vfio-pci
Message-ID: <20191205085111.GD31791@joy-OptiPlex-7040>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
 <8bcf603c-f142-f96d-bb11-834d686f5519@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bcf603c-f142-f96d-bb11-834d686f5519@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, shaopeng.he@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 02:33:19PM +0800, Jason Wang wrote:
> Hi:
> 
> On 2019/12/5 上午11:24, Yan Zhao wrote:
> > For SRIOV devices, VFs are passthroughed into guest directly without host
> > driver mediation. However, when VMs migrating with passthroughed VFs,
> > dynamic host mediation is required to  (1) get device states, (2) get
> > dirty pages. Since device states as well as other critical information
> > required for dirty page tracking for VFs are usually retrieved from PFs,
> > it is handy to provide an extension in PF driver to centralizingly control
> > VFs' migration.
> > 
> > Therefore, in order to realize (1) passthrough VFs at normal time, (2)
> > dynamically trap VFs' bars for dirty page tracking and
> 
> 
> A silly question, what's the reason for doing this, is this a must for dirty
> page tracking?
>
For performance consideration. VFs' bars should be passthoughed at
normal time and only enter into trap state on need.

> 
> >   (3) centralizing
> > VF critical states retrieving and VF controls into one driver, we propose
> > to introduce mediate ops on top of current vfio-pci device driver.
> > 
> > 
> >                                     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
> >   __________   register mediate ops|  ___________     ___________    |
> > |          |<-----------------------|     VF    |   |           |
> > | vfio-pci |                      | |  mediate  |   | PF driver |   |
> > |__________|----------------------->|   driver  |   |___________|
> >       |            open(pdev)      |  -----------          |         |
> >       |                                                    |
> >       |                            |_ _ _ _ _ _ _ _ _ _ _ _|_ _ _ _ _|
> >      \|/                                                  \|/
> > -----------                                         ------------
> > |    VF   |                                         |    PF    |
> > -----------                                         ------------
> > 
> > 
> > VF mediate driver could be a standalone driver that does not bind to
> > any devices (as in demo code in patches 5-6) or it could be a built-in
> > extension of PF driver (as in patches 7-9) .
> > 
> > Rather than directly bind to VF, VF mediate driver register a mediate
> > ops into vfio-pci in driver init. vfio-pci maintains a list of such
> > mediate ops.
> > (Note that: VF mediate driver can register mediate ops into vfio-pci
> > before vfio-pci binding to any devices. And VF mediate driver can
> > support mediating multiple devices.)
> > 
> > When opening a device (e.g. a VF), vfio-pci goes through the mediate ops
> > list and calls each vfio_pci_mediate_ops->open() with pdev of the opening
> > device as a parameter.
> > VF mediate driver should return success or failure depending on it
> > supports the pdev or not.
> > E.g. VF mediate driver would compare its supported VF devfn with the
> > devfn of the passed-in pdev.
> > Once vfio-pci finds a successful vfio_pci_mediate_ops->open(), it will
> > stop querying other mediate ops and bind the opening device with this
> > mediate ops using the returned mediate handle.
> > 
> > Further vfio-pci ops (VFIO_DEVICE_GET_REGION_INFO ioctl, rw, mmap) on the
> > VF will be intercepted into VF mediate driver as
> > vfio_pci_mediate_ops->get_region_info(),
> > vfio_pci_mediate_ops->rw,
> > vfio_pci_mediate_ops->mmap, and get customized.
> > For vfio_pci_mediate_ops->rw and vfio_pci_mediate_ops->mmap, they will
> > further return 'pt' to indicate whether vfio-pci should further
> > passthrough data to hw.
> > 
> > when vfio-pci closes the VF, it calls its vfio_pci_mediate_ops->release()
> > with a mediate handle as parameter.
> > 
> > The mediate handle returned from vfio_pci_mediate_ops->open() lets VF
> > mediate driver be able to differentiate two opening VFs of the same device
> > id and vendor id.
> > 
> > When VF mediate driver exits, it unregisters its mediate ops from
> > vfio-pci.
> > 
> > 
> > In this patchset, we enable vfio-pci to provide 3 things:
> > (1) calling mediate ops to allow vendor driver customizing default
> > region info/rw/mmap of a region.
> > (2) provide a migration region to support migration
> 
> 
> What's the benefit of introducing a region? It looks to me we don't expect
> the region to be accessed directly from guest. Could we simply extend device
> fd ioctl for doing such things?
>
You may take a look on mdev live migration discussions in
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01763.html

or previous discussion at
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04908.html,
which has kernel side implemetation https://patchwork.freedesktop.org/series/56876/

generaly speaking, qemu part of live migration is consistent for
vfio-pci + mediate ops way or mdev way. The region is only a channel for
QEMU and kernel to communicate information without introducing IOCTLs.


> 
> > (3) provide a dynamic trap bar info region to allow vendor driver
> > control trap/untrap of device pci bars
> > 
> > This vfio-pci + mediate ops way differs from mdev way in that
> > (1) medv way needs to create a 1:1 mdev device on top of one VF, device
> > specific mdev parent driver is bound to VF directly.
> > (2) vfio-pci + mediate ops way does not create mdev devices and VF
> > mediate driver does not bind to VFs. Instead, vfio-pci binds to VFs.
> > 
> > The reason why we don't choose the way of writing mdev parent driver is
> > that
> > (1) VFs are almost all the time directly passthroughed. Directly binding
> > to vfio-pci can make most of the code shared/reused.
> 
> 
> Can we split out the common parts from vfio-pci?
> 
That's very attractive. but one cannot implement a vfio-pci except
export everything in it as common part :)
> 
> >   If we write a
> > vendor specific mdev parent driver, most of the code (like passthrough
> > style of rw/mmap) still needs to be copied from vfio-pci driver, which is
> > actually a duplicated and tedious work.
> 
> 
> The mediate ops looks quite similar to what vfio-mdev did. And it looks to
> me we need to consider live migration for mdev as well. In that case, do we
> still expect mediate ops through VFIO directly?
> 
> 
> > (2) For features like dynamically trap/untrap pci bars, if they are in
> > vfio-pci, they can be available to most people without repeated code
> > copying and re-testing.
> > (3) with a 1:1 mdev driver which passthrough VFs most of the time, people
> > have to decide whether to bind VFs to vfio-pci or mdev parent driver before
> > it runs into a real migration need. However, if vfio-pci is bound
> > initially, they have no chance to do live migration when there's a need
> > later.
> 
> 
> We can teach management layer to do this.
> 
No. not possible as vfio-pci by default has no migration region and
dirty page tracking needs vendor's mediation at least for most
passthrough devices now.

Thanks
Yn

> Thanks
> 
> 
> > 
> > In this patchset,
> > - patches 1-4 enable vfio-pci to call mediate ops registered by vendor
> >    driver to mediate/customize region info/rw/mmap.
> > 
> > - patches 5-6 provide a standalone sample driver to register a mediate ops
> >    for Intel Graphics Devices. It does not bind to IGDs directly but decides
> >    what devices it supports via its pciidlist. It also demonstrates how to
> >    dynamic trap a device's PCI bars. (by adding more pciids in its
> >    pciidlist, this sample driver actually is not necessarily limited to
> >    support IGDs)
> > 
> > - patch 7-9 provide a sample on i40e driver that supports Intel(R)
> >    Ethernet Controller XL710 Family of devices. It supports VF precopy live
> >    migration on Intel's 710 SRIOV. (but we commented out the real
> >    implementation of dirty page tracking and device state retrieving part
> >    to focus on demonstrating framework part. Will send out them in future
> >    versions)
> >    patch 7 registers/unregisters VF mediate ops when PF driver
> >    probes/removes. It specifies its supporting VFs via
> >    vfio_pci_mediate_ops->open(pdev)
> > 
> >    patch 8 reports device cap of VFIO_PCI_DEVICE_CAP_MIGRATION and
> >    provides a sample implementation of migration region.
> >    The QEMU part of vfio migration is based on v8
> >    https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05542.html.
> >    We do not based on recent v9 because we think there are still opens in
> >    dirty page track part in that series.
> > 
> >    patch 9 reports device cap of VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR and
> >    provides an example on how to trap part of bar0 when migration starts
> >    and passthrough this part of bar0 again when migration fails.
> > 
> > Yan Zhao (9):
> >    vfio/pci: introduce mediate ops to intercept vfio-pci ops
> >    vfio/pci: test existence before calling region->ops
> >    vfio/pci: register a default migration region
> >    vfio-pci: register default dynamic-trap-bar-info region
> >    samples/vfio-pci/igd_dt: sample driver to mediate a passthrough IGD
> >    sample/vfio-pci/igd_dt: dynamically trap/untrap subregion of IGD bar0
> >    i40e/vf_migration: register mediate_ops to vfio-pci
> >    i40e/vf_migration: mediate migration region
> >    i40e/vf_migration: support dynamic trap of bar0
> > 
> >   drivers/net/ethernet/intel/Kconfig            |   2 +-
> >   drivers/net/ethernet/intel/i40e/Makefile      |   3 +-
> >   drivers/net/ethernet/intel/i40e/i40e.h        |   2 +
> >   drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 +
> >   .../ethernet/intel/i40e/i40e_vf_migration.c   | 626 ++++++++++++++++++
> >   .../ethernet/intel/i40e/i40e_vf_migration.h   |  78 +++
> >   drivers/vfio/pci/vfio_pci.c                   | 189 +++++-
> >   drivers/vfio/pci/vfio_pci_private.h           |   2 +
> >   include/linux/vfio.h                          |  18 +
> >   include/uapi/linux/vfio.h                     | 160 +++++
> >   samples/Kconfig                               |   6 +
> >   samples/Makefile                              |   1 +
> >   samples/vfio-pci/Makefile                     |   2 +
> >   samples/vfio-pci/igd_dt.c                     | 367 ++++++++++
> >   14 files changed, 1455 insertions(+), 4 deletions(-)
> >   create mode 100644 drivers/net/ethernet/intel/i40e/i40e_vf_migration.c
> >   create mode 100644 drivers/net/ethernet/intel/i40e/i40e_vf_migration.h
> >   create mode 100644 samples/vfio-pci/Makefile
> >   create mode 100644 samples/vfio-pci/igd_dt.c
> > 
> 

