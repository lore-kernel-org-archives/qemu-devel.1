Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0265C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BFD206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BFD206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOe6W-00082M-1B
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 05:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOe5n-0007Ov-Tx
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOe5m-0001HI-Aw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:12:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:25238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jOe5m-0001Gv-2p
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:12:22 -0400
IronPort-SDR: kq0P6aqg+yTZvBzgjxlHUwNcj+j3v1k5Hmz+GpafajeLB/9PpqP/qkMkPFWY90fNyllkysVICg
 ETibBAM3TX+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 02:12:20 -0700
IronPort-SDR: 6DZfSWbji33ZBRzjz6OV60+zabtDaKUmsqS6CmrO5jvPhgTksdHX4hTo959D8/TW+pnYu1H5Jz
 UD9fHbnsn6Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="245644372"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 02:12:14 -0700
Date: Wed, 15 Apr 2020 05:02:36 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v5 3/4] vfio/mdev: add migration_version attribute for
 mdev (under mdev device node)
Message-ID: <20200415090236.GK10586@joy-OptiPlex-7040>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200413055504.27311-1-yan.y.zhao@intel.com>
 <20200415074258.GK269314@sturgeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415074258.GK269314@sturgeon>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 03:42:58PM +0800, Erik Skultety wrote:
> On Mon, Apr 13, 2020 at 01:55:04AM -0400, Yan Zhao wrote:
> > migration_version attribute is used to check migration compatibility
> > between two mdev devices of the same mdev type.
> > The key is that it's rw and its data is opaque to userspace.
> >
> > Userspace reads migration_version of mdev device at source side and
> > writes the value to migration_version attribute of mdev device at target
> > side. It judges migration compatibility according to whether the read
> > and write operations succeed or fail.
> >
> > Currently, it is able to read/write migration_version attribute under two
> > places:
> >
> > (1) under mdev_type node
> > userspace is able to know whether two mdev devices are compatible before
> > a mdev device is created.
> >
> > userspace also needs to check whether the two mdev devices are of the same
> > mdev type before checking the migration_version attribute. It also needs
> > to check device creation parameters if aggregation is supported in future.
> >
> > (2) under mdev device node
> > userspace is able to know whether two mdev devices are compatible after
> > they are all created. But it does not need to check mdev type and device
> > creation parameter for aggregation as device vendor driver would have
> > incorporated those information into the migration_version attribute.
> >
> >              __    userspace
> >               /\              \
> >              /                 \write
> >             / read              \
> >    ________/__________       ___\|/_____________
> >   | migration_version |     | migration_version |-->check migration
> >   ---------------------     ---------------------   compatibility
> >     mdev device A               mdev device B
> >
> > This patch is for mdev documentation about the second place (under
> > mdev device node)
> >
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Erik Skultety <eskultet@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: "Tian, Kevin" <kevin.tian@intel.com>
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> > Cc: Neo Jia <cjia@nvidia.com>
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Christophe de Dinechin <dinechin@redhat.com>
> >
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  .../driver-api/vfio-mediated-device.rst       | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
> > index 2d1f3c0f3c8f..efbadfd51b7e 100644
> > --- a/Documentation/driver-api/vfio-mediated-device.rst
> > +++ b/Documentation/driver-api/vfio-mediated-device.rst
> > @@ -383,6 +383,7 @@ Directories and Files Under the sysfs for Each mdev Device
> >           |--- remove
> >           |--- mdev_type {link to its type}
> >           |--- vendor-specific-attributes [optional]
> > +         |--- migration_verion [optional]
> >
> >  * remove (write only)
> >
> > @@ -394,6 +395,75 @@ Example::
> >
> >  	# echo 1 > /sys/bus/mdev/devices/$mdev_UUID/remove
> >
> > +* migration_version (rw, optional)
> 
> Hmm, ^this is not consistent with how patch 1/5 reports this information, but
> looking at the existing docs we're not doing very well in terms of consistency
> there either.
> 
> I suggest we go with "(read-write)" in both patch 1/5 and here and then start
> the paragraph with "This is an optional attribute."
>
ok. got it.

> > +  It is used to check migration compatibility between two mdev devices.
> > +  Absence of this attribute means the mdev device does not support migration.
> > +
> > +  This attribute provides a way to check migration compatibility between two
> > +  mdev devices from userspace after device created. The intended usage is
> 
> after the target device has been created.
> 
> side note: maybe add something like "(see the migration_version attribute of
> the device node if the target device already exists)" in the same section in
> patch 1/5.

ok. good idea.
> 
> > +  for userspace to read the migration_version attribute from one mdev device and
> > +  then writing that value to the migration_version attribute of the other mdev
> > +  device. The second mdev device indicates compatibility via the return code of
> > +  the write operation. This makes compatibility between mdev devices completely
> > +  vendor-defined and opaque to userspace. Userspace should do nothing more
> > +  than use the migration_version attribute to confirm source to target
> > +  compatibility.
> 
> ...
> 
> > +
> > +  Reading/Writing Attribute Data:
> > +  read(2) will fail if a mdev device does not support migration and otherwise
> > +        succeed and return migration_version string of the mdev device.
> > +
> > +        This migration_version string is vendor defined and opaque to the
> > +        userspace. Vendor is free to include whatever they feel is relevant.
> > +        e.g. <pciid of parent device>-<software version>.
> > +
> > +        Restrictions on this migration_version string:
> > +            1. It should only contain ascii characters
> > +            2. MAX Length is PATH_MAX (4096)
> > +
> > +  write(2) expects migration_version string of source mdev device, and will
> > +         succeed if it is determined to be compatible and otherwise fail with
> > +         vendor specific errno.
> > +
> > +  Errno:
> > +  -An errno on read(2) indicates the mdev devicedoes not support migration;
> 
> s/devicedoes/device does/
> 
sorry for such kind of errors.

> > +  -An errno on write(2) indicates the mdev devices are incompatible or the
> > +   target doesn't support migration.
> > +  Vendor driver is free to define specific errno and is suggested to
> > +  print detailed error in syslog for diagnose purpose.
> > +
> > +  Userspace should treat ANY of below conditions as two mdev devices not
> > +  compatible:
> > +  (1) any one of the two mdev devices does not have a migration_version
> > +  attribute
> > +  (2) error when reading from migration_version attribute of one mdev device
> > +  (3) error when writing migration_version string of one mdev device to
> > +  migration_version attribute of the other mdev device
> > +
> > +  Userspace should regard two mdev devices compatible when ALL of below
> > +  conditions are met:
> > +  (1) success when reading from migration_version attribute of one mdev device.
> > +  (2) success when writing migration_version string of one mdev device to
> > +  migration_version attribute of the other mdev device.
> > +
> > +  Example Usage:
> > +  (1) Retrieve the mdev source migration_version:
> > +
> > +  # cat /sys/bus/mdev/devices/$mdev_UUID1/migration_version
> > +
> > +  If reading the source migration_version generates an error, migration is not
> > +  possible.
> > +
> > +  (2) Test source migration_version at target:
> > +
> > +  Given a migration_version as outlined above, its compatibility to an
> > +  instantiated device of the same mdev type can be tested as:
> > +  # echo $VERSION > /sys/bus/mdev/devices/$mdev_UUID2/migration_version
> > +
> > +  If this write fails, the source and target migration versions are not
> > +  compatible or the target does not support migration.
> > +
> > +
> >  Mediated device Hot plug
> >  ------------------------
> 
> Overall, the same comments as in 1/5 apply text-wise.
> 

got it. will align it with the first patch.

Thanks
Yan

> Regards,
> --
> Erik Skultety
> 

