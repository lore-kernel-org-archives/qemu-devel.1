Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D653C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C556C2177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C556C2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Jrc-0004yN-2y
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3Jqz-0004F7-5Q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:53:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3Jqw-0005OB-UN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 17830AEF5;
 Wed,  5 Aug 2020 13:53:26 +0000 (UTC)
Subject: Re: [PATCH] softmmu: Add missing trace-events file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200805130221.24487-1-philmd@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <55ea43f9-a62b-46e8-0dc7-2f60fc23bc58@suse.de>
Date: Wed, 5 Aug 2020 15:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200805130221.24487-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 3:02 PM, Philippe Mathieu-Daudé wrote:
> Commit c7f419f584 moved softmmu-only files out of the root
> directory, but forgot to move the trace events, which should
> no longer be generated to "trace-root.h". Fix that by adding
> softmmu/trace-events.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>


missed, sorry.

Tested-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Claudio Fontana <cfontana@suse.de>


I wonder if checkpatch could emit a warning when moving files around directories
when they use tracing.. will take a look.

Ciao,

Claudio


> ---
>  Makefile.objs        |  1 +
>  softmmu/balloon.c    |  2 +-
>  softmmu/ioport.c     |  2 +-
>  softmmu/memory.c     |  2 +-
>  softmmu/vl.c         |  2 +-
>  softmmu/trace-events | 28 ++++++++++++++++++++++++++++
>  trace-events         | 27 ---------------------------
>  7 files changed, 33 insertions(+), 31 deletions(-)
>  create mode 100644 softmmu/trace-events
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index d22b3b45d7..61c1ad3c3b 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -190,6 +190,7 @@ trace-events-subdirs += hw/gpio
>  trace-events-subdirs += hw/riscv
>  trace-events-subdirs += migration
>  trace-events-subdirs += net
> +trace-events-subdirs += softmmu
>  trace-events-subdirs += ui
>  endif
>  trace-events-subdirs += hw/core
> diff --git a/softmmu/balloon.c b/softmmu/balloon.c
> index 354408c6ea..23452295cd 100644
> --- a/softmmu/balloon.c
> +++ b/softmmu/balloon.c
> @@ -28,10 +28,10 @@
>  #include "qemu/atomic.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/balloon.h"
> -#include "trace-root.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qmp/qerror.h"
> +#include "trace.h"
>  
>  static QEMUBalloonEvent *balloon_event_fn;
>  static QEMUBalloonStatus *balloon_stat_fn;
> diff --git a/softmmu/ioport.c b/softmmu/ioport.c
> index 04e360e79a..cb8adb0b93 100644
> --- a/softmmu/ioport.c
> +++ b/softmmu/ioport.c
> @@ -28,9 +28,9 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/ioport.h"
> -#include "trace-root.h"
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
> +#include "trace.h"
>  
>  typedef struct MemoryRegionPortioList {
>      MemoryRegion mr;
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..d030eb6f7c 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -24,7 +24,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/qemu-print.h"
>  #include "qom/object.h"
> -#include "trace-root.h"
> +#include "trace.h"
>  
>  #include "exec/memory-internal.h"
>  #include "exec/ram_addr.h"
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 4eb9d1f7fd..f7b103467c 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -90,7 +90,7 @@
>  
>  #include "disas/disas.h"
>  
> -#include "trace-root.h"
> +#include "trace.h"
>  #include "trace/control.h"
>  #include "qemu/plugin.h"
>  #include "qemu/queue.h"
> diff --git a/softmmu/trace-events b/softmmu/trace-events
> new file mode 100644
> index 0000000000..b80ca042e1
> --- /dev/null
> +++ b/softmmu/trace-events
> @@ -0,0 +1,28 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# balloon.c
> +# Since requests are raised via monitor, not many tracepoints are needed.
> +balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
> +
> +# ioport.c
> +cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
> +cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
> +
> +# memory.c
> +memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +flatview_new(void *view, void *root) "%p (root %p)"
> +flatview_destroy(void *view, void *root) "%p (root %p)"
> +flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> +
> +# vl.c
> +vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
> +load_file(const char *name, const char *path) "name %s location %s"
> +runstate_set(int current_state, const char *current_state_str, int new_state, const char *new_state_str) "current_run_state %d (%s) new_state %d (%s)"
> +system_wakeup_request(int reason) "reason=%d"
> +qemu_system_shutdown_request(int reason) "reason=%d"
> +qemu_system_powerdown_request(void) ""
> diff --git a/trace-events b/trace-events
> index 42107ebc69..5882c2d5fc 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -25,22 +25,6 @@
>  #
>  # The <format-string> should be a sprintf()-compatible format string.
>  
> -# ioport.c
> -cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
> -cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
> -
> -# balloon.c
> -# Since requests are raised via monitor, not many tracepoints are needed.
> -balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
> -
> -# vl.c
> -vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
> -load_file(const char *name, const char *path) "name %s location %s"
> -runstate_set(int current_state, const char *current_state_str, int new_state, const char *new_state_str) "current_run_state %d (%s) new_state %d (%s)"
> -system_wakeup_request(int reason) "reason=%d"
> -qemu_system_shutdown_request(int reason) "reason=%d"
> -qemu_system_powerdown_request(void) ""
> -
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
>  dma_aio_cancel(void *dbs) "dbs=%p"
> @@ -55,17 +39,6 @@ ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_
>  memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
>  memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
>  
> -# memory.c
> -memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -flatview_new(void *view, void *root) "%p (root %p)"
> -flatview_destroy(void *view, void *root) "%p (root %p)"
> -flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> -
>  # gdbstub.c
>  gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
>  gdbstub_op_exiting(uint8_t code) "notifying exit with code=0x%02x"
> 


