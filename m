Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B058EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF1920775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGk0TOSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF1920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcUs-0001fo-I1
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eskultet@redhat.com>) id 1jOcTz-0000Vf-4P
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eskultet@redhat.com>) id 1jOcTx-0005Vv-2P
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:29:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1jOcTw-0005Vh-TV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586935752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq4PnsZgQ2G24Tjq97vpI5F2ndNze8Wd6Dp4iuNzDEg=;
 b=eGk0TOSRtmAd+WnKpdvBE6TciOUj5xjz1/MsBeYjodkAsA6PY398E7M8ZWtuYhvr9tEC6n
 m+PT7b6HqpxpTNh0uJXVE/rV9BYxqRoD7VRZzSYYn34eTW5lZYPdJ78G0hGvPJiZvAAGVw
 yRy+kC1xTf280mia7BzfbO1u/IwzYjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-G5cDUwQsPCGDTDJeZalDaw-1; Wed, 15 Apr 2020 03:29:10 -0400
X-MC-Unique: G5cDUwQsPCGDTDJeZalDaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D786718CA250;
 Wed, 15 Apr 2020 07:29:06 +0000 (UTC)
Received: from sturgeon (unknown [10.40.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF311001281;
 Wed, 15 Apr 2020 07:28:53 +0000 (UTC)
Date: Wed, 15 Apr 2020 09:28:51 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v5 1/4] vfio/mdev: add migration_version attribute for
 mdev (under mdev_type node)
Message-ID: <20200415072851.GJ269314@sturgeon>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200413055403.27203-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413055403.27203-1-yan.y.zhao@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 libvir-list@redhat.com, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, yi.l.liu@intel.com, corbet@lwn.net, ziye.yang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, felipe@nutanix.com,
 Ken.Xue@amd.com, kevin.tian@intel.com, xin.zeng@intel.com, dgilbert@redhat.com,
 zhenyuw@linux.intel.com, jonathan.davies@nutanix.com,
 intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
 dinechin@redhat.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 13, 2020 at 01:54:03AM -0400, Yan Zhao wrote:
> migration_version attribute is used to check migration compatibility
> between two mdev devices of the same mdev type.
> The key is that it's rw and its data is opaque to userspace.
>
> Userspace reads migration_version of mdev device at source side and
> writes the value to migration_version attribute of mdev device at targe=
t
> side. It judges migration compatibility according to whether the read
> and write operations succeed or fail.
>
> Currently, it is able to read/write migration_version attribute under t=
wo
> places:
>
> (1) under mdev_type node
> userspace is able to know whether two mdev devices are compatible befor=
e
> a mdev device is created.
>
> userspace also needs to check whether the two mdev devices are of the s=
ame
> mdev type before checking the migration_version attribute. It also need=
s
> to check device creation parameters if aggregation is supported in futu=
re.
>
> (2) under mdev device node
> userspace is able to know whether two mdev devices are compatible after
> they are all created. But it does not need to check mdev type and devic=
e
> creation parameter for aggregation as device vendor driver would have
> incorporated those information into the migration_version attribute.
>
>              __    userspace
>               /\              \
>              /                 \write
>             / read              \
>    ________/__________       ___\|/_____________
>   | migration_version |     | migration_version |-->check migration
>   ---------------------     ---------------------   compatibility
>     mdev device A               mdev device B
>
> This patch is for mdev documentation about the first place (under
> mdev_type node)
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> Cc: Neo Jia <cjia@nvidia.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Christophe de Dinechin <dinechin@redhat.com>
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>
> ---
> v5:
> updated commit message a little to indicate this patch is for
> migration_version attribute under mdev_type node
>
> v4:
> fixed a typo. (Cornelia Huck)
>
> v3:
> 1. renamed version to migration_version
> (Christophe de Dinechin, Cornelia Huck, Alex Williamson)
> 2. let errno to be freely defined by vendor driver
> (Alex Williamson, Erik Skultety, Cornelia Huck, Dr. David Alan Gilbert)
> 3. let checking mdev_type be prerequisite of migration compatibility
> check. (Alex Williamson)
> 4. reworded example usage section.
> (most of this section came from Alex Williamson)
> 5. reworded attribute intention section (Cornelia Huck)
>
> v2:
> 1. added detailed intent and usage
> 2. made definition of version string completely private to vendor drive=
r
>    (Alex Williamson)
> 3. abandoned changes to sample mdev drivers (Alex Williamson)
> 4. mandatory --> optional (Cornelia Huck)
> 5. added description for errno (Cornelia Huck)
> ---
>  .../driver-api/vfio-mediated-device.rst       | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>
> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Docume=
ntation/driver-api/vfio-mediated-device.rst
> index 25eb7d5b834b..2d1f3c0f3c8f 100644
> --- a/Documentation/driver-api/vfio-mediated-device.rst
> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Phys=
ical Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- migration_version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |     |   |--- create
> @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Phys=
ical Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- migration_version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |          |--- create
> @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Phys=
ical Device
>    |          |--- available_instances
>    |          |--- device_api
>    |          |--- description
> +  |          |--- migration_version
>    |          |--- [devices]
>
>  * [mdev_supported_types]
> @@ -246,6 +249,116 @@ Directories and files under the sysfs for Each Ph=
ysical Device
>    This attribute should show the number of devices of type <type-id> t=
hat can be
>    created.

I've got only a few suggestions to improve to wording in the documentatio=
n
(feel free to disagree):

>
> +* migration_version
> +
> +  This attribute is rw, and is optional.

IMO better wording: "This is an optional, RW attribute."

> +  It is used to check migration compatibility between two mdev devices=
 of the
> +  same mdev type. Absence of this attribute means the device of type <=
type-id>
> +  does not support migration.
> +  This attribute provides a way to check migration compatibility betwe=
en two
> +  mdev devices from userspace even before device creation. The intende=
d usage is

^This sentence essentially duplicates the information from the first sent=
ence,
can we condense it into something like:

"It is used to check the migration compatibility between two mdev devices=
 of the
same mdev type. Typically, the target device has not been created yet at =
the
time of userspace using this attribute to check the migration compatibili=
ty."

> +  for userspace to read the migration_version attribute from one mdev =
device and
> +  then writing that value to the migration_version attribute of the ot=
her mdev
> +  device. The second mdev device indicates compatibility via the retur=
n code of
> +  the write operation. This makes compatibility between mdev devices c=
ompletely
> +  vendor-defined and opaque to userspace. Userspace should do nothing =
more
> +  than verify the mdev types match and then use the migration_version =
attribute
> +  to confirm source to target compatibility.

I'd rephrase the ^last sentence differently:
"Therefore, userspace is only expected to verify that the mdev types of t=
he
respective devices match and then use the migration_version attribute to
confirm migration compatibility between the source and target mdev device=
s."

> +
> +  Reading/Writing Attribute Data:
> +  read(2) will fail if device of type <type-id> does not support migra=
tion and
> +          otherwise succeed and return migration_version string of the=
 device of

"returns a migration_version string of the device on success, fails with =
an
errno if the device doesn't support migration"

> +          type <type-id>.
> +
> +          This migration_version string is vendor defined and opaque t=
o the
> +          userspace. Vendor is free to include whatever they feel is r=
elevant.
> +          e.g. <pciid of parent device>-<software version>.
> +
> +          Restrictions on this migration_version string:
> +            1. It should only contain ascii characters
> +            2. MAX Length is PATH_MAX (4096)
> +
> +  write(2) expects migration_version string of source mdev device, and=
 will
> +          succeed if it is determined to be compatible and otherwise f=
ail with
> +          vendor specific errno.

"expects a migration_version string of the source mdev device, succeeds i=
f the
two mdev devices are migration compatible, otherwise fails with and errno=
"

> +
> +  Errno:
> +  -An errno on read(2) indicates the device of type <type-id> does not=
 support
> +  migration;
> +  -An errno on write(2) indicates the devices are incompatible or the =
target
> +  doesn't support migration.
> +  Vendor driver is free to define specific errno and is suggested to
> +  print detailed error in syslog for diagnose purpose.
> +
> +  Userspace should treat ANY of below conditions as two mdev devices n=
ot

Userspace should treat any of the below conditions as an indication of mi=
gration
incompatibility between two mdev devices.

> +  compatible:
> +  (0) The mdev devices are not of the same type
> +  (1) any one of the two mdev devices does not have a migration_versio=
n
> +  attribute

any of the two mdev devices is missing the migration_version attribute

> +  (2) error when reading from migration_version attribute of one mdev =
device

when reading the source mdev's migration_version attribute

> +  (3) error when writing migration_version string of one mdev device t=
o
> +  migration_version attribute of the other mdev device

when writing the source mdev migration_version string to the target mdev
device's migration_version attribute

> +
> +  Userspace should regard two mdev devices compatible when ALL of belo=
w
> +  conditions are met:

Userspace can consider the two mdev devices to be compatible when all of =
the
below conditions are met:

> +  (0) The mdev devices are of the same type
> +  (1) success when reading from migration_version attribute of one mde=
v device.

reading the migration_version attribute of the source succeeds

> +  (2) success when writing migration_version string of one mdev device=
 to
> +  migration_version attribute of the other mdev device.

writing the migration_version string to the target mdev's migration_versi=
on
attribute succeeds

> +
> +  Example Usage:
> +  (1) Compare mdev types:

Comparing two mdev types:

> +
> +  The mdev type of an instantiated device can be read from the mdev_ty=
pe link
> +  within the device instance in sysfs, for example:
> +
> +  # basename $(readlink -f /sys/bus/mdev/devices/$MDEV_UUID/mdev_type/=
)
> +
> +  The mdev types available on a given host system can also be found th=
rough
> +  /sys/class/mdev_bus, for example:
> +
> +  # ls /sys/class/mdev_bus/*/mdev_supported_types/
> +
> +  Migration is only possible between devices of the same mdev type.
> +
> +  (2) Retrieve the mdev source migration_version:
> +
> +  The migration_version information can either be read from the mdev_t=
ype link
> +  on an instantiated device:

