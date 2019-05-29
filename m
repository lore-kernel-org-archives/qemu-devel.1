Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D08CC04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78FA2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78FA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVmdT-0002Bp-2m
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 20:40:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hVmcg-0001n1-R9
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hVmcf-0003GU-4k
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:39:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:53739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hVmce-0003B3-8u
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:39:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 May 2019 17:39:12 -0700
X-ExtLoop1: 1
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
	([10.239.13.9])
	by fmsmga004.fm.intel.com with ESMTP; 28 May 2019 17:39:07 -0700
Date: Tue, 28 May 2019 20:33:23 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190529003323.GH27438@joy-OptiPlex-7040>
References: <20190527034155.31473-1-yan.y.zhao@intel.com>
	<20190527034437.31594-1-yan.y.zhao@intel.com>
	<20190528110135.222aa24e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528110135.222aa24e.cohuck@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH v3 2/2] drm/i915/gvt: export
 migration_version to mdev sysfs for Intel vGPU
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
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 05:01:35PM +0800, Cornelia Huck wrote:
> On Sun, 26 May 2019 23:44:37 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > This feature implements the migration_version attribute for Intel's vGPU
> > mdev devices.
> > 
> > migration_version attribute is rw.
> > It's used to check migration compatibility for two mdev devices of the
> > same mdev type.
> > migration_version string is defined by vendor driver and opaque to
> > userspace.
> > 
> > For Intel vGPU of gen8 and gen9, the format of migration_version string
> > is:
> >   <vendor id>-<device id>-<vgpu type>-<software version>.
> > 
> > For future platforms, the format of migration_version string is to be
> > expanded to include more meta data to identify Intel vGPUs for live
> > migration compatibility check
> > 
> > For old platforms, and for GVT not supporting vGPU live migration
> > feature, -ENODEV is returned on read(2)/write(2) of migration_version
> > attribute.
> > For vGPUs running old GVT who do not expose migration_version
> > attribute, live migration is regarded as not supported for those vGPUs.
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
> > 
> > ---
> > v3:
> > 1. renamed version to migration_version
> > (Christophe de Dinechin, Cornelia Huck, Alex Williamson)
> > 2. instead of generating migration version strings each time, storing
> > them in vgpu types generated during initialization.
> > (Zhenyu Wang, Cornelia Huck)
> > 3. replaced multiple snprintf to one big snprintf in
> > intel_gvt_get_vfio_migration_version()
> > (Dr. David Alan Gilbert)
> > 4. printed detailed error log
> > (Alex Williamson, Erik Skultety, Cornelia Huck, Dr. David Alan Gilbert)
> > 5. incorporated <software version> into migration_version string
> > (Alex Williamson)
> > 6. do not use ifndef macro to switch off migration_version attribute
> > (Zhenyu Wang)
> > 
> > v2:
> > 1. removed 32 common part of version string
> > (Alex Williamson)
> > 2. do not register version attribute for GVT not supporting live
> > migration.(Cornelia Huck)
> > 3. for platforms out of gen8, gen9, return -EINVAL --> -ENODEV for
> > incompatible. (Cornelia Huck)
> > ---
> >  drivers/gpu/drm/i915/gvt/Makefile            |   2 +-
> >  drivers/gpu/drm/i915/gvt/gvt.c               |  39 +++++
> >  drivers/gpu/drm/i915/gvt/gvt.h               |   5 +
> >  drivers/gpu/drm/i915/gvt/migration_version.c | 167 +++++++++++++++++++
> >  drivers/gpu/drm/i915/gvt/vgpu.c              |  13 +-
> >  5 files changed, 223 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/gpu/drm/i915/gvt/migration_version.c
> > 
> 
> (...)
> 
> > diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
> > index 43f4242062dd..be2980e8ac75 100644
> > --- a/drivers/gpu/drm/i915/gvt/gvt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> > @@ -105,14 +105,53 @@ static ssize_t description_show(struct kobject *kobj, struct device *dev,
> >  		       type->weight);
> >  }
> >  
> > +static ssize_t migration_version_show(struct kobject *kobj, struct device *dev,
> > +		char *buf)
> 
> Indentation looks a bit odd? (Also below.)
>
yes. Let me correct it in next revision.

