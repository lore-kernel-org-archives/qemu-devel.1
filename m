Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D5C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600A5214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600A5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwQF-0007tI-Fn
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:30:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNwOS-0006gs-LU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNwOR-0004JE-6Q
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hNwOQ-0004Ie-Uz
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:28:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09086C057F32;
	Tue,  7 May 2019 09:28:10 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4E651001DDE;
	Tue,  7 May 2019 09:27:55 +0000 (UTC)
Date: Tue, 7 May 2019 11:27:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190507112753.2699d0b5.cohuck@redhat.com>
In-Reply-To: <20190506015102.3691-1-yan.y.zhao@intel.com>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506015102.3691-1-yan.y.zhao@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 07 May 2019 09:28:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On Sun,  5 May 2019 21:51:02 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> This feature implements the version attribute for Intel's vGPU mdev
> devices.
> 
> version attribute is rw.
> It's used to check device compatibility for two mdev devices.
> version string format and length are private for vendor driver. vendor
> driver is able to define them freely.
> 
> For Intel vGPU of gen8 and gen9, the mdev device version
> consists of 3 fields: "vendor id" + "device id" + "mdev type".
> 
> Reading from a vGPU's version attribute, a string is returned in below
> format: <vendor id>-<device id>-<mdev type>. e.g.
> 8086-193b-i915-GVTg_V5_2.
> 
> Writing a string to a vGPU's version attribute will trigger GVT to check
> whether a vGPU identified by the written string is compatible with
> current vGPU owning this version attribute. errno is returned if the two
> vGPUs are incompatible. The length of written string is returned in
> compatible case.
> 
> For other platforms, and for GVT not supporting vGPU live migration
> feature, errnos are returned when read/write of mdev devices' version
> attributes.
> 
> For old GVT versions where no version attributes exposed in sysfs, it is
> regarded as not supporting vGPU live migration.
> 
> For future platforms, besides the current 2 fields in vendor proprietary
> part, more fields may be added to identify Intel vGPU well for live
> migration purpose.
> 
> v2:
> 1. removed 32 common part of version string
> (Alex Williamson)
> 2. do not register version attribute for GVT not supporting live
> migration.(Cornelia Huck)
> 3. for platforms out of gen8, gen9, return -EINVAL --> -ENODEV for
> incompatible. (Cornelia Huck)

Should go below '---'.

> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> c: Neo Jia <cjia@nvidia.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  drivers/gpu/drm/i915/gvt/Makefile         |  2 +-
>  drivers/gpu/drm/i915/gvt/device_version.c | 87 +++++++++++++++++++++++
>  drivers/gpu/drm/i915/gvt/gvt.c            | 51 +++++++++++++
>  drivers/gpu/drm/i915/gvt/gvt.h            |  6 ++
>  4 files changed, 145 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/i915/gvt/device_version.c
> 

(...)

> diff --git a/drivers/gpu/drm/i915/gvt/device_version.c b/drivers/gpu/drm/i915/gvt/device_version.c
> new file mode 100644
> index 000000000000..bd4cdcbdba95
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gvt/device_version.c
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright(c) 2011-2017 Intel Corporation. All rights reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the next
> + * paragraph) shall be included in all copies or substantial portions of the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Authors:
> + *    Yan Zhao <yan.y.zhao@intel.com>
> + */
> +#include <linux/vfio.h>
> +#include "i915_drv.h"
> +
> +static bool is_compatible(const char *self, const char *remote)
> +{
> +	if (strlen(remote) != strlen(self))
> +		return false;
> +
> +	return (strncmp(self, remote, strlen(self))) ? false : true;
> +}
> +
> +ssize_t intel_gvt_get_vfio_device_version_len(struct drm_i915_private *dev_priv)
> +{
> +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> +		return -ENODEV;
> +
> +	return PAGE_SIZE;
> +}
> +
> +ssize_t intel_gvt_get_vfio_device_version(struct drm_i915_private *dev_priv,
> +		char *buf, const char *mdev_type)
> +{
> +	int cnt = 0, ret = 0;
> +	const char *str = NULL;
> +
> +	/* currently only gen8 & gen9 are supported */
> +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> +		return -ENODEV;
> +
> +	/* vendor id + device id + mdev type */
> +	/* vendor id */
> +	cnt = snprintf(buf, 5, "%04x", PCI_VENDOR_ID_INTEL);
> +	buf += cnt;
> +	ret += cnt;
> +
> +	/* device id */
> +	cnt = snprintf(buf, 6, "-%04x", INTEL_DEVID(dev_priv));
> +	buf += cnt;
> +	ret += cnt;
> +
> +	/* mdev type */
> +	str = mdev_type;
> +	cnt = snprintf(buf, strlen(str) + 3, "-%s\n", mdev_type);
> +	buf += cnt;
> +	ret += cnt;
> +
> +	return ret;

I'm not familiar with this driver; but would it make sense to pre-build
the version on init? It does not look to me like the values could
change dynamically.

> +}
> +
> +ssize_t intel_gvt_check_vfio_device_version(struct drm_i915_private *dev_priv,
> +		const char *self, const char *remote)
> +{
> +
> +	/* currently only gen8 & gen9 are supported */
> +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> +		return -ENODEV;
> +
> +	if (!is_compatible(self, remote))
> +		return -EINVAL;
> +
> +	return 0;
> +}

Return values look reasonable to me. I'll leave discussions regarding
where the attribute should go to folks familiar with this driver.

