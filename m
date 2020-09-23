Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D89C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33D5214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33D5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3Do-0006PD-T2
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhi.a.wang@intel.com>)
 id 1kL3Aq-00033I-Hg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:43:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:6617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhi.a.wang@intel.com>)
 id 1kL3An-0007Qq-4s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:43:00 -0400
IronPort-SDR: Zc4apLHxEFCu78rQ8HlCw+JMkx/atTyxaJehQ2OchCGQ3VWAfWiDj7onLXjXkJ/Kewp73PAzlk
 nk3OKiykFWgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="160940404"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="160940404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 04:42:53 -0700
IronPort-SDR: /T9yCkQOg5i70cPJz/oeQQpN16mCbWcO3lEohLIwb4djmYybMxZUsgzHjHYtnCSiNtGBlF6oyG
 lltdoZzjvPMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="510960594"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2020 04:42:53 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 04:42:52 -0700
Received: from irsmsx606.ger.corp.intel.com (163.33.146.139) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 19:42:49 +0800
Received: from irsmsx606.ger.corp.intel.com ([163.33.146.139]) by
 IRSMSX606.ger.corp.intel.com ([163.33.146.139]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 12:42:47 +0100
From: "Wang, Zhi A" <zhi.a.wang@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>
Subject: RE: [PATCH v26 08/17] vfio: Add save state functions to SaveVMHandlers
Thread-Topic: [PATCH v26 08/17] vfio: Add save state functions to
 SaveVMHandlers
Thread-Index: AQHWkTw5lj/xtNYyRk6KT9tsRipZqql2AqCw
Date: Wed, 23 Sep 2020 11:42:47 +0000
Message-ID: <e0000720693f401d83159047101efcb4@intel.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-9-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1600817059-26721-9-git-send-email-kwankhede@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.65; envelope-from=zhi.a.wang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 07:42:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zhao, 
 Yan Y" <yan.y.zhao@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I met a problem when trying this patch. Mostly the problem happens if a dev=
ice doesn't set any pending bytes in the iteration stage, which shows this =
device doesn't have a stage of iteration. The QEMU in the destination machi=
ne will complain out-of-memory. After some investigation, it seems the vend=
or-specific bit stream is not complete and the QEMU in the destination mach=
ine will wrongly take a signature as the size of the section and failed to =
allocate the memory. Not sure if others meet the same problem.

I solved this problem by the following fix and the qemu version I am using =
is v5.0.0.0.

commit 13a80adc2cdddd48d76acf6a5dd715bcbf42b577
Author: Zhi Wang <zhi.wang.linux@gmail.com>
Date:   Tue Sep 15 15:58:45 2020 +0300

    fix
   =20
    Signed-off-by: Zhi Wang <zhi.wang.linux@gmail.com>

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 09eec9c..e741319 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -453,10 +458,12 @@ static int vfio_save_iterate(QEMUFile *f, void *opaqu=
e)
             return ret;
         }
=20
-        if (migration->pending_bytes =3D=3D 0) {
-            /* indicates data finished, goto complete phase */
-            return 1;
-        }
+	if (migration->pending_bytes =3D=3D 0) {
+		/* indicates data finished, goto complete phase */
+		qemu_put_be64(f, 0);
+		qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+		return 1;
+	}
     }
=20
     data_size =3D vfio_save_buffer(f, vbasedev);=20

