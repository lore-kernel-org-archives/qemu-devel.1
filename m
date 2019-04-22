Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D3C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C950120859
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C950120859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIa82-0004lz-0c
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 10:41:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hIa71-0004DY-Kn
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hIa6z-0000r5-P2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hIa6z-0000qj-Gh
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:40:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B3C881DEC;
	Mon, 22 Apr 2019 14:39:58 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33DF21001E97;
	Mon, 22 Apr 2019 14:39:51 +0000 (UTC)
Date: Mon, 22 Apr 2019 08:39:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190422083950.25eb9e7c@x1.home>
In-Reply-To: <20190419083505.19654-1-yan.y.zhao@intel.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 22 Apr 2019 14:39:59 +0000 (UTC)
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
	kevin.tian@intel.com, dgilbert@redhat.com,
	zhenyuw@linux.intel.com, intel-gvt-dev@lists.freedesktop.org,
	changpeng.liu@intel.com, cohuck@redhat.com,
	linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
	jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422143950.Cj35Bkw6BS6Pj8ejyr0OhhdS7LooYh0RF80PBt53pMM@z>

On Fri, 19 Apr 2019 04:35:04 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> device version attribute in mdev sysfs is used by user space software
> (e.g. libvirt) to query device compatibility for live migration of VFIO
> mdev devices. This attribute is mandatory if a mdev device supports live
> migration.

The Subject: doesn't quite match what's being proposed here.
 
> It consists of two parts: common part and vendor proprietary part.
> common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
>              identifies device type. e.g., for pci device, it is
>              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).

What purpose does this serve?  If it's intended as some sort of
namespace feature, shouldn't we first assume that we can only support
migration to devices of the same type?  Therefore each type would
already have its own namespace.  Also that would make the trailing bit
of the version string listed below in the example redundant.  A vendor
is still welcome to include this in their version string if they wish,
but I think the string should be entirely vendor defined.

> vendor proprietary part: this part is varied in length. vendor driver can
>              specify any string to identify a device.
> 
> When reading this attribute, it should show device version string of the
> device of type <type-id>. If a device does not support live migration, it
> should return errno.
> When writing a string to this attribute, it returns errno for
> incompatibility or returns written string length in compatibility case.
> If a device does not support live migration, it always returns errno.
> 
> For user space software to use:
> 1.
> Before starting live migration, user space software first reads source side
> mdev device's version. e.g.
> "#cat \
> /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type/version"
> 00028086-193b-i915-GVTg_V5_4
> 
> 2.
> Then, user space software writes the source side returned version string
> to device version attribute in target side, and checks the return value.
> If a negative errno is returned in the target side, then mdev devices in
> source and target sides are not compatible;
> If a positive number is returned and it equals to the length of written
> string, then the two mdev devices in source and target side are compatible.
> e.g.
> (a) compatibility case
> "# echo 00028086-193b-i915-GVTg_V5_4 >
> /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> 
> (b) incompatibility case
> "#echo 00028086-193b-i915-GVTg_V5_1 >
> /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> -bash: echo: write error: Invalid argument
> 
> 3. if two mdev devices are compatible, user space software can start
> live migration, and vice versa.
> 
> Note: if a mdev device does not support live migration, it either does
> not provide a version attribute, or always returns errno when its version
> attribute is read/written.

I think it would be cleaner to do the former, not supply the
attribute.  This seems to do the latter in the sample drivers.  Thanks,

Alex

> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> Cc: Neo Jia <cjia@nvidia.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  Documentation/vfio-mediated-device.txt | 36 ++++++++++++++++++++++++++
>  samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
>  samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
>  samples/vfio-mdev/mtty.c               | 16 ++++++++++++
>  4 files changed, 85 insertions(+)
> 
> diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfio-mediated-device.txt
> index c3f69bcaf96e..bc28471c0667 100644
> --- a/Documentation/vfio-mediated-device.txt
> +++ b/Documentation/vfio-mediated-device.txt
> @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physical Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |     |   |--- create
> @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physical Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |          |--- create
> @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physical Device
>    |          |--- available_instances
>    |          |--- device_api
>    |          |--- description
> +  |          |--- version
>    |          |--- [devices]
>  
>  * [mdev_supported_types]
> @@ -225,6 +228,8 @@ Directories and files under the sysfs for Each Physical Device
>    [<type-id>], device_api, and available_instances are mandatory attributes
>    that should be provided by vendor driver.
>  
> +  version is a mandatory attribute if a mdev device supports live migration.
> +
>  * [<type-id>]
>  
>    The [<type-id>] name is created by adding the device driver string as a prefix
> @@ -246,6 +251,35 @@ Directories and files under the sysfs for Each Physical Device
>    This attribute should show the number of devices of type <type-id> that can be
>    created.
>  
> +* version
> +
> +  This attribute is rw. It is used to check whether two devices are compatible
> +  for live migration. If this attribute is missing, then the corresponding mdev
> +  device is regarded as not supporting live migration.
> +
> +  It consists of two parts: common part and vendor proprietary part.
> +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
> +               device type. e.g., for pci device, it is
> +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> +  vendor proprietary part: this part is varied in length. vendor driver can
> +               specify any string to identify a device.
> +
> +  When reading this attribute, it should show device version string of the device
> +  of type <type-id>. If a device does not support live migration, it should
> +  return errno.
> +  When writing a string to this attribute, it returns errno for incompatibility
> +  or returns written string length in compatibility case. If a device does not
> +  support live migration, it always returns errno.
> +
> +  for example.
> +  # cat \
> + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
> +  00028086-193b-i915-GVTg_V5_2
> +
> +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> + -bash: echo: write error: Invalid argument
> +
>  * [device]
>  
>    This directory contains links to the devices of type <type-id> that have been
> @@ -327,12 +361,14 @@ card.
>          |   |   |-- available_instances
>          |   |   |-- create
>          |   |   |-- device_api
> +        |   |   |-- version
>          |   |   |-- devices
>          |   |   `-- name
>          |   `-- mtty-2
>          |       |-- available_instances
>          |       |-- create
>          |       |-- device_api
> +        |       |-- version
>          |       |-- devices
>          |       `-- name
>          |-- mtty_dev
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index b038aa9f5a70..2f5ba96b91a2 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -1391,11 +1391,28 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>  }
>  MDEV_TYPE_ATTR_RO(device_api);
>  
> +static ssize_t version_show(struct kobject *kobj, struct device *dev,
> +		char *buf)
> +{
> +	/* do not support live migration */
> +	return -EINVAL;
> +}
> +
> +static ssize_t version_store(struct kobject *kobj, struct device *dev,
> +		const char *buf, size_t count)
> +{
> +	/* do not support live migration */
> +	return -EINVAL;
> +}
> +
> +static MDEV_TYPE_ATTR_RW(version);
> +
>  static struct attribute *mdev_types_attrs[] = {
>  	&mdev_type_attr_name.attr,
>  	&mdev_type_attr_description.attr,
>  	&mdev_type_attr_device_api.attr,
>  	&mdev_type_attr_available_instances.attr,
> +	&mdev_type_attr_version.attr,
>  	NULL,
>  };
>  
> diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> index cc86bf6566e4..ff15fdfc7d46 100644
> --- a/samples/vfio-mdev/mdpy.c
> +++ b/samples/vfio-mdev/mdpy.c
> @@ -695,11 +695,27 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>  }
>  MDEV_TYPE_ATTR_RO(device_api);
>  
> +static ssize_t version_show(struct kobject *kobj, struct device *dev,
> +		char *buf)
> +{
> +	/* do not support live migration */
> +	return -EINVAL;
> +}
> +
> +static ssize_t version_store(struct kobject *kobj, struct device *dev,
> +		const char *buf, size_t count)
> +{
> +	/* do not support live migration */
> +	return -EINVAL;
> +}
> +static MDEV_TYPE_ATTR_RW(version);
> +
>  static struct attribute *mdev_types_attrs[] = {
>  	&mdev_type_attr_name.attr,
>  	&mdev_type_attr_description.attr,
>  	&mdev_type_attr_device_api.attr,
>  	&mdev_type_attr_available_instances.attr,
> +	&mdev_type_attr_version.attr,
>  	NULL,
>  };
>  
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index 1c77c370c92f..4ae3aad3474d 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -1390,10 +1390,26 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>  
>  MDEV_TYPE_ATTR_RO(device_api);
>  
> +static ssize_t version_show(struct kobject *kobj, struct device *dev,
> +		char *buf)
> +{
> +	/* do not support live migration */
> +	return -EINVAL;
> +}
> +
> +static ssize_t version_store(struct kobject *kobj, struct device *dev,
> +		const char *buf, size_t count)
> +{
> +	/* do not support live migration */
> +	return -EINVAL;
> +}
> +
> +static MDEV_TYPE_ATTR_RW(version);
>  static struct attribute *mdev_types_attrs[] = {
>  	&mdev_type_attr_name.attr,
>  	&mdev_type_attr_device_api.attr,
>  	&mdev_type_attr_available_instances.attr,
> +	&mdev_type_attr_version.attr,
>  	NULL,
>  };
>  


