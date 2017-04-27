Received: from eggs.gnu.org ([2001:4830:134:3::10]:51863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3i4g-00038k-8Q
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 07:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3i4c-0000yM-9y
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 07:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3i4c-0000yE-09
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 07:59:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF75B80056
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 11:59:00 +0000 (UTC)
Date: Thu, 27 Apr 2017 12:58:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170427115854.GF2082@work-vm>
References: <20170425220451.6028-1-quintela@redhat.com>
	<20170425220451.6028-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425220451.6028-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/41] migration: Create migration/blocker.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> This allows us to remove lots of includes of migration/migration.h
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

if you need to regenerate it, I think the xvzrle.h move is out of place
in this patch.

Dave

> ---
>  block/qcow.c                              |  2 +-
>  block/vdi.c                               |  2 +-
>  block/vhdx.c                              |  2 +-
>  block/vmdk.c                              |  2 +-
>  block/vpc.c                               |  2 +-
>  block/vvfat.c                             |  2 +-
>  hw/9pfs/9p.c                              |  2 +-
>  hw/display/qxl.c                          |  2 +-
>  hw/display/virtio-gpu.c                   |  2 +-
>  hw/intc/arm_gic_kvm.c                     |  2 +-
>  hw/intc/arm_gicv3_its_kvm.c               |  2 +-
>  hw/intc/arm_gicv3_kvm.c                   |  2 +-
>  hw/misc/ivshmem.c                         |  2 +-
>  hw/scsi/vhost-scsi.c                      |  2 +-
>  hw/virtio/vhost.c                         |  2 +-
>  include/migration/blocker.h               | 35 +++++++++++++++++++++++++++++++
>  include/migration/migration.h             | 18 ----------------
>  migration/migration.c                     |  1 +
>  migration/ram.c                           |  2 +-
>  migration/xbzrle.c                        |  2 +-
>  {include/migration => migration}/xbzrle.h |  0
>  stubs/migr-blocker.c                      |  2 +-
>  target/i386/kvm.c                         |  2 +-
>  tests/test-xbzrle.c                       |  2 +-
>  24 files changed, 56 insertions(+), 38 deletions(-)
>  create mode 100644 include/migration/blocker.h
>  rename {include/migration => migration}/xbzrle.h (100%)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index 9d6ac83..48e852c 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -32,7 +32,7 @@
>  #include <zlib.h>
>  #include "qapi/qmp/qerror.h"
>  #include "crypto/cipher.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  
>  /**************************************************************/
>  /* QEMU COW block driver with compression and encryption support */
> diff --git a/block/vdi.c b/block/vdi.c
> index 9b4f70e..5f7b29f 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -55,7 +55,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qemu/module.h"
>  #include "qemu/bswap.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qemu/coroutine.h"
>  #include "qemu/cutils.h"
>  #include "qemu/uuid.h"
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 052a753..6128b7b 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -24,7 +24,7 @@
>  #include "qemu/crc32c.h"
>  #include "qemu/bswap.h"
>  #include "block/vhdx.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qemu/uuid.h"
>  
>  /* Options for VHDX creation */
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a9bd22b..f09f0b2 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -31,7 +31,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/bswap.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qemu/cutils.h"
>  #include <zlib.h>
>  
> diff --git a/block/vpc.c b/block/vpc.c
> index f591d4b..cb2d4cf 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -28,7 +28,7 @@
>  #include "block/block_int.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/module.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qemu/bswap.h"
>  #include "qemu/uuid.h"
>  
> diff --git a/block/vvfat.c b/block/vvfat.c
> index b509d55..3fcc59c 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -28,7 +28,7 @@
>  #include "block/block_int.h"
>  #include "qemu/module.h"
>  #include "qemu/bswap.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qstring.h"
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index c80ba67..ab3e22f 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -23,7 +23,7 @@
>  #include "9p-xattr.h"
>  #include "coth.h"
>  #include "trace.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  
>  int open_fd_hw;
>  int total_open_fd;
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 4d94cec..ad09bb9 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -26,7 +26,7 @@
>  #include "qemu/queue.h"
>  #include "qemu/atomic.h"
>  #include "sysemu/sysemu.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "trace.h"
>  
>  #include "qxl.h"
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e1056f3..8ad27f3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -19,7 +19,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
>  #include "hw/virtio/virtio-bus.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index ec952ec..af5cd36 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -24,7 +24,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
>  #include "gic_internal.h"
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index bd4f3aa..a0441d6 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -24,7 +24,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  
>  #define TYPE_KVM_ARM_ITS "arm-its-kvm"
>  #define KVM_ARM_ITS(obj) OBJECT_CHECK(GICv3ITSState, (obj), TYPE_KVM_ARM_ITS)
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 19aab56..4ee2baa 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -28,7 +28,7 @@
>  #include "kvm_arm.h"
>  #include "gicv3_internal.h"
>  #include "vgic_common.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  
>  #ifdef DEBUG_GICV3_KVM
>  #define DPRINTF(fmt, ...) \
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 82ce837..475e36a 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -25,7 +25,7 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "sysemu/kvm.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "qemu/error-report.h"
>  #include "qemu/event_notifier.h"
>  #include "qom/object_interfaces.h"
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index f53bc17..0558737 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -21,7 +21,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/queue.h"
>  #include "monitor/monitor.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "hw/virtio/vhost-scsi.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/virtio-scsi.h"
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 0001e60..03a46a7 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -25,7 +25,7 @@
>  #include "exec/address-spaces.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "sysemu/dma.h"
>  
>  /* enabled until disconnected backend stabilizes */
> diff --git a/include/migration/blocker.h b/include/migration/blocker.h
> new file mode 100644
> index 0000000..acd2701
> --- /dev/null
> +++ b/include/migration/blocker.h
> @@ -0,0 +1,35 @@
> +/*
> + * QEMU migration blockers
> + *
> + * Copyright IBM, Corp. 2008
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef MIGRATION_BLOCKER_H
> +#define MIGRATION_BLOCKER_H
> +
> +/**
> + * @migrate_add_blocker - prevent migration from proceeding
> + *
> + * @reason - an error to be returned whenever migration is attempted
> + *
> + * @errp - [out] The reason (if any) we cannot block migration right now.
> + *
> + * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
> + */
> +int migrate_add_blocker(Error *reason, Error **errp);
> +
> +/**
> + * @migrate_del_blocker - remove a blocking error from migration
> + *
> + * @reason - the error blocking migration
> + */
> +void migrate_del_blocker(Error *reason);
> +
> +#endif
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 9579280..02b074f 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -267,24 +267,6 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  void ram_postcopy_migrated_memory_release(MigrationState *ms);
>  
> -/**
> - * @migrate_add_blocker - prevent migration from proceeding
> - *
> - * @reason - an error to be returned whenever migration is attempted
> - *
> - * @errp - [out] The reason (if any) we cannot block migration right now.
> - *
> - * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
> - */
> -int migrate_add_blocker(Error *reason, Error **errp);
> -
> -/**
> - * @migrate_del_blocker - remove a blocking error from migration
> - *
> - * @reason - the error blocking migration
> - */
> -void migrate_del_blocker(Error *reason);
> -
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index f094079..8625a6c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -17,6 +17,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "migration/blocker.h"
>  #include "migration/migration.h"
>  #include "migration/qemu-file.h"
>  #include "sysemu/sysemu.h"
> diff --git a/migration/ram.c b/migration/ram.c
> index 5428026..4e562be 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -35,7 +35,7 @@
>  #include "qemu/bitmap.h"
>  #include "qemu/timer.h"
>  #include "qemu/main-loop.h"
> -#include "migration/xbzrle.h"
> +#include "xbzrle.h"
>  #include "migration/migration.h"
>  #include "migration/postcopy-ram.h"
>  #include "exec/address-spaces.h"
> diff --git a/migration/xbzrle.c b/migration/xbzrle.c
> index 421bca0..1ba482d 100644
> --- a/migration/xbzrle.c
> +++ b/migration/xbzrle.c
> @@ -12,7 +12,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> -#include "migration/xbzrle.h"
> +#include "xbzrle.h"
>  
>  /*
>    page = zrun nzrun
> diff --git a/include/migration/xbzrle.h b/migration/xbzrle.h
> similarity index 100%
> rename from include/migration/xbzrle.h
> rename to migration/xbzrle.h
> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
> index a5ba18f..2b64ac9 100644
> --- a/stubs/migr-blocker.c
> +++ b/stubs/migr-blocker.c
> @@ -1,6 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  
>  int migrate_add_blocker(Error *reason, Error **errp)
>  {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 55865db..011d4a5 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -43,7 +43,7 @@
>  #include "standard-headers/asm-x86/hyperv.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/msi.h"
> -#include "migration/migration.h"
> +#include "migration/blocker.h"
>  #include "exec/memattrs.h"
>  #include "trace.h"
>  
> diff --git a/tests/test-xbzrle.c b/tests/test-xbzrle.c
> index d97b5eb..f5e08de 100644
> --- a/tests/test-xbzrle.c
> +++ b/tests/test-xbzrle.c
> @@ -13,7 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
> -#include "include/migration/xbzrle.h"
> +#include "../migration/xbzrle.h"
>  
>  #define PAGE_SIZE 4096
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
