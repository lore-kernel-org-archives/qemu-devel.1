Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D4C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1A920731
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1A920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNsDa-0008Op-No
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 02:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsCo-0007F3-4q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsCm-00018I-5P
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:04:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:31026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jNsCl-00017p-Pu
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:04:24 -0400
IronPort-SDR: naHrxC+Op19+gNwwN5mUHz8MJfHYT7qeLmyhFjtengSV2VvmFlzUW9MSpOlCEvYTmYam6zIbgx
 yhBpZO2JvrMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 23:04:22 -0700
IronPort-SDR: K3DgIRTWAeIzcfBdfRA7WdCna4AeUWc7sbK1ycZAorzxXybi2+7e6mYPbEqcriVTdUoSj5ET1Y
 RVYy7NTUADQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="245065749"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
 by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2020 23:04:15 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: intel-gvt-dev@lists.freedesktop.org
Subject: [PATCH v5 2/4] drm/i915/gvt: export migration_version to mdev sysfs
 (under mdev_type node)
Date: Mon, 13 Apr 2020 01:54:36 -0400
Message-Id: <20200413055436.27261-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413055201.27053-1-yan.y.zhao@intel.com>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 libvir-list@redhat.com, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, corbet@lwn.net, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 Yan Zhao <yan.y.zhao@intel.com>, xin.zeng@intel.com, dgilbert@redhat.com,
 zhenyuw@linux.intel.com, dinechin@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, berrange@redhat.com, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements the mdev_type part of migration_version attribute
for Intel's vGPU mdev devices.

migration_version attribute under mdev_type node is rw.
It is located at
/sys/class/mdev_bus/0000:00:02.0/mdev_supported_types/$MDEV_TYPE/
or
/sys/devices/pci0000:00/0000:00:02.0/mdev_supported_types/$MDEV_TYPE/

It's used to check migration compatibility for two mdev devices of the
same mdev type.
migration_version string is defined by vendor driver and opaque to
userspace.

For Intel vGPU of gen8 and gen9, the format of migration_version string
is:
  <vendor id>-<device id>-<vgpu type>-<software version>.

For future platforms, the format of migration_version string is to be
expanded to include more meta data to identify Intel vGPUs for live
migration compatibility check

For old platforms, and for GVT not supporting vGPU live migration
feature, -ENODEV is returned on read(2)/write(2) of migration_version
attribute.
For vGPUs running old GVT who do not expose migration_version
attribute, live migration is regarded as not supported for those vGPUs.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
c: Neo Jia <cjia@nvidia.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>

Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

---
v5:
updated commit message to indicate this patch introduces migration_version
attributes under mdev_type sysfs directory

v4:
1. fixed Indentation/spell issues and reworded several error messages
(Cornelia Huck)
2. added kfree(version) in snprintf failure case (Zhenyu Wang)

v3:
1. renamed version to migration_version
(Christophe de Dinechin, Cornelia Huck, Alex Williamson)
2. instead of generating migration version strings each time, storing
them in vgpu types generated during initialization.
(Zhenyu Wang, Cornelia Huck)
3. replaced multiple snprintf to one big snprintf in
intel_gvt_get_vfio_migration_version()
(Dr. David Alan Gilbert)
4. printed detailed error log
(Alex Williamson, Erik Skultety, Cornelia Huck, Dr. David Alan Gilbert)
5. incorporated <software version> into migration_version string
(Alex Williamson)
6. do not use ifndef macro to switch off migration_version attribute
(Zhenyu Wang)

v2:
1. removed 32 common part of version string
(Alex Williamson)
2. do not register version attribute for GVT not supporting live
migration.(Cornelia Huck)
3. for platforms out of gen8, gen9, return -EINVAL --> -ENODEV for
incompatible. (Cornelia Huck)
---
 drivers/gpu/drm/i915/gvt/Makefile            |   2 +-
 drivers/gpu/drm/i915/gvt/gvt.c               |  39 +++++
 drivers/gpu/drm/i915/gvt/gvt.h               |   5 +
 drivers/gpu/drm/i915/gvt/migration_version.c | 170 +++++++++++++++++++
 drivers/gpu/drm/i915/gvt/vgpu.c              |  13 +-
 5 files changed, 226 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/migration_version.c

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index 9c5bc39a2095..11c6aba0bf0a 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -3,7 +3,7 @@ GVT_DIR := gvt
 GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
-	fb_decoder.o dmabuf.o page_track.o migrate.o
+	fb_decoder.o dmabuf.o page_track.o migrate.o migration_version.o
 
 ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index d89dbc29bb96..fb464e3b2a57 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -106,14 +106,53 @@ static ssize_t description_show(struct kobject *kobj, struct device *dev,
 		       type->weight);
 }
 