-----Original Message-----
From: Kirti Wankhede <kwankhede@nvidia.com>=20
Sent: Wednesday, September 23, 2020 2:24 AM
To: alex.williamson@redhat.com; cjia@nvidia.com
Cc: Tian, Kevin <kevin.tian@intel.com>; Yang, Ziye <ziye.yang@intel.com>; L=
iu, Changpeng <changpeng.liu@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; ml=
evitsk@redhat.com; eskultet@redhat.com; cohuck@redhat.com; dgilbert@redhat.=
com; jonathan.davies@nutanix.com; eauger@redhat.com; aik@ozlabs.ru; pasic@l=
inux.ibm.com; felipe@nutanix.com; Zhengxiao.zx@Alibaba-inc.com; shuangtai.t=
st@alibaba-inc.com; Ken.Xue@amd.com; Wang, Zhi A <zhi.a.wang@intel.com>; Zh=
ao, Yan Y <yan.y.zhao@intel.com>; pbonzini@redhat.com; quintela@redhat.com;=
 eblake@redhat.com; armbru@redhat.com; peterx@redhat.com; qemu-devel@nongnu=
.org; Kirti Wankhede <kwankhede@nvidia.com>
Subject: [PATCH v26 08/17] vfio: Add save state functions to SaveVMHandlers

Added .save_live_pending, .save_live_iterate and .save_live_complete_precop=
y functions. These functions handles pre-copy and stop-and-copy phase.

In _SAVING|_RUNNING device state or pre-copy phase:
- read pending_bytes. If pending_bytes > 0, go through below steps.
- read data_offset - indicates kernel driver to write data to staging
  buffer.
- read data_size - amount of data in bytes written by vendor driver in
  migration region.
- read data_size bytes of data from data_offset in the migration region.
- Write data packet to file stream as below:
{VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data, VFIO_MIG_FLAG_END_OF=
_STATE }

In _SAVING device state or stop-and-copy phase a. read config space of devi=
ce and save to migration file stream. This
   doesn't need to be from vendor driver. Any other special config state
   from driver can be saved as data in following iteration.
b. read pending_bytes. If pending_bytes > 0, go through below steps.
c. read data_offset - indicates kernel driver to write data to staging
   buffer.
d. read data_size - amount of data in bytes written by vendor driver in
   migration region.
e. read data_size bytes of data from data_offset in the migration region.
f. Write data packet as below:
   {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data} g. iterate throug=
h steps b to f while (pending_bytes > 0) h. Write {VFIO_MIG_FLAG_END_OF_STA=
TE}

When data region is mapped, its user's responsibility to read data from dat=
a_offset of data_size before moving to next steps.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c           | 273 ++++++++++++++++++++++++++++++++++++++=
++++
 hw/vfio/trace-events          |   6 +
 include/hw/vfio/vfio-common.h |   1 +
 3 files changed, 280 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c index 8e8adaa25779..=
4611bb972228 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -180,6 +180,154 @@ static int vfio_migration_set_state(VFIODevice *vbase=
dev, uint32_t mask,
     return 0;
 }
