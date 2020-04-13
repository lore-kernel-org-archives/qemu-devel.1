Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9873C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B55120735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNsBE-00064b-My
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 02:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsAd-0005fQ-F9
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsAb-0000Cm-7L
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:02:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:40950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jNsAa-00005o-UG
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:02:09 -0400
IronPort-SDR: wyOSYTbtlSK0WidxdLe0/Y9DM1AkT/yckIH/Tbyq5wPnfw1xTWRRIMp/AiIPt7jtPf1L0m8/y/
 HYTDukTPbGzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 23:01:59 -0700
IronPort-SDR: O5wdGuyQlc7bo5KmVytTBytv4gIaY33RmF0q8WDMiPNVI4GCYyrC5X6Yd4Ae+HQAXSFb7BKflg
 896Qwv3gpldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="453054045"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2020 23:01:52 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: intel-gvt-dev@lists.freedesktop.org
Subject: [PATCH v5 0/4] introduction of migration_version attribute for VFIO
 live migration
Date: Mon, 13 Apr 2020 01:52:01 -0400
Message-Id: <20200413055201.27053-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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

This patchset introduces a migration_version attribute under sysfs of VFIO
Mediated devices.

This migration_version attribute is used to check migration compatibility
between two mdev devices.

Currently, it has two locations:
(1) under mdev_type node,
    which can be used even before device creation, but only for mdev
    devices of the same mdev type.
(2) under mdev device node,
    which can only be used after the mdev devices are created, but the src
    and target mdev devices are not necessarily be of the same mdev type
(The second location is newly added in v5, in order to keep consistent
with the migration_version node for migratable pass-though devices)

Patch 1 defines migration_version attribute for the first location in
Documentation/vfio-mediated-device.txt

Patch 2 uses GVT as an example for patch 1 to show how to expose
migration_version attribute and check migration compatibility in vendor
driver.

Patch 3 defines migration_version attribute for the second location in
Documentation/vfio-mediated-device.txt

Patch 4 uses GVT as an example for patch 3 to show how to expose
migration_version attribute and check migration compatibility in vendor
driver.

(The previous "Reviewed-by" and "Acked-by" for patch 1 and patch 2 are
kept in v5, as there are only small changes to commit messages of the two
patches.)

v5:
added patch 2 and 4 for mdev device part of migration_version attribute.

v4:
1. fixed indentation/spell errors, reworded several error messages
2. added a missing memory free for error handling in patch 2

v3:
1. renamed version to migration_version
2. let errno to be freely defined by vendor driver
3. let checking mdev_type be prerequisite of migration compatibility check
4. reworded most part of patch 1
5. print detailed error log in patch 2 and generate migration_version
string at init time

v2:
1. renamed patched 1
2. made definition of device version string completely private to vendor
driver
3. reverted changes to sample mdev drivers
4. described intent and usage of version attribute more clearly.


Yan Zhao (4):
  vfio/mdev: add migration_version attribute for mdev (under mdev_type
    node)
  drm/i915/gvt: export migration_version to mdev sysfs (under mdev_type
    node)
  vfio/mdev: add migration_version attribute for mdev (under mdev device
    node)
  drm/i915/gvt: export migration_version to mdev sysfs (under mdev
    device node)

 .../driver-api/vfio-mediated-device.rst       | 183 ++++++++++++++++++
 drivers/gpu/drm/i915/gvt/Makefile             |   2 +-
 drivers/gpu/drm/i915/gvt/gvt.c                |  39 ++++
 drivers/gpu/drm/i915/gvt/gvt.h                |   7 +
 drivers/gpu/drm/i915/gvt/kvmgt.c              |  55 ++++++
 drivers/gpu/drm/i915/gvt/migration_version.c  | 170 ++++++++++++++++
 drivers/gpu/drm/i915/gvt/vgpu.c               |  13 +-
 7 files changed, 466 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/migration_version.c

-- 
2.17.1