+static ssize_t migration_version_show(struct kobject *kobj, struct device *dev,
+					char *buf)
+{
+	struct intel_vgpu_type *type;
+	void *gvt = kdev_to_i915(dev)->gvt;
+
+	type = intel_gvt_find_vgpu_type(gvt, kobject_name(kobj));
+	if (!type || !type->migration_version) {
+		gvt_err("Migration not supported on type %s. Please search previous detailed log\n",
+				kobject_name(kobj));
+		return -ENODEV;
+	}
+
+	return snprintf(buf, strlen(type->migration_version) + 2,
+			"%s\n", type->migration_version);
+}
+
+static ssize_t migration_version_store(struct kobject *kobj, struct device *dev,
+					const char *buf, size_t count)
+{
+	int ret = 0;
+	struct intel_vgpu_type *type;
+	void *gvt = kdev_to_i915(dev)->gvt;
+
+	type = intel_gvt_find_vgpu_type(gvt, kobject_name(kobj));
+	if (!type || !type->migration_version) {
+		gvt_err("Migration not supported on type %s. Please search previous detailed log\n",
+				kobject_name(kobj));
+		return -ENODEV;
+	}
+
+	ret = intel_gvt_check_vfio_migration_version(gvt,
+			type->migration_version, buf);
+
+	return (ret < 0 ? ret : count);
+}
+
 static MDEV_TYPE_ATTR_RO(available_instances);
 static MDEV_TYPE_ATTR_RO(device_api);
 static MDEV_TYPE_ATTR_RO(description);