=20
+static void *get_data_section_size(VFIORegion *region, uint64_t data_offse=
t,
+                                   uint64_t data_size, uint64_t *size)=20
+{
+    void *ptr =3D NULL;
+    uint64_t limit =3D 0;
+    int i;
+
+    if (!region->mmaps) {
+        if (size) {
+            *size =3D data_size;
+        }
+        return ptr;
+    }
+
+    for (i =3D 0; i < region->nr_mmaps; i++) {
+        VFIOMmap *map =3D region->mmaps + i;
+
+        if ((data_offset >=3D map->offset) &&
+            (data_offset < map->offset + map->size)) {
+
+            /* check if data_offset is within sparse mmap areas */
+            ptr =3D map->mmap + data_offset - map->offset;
+            if (size) {
+                *size =3D MIN(data_size, map->offset + map->size - data_of=
fset);
+            }
+            break;
+        } else if ((data_offset < map->offset) &&
+                   (!limit || limit > map->offset)) {
+            /*
+             * data_offset is not within sparse mmap areas, find size of
+             * non-mapped area. Check through all list since region->mmaps=
 list
+             * is not sorted.
+             */
+            limit =3D map->offset;
+        }
+    }
+
+    if (!ptr && size) {
+        *size =3D limit ? limit - data_offset : data_size;
+    }
+    return ptr;
+}
+
+static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t=20
+*size) {
+    VFIOMigration *migration =3D vbasedev->migration;
+    VFIORegion *region =3D &migration->region;
+    uint64_t data_offset =3D 0, data_size =3D 0, sz;
+    int ret;
+
+    ret =3D vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
+                region->fd_offset + offsetof(struct vfio_device_migration_=
info,
+                                             data_offset));
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D vfio_mig_read(vbasedev, &data_size, sizeof(data_size),
+                region->fd_offset + offsetof(struct vfio_device_migration_=
info,
+                                             data_size));
+    if (ret < 0) {
+        return ret;
+    }
+
+    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
+                           migration->pending_bytes);
+
+    qemu_put_be64(f, data_size);
+    sz =3D data_size;
+
+    while (sz) {
+        void *buf =3D NULL;
+        uint64_t sec_size;
+        bool buf_allocated =3D false;
+
+        buf =3D get_data_section_size(region, data_offset, sz,=20
+ &sec_size);
+
+        if (!buf) {
+            buf =3D g_try_malloc(sec_size);
+            if (!buf) {
+                error_report("%s: Error allocating buffer ", __func__);
+                return -ENOMEM;
+            }
+            buf_allocated =3D true;
+
+            ret =3D vfio_mig_read(vbasedev, buf, sec_size,
+                                region->fd_offset + data_offset);
+            if (ret < 0) {
+                g_free(buf);
+                return ret;
+            }
+        }
+
+        qemu_put_buffer(f, buf, sec_size);
+
+        if (buf_allocated) {
+            g_free(buf);
+        }
+        sz -=3D sec_size;
+        data_offset +=3D sec_size;
+    }
+
+    ret =3D qemu_file_get_error(f);
+
+    if (!ret && size) {
+        *size =3D data_size;
+    }
+
+    return ret;
+}
+
+static int vfio_update_pending(VFIODevice *vbasedev) {
+    VFIOMigration *migration =3D vbasedev->migration;
+    VFIORegion *region =3D &migration->region;
+    uint64_t pending_bytes =3D 0;
+    int ret;
+
+    ret =3D vfio_mig_read(vbasedev, &pending_bytes, sizeof(pending_bytes),
+                region->fd_offset + offsetof(struct vfio_device_migration_=
info,
+                                             pending_bytes));
+    if (ret < 0) {
+        migration->pending_bytes =3D 0;
+        return ret;
+    }
+
+    migration->pending_bytes =3D pending_bytes;
+    trace_vfio_update_pending(vbasedev->name, pending_bytes);
+    return 0;
+}
+
+static int vfio_save_device_config_state(QEMUFile *f, void *opaque) {
+    VFIODevice *vbasedev =3D opaque;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
+
+    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
+        vbasedev->ops->vfio_save_config(vbasedev, f);
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    trace_vfio_save_device_config_state(vbasedev->name);
+
+    return qemu_file_get_error(f);
+}
+
 /* ---------------------------------------------------------------------- =
*/
=20
 static int vfio_save_setup(QEMUFile *f, void *opaque) @@ -232,9 +380,134 @=
@ static void vfio_save_cleanup(void *opaque)
     trace_vfio_save_cleanup(vbasedev->name);
 }
