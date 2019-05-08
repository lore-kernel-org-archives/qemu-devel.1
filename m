Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA827C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD98621019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD98621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36135 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLWE-0002m6-Sy
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:17:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hOLUd-0000kT-Q9
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hOLUb-0007BZ-Tg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:16:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:55430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hOLUb-0007B3-L5
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:16:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 May 2019 05:16:12 -0700
X-ExtLoop1: 1
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
	([10.239.13.9])
	by fmsmga004.fm.intel.com with ESMTP; 08 May 2019 05:16:07 -0700
Date: Wed, 8 May 2019 08:10:30 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190508121030.GD24397@joy-OptiPlex-7040>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506015102.3691-1-yan.y.zhao@intel.com>
	<20190508105032.GE2718@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508105032.GE2718@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH v2 2/2] drm/i915/gvt: export mdev device
 version to sysfs for Intel vGPU
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
	"shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
	Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 06:50:33PM +0800, Dr. David Alan Gilbert wrote:
> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > This feature implements the version attribute for Intel's vGPU mdev
> > devices.
> > 
> > version attribute is rw.
> > It's used to check device compatibility for two mdev devices.
> > version string format and length are private for vendor driver. vendor
> > driver is able to define them freely.
> > 
> > For Intel vGPU of gen8 and gen9, the mdev device version
> > consists of 3 fields: "vendor id" + "device id" + "mdev type".
> > 
> > Reading from a vGPU's version attribute, a string is returned in below
> > format: <vendor id>-<device id>-<mdev type>. e.g.
> > 8086-193b-i915-GVTg_V5_2.
> > 
> > Writing a string to a vGPU's version attribute will trigger GVT to check
> > whether a vGPU identified by the written string is compatible with
> > current vGPU owning this version attribute. errno is returned if the two
> > vGPUs are incompatible. The length of written string is returned in
> > compatible case.
> > 
> > For other platforms, and for GVT not supporting vGPU live migration
> > feature, errnos are returned when read/write of mdev devices' version
> > attributes.
> > 
> > For old GVT versions where no version attributes exposed in sysfs, it is
> > regarded as not supporting vGPU live migration.
> > 
> > For future platforms, besides the current 2 fields in vendor proprietary
> > part, more fields may be added to identify Intel vGPU well for live
> > migration purpose.
> > 
> > v2:
> > 1. removed 32 common part of version string
> > (Alex Williamson)
> > 2. do not register version attribute for GVT not supporting live
> > migration.(Cornelia Huck)
> > 3. for platforms out of gen8, gen9, return -EINVAL --> -ENODEV for
> > incompatible. (Cornelia Huck)
> > 
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Erik Skultety <eskultet@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: "Tian, Kevin" <kevin.tian@intel.com>
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> > c: Neo Jia <cjia@nvidia.com>
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/Makefile         |  2 +-
> >  drivers/gpu/drm/i915/gvt/device_version.c | 87 +++++++++++++++++++++++
> >  drivers/gpu/drm/i915/gvt/gvt.c            | 51 +++++++++++++
> >  drivers/gpu/drm/i915/gvt/gvt.h            |  6 ++
> >  4 files changed, 145 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/i915/gvt/device_version.c
> > 
> > diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> > index 271fb46d4dd0..54e209a23899 100644
> > --- a/drivers/gpu/drm/i915/gvt/Makefile
> > +++ b/drivers/gpu/drm/i915/gvt/Makefile
> > @@ -3,7 +3,7 @@ GVT_DIR := gvt
> >  GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
> >  	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
> >  	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
> > -	fb_decoder.o dmabuf.o page_track.o
> > +	fb_decoder.o dmabuf.o page_track.o device_version.o
> >  
> >  ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
> >  i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> > diff --git a/drivers/gpu/drm/i915/gvt/device_version.c b/drivers/gpu/drm/i915/gvt/device_version.c
> > new file mode 100644
> > index 000000000000..bd4cdcbdba95
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/gvt/device_version.c
> > @@ -0,0 +1,87 @@
> > +/*
> > + * Copyright(c) 2011-2017 Intel Corporation. All rights reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice (including the next
> > + * paragraph) shall be included in all copies or substantial portions of the
> > + * Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> > + * SOFTWARE.
> > + *
> > + * Authors:
> > + *    Yan Zhao <yan.y.zhao@intel.com>
> > + */
> > +#include <linux/vfio.h>
> > +#include "i915_drv.h"
> > +
> > +static bool is_compatible(const char *self, const char *remote)
> > +{
> > +	if (strlen(remote) != strlen(self))
> > +		return false;
> > +
> > +	return (strncmp(self, remote, strlen(self))) ? false : true;
> > +}
> > +
> > +ssize_t intel_gvt_get_vfio_device_version_len(struct drm_i915_private *dev_priv)
> > +{
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> > +		return -ENODEV;
> > +
> > +	return PAGE_SIZE;
> > +}
> > +
> > +ssize_t intel_gvt_get_vfio_device_version(struct drm_i915_private *dev_priv,
> > +		char *buf, const char *mdev_type)
> > +{
> > +	int cnt = 0, ret = 0;
> > +	const char *str = NULL;
> > +
> > +	/* currently only gen8 & gen9 are supported */
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> > +		return -ENODEV;
> > +
> > +	/* vendor id + device id + mdev type */
> > +	/* vendor id */
> > +	cnt = snprintf(buf, 5, "%04x", PCI_VENDOR_ID_INTEL);
> > +	buf += cnt;
> > +	ret += cnt;
> > +
> > +	/* device id */
> > +	cnt = snprintf(buf, 6, "-%04x", INTEL_DEVID(dev_priv));
> > +	buf += cnt;
> > +	ret += cnt;
> > +
> > +	/* mdev type */
> > +	str = mdev_type;
> > +	cnt = snprintf(buf, strlen(str) + 3, "-%s\n", mdev_type);
> > +	buf += cnt;
> > +	ret += cnt;
> 
> Why not just one big snprintf?
> 
> Dave

oh, right:)
I'll use one big snprintf in next revision. thank you:)

