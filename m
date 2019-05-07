Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6FC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F1C20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F1C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwI0-0004lh-VI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:21:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNwGs-0003hM-0G
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNwGq-0008OY-CD
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:20:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hNwGo-0008Jy-BW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:20:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4031309703F;
	Tue,  7 May 2019 09:20:15 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7803611DC;
	Tue,  7 May 2019 09:19:56 +0000 (UTC)
Date: Tue, 7 May 2019 11:19:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190507111954.43d477c3.cohuck@redhat.com>
In-Reply-To: <20190506014904.3621-1-yan.y.zhao@intel.com>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 07 May 2019 09:20:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio/mdev: add version attribute
 for mdev device
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
	kevin.tian@intel.com, dgilbert@redhat.com,
	zhenyuw@linux.intel.com, dinechin@redhat.com,
	alex.williamson@redhat.com, intel-gvt-dev@lists.freedesktop.org,
	changpeng.liu@intel.com, linux-kernel@vger.kernel.org,
	zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun,  5 May 2019 21:49:04 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> version attribute is used to check two mdev devices' compatibility.
>=20
> The key point of this version attribute is that it's rw.
> User space has no need to understand internal of device version and no
> need to compare versions by itself.
> Compared to reading version strings from both two mdev devices being
> checked, user space only reads from one mdev device's version attribute.
> After getting its version string, user space writes this string into the
> other mdev device's version attribute. Vendor driver of mdev device
> whose version attribute being written will check device compatibility of
> the two mdev devices for user space and return success for compatibility
> or errno for incompatibility.

I'm still missing a bit _what_ is actually supposed to be
compatible/incompatible. I'd assume some internal state descriptions
(even if this is not actually limited to migration).

> So two readings of version attributes + checking in user space are now
> changed to one reading + one writing of version attributes + checking in
> vendor driver.

I'm not sure that needs to go into the patch description (sounds like
it is rather a change log?)

> Format and length of version strings are now private to vendor driver
> who can define them freely.

Same here; simply drop the 'now'?

>=20
>              __ user space
>               /\          \
>              /             \write
>             / read          \
>      ______/__           ___\|/___
>     | version |         | version |-->check compatibility
>     -----------         -----------
>     mdev device A       mdev device B
>=20
> This version attribute is optional. If a mdev device does not provide
> with a version attribute, this mdev device is incompatible to all other
> mdev devices.

Again, I'd like an explanation here what kind of compatibility we're
talking about.

>=20
> Live migration is able to take advantage of this version attribute.
> Before user space actually starts live migration, it can first check
> whether two mdev devices are compatible.
>=20
> v2:
> 1. added detailed intent and usage
> 2. made definition of version string completely private to vendor driver
>    (Alex Williamson)
> 3. abandoned changes to sample mdev drivers (Alex Williamson)
> 4. mandatory --> optional (Cornelia Huck)
> 5. added description for errno (Cornelia Huck)

This changelog should go below the ---, so that it does not actually
show up in the patch description later :)

>=20
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
>=20
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  Documentation/vfio-mediated-device.txt | 140 +++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>=20
> diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfio-=
mediated-device.txt
> index c3f69bcaf96e..013a764968eb 100644
> --- a/Documentation/vfio-mediated-device.txt
> +++ b/Documentation/vfio-mediated-device.txt
> @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physic=
al Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |     |   |--- create
> @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physic=
al Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |          |--- create
> @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physic=
al Device
>    |          |--- available_instances
>    |          |--- device_api
>    |          |--- description
> +  |          |--- version
>    |          |--- [devices]
> =20
>  * [mdev_supported_types]
> @@ -246,6 +249,143 @@ Directories and files under the sysfs for Each Phys=
ical Device
>    This attribute should show the number of devices of type <type-id> tha=
t can be
>    created.
> =20
> +* version
> +
> +  This attribute is rw, and is optional.
> +  It is used to check device compatibility between two mdev devices and =
is
> +  accessed in pairs between the two mdev devices being checked.
> +  The intent of this attribute is to make an mdev device's version opaqu=
e to
> +  user space, so instead of reading two mdev devices' version strings and
> +  comparing in userspace, user space should only read one mdev device's =
version
> +  attribute, and writes this version string into the other mdev device's=
 version
> +  attribute. Then vendor driver of mdev device whose version attribute b=
eing
> +  written would check the incoming version string and tell user space wh=
ether
> +  the two mdev devices are compatible via return value. That's why this
> +  attribute is writable.

I would reword this a bit:

"This attribute provides a way to check device compatibility between
two mdev devices from userspace. The intended usage is for userspace to
read the version attribute from one mdev device and then writing that
value to the version attribute of the other mdev device. The second
mdev device indicates compatibility via the return code of the write
operation. This makes compatibility between mdev devices completely
vendor-defined and opaque to userspace."

We still should explain _what_ compatibility we're talking about here,
though.

> +
> +  when reading this attribute, it should show device version string of
> +  the device of type <type-id>.
> +
> +  This string is private to vendor driver itself. Vendor driver is able =
to
> +  freely define format and length of device version string.
> +  e.g. It can use a combination of pciid of parent device + mdev type.
> +
> +  When writing a string to this attribute, vendor driver should analyze =
this
> +  string and check whether the mdev device being identified by this stri=
ng is
> +  compatible with the mdev device for this attribute. vendor driver shou=
ld then
> +  return written string's length if it regards the two mdev devices are
> +  compatible; vendor driver should return negative errno if it regards t=
he two
> +  mdev devices are not compatible.
> +
> +  User space should treat ANY of below conditions as two mdev devices not
> +  compatible:
> +  (1) any one of the two mdev devices does not have a version attribute
> +  (2) error when read from one mdev device's version attribute

s/read/reading/

> +  (3) error when write one mdev device's version string to the other mdev

s/write/writing/

> +  device's version attribute
> +
> +  User space should regard two mdev devices compatible when ALL of below
> +  conditions are met:
> +  (1) success when read from one mdev device's version attribute.

s/read/reading/

> +  (2) success when write one mdev device's version string to the other m=
dev

s/write/writing/

> +  device's version attribute
> +
> +  Errno:
> +  If vendor driver wants to claim a mdev device incompatible to all othe=
r mdev

"If the vendor driver wants to designate a mdev device..."

> +  devices, it should not register version attribute for this mdev device=
. But if
> +  a vendor driver has already registered version attribute and it wants =
to claim
> +  a mdev device incompatible to all other mdev devices, it needs to retu=
rn
> +  -ENODEV on access to this mdev device's version attribute.
> +  If a mdev device is only incompatible to certain mdev devices, write of
> +  incompatible mdev devices's version strings to its version attribute s=
hould
> +  return -EINVAL;


Maybe put the defined return code into a bulleted list instead? But
this looks reasonable as well.

> +
> +  This attribute can be taken advantage of by live migration.
> +  If user space detects two mdev devices are compatible through version
> +  attribute, it can start migration between the two mdev devices, otherw=
ise it
> +  should abort its migration attempts between the two mdev devices.

(...)

