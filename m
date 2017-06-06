Received: from eggs.gnu.org ([2001:4830:134:3::10]:55135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIF3y-0001dL-7w
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIF3s-0005QW-D8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:02:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIF3s-0005QP-3p
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:02:20 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1AF580C02
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 14:02:18 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-248.ams2.redhat.com
	[10.36.117.248])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v56E2Hdo020907
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 10:02:17 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 16:02:15 +0200
Message-Id: <20170606140216.12270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/33] Misc patches for 2017-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 70f31414e71250c6049a46851372ee6ea76f40=
dd:

  Merge remote-tracking branch 'remotes/ehabkost/tags/numa-pull-request' =
into staging (2017-06-01 10:58:47 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0c5029c963dbce627d75cd0267594224c89a6479:

  Merge tag 'tags/for-upstream' into HEAD

----------------------------------------------------------------
* virtio-scsi use-after-free fix (Fam)
* vhost-user-scsi support (Felipe)
* SMM fixes and improvements for TCG (myself, Mihail)
* irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
* Coverity fix (Stefano)
* NBD cleanups and fixes (Vladimir, Eric, myself)
* RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
* socket error reporting improvement (Daniel)
* GDB XML description for SSE registers (Abdallah)
* kvmclock update fix (Denis)
* SMM memory savings (Gonglei)
* -cpu 486 fix (Paolo)
* various bugfixes (Roman, Peter, myself, Thomas)
* rtc-test improvement (Guangrong)
* migration throttling fix (Felipe)

----------------------------------------------------------------
Dropped Peter's "exec: fix address_space_get_iotlb_entry page mask" at hi=
s
request, fixed vhost-user-scsi.

Abdallah Bouassida (1):
      target/i386: Add GDB XML description for SSE registers

Daniel P. Berrange (1):
      sockets: improve error reporting if UNIX socket path is too long

Denis Plotnikov (1):
      kvmclock: update system_time_msr address forcibly

Eric Blake (1):
      nbd: Fully initialize client in case of failed negotiation

Fam Zheng (1):
      virtio-scsi: Unset hotplug handler when unrealize

Felipe Franciosi (3):
      vhost-user-scsi: Introduce vhost-user-scsi host device
      vhost-user-scsi: Introduce a vhost-user-scsi sample application
      cpus: reset throttle_thread_scheduled after sleep

Gonglei (1):
      kvm: don't register smram_listener when smm is off

Mihail Abakumov (1):
      i386: fix read/write cr with icount option

Paolo Bonzini (5):
      target/i386: enable A20 automatically in system management mode
      target/i386: use multiple CPU AddressSpaces
      linuxboot_dma: compile for i486
      edu: fix memory leak on msi_broken platforms
      nbd: make it thread-safe, fix qcow2 over nbd

Peter Xu (4):
      kvm: irqchip: trace changes on msi add/remove
      msix: trace control bit write op
      kvm: irqchip: skip update msi when disabled
      exec: simplify phys_page_find() params

Roman Pen (1):
      i386/kvm: do not zero out segment flags if segment is unusable or n=
ot present

Stefano Stabellini (1):
      Check the return value of fcntl in qemu_set_cloexec

Tai Yunfang (1):
      mc146818rtc: precisely count the clock for periodic timer

Thomas Huth (1):
      hw/core: nmi.c can be compiled as common-obj nowadays

Vladimir Sementsov-Ogievskiy (5):
      nbd: strict nbd_wr_syncv
      nbd: read_sync and friends: return 0 on success
      nbd: add errp parameter to nbd_wr_syncv()
      nbd: add errp to read_sync, write_sync and drop_sync
      nbd/client.c: use errp instead of LOG

Xiao Guangrong (5):
      mc146818rtc: update periodic timer only if it is needed
      mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARGET=
_I386
      mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
      mc146818rtc: embrace all x86 specific code
      qtest: add rtc periodic timer test

 .gitignore                                |   1 +
 Makefile                                  |   3 +
 Makefile.objs                             |   4 +
 block/nbd-client.c                        |  41 +-
 configure                                 |   4 +-
 contrib/libvhost-user/libvhost-user.h     |  11 +-
 contrib/vhost-user-scsi/Makefile.objs     |   1 +
 contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++=
++++++
 cpus.c                                    |   2 +-
 default-configs/pci.mak                   |   1 +
 default-configs/s390x-softmmu.mak         |   1 +
 exec.c                                    |  13 +-
 gdb-xml/i386-32bit-sse.xml                |  52 ++
 gdb-xml/i386-32bit.xml                    |  14 +
 gdb-xml/i386-64bit-sse.xml                |  60 ++
 gdb-xml/i386-64bit.xml                    |  14 +
 hw/core/Makefile.objs                     |   2 +-
 hw/i386/kvm/clock.c                       |   3 +
 hw/misc/edu.c                             |  12 +-
 hw/pci/msix.c                             |  11 +-
 hw/pci/trace-events                       |   3 +
 hw/scsi/Makefile.objs                     |   1 +
 hw/scsi/vhost-scsi-common.c               |   1 -
 hw/scsi/vhost-user-scsi.c                 | 211 +++++++
 hw/scsi/virtio-scsi.c                     |   3 +
 hw/timer/mc146818rtc.c                    | 203 ++++---
 hw/virtio/virtio-pci.c                    |  58 ++
 hw/virtio/virtio-pci.h                    |  11 +
 include/block/nbd.h                       |   8 +-
 include/hw/timer/mc146818rtc_regs.h       |  20 +
 include/hw/virtio/vhost-user-scsi.h       |  35 ++
 include/hw/virtio/virtio-scsi.h           |   2 +
 kvm-all.c                                 |   8 +-
 nbd/client.c                              | 125 ++---
 nbd/common.c                              |  23 +-
 nbd/nbd-internal.h                        |  40 +-
 nbd/server.c                              | 100 ++--
 pc-bios/linuxboot_dma.bin                 | Bin 1536 -> 1536 bytes
 pc-bios/optionrom/Makefile                |   1 +
 qemu-nbd.c                                |   5 +-
 target/i386/arch_memory_mapping.c         |  18 +-
 target/i386/cpu.c                         |  23 +-
 target/i386/cpu.h                         |  20 +-
 target/i386/helper.c                      |  96 ++--
 target/i386/kvm.c                         |  36 +-
 target/i386/machine.c                     |   4 -
 target/i386/smm_helper.c                  |  18 -
 target/i386/translate.c                   |  12 +
 tests/qemu-iotests/083.out                |   2 +
 tests/rtc-test.c                          |  49 ++
 trace-events                              |   3 +-
 util/oslib-posix.c                        |   4 +-
 util/qemu-sockets.c                       |  68 ++-
 53 files changed, 1954 insertions(+), 393 deletions(-)
 create mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
 create mode 100644 gdb-xml/i386-32bit-sse.xml
 create mode 100644 gdb-xml/i386-32bit.xml
 create mode 100644 gdb-xml/i386-64bit-sse.xml
 create mode 100644 gdb-xml/i386-64bit.xml
 create mode 100644 hw/scsi/vhost-user-scsi.c
 create mode 100644 include/hw/virtio/vhost-user-scsi.h
--=20
2.13.0

diff --cc hw/scsi/vhost-user-scsi.c
index 0000000000,d27b2ada8e..c8fdf33074
mode 000000,100644..100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@@ -1,0 -1,211 +1,211 @@@
+ /*
+  * vhost-user-scsi host device
+  *
+  * Copyright (c) 2016 Nutanix Inc. All rights reserved.
+  *
+  * Author:
+  *  Felipe Franciosi <felipe@nutanix.com>
+  *
+  * This work is largely based on the "vhost-scsi" implementation by:
+  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
+  *  Nicholas Bellinger <nab@risingtidesystems.com>
+  *
+  * This work is licensed under the terms of the GNU LGPL, version 2 or =
later.
+  * See the COPYING.LIB file in the top-level directory.
+  *
+  */
+=20
+ #include "qemu/osdep.h"
+ #include "migration/vmstate.h"
+ #include "qapi/error.h"
+ #include "qemu/error-report.h"
+ #include "qemu/typedefs.h"
+ #include "qom/object.h"
+ #include "hw/fw-path-provider.h"
+ #include "hw/qdev-core.h"
+ #include "hw/virtio/vhost.h"
+ #include "hw/virtio/vhost-backend.h"
+ #include "hw/virtio/vhost-user-scsi.h"
+ #include "hw/virtio/virtio.h"
+ #include "hw/virtio/virtio-access.h"
 -#include "sysemu/char.h"
++#include "chardev/char-fe.h"
+=20
+ /* Features supported by the host application */
+ static const int user_feature_bits[] =3D {
+     VIRTIO_F_NOTIFY_ON_EMPTY,
+     VIRTIO_RING_F_INDIRECT_DESC,
+     VIRTIO_RING_F_EVENT_IDX,
+     VIRTIO_SCSI_F_HOTPLUG,
+     VHOST_INVALID_FEATURE_BIT
+ };
+=20
+ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t stat=
us)
+ {
+     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
+     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
+     bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_run=
ning;
+=20
+     if (vsc->dev.started =3D=3D start) {
+         return;
+     }
+=20
+     if (start) {
+         int ret;
+=20
+         ret =3D vhost_scsi_common_start(vsc);
+         if (ret < 0) {
+             error_report("unable to start vhost-user-scsi: %s", strerro=
r(-ret));
+             exit(1);
+         }
+     } else {
+         vhost_scsi_common_stop(vsc);
+     }
+ }
+=20
+ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq=
)
+ {
+ }
+=20
+ static void vhost_user_scsi_save(QEMUFile *f, void *opaque)
+ {
+     VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
+     virtio_save(vdev, f);
+ }
+=20
+ static int vhost_user_scsi_load(QEMUFile *f, void *opaque, int version_=
id)
+ {
+     VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
+     return virtio_load(vdev, f, version_id);
+ }
+=20
+ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
+ {
+     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
+     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
+     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
+     static int vhost_user_scsi_id;
+     Error *err =3D NULL;
+     int ret;
+=20
+     if (!vs->conf.chardev.chr) {
+         error_setg(errp, "vhost-user-scsi: missing chardev");
+         return;
+     }
+=20
+     virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
+                                vhost_dummy_handle_output,
+                                vhost_dummy_handle_output, &err);
+     if (err !=3D NULL) {
+         error_propagate(errp, err);
+         return;
+     }
+=20
+     vsc->dev.nvqs =3D 2 + vs->conf.num_queues;
+     vsc->dev.vqs =3D g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+     vsc->dev.vq_index =3D 0;
+     vsc->dev.backend_features =3D 0;
+=20
+     ret =3D vhost_dev_init(&vsc->dev, (void *)&vs->conf.chardev,
+                          VHOST_BACKEND_TYPE_USER, 0);
+     if (ret < 0) {
+         error_setg(errp, "vhost-user-scsi: vhost initialization failed:=
 %s",
+                    strerror(-ret));
+         return;
+     }
+=20
+     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
+     vsc->channel =3D 0;
+     vsc->lun =3D 0;
+     vsc->target =3D vs->conf.boot_tpgt;
+=20
+     register_savevm(dev, "vhost-user-scsi", vhost_user_scsi_id++, 1,
+                     vhost_user_scsi_save, vhost_user_scsi_load, s);
+ }
+=20
+ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
+ {
+     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
+     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
+=20
+     /* This will stop the vhost backend. */
+     vhost_user_scsi_set_status(vdev, 0);
+=20
+     vhost_dev_cleanup(&vsc->dev);
+     g_free(vsc->dev.vqs);
+=20
+     virtio_scsi_common_unrealize(dev, errp);
+ }
+=20
+ static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
+                                              uint64_t features, Error *=
*errp)
+ {
+     VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
+=20
+     /* Turn on predefined features supported by this device */
+     features |=3D s->host_features;
+=20
+     return vhost_scsi_common_get_features(vdev, features, errp);
+ }
+=20
+ static Property vhost_user_scsi_properties[] =3D {
+     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0=
),
+     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,=
 1),
