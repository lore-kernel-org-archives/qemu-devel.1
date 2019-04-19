Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5475C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 08:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947CD217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 08:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947CD217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHP4I-0003r3-EN
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 04:40:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hHP3W-0003Zq-9u
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hHP3V-0003Q7-Bd
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:39:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:45450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hHP3V-0003L6-2m
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:39:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Apr 2019 01:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; d="scan'208";a="141935693"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
	by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2019 01:39:19 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: intel-gvt-dev@lists.freedesktop.org
Date: Fri, 19 Apr 2019 04:32:58 -0400
Message-Id: <20190419083258.19580-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH 0/2] introduction of version attribute for VFIO
 live migration
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
	kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
	dgilbert@redhat.com, zhenyuw@linux.intel.com,
	alex.williamson@redhat.com, changpeng.liu@intel.com,
	cohuck@redhat.com, linux-kernel@vger.kernel.org,
	zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419083258.cRet5pmbTPuC2_uXQzkqtM3V1pzSePef8Kqjud0tMNk@z>

This patchset introduces a version attribute under sysfs of VFIO Mediated
devices.

This version attribute is used by user space software like libvirt to
determine whether two mdev devices are compatible for live migration
before starting live migration.

Patch 1 defines version attribute as mandatory for VFIO live migration. It
means if version attribute is missing or it returns errno, the
corresponding mdev device is regarded as not supporting live migration.
samples for vfio-mdev are modified to demonstrate it.

Patch 2 uses GVT as an example to show how to expose version attribute and
check device compatibility in vendor driver.


Yan Zhao (2):
  vfio/mdev: add version field as mandatory attribute for mdev device
  drm/i915/gvt: export mdev device version to sysfs for Intel vGPU

 Documentation/vfio-mediated-device.txt    | 36 +++++++++
 drivers/gpu/drm/i915/gvt/Makefile         |  2 +-
 drivers/gpu/drm/i915/gvt/device_version.c | 94 +++++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/gvt.c            | 55 +++++++++++++
 drivers/gpu/drm/i915/gvt/gvt.h            |  6 ++
 samples/vfio-mdev/mbochs.c                | 17 ++++
 samples/vfio-mdev/mdpy.c                  | 16 ++++
 samples/vfio-mdev/mtty.c                  | 16 ++++
 8 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/device_version.c

-- 
2.17.1


