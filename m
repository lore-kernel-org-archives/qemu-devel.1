Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egVrw-0000O8-6v
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egVrr-0005UM-9N
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:22:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:19491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1egVrq-0005TN-Tb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:22:31 -0500
Date: Tue, 30 Jan 2018 14:22:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180130102202.28519-2-armbru@redhat.com>
Message-ID: <alpine.BSF.2.21.1801301417470.81470@zero.eik.bme.hu>
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 01/18] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 30 Jan 2018, Markus Armbruster wrote:
> Clean up includes so that osdep.h is included first and headers
> which it implies are not included manually.
>
> This commit was created with scripts/clean-includes, with the change
> to target/s390x/gen-features.c manually reverted, and blank lines
> around deletions collapsed.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> block/parallels.h                                     |  1 -
> hw/block/vhost-user-blk.c                             |  1 -
> hw/ide/sii3112.c                                      |  1 +
> hw/nvram/eeprom_at24c.c                               |  3 +--
> hw/tpm/tpm_emulator.c                                 |  4 ----
> hw/tpm/tpm_int.h                                      |  2 --
> hw/tpm/tpm_ioctl.h                                    |  2 --
> hw/xtensa/xtensa_memory.h                             |  1 -
> include/exec/tb-lookup.h                              |  2 --
> include/hw/intc/xlnx-pmu-iomod-intc.h                 |  1 -
> include/hw/intc/xlnx-zynqmp-ipi.h                     |  1 -
> include/hw/nvram/fw_cfg.h                             |  1 -
> include/hw/pci-bridge/simba.h                         |  1 -
> include/hw/xtensa/xtensa-isa.h                        |  2 --
> include/qapi/clone-visitor.h                          |  1 -
> include/sysemu/hvf.h                                  |  2 --
> include/ui/console.h                                  |  1 -
> io/channel-websock.c                                  |  3 ---
> linux-user/syscall.c                                  |  1 -
> scsi/pr-helper.h                                      |  2 --
> target/i386/hvf/vmx.h                                 |  1 -
> target/i386/hvf/x86hvf.c                              |  3 ---
> target/xtensa/core-dc232b/xtensa-modules.c            |  1 +
> target/xtensa/core-dc233c/xtensa-modules.c            |  1 +
> target/xtensa/core-de212/xtensa-modules.c             |  1 +
> target/xtensa/core-fsf/xtensa-modules.c               |  1 +
> target/xtensa/core-sample_controller/xtensa-modules.c |  1 +
> target/xtensa/xtensa-isa.c                            |  4 +---
> tests/migration/stress.c                              | 10 +---------
> tests/ptimer-test.c                                   |  4 ++--
> trace/control-internal.h                              |  2 --
> 31 files changed, 11 insertions(+), 51 deletions(-)
>
> diff --git a/block/parallels.h b/block/parallels.h
> index 4b044079ef..5aa101cfc8 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -32,7 +32,6 @@
> #ifndef BLOCK_PARALLELS_H
> #define BLOCK_PARALLELS_H
> #include "qemu/coroutine.h"
> -#include "qemu/typedefs.h"
>
> #define HEADS_NUMBER 16
> #define SEC_IN_CYL 32
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index b53b4c9c57..f840f07dfe 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -19,7 +19,6 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "qemu/error-report.h"
> -#include "qemu/typedefs.h"
> #include "qemu/cutils.h"
> #include "qom/object.h"
> #include "hw/qdev-core.h"
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 17aa930e39..a5d1776756 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -12,6 +12,7 @@
>  * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
>  */
>
> +#include "qemu/osdep.h"
> #include <qemu/osdep.h>
> #include <hw/ide/pci.h>
> #include "trace.h"

This is wrong. I've sent a patch instead to change angle brackets to 
quotes for these two includes. This wasn't catched either by checkpatch 
nor review though so maybe it could be added to checkpatch if quotes are 
the preferred style for these includes.

Regards,
BALATON Zoltan
