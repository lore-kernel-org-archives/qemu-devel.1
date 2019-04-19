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
From: Yan Zhao <yan.y.zhao@intel.com>
Date: Fri, 19 Apr 2019 04:32:58 -0400
Message-Id: <20190419083258.19580-1-yan.y.zhao@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] introduction of version attribute for VFIO
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: intel-gvt-dev@lists.freedesktop.org
Cc: arei.gonglei@huawei.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, alex.williamson@redhat.com, eskultet@redhat.com, dgilbert@redhat.com, cohuck@redhat.com, kevin.tian@intel.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, cjia@nvidia.com, kwankhede@nvidia.com, Yan Zhao <yan.y.zhao@intel.com>

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