> > +{
> > +	struct intel_vgpu_type *type;
> > +	void *gvt = kdev_to_i915(dev)->gvt;
> > +
> > +	type = intel_gvt_find_vgpu_type(gvt, kobject_name(kobj));
> > +	if (!type || !type->migration_version) {
> > +		gvt_err("Does not support migraion on type %s. Please search previous detailed log\n",
> 
> s/migraion/migration/ (also below)
>
Sorry for typos again. I'll be more careful next time. thank you:)

> Or reword to "Migration not supported on type %s."?
>
Yes, better :)

> > +				kobject_name(kobj));
> > +		return -ENODEV;
> > +	}
> > +
> > +	return snprintf(buf, strlen(type->migration_version) + 2,
> > +			"%s\n", type->migration_version);
> > +}
> > +
> > +static ssize_t migration_version_store(struct kobject *kobj, struct device *dev,
> > +		const char *buf, size_t count)
> > +{
> > +	int ret = 0;
> > +	struct intel_vgpu_type *type;
> > +	void *gvt = kdev_to_i915(dev)->gvt;
> > +
> > +	type = intel_gvt_find_vgpu_type(gvt, kobject_name(kobj));
> > +	if (!type || !type->migration_version) {
> > +		gvt_err("Does not support migraion on type %s. Please search previous detailed log\n",
> > +				kobject_name(kobj));
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = intel_gvt_check_vfio_migration_version(gvt,
> > +			type->migration_version, buf);
> > +
> > +	return (ret < 0 ? ret : count);
> > +}
> > +
> >  static MDEV_TYPE_ATTR_RO(available_instances);
> >  static MDEV_TYPE_ATTR_RO(device_api);
> >  static MDEV_TYPE_ATTR_RO(description);
> > +static MDEV_TYPE_ATTR_RW(migration_version);
> >  
> >  static struct attribute *gvt_type_attrs[] = {
> >  	&mdev_type_attr_available_instances.attr,
> >  	&mdev_type_attr_device_api.attr,
> >  	&mdev_type_attr_description.attr,
> > +	&mdev_type_attr_migration_version.attr,
> >  	NULL,
> >  };
> 
> (...)
> 
> > +char *
> > +intel_gvt_get_vfio_migration_version(struct intel_gvt *gvt,
> > +		const char *vgpu_type)
> > +{
> > +	int cnt = 0;
> > +	struct drm_i915_private *dev_priv = gvt->dev_priv;
> > +	char *version = NULL;
> > +
> > +	/* currently only gen8 & gen9 are supported */
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9)) {
> > +		gvt_err("Local hardware does not support migration on %d\n",
> > +				INTEL_INFO(dev_priv)->gen);
> > +		return NULL;
> > +	}
> > +
> > +	if (GVT_VFIO_MIGRATION_SOFTWARE_VERSION == INV_SOFTWARE_VERSION) {
> > +		gvt_err("Local GVT does not support migration\n");
> > +		return NULL;
> > +	}
> > +
> > +	version = kzalloc(MIGRATION_VERSION_TOTAL_LEN, GFP_KERNEL);
> > +
> > +	if (unlikely(!version)) {
> > +		gvt_err("memory allocation failed when get local migraiton version\n");
> 
> s/migraiton/migration/
> 
> Or "cannot allocate memory for local migration version"?
>
Ok.

> > +		return NULL;
> > +	}
> > +
> > +	/* vendor id + device id + vgpu type + software version */
> > +	cnt = snprintf(version, MIGRATION_VERSION_TOTAL_LEN, PRINTF_FORMAT,
> > +			PCI_VENDOR_ID_INTEL,
> > +			INTEL_DEVID(dev_priv),
> > +			vgpu_type,
> > +			GVT_VFIO_MIGRATION_SOFTWARE_VERSION);
> > +
> > +	if (cnt)
> > +		return version;
> > +
> > +	gvt_err("string generation failed when get local migration version\n");
> > +	return NULL;
> > +}
> 
> (...)
> 
> Only some nitpicks from me, but I'm not really familiar with this
> driver. Overall, this looks sane to me, so have an
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>


Thank you so much Cornelia :)



______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