+static MDEV_TYPE_ATTR_RW(migration_version);
 
 static struct attribute *gvt_type_attrs[] = {
 	&mdev_type_attr_available_instances.attr,
 	&mdev_type_attr_device_api.attr,
 	&mdev_type_attr_description.attr,
+	&mdev_type_attr_migration_version.attr,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index c60df1e1d613..b26e42596565 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -277,6 +277,7 @@ struct intel_vgpu_type {
 	unsigned int fence;
 	unsigned int weight;
 	enum intel_vgpu_edid resolution;
+	char *migration_version;
 };
 
 struct intel_gvt {
@@ -709,6 +710,10 @@ int submit_context(struct intel_vgpu *vgpu,
 		struct execlist_ctx_descriptor_format *desc,
 		bool emulate_schedule_in);
 
+ssize_t intel_gvt_check_vfio_migration_version(struct intel_gvt *gvt,
+		const char *self, const char *remote);
+char *intel_gvt_get_vfio_migration_version(struct intel_gvt *gvt,
+		const char *vgpu_type);
 
 #include "trace.h"
 #include "mpt.h"
diff --git a/drivers/gpu/drm/i915/gvt/migration_version.c b/drivers/gpu/drm/i915/gvt/migration_version.c
new file mode 100644
index 000000000000..ded43b7d9e95
--- /dev/null
+++ b/drivers/gpu/drm/i915/gvt/migration_version.c
@@ -0,0 +1,170 @@
+/*
+ * Copyright(c) 2011-2017 Intel Corporation. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Authors:
+ *    Yan Zhao <yan.y.zhao@intel.com>
+ */
+#include <linux/vfio.h>
+#include "i915_drv.h"
+#include "gvt.h"
+
+#define INV_SOFTWARE_VERSION (-1U)
+#define VENDOR_ID_LEN (4)
+#define DEVICE_ID_LEN (4)
+#define VGPU_TYPE_LEN (16)
+#define SOFTWARE_VER_LEN (8)
+
+/* total length of vfio migration version string.
+ * never exceed limit of PATH_MAX (4096)
+ */
+#define MIGRATION_VERSION_TOTAL_LEN (VENDOR_ID_LEN + DEVICE_ID_LEN + \
+					VGPU_TYPE_LEN + SOFTWARE_VER_LEN + 4)
+
+#define GVT_VFIO_MIGRATION_SOFTWARE_VERSION INV_SOFTWARE_VERSION
+
+
+#define PRINTF_FORMAT "%04x-%04x-%s-%08x"
+#define SCANF_FORMAT "%x-%x-%16[^-]-%x"
+
+enum incompatible_reason {
+	IREASON_WRONG_REMOTE_FORMAT = 0,
+	IREASON_HARDWARE_MISMATCH,
+	IREASON_SOFTWARE_VERSION_MISMATCH,
+	IREASON_VGPU_TYPE_MISMATCH,
+};
+
+static const char *const incompatible_reason_str[] = {
+	[IREASON_WRONG_REMOTE_FORMAT] =
+		"wrong string format. probably wrong GVT version",
+	[IREASON_HARDWARE_MISMATCH] =
+		"physical device not matched",
+	[IREASON_SOFTWARE_VERSION_MISMATCH] =
+		"migration software version not matched",
+	[IREASON_VGPU_TYPE_MISMATCH] =
+		"vgpu type not matched"
+};
+
+static bool is_compatible(const char *local, const char *remote)
+{
+	bool ret;
+
+	ret = sysfs_streq(local, remote);
+
+	if (!ret) {
+		int vid_l = 0, did_l = 0, vid_r = 0, did_r = 0;
+		char type_l[VGPU_TYPE_LEN], type_r[VGPU_TYPE_LEN];
+		u32 sv_l = 0, sv_r = 0;
+		int rl = 0, rr = 0;
+		enum incompatible_reason reason = IREASON_WRONG_REMOTE_FORMAT;
+
+		memset(type_l, 0, sizeof(type_l));
+		memset(type_r, 0, sizeof(type_r));
+
+		rl = sscanf(local, SCANF_FORMAT,
+				&vid_l, &did_l, type_l, &sv_l);
+		rr = sscanf(remote, SCANF_FORMAT,
+				&vid_r, &did_r, type_r, &sv_r);
+
+		if (rl == rr) {
+			if (vid_l != vid_r || did_l != did_r)
+				reason = IREASON_HARDWARE_MISMATCH;
+			else if (sv_l != sv_r)
+				reason = IREASON_SOFTWARE_VERSION_MISMATCH;
+			else if (strncmp(type_l, type_r, VGPU_TYPE_LEN))
+				reason = IREASON_VGPU_TYPE_MISMATCH;
+		}
+
+		gvt_err("Migration version mismatched. Possible reason: %s. Local migration version:%s, Remote migration version:%s\n",
+				incompatible_reason_str[reason], local,	remote);
+
+	}
+	return ret;
+
+}
+
+
+char *
+intel_gvt_get_vfio_migration_version(struct intel_gvt *gvt,
+		const char *vgpu_type)
+{
+	int cnt = 0;
+	struct drm_i915_private *dev_priv = gvt->gt->i915;
+	char *version = NULL;
+
+	/* currently only gen8 & gen9 are supported */
+	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9)) {
+		gvt_err("Local hardware does not support migration on %d\n",
+				INTEL_INFO(dev_priv)->gen);
+		return NULL;
+	}
+
+	if (GVT_VFIO_MIGRATION_SOFTWARE_VERSION == INV_SOFTWARE_VERSION) {
+		gvt_err("Local GVT does not support migration\n");
+		return NULL;
+	}
+
+	version = kzalloc(MIGRATION_VERSION_TOTAL_LEN, GFP_KERNEL);
+
+	if (unlikely(!version)) {
+		gvt_err("cannot allocate memory for local migration version %s\n",
+				vgpu_type);
+		return NULL;
+	}
+
+	/* vendor id + device id + vgpu type + software version */
+	cnt = snprintf(version, MIGRATION_VERSION_TOTAL_LEN, PRINTF_FORMAT,
+			PCI_VENDOR_ID_INTEL,
+			INTEL_DEVID(dev_priv),
+			vgpu_type,
+			GVT_VFIO_MIGRATION_SOFTWARE_VERSION);
+
+	if (cnt)
+		return version;
+
+	gvt_err("cannot generate local migration version for type %s\n",
+			vgpu_type);
+	kfree(version);
+	return NULL;
+}
+
+ssize_t intel_gvt_check_vfio_migration_version(struct intel_gvt *gvt,
+		const char *self, const char *remote)
+{
+	struct drm_i915_private *dev_priv = gvt->gt->i915;
+
+	/* currently only gen8 & gen9 are supported */
+	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9)) {
+		gvt_err("Local hardware does not support migration on %d\n",
+				INTEL_INFO(dev_priv)->gen);
+		return -ENODEV;
+	}
+
+	if (GVT_VFIO_MIGRATION_SOFTWARE_VERSION == INV_SOFTWARE_VERSION) {
+		gvt_err("Local GVT does not support migration\n");
+		return -ENODEV;
+	}
+
+	if (!is_compatible(self, remote))
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 72d22d97bc37..38b2575b39b7 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -155,13 +155,18 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 			sprintf(gvt->types[i].name, "GVTg_V5_%s",
 				vgpu_types[i].name);
 
-		gvt_dbg_core("type[%d]: %s avail %u low %u high %u fence %u weight %u res %s\n",
+		gvt->types[i].migration_version =
+			intel_gvt_get_vfio_migration_version(gvt,
+					gvt->types[i].name);
+		gvt_dbg_core("type[%d]: %s avail %u low %u high %u fence %u weight %u res %s, migratio_version:%s\n",
 			     i, gvt->types[i].name,
 			     gvt->types[i].avail_instance,
 			     gvt->types[i].low_gm_size,
 			     gvt->types[i].high_gm_size, gvt->types[i].fence,
 			     gvt->types[i].weight,
-			     vgpu_edid_str(gvt->types[i].resolution));
+			     vgpu_edid_str(gvt->types[i].resolution),
+			     (gvt->types[i].migration_version ?
+			     gvt->types[i].migration_version : "null"));
 	}
 
 	gvt->num_types = i;
@@ -170,6 +175,10 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 
 void intel_gvt_clean_vgpu_types(struct intel_gvt *gvt)
 {
+	int i;
+
+	for (i = 0; i < gvt->num_types; i++)
+		kfree(gvt->types[i].migration_version);
 	kfree(gvt->types);
 }
 
-- 
2.17.1