> 
> > +	return ret;
> > +}
> > +
> > +ssize_t intel_gvt_check_vfio_device_version(struct drm_i915_private *dev_priv,
> > +		const char *self, const char *remote)
> > +{
> > +
> > +	/* currently only gen8 & gen9 are supported */
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> > +		return -ENODEV;
> > +
> > +	if (!is_compatible(self, remote))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
> > index 43f4242062dd..19f16eec5a4c 100644
> > --- a/drivers/gpu/drm/i915/gvt/gvt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> > @@ -105,14 +105,65 @@ static ssize_t description_show(struct kobject *kobj, struct device *dev,
> >  		       type->weight);
> >  }
> >  
> > +#ifdef GVT_MIGRATION_VERSION
> > +static ssize_t version_show(struct kobject *kobj, struct device *dev,
> > +		char *buf)
> > +{
> > +	struct drm_i915_private *i915 = kdev_to_i915(dev);
> > +	const char *mdev_type = kobject_name(kobj);
> > +
> > +	return intel_gvt_get_vfio_device_version(i915, buf, mdev_type);
> > +}
> > +
> > +static ssize_t version_store(struct kobject *kobj, struct device *dev,
> > +		const char *buf, size_t count)
> > +{
> > +	char *remote = NULL, *self = NULL;
> > +	int len, ret = 0;
> > +	struct drm_i915_private *i915 = kdev_to_i915(dev);
> > +	const char *mdev_type = kobject_name(kobj);
> > +
> > +	len = intel_gvt_get_vfio_device_version_len(i915);
> > +	if (len < 0)
> > +		return len;
> > +
> > +	self = kmalloc(len, GFP_KERNEL);
> > +	if (!self)
> > +		return -ENOMEM;
> > +
> > +	ret = intel_gvt_get_vfio_device_version(i915, self, mdev_type);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	remote = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!remote) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	ret = intel_gvt_check_vfio_device_version(i915, self, remote);
> > +
> > +out:
> > +	kfree(self);
> > +	kfree(remote);
> > +	return (ret < 0 ? ret : count);
> > +}
> > +#endif
> > +
> >  static MDEV_TYPE_ATTR_RO(available_instances);
> >  static MDEV_TYPE_ATTR_RO(device_api);
> >  static MDEV_TYPE_ATTR_RO(description);
> > +#ifdef GVT_MIGRATION_VERSION
> > +static MDEV_TYPE_ATTR_RW(version);
> > +#endif
> >  
> >  static struct attribute *gvt_type_attrs[] = {
> >  	&mdev_type_attr_available_instances.attr,
> >  	&mdev_type_attr_device_api.attr,
> >  	&mdev_type_attr_description.attr,
> > +#ifdef GVT_MIGRATION_VERSION
> > +	&mdev_type_attr_version.attr,
> > +#endif
> >  	NULL,
> >  };
> >  
> > diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
> > index f5a328b5290a..4062f6b26acf 100644
> > --- a/drivers/gpu/drm/i915/gvt/gvt.h
> > +++ b/drivers/gpu/drm/i915/gvt/gvt.h
> > @@ -687,6 +687,12 @@ void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
> >  int intel_gvt_debugfs_init(struct intel_gvt *gvt);
> >  void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
> >  
> > +ssize_t intel_gvt_get_vfio_device_version(struct drm_i915_private *i915,
> > +		char *buf, const char *mdev_type);
> > +ssize_t intel_gvt_check_vfio_device_version(struct drm_i915_private *dev_priv,
> > +		const char *self, const char *remote);
> > +ssize_t
> > +intel_gvt_get_vfio_device_version_len(struct drm_i915_private *dev_priv);
> >  
> >  #include "trace.h"
> >  #include "mpt.h"
> > -- 
> > 2.17.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

