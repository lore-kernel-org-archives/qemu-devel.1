Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9606C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9CF21738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9CF21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwkK-0001LS-Ea
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:50:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hIwjR-00011e-KU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hIwjQ-0003lY-3C
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hIwjP-0003ko-RV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:49:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAFE210C6E;
	Tue, 23 Apr 2019 14:48:56 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 795CC5D6A9;
	Tue, 23 Apr 2019 14:48:52 +0000 (UTC)
Date: Tue, 23 Apr 2019 08:48:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Message-ID: <20190423084852.62168bb2@x1.home>
In-Reply-To: <20190423134400.GL6022@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
	<20190423063540.7ec83c31@x1.home>
	<20190423134400.GL6022@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 23 Apr 2019 14:49:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/mdev: add version field as
 mandatory attribute for mdev device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
	Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
	qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com,
	yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
	mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com,
	arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com,
	kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
	dgilbert@redhat.com, zhenyuw@linux.intel.com,
	intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com,
	cohuck@redhat.com, linux-kernel@vger.kernel.org,
	zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423144852._soKmdvJpFG3vjh5wZ9cj28MnEcE753sGGGoBwUHPlI@z>

On Tue, 23 Apr 2019 14:44:00 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Apr 23, 2019 at 06:35:40AM -0600, Alex Williamson wrote:
> > On Tue, 23 Apr 2019 11:39:39 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote: =20
> > > > +* version
> > > > +
> > > > +  This attribute is rw. It is used to check whether two devices ar=
e compatible
> > > > +  for live migration. If this attribute is missing, then the corre=
sponding mdev
> > > > +  device is regarded as not supporting live migration.
> > > > +
> > > > +  It consists of two parts: common part and vendor proprietary par=
t.
> > > > +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bi=
ts identifies
> > > > +               device type. e.g., for pci device, it is
> > > > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > > > +  vendor proprietary part: this part is varied in length. vendor d=
river can
> > > > +               specify any string to identify a device.
> > > > +
> > > > +  When reading this attribute, it should show device version strin=
g of the device
> > > > +  of type <type-id>. If a device does not support live migration, =
it should
> > > > +  return errno.
> > > > +  When writing a string to this attribute, it returns errno for in=
compatibility
> > > > +  or returns written string length in compatibility case. If a dev=
ice does not
> > > > +  support live migration, it always returns errno.
> > > > +
> > > > +  for example.
> > > > +  # cat \
> > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVT=
g_V5_2/version
> > > > +  00028086-193b-i915-GVTg_V5_2
> > > > +
> > > > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVT=
g_V5_4/version
> > > > + -bash: echo: write error: Invalid argument
> > > > +   =20
> > >=20
> > > IIUC this path is against the physical device. IOW, the mgmt app woul=
d have
> > > to first write to the "version" file to choose a version, and then wr=
ite to
> > > the "create" file to actually create an virtual device. This has the =
obvious
> > > concurrency problem if multiple devices are being created at the same=
 time
> > > and distinct versions for each device are required. There would need =
to be
> > > a locking scheme defined to ensure safety. =20
> >=20
> > "Create a device of a given version" is not an intended feature of this
> > interface aiui.  Writing the version attribute only indicates
> > migration compatibility with a binary result.
> >   =20
> > > Wouldn't it be better if we can pass the desired version when we writ=
e to
> > > the "create" file, so that we avoid any concurrent usage problems. "v=
ersion"
> > > could be just a read-only file with a *list* of supported versions.
> > >=20
> > > eg
> > >=20
> > >   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915=
-GVTg_V5_4/version
> > >   5.0
> > >   5.1
> > >   5.2
> > >=20
> > >   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=3D5.2" >
> > >       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/crea=
te =20
> >=20
> > This is reminiscent of the proposed aggregation support, but again,
> > this sort of feature is not intended here.  It's no expected that any
> > vendor driver would support creating device types of different
> > versions, but they may support migration from different versions. =20
>=20
> Hmm, that's a subtle distinction I wasn't seeing the patch series.
> IIUC from what you're saying, a device can be created with version
> "C", but for an incoming migration it can (potentially) accept
> serialized state matching any of versions "A", "B" or "C".
>=20
> That is sufficient if migration is being used as a host upgrade
> tool, to move from OS release N to N + 1.
>=20
> It wouldn't cover the case where you need to support backwards
> migration too. eg if you have a mixture of hosts with release
> N and N + 1 and want to make sure that VMs can always move
> betweeen any host.  That would require that you can create
> mdevs with the lowest common denominator version, not solely
> the most recent.
>=20
> In QEMU this is done by mgmt applications picking a versioned
> machine type for QEMU that is older than most recent.

I suppose we'd need to determine how important that is, this is just a
device after all, there are always fallback mechanisms via hotplug.
There are a lot of pieces that need to line up for backwards migration
including support for it at the individual vendor driver.  Nothing we
design into the API is going to require vendor drivers to support
backwards migration and we already have some vendors requiring host and
guest driver alignment.  Specifying a version with a create syntax as
you've provided is reasonable, but this also balloons into whole
tangential interface providing information regarding what versions a
vendor driver is able to create, because presumably management tools
wouldn't prefer a try-and-see type interface.  I believe an intentional
aspect of the proposal here is that we don't need to provide a list of
compatible versions, that's handled internally to the vendor driver.

I don't know if we could start with the proposal here and later add
these sorts of features.  Ideas?  Thanks,

Alex

