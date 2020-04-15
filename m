Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05B7C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E45206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E45206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOe2f-0005jm-Ox
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 05:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOe1r-0004jS-R6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOe1p-0008Mu-9I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:08:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:9213)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jOe1o-0008Lv-Uy
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:08:17 -0400
IronPort-SDR: 7YZzcpKm8AtZrKTfC22r0DtJjmeZqrr4cFKTCndLeO0LnTdkOqZCYMXQDYomdmu1bLKRHeeVNL
 NHwXkICx0HwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 02:08:13 -0700
IronPort-SDR: Sb/bOKaI/6yn3gDzWatW0WtOr9GWinUWQ1Q99E1O1FXNzLpPKvXtosbGeW7MVGT5fdFcGDqxwW
 nHgK0jCfbZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="453859196"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 02:08:06 -0700
Date: Wed, 15 Apr 2020 04:58:28 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v5 1/4] vfio/mdev: add migration_version attribute for
 mdev (under mdev_type node)
Message-ID: <20200415085828.GJ10586@joy-OptiPlex-7040>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200413055403.27203-1-yan.y.zhao@intel.com>
 <20200415072851.GJ269314@sturgeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415072851.GJ269314@sturgeon>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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

On Wed, Apr 15, 2020 at 03:28:51PM +0800, Erik Skultety wrote:
> On Mon, Apr 13, 2020 at 01:54:03AM -0400, Yan Zhao wrote:
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
> > This patch is for mdev documentation about the first place (under
> > mdev_type node)
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
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> >
> > ---
> > v5:
> > updated commit message a little to indicate this patch is for
> > migration_version attribute under mdev_type node
> >
> > v4:
> > fixed a typo. (Cornelia Huck)
> >
> > v3:
> > 1. renamed version to migration_version
> > (Christophe de Dinechin, Cornelia Huck, Alex Williamson)
> > 2. let errno to be freely defined by vendor driver
> > (Alex Williamson, Erik Skultety, Cornelia Huck, Dr. David Alan Gilbert)
> > 3. let checking mdev_type be prerequisite of migration compatibility
> > check. (Alex Williamson)
> > 4. reworded example usage section.
> > (most of this section came from Alex Williamson)
> > 5. reworded attribute intention section (Cornelia Huck)
> >
> > v2:
> > 1. added detailed intent and usage
> > 2. made definition of version string completely private to vendor driver
> >    (Alex Williamson)
> > 3. abandoned changes to sample mdev drivers (Alex Williamson)
> > 4. mandatory --> optional (Cornelia Huck)
> > 5. added description for errno (Cornelia Huck)
> > ---
> >  .../driver-api/vfio-mediated-device.rst       | 113 ++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >
> > diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
> > index 25eb7d5b834b..2d1f3c0f3c8f 100644
> > --- a/Documentation/driver-api/vfio-mediated-device.rst
> > +++ b/Documentation/driver-api/vfio-mediated-device.rst
> > @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physical Device
> >    |     |   |--- available_instances
> >    |     |   |--- device_api
> >    |     |   |--- description
> > +  |     |   |--- migration_version
> >    |     |   |--- [devices]
> >    |     |--- [<type-id>]
> >    |     |   |--- create
> > @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physical Device
> >    |     |   |--- available_instances
> >    |     |   |--- device_api
> >    |     |   |--- description
> > +  |     |   |--- migration_version
> >    |     |   |--- [devices]
> >    |     |--- [<type-id>]
> >    |          |--- create
> > @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physical Device
> >    |          |--- available_instances
> >    |          |--- device_api
> >    |          |--- description
> > +  |          |--- migration_version
> >    |          |--- [devices]
> >
> >  * [mdev_supported_types]
> > @@ -246,6 +249,116 @@ Directories and files under the sysfs for Each Physical Device
> >    This attribute should show the number of devices of type <type-id> that can be
> >    created.
> 
> I've got only a few suggestions to improve to wording in the documentation
> (feel free to disagree):
> 
hi Erik,
Thanks for your good suggestions. They are better to understand than
the original ones:)
I'll update the doc according to them except for below minor one --
may I just put it like this:
* migration_version (rw, optional)

Thanks
Yan

> >
> > +* migration_version
> > +
> > +  This attribute is rw, and is optional.
> 
> IMO better wording: "This is an optional, RW attribute."
>