s/information/string

> +
> +  # cat /sys/bus/mdev/devices/$UUID1/mdev_type/migration_version
> +
> +  Or it can be read from the mdev type definition, for example:
> +
> +  # cat /sys/class/mdev_bus/*/mdev_supported_types/$MDEV_TYPE/migratio=
n_version
> +
> +  If reading the source migration_version generates an error, migratio=
n is not
> +  possible.
> +  NB, there might be several parent devices for a given mdev type on a=
 host
> +  system, each may support or expose different migration_versions.
> +  Matching the specific mdev type to a parent may become important in =
such
> +  configurations.
> +
> +  (3) Test source migration_version at target:
> +
> +  Given a migration_version as outlined above, its compatibility to an
> +  instantiated device of the same mdev type can be tested as:
> +  # echo $VERSION > /sys/bus/mdev/devices/$UUID2/mdev_type/migration_v=
ersion
> +
> +  If this write fails, the source and target migration versions are no=
t
> +  compatible or the target does not support migration.
> +
> +  Compatibility can also be tested prior to target device creation usi=
ng the

prior to creation of the target device

> +  mdev type definition for a parent device with a previously found mat=
ching mdev
> +  type, for example:

using the migration_version attribute present inside a specific mdev type
directory for a given physical parent device.

> +
> +  # echo $VERSION > \
> +  /sys/class/mdev_bus/$PARENT/mdev_supported_types/$MDEV_TYPE/migratio=
n_version
> +
> +  Again, an error writing the migration_version indicates that an inst=
ance of
> +  this mdev type would not support a migration from the provided migra=
tion
> +  version.

would not support migration from the source.

--
Erik Skultety


