Received: from eggs.gnu.org ([2001:4830:134:3::10]:56534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9Mn-0002Xy-B1
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9Mk-0000yV-KR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:37:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <037e1f36-17e6-0ebb-c3a6-81edbf8fe09d@amsat.org>
Date: Tue, 22 Aug 2017 10:37:01 -0300
MIME-Version: 1.0
In-Reply-To: <20170822131832.20191-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/10] scsi: move block/scsi.h to
 include/scsi/constants.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

On 08/22/2017 10:18 AM, Paolo Bonzini wrote:
> Complete the transition by renaming this header, which was
> shared by block/iscsi.c and the SCSI emulation code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   block/iscsi.c                              | 2 +-
>   hw/block/virtio-blk.c                      | 2 +-
>   hw/scsi/megasas.c                          | 2 +-
>   hw/scsi/mptendian.c                        | 2 +-
>   hw/scsi/mptsas.c                           | 2 +-
>   hw/scsi/scsi-bus.c                         | 2 +-
>   hw/scsi/scsi-disk.c                        | 2 +-
>   hw/scsi/scsi-generic.c                     | 2 +-
>   hw/scsi/spapr_vscsi.c                      | 2 +-
>   hw/scsi/virtio-scsi-dataplane.c            | 2 +-
>   hw/scsi/virtio-scsi.c                      | 2 +-
>   hw/scsi/vmw_pvscsi.c                       | 2 +-
>   hw/usb/dev-uas.c                           | 2 +-
>   include/hw/ide/internal.h                  | 2 +-
>   include/{block/scsi.h => scsi/constants.h} | 0
>   scsi/utils.c                               | 2 +-
>   tests/virtio-scsi-test.c                   | 2 +-
>   17 files changed, 16 insertions(+), 16 deletions(-)
>   rename include/{block/scsi.h => scsi/constants.h} (100%)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index d557c99668..c43c0953e1 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -34,7 +34,7 @@
>   #include "qemu/bitops.h"
>   #include "qemu/bitmap.h"
>   #include "block/block_int.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "qemu/iov.h"
>   #include "qemu/uuid.h"
>   #include "qmp-commands.h"
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index a16ac75090..05d1440786 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -22,7 +22,7 @@
>   #include "sysemu/blockdev.h"
>   #include "hw/virtio/virtio-blk.h"
>   #include "dataplane/virtio-blk.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #ifdef __linux__
>   # include <scsi/sg.h>
>   #endif
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 734fdaef90..0db68aacee 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -27,7 +27,7 @@
>   #include "hw/pci/msix.h"
>   #include "qemu/iov.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "mfi.h"
> diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
> index b7fe2a2a36..3415229b5e 100644
> --- a/hw/scsi/mptendian.c
> +++ b/hw/scsi/mptendian.c
> @@ -28,7 +28,7 @@
>   #include "hw/pci/msi.h"
>   #include "qemu/iov.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "trace.h"
>   
>   #include "mptsas.h"
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 765ab53c34..8bae8f543e 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -30,7 +30,7 @@
>   #include "hw/pci/msi.h"
>   #include "qemu/iov.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "mptsas.h"
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index f71218f02a..b9244606f8 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -3,7 +3,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "hw/qdev.h"
>   #include "sysemu/block-backend.h"
>   #include "sysemu/blockdev.h"
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 0a1f4ef0c7..5faf6682c5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,7 +32,7 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/block-backend.h"
>   #include "sysemu/blockdev.h"
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 04c687ee76..bd0d9ff355 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -34,7 +34,7 @@ do { printf("scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
>   do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
>   
>   #include <scsi/sg.h>
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   
>   #ifndef MAX_UINT
>   #define MAX_UINT ((unsigned int)-1)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 55ee48c4da..360db53ac8 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -36,7 +36,7 @@
>   #include "cpu.h"
>   #include "hw/hw.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "srp.h"
>   #include "hw/qdev.h"
>   #include "hw/ppc/spapr.h"
> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
> index 944ea4eb53..add4b3f4a4 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -17,7 +17,7 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/block-backend.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "hw/virtio/virtio-bus.h"
>   #include "hw/virtio/virtio-access.h"
>   
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index eb639442d1..823a1e9a42 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -21,7 +21,7 @@
>   #include "qemu/iov.h"
>   #include "sysemu/block-backend.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "hw/virtio/virtio-bus.h"
>   #include "hw/virtio/virtio-access.h"
>   
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 77d8b6f9e2..6d3f0bf11d 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -28,7 +28,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "hw/pci/msi.h"
>   #include "vmw_pvscsi.h"
>   #include "trace.h"
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
> index fffc424396..c218b53f09 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -19,7 +19,7 @@
>   #include "hw/usb.h"
>   #include "hw/usb/desc.h"
>   #include "hw/scsi/scsi.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   
>   /* --------------------------------------------------------------------- */
>   
> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
> index 482a9512be..63a99e0366 100644
> --- a/include/hw/ide/internal.h
> +++ b/include/hw/ide/internal.h
> @@ -11,7 +11,7 @@
>   #include "sysemu/dma.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/block/block.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   
>   /* debug IDE devices */
>   //#define DEBUG_IDE
> diff --git a/include/block/scsi.h b/include/scsi/constants.h
> similarity index 100%
> rename from include/block/scsi.h
> rename to include/scsi/constants.h
> diff --git a/scsi/utils.c b/scsi/utils.c
> index ca5b058a73..eedd5f45b4 100644
> --- a/scsi/utils.c
> +++ b/scsi/utils.c
> @@ -1,5 +1,5 @@
>   #include "qemu/osdep.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "scsi/utils.h"
>   #include "qemu/bswap.h"
>   
> diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> index 87a3b6e81a..082d323541 100644
> --- a/tests/virtio-scsi-test.c
> +++ b/tests/virtio-scsi-test.c
> @@ -10,7 +10,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "libqtest.h"
> -#include "block/scsi.h"
> +#include "scsi/constants.h"
>   #include "libqos/libqos-pc.h"
>   #include "libqos/libqos-spapr.h"
>   #include "libqos/virtio.h"
> 