> > +  It is used to check migration compatibility between two mdev devices of the
> > +  same mdev type. Absence of this attribute means the device of type <type-id>
> > +  does not support migration.
> > +  This attribute provides a way to check migration compatibility between two
> > +  mdev devices from userspace even before device creation. The intended usage is
> 
> ^This sentence essentially duplicates the information from the first sentence,
> can we condense it into something like:
> 
> "It is used to check the migration compatibility between two mdev devices of the
> same mdev type. Typically, the target device has not been created yet at the
> time of userspace using this attribute to check the migration compatibility."
> 
> > +  for userspace to read the migration_version attribute from one mdev device and
> > +  then writing that value to the migration_version attribute of the other mdev
> > +  device. The second mdev device indicates compatibility via the return code of
> > +  the write operation. This makes compatibility between mdev devices completely
> > +  vendor-defined and opaque to userspace. Userspace should do nothing more
> > +  than verify the mdev types match and then use the migration_version attribute
> > +  to confirm source to target compatibility.
> 
> I'd rephrase the ^last sentence differently:
> "Therefore, userspace is only expected to verify that the mdev types of the
> respective devices match and then use the migration_version attribute to
> confirm migration compatibility between the source and target mdev devices."
> 
> > +
> > +  Reading/Writing Attribute Data:
> > +  read(2) will fail if device of type <type-id> does not support migration and
> > +          otherwise succeed and return migration_version string of the device of
> 
> "returns a migration_version string of the device on success, fails with an
> errno if the device doesn't support migration"
> 
> > +          type <type-id>.
> > +
> > +          This migration_version string is vendor defined and opaque to the
> > +          userspace. Vendor is free to include whatever they feel is relevant.
> > +          e.g. <pciid of parent device>-<software version>.
> > +
> > +          Restrictions on this migration_version string:
> > +            1. It should only contain ascii characters
> > +            2. MAX Length is PATH_MAX (4096)
> > +
> > +  write(2) expects migration_version string of source mdev device, and will
> > +          succeed if it is determined to be compatible and otherwise fail with
> > +          vendor specific errno.
> 
> "expects a migration_version string of the source mdev device, succeeds if the
> two mdev devices are migration compatible, otherwise fails with and errno"
> 
> > +
> > +  Errno:
> > +  -An errno on read(2) indicates the device of type <type-id> does not support
> > +  migration;
> > +  -An errno on write(2) indicates the devices are incompatible or the target
> > +  doesn't support migration.
> > +  Vendor driver is free to define specific errno and is suggested to
> > +  print detailed error in syslog for diagnose purpose.
> > +
> > +  Userspace should treat ANY of below conditions as two mdev devices not
> 
> Userspace should treat any of the below conditions as an indication of migration
> incompatibility between two mdev devices.
> 
> > +  compatible:
> > +  (0) The mdev devices are not of the same type
> > +  (1) any one of the two mdev devices does not have a migration_version
> > +  attribute
> 
> any of the two mdev devices is missing the migration_version attribute
> 
> > +  (2) error when reading from migration_version attribute of one mdev device
> 
> when reading the source mdev's migration_version attribute
> 
> > +  (3) error when writing migration_version string of one mdev device to
> > +  migration_version attribute of the other mdev device
> 
> when writing the source mdev migration_version string to the target mdev
> device's migration_version attribute
> 
> > +
> > +  Userspace should regard two mdev devices compatible when ALL of below
> > +  conditions are met:
> 
> Userspace can consider the two mdev devices to be compatible when all of the
> below conditions are met:
> 
> > +  (0) The mdev devices are of the same type
> > +  (1) success when reading from migration_version attribute of one mdev device.
> 
> reading the migration_version attribute of the source succeeds
> 
> > +  (2) success when writing migration_version string of one mdev device to
> > +  migration_version attribute of the other mdev device.
> 
> writing the migration_version string to the target mdev's migration_version
> attribute succeeds
> 
> > +
> > +  Example Usage:
> > +  (1) Compare mdev types:
> 
> Comparing two mdev types:
> 
> > +
> > +  The mdev type of an instantiated device can be read from the mdev_type link
> > +  within the device instance in sysfs, for example:
> > +
> > +  # basename $(readlink -f /sys/bus/mdev/devices/$MDEV_UUID/mdev_type/)
> > +
> > +  The mdev types available on a given host system can also be found through
> > +  /sys/class/mdev_bus, for example:
> > +
> > +  # ls /sys/class/mdev_bus/*/mdev_supported_types/
> > +
> > +  Migration is only possible between devices of the same mdev type.
> > +
> > +  (2) Retrieve the mdev source migration_version:
> > +
> > +  The migration_version information can either be read from the mdev_type link
> > +  on an instantiated device:
> 
> s/information/string
> 
> > +
> > +  # cat /sys/bus/mdev/devices/$UUID1/mdev_type/migration_version
> > +
> > +  Or it can be read from the mdev type definition, for example:
> > +
> > +  # cat /sys/class/mdev_bus/*/mdev_supported_types/$MDEV_TYPE/migration_version
> > +
> > +  If reading the source migration_version generates an error, migration is not
> > +  possible.
> > +  NB, there might be several parent devices for a given mdev type on a host
> > +  system, each may support or expose different migration_versions.
> > +  Matching the specific mdev type to a parent may become important in such
> > +  configurations.
> > +
> > +  (3) Test source migration_version at target:
> > +
> > +  Given a migration_version as outlined above, its compatibility to an
> > +  instantiated device of the same mdev type can be tested as:
> > +  # echo $VERSION > /sys/bus/mdev/devices/$UUID2/mdev_type/migration_version
> > +
> > +  If this write fails, the source and target migration versions are not
> > +  compatible or the target does not support migration.
> > +
> > +  Compatibility can also be tested prior to target device creation using the
> 
> prior to creation of the target device
> 
> > +  mdev type definition for a parent device with a previously found matching mdev
> > +  type, for example:
> 
> using the migration_version attribute present inside a specific mdev type
> directory for a given physical parent device.
> 
> > +
> > +  # echo $VERSION > \
> > +  /sys/class/mdev_bus/$PARENT/mdev_supported_types/$MDEV_TYPE/migration_version
> > +
> > +  Again, an error writing the migration_version indicates that an instance of
> > +  this mdev type would not support a migration from the provided migration
> > +  version.
> 
> would not support migration from the source.
> 
> --
> Erik Skultety
> 