+     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sector=
s,
+                        0xFFFF),
+     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lu=
n, 128),
+     DEFINE_PROP_BIT64("hotplug", VHostUserSCSI, host_features,
+                                                 VIRTIO_SCSI_F_HOTPLUG,
+                                                 true),
+     DEFINE_PROP_BIT64("param_change", VHostUserSCSI, host_features,
+                                                      VIRTIO_SCSI_F_CHAN=
GE,
+                                                      true),
+     DEFINE_PROP_END_OF_LIST(),
+ };
+=20
+ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
+ {
+     DeviceClass *dc =3D DEVICE_CLASS(klass);
+     VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+     FWPathProviderClass *fwc =3D FW_PATH_PROVIDER_CLASS(klass);
+=20
+     dc->props =3D vhost_user_scsi_properties;
+     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+     vdc->realize =3D vhost_user_scsi_realize;
+     vdc->unrealize =3D vhost_user_scsi_unrealize;
+     vdc->get_features =3D vhost_user_scsi_get_features;
+     vdc->set_config =3D vhost_scsi_common_set_config;
+     vdc->set_status =3D vhost_user_scsi_set_status;
+     fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
+ }
+=20
+ static void vhost_user_scsi_instance_init(Object *obj)
+ {
+     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(obj);
+=20
+     vsc->feature_bits =3D user_feature_bits;
+=20
+     /* Add the bootindex property for this object */
+     device_add_bootindex_property(obj, &vsc->bootindex, "bootindex", NU=
LL,
+                                   DEVICE(vsc), NULL);
+ }
+=20
+ static const TypeInfo vhost_user_scsi_info =3D {
+     .name =3D TYPE_VHOST_USER_SCSI,
+     .parent =3D TYPE_VHOST_SCSI_COMMON,
+     .instance_size =3D sizeof(VHostUserSCSI),
+     .class_init =3D vhost_user_scsi_class_init,
+     .instance_init =3D vhost_user_scsi_instance_init,
+     .interfaces =3D (InterfaceInfo[]) {
+         { TYPE_FW_PATH_PROVIDER },
+         { }
+     },
+ };
+=20
+ static void virtio_register_types(void)
+ {
+     type_register_static(&vhost_user_scsi_info);
+ }
+=20
+ type_init(virtio_register_types)
diff --cc include/hw/virtio/virtio-scsi.h
index eac2013ddd,ca77a4263d..de6ae5a9f6
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@@ -21,6 -21,7 +21,7 @@@
  #include "hw/virtio/virtio.h"
  #include "hw/pci/pci.h"
  #include "hw/scsi/scsi.h"
 -#include "sysemu/char.h"
++#include "chardev/char-fe.h"
  #include "sysemu/iothread.h"
 =20
  #define TYPE_VIRTIO_SCSI_COMMON "virtio-scsi-common"