=20
+static void vfio_save_pending(QEMUFile *f, void *opaque,
+                              uint64_t threshold_size,
+                              uint64_t *res_precopy_only,
+                              uint64_t *res_compatible,
+                              uint64_t *res_postcopy_only) {
+    VFIODevice *vbasedev =3D opaque;
+    VFIOMigration *migration =3D vbasedev->migration;
+    int ret;
+
+    ret =3D vfio_update_pending(vbasedev);
+    if (ret) {
+        return;
+    }
+
+    *res_precopy_only +=3D migration->pending_bytes;
+
+    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
+                            *res_postcopy_only, *res_compatible); }
+
+static int vfio_save_iterate(QEMUFile *f, void *opaque) {
+    VFIODevice *vbasedev =3D opaque;
+    VFIOMigration *migration =3D vbasedev->migration;
+    uint64_t data_size;
+    int ret;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+
+    if (migration->pending_bytes =3D=3D 0) {
+        ret =3D vfio_update_pending(vbasedev);
+        if (ret) {
+            return ret;
+        }
+
+        if (migration->pending_bytes =3D=3D 0) {
+            /* indicates data finished, goto complete phase */
+            return 1;
+        }
+    }
+
+    ret =3D vfio_save_buffer(f, vbasedev, &data_size);
+
+    if (ret) {
+        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
+                     strerror(errno));
+        return ret;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret =3D qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    trace_vfio_save_iterate(vbasedev->name, data_size);
+
+    return 0;
+}
+
+static int vfio_save_complete_precopy(QEMUFile *f, void *opaque) {
+    VFIODevice *vbasedev =3D opaque;
+    VFIOMigration *migration =3D vbasedev->migration;
+    uint64_t data_size;
+    int ret;
+
+    ret =3D vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_RUNNING,
+                                   VFIO_DEVICE_STATE_SAVING);
+    if (ret) {
+        error_report("%s: Failed to set state STOP and SAVING",
+                     vbasedev->name);
+        return ret;
+    }
+
+    ret =3D vfio_save_device_config_state(f, opaque);
+    if (ret) {
+        return ret;
+    }
+
+    ret =3D vfio_update_pending(vbasedev);
+    if (ret) {
+        return ret;
+    }
+
+    while (migration->pending_bytes > 0) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+        ret =3D vfio_save_buffer(f, vbasedev, &data_size);
+        if (ret < 0) {
+            error_report("%s: Failed to save buffer", vbasedev->name);
+            return ret;
+        }
+
+        if (data_size =3D=3D 0) {
+            break;
+        }
+
+        ret =3D vfio_update_pending(vbasedev);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret =3D qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    ret =3D vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_SAVING, =
0);
+    if (ret) {
+        error_report("%s: Failed to set state STOPPED", vbasedev->name);
+        return ret;
+    }
+
+    trace_vfio_save_complete_precopy(vbasedev->name);
+    return ret;
+}
+
 static SaveVMHandlers savevm_vfio_handlers =3D {
     .save_setup =3D vfio_save_setup,
     .save_cleanup =3D vfio_save_cleanup,
+    .save_live_pending =3D vfio_save_pending,
+    .save_live_iterate =3D vfio_save_iterate,
+    .save_live_complete_precopy =3D vfio_save_complete_precopy,
 };
=20
 /* ---------------------------------------------------------------------- =
*/ diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events index 982d8dccb=
219..118b5547c921 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -154,3 +154,9 @@ vfio_vmstate_change(const char *name, int running, cons=
t char *reason, uint32_t  vfio_migration_state_notifier(const char *name, c=
onst char *state) " (%s) state %s"
 vfio_save_setup(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
+vfio_save_buffer(const char *name, uint64_t data_offset, uint64_t=20
+data_size, uint64_t pending) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64"=20
+pending 0x%"PRIx64 vfio_update_pending(const char *name, uint64_t pending)=
 " (%s) pending 0x%"PRIx64 vfio_save_device_config_state(const char *name) =
" (%s)"
+vfio_save_pending(const char *name, uint64_t precopy, uint64_t=20
+postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRI=
x64" compatible 0x%"PRIx64 vfio_save_iterate(const char *name, int data_siz=
e) " (%s) data_size %d"
+vfio_save_complete_precopy(const char *name) " (%s)"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h =
index 49c7c7a0e29a..471e444a364c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -60,6 +60,7 @@ typedef struct VFIORegion {
=20
 typedef struct VFIOMigration {
     VFIORegion region;
+    uint64_t pending_bytes;
 } VFIOMigration;
=20
 typedef struct VFIOAddressSpace {
--
2.7.0


