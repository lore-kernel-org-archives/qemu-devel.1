Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC4CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572632312C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdpkkW7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572632312C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JTC-0007dh-HJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3JSG-0007CW-TR
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:27:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3JS1-0002Lt-Ne
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596634044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqR0wc8ufPYsrTaG/m5AuBLfx/9X+/ojPkyqoZk/0G8=;
 b=AdpkkW7Wx0cOeeO4q61m9BlJwzGvieSZ+xDfwIhRY9sWC/p625CCth/zqsH9hqv6IxKZg/
 TqIePm6YuM/ClL7W+ybwOENdxzg86ZBB3T/gjQBmCyWSNWAVyo6vHwQd7PyLVEQ44XAzuV
 p+lJvVtDfGbt3WN9I8+5IXeLVwRjgpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-GusaaZ6pMkuJPcFnE86Fsw-1; Wed, 05 Aug 2020 09:27:22 -0400
X-MC-Unique: GusaaZ6pMkuJPcFnE86Fsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99180800FEF;
 Wed,  5 Aug 2020 13:27:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1221B47B;
 Wed,  5 Aug 2020 13:27:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73AD11141D60; Wed,  5 Aug 2020 15:27:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] softmmu: Add missing trace-events file
References: <20200805130221.24487-1-philmd@redhat.com>
Date: Wed, 05 Aug 2020 15:27:11 +0200
In-Reply-To: <20200805130221.24487-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 5 Aug 2020 15:02:20
 +0200")
Message-ID: <87wo2dmde8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Commit c7f419f584 moved softmmu-only files out of the root
> directory, but forgot to move the trace events, which should
> no longer be generated to "trace-root.h". Fix that by adding
> softmmu/trace-events.

Dang!  I'd like to have this in 5.1 if at all possible.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
> @@ -190,6 +190,7 @@ trace-events-subdirs +=3D hw/gpio
>  trace-events-subdirs +=3D hw/riscv
>  trace-events-subdirs +=3D migration
>  trace-events-subdirs +=3D net
> +trace-events-subdirs +=3D softmmu
>  trace-events-subdirs +=3D ui
>  endif
>  trace-events-subdirs +=3D hw/core
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
> =20
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
> =20
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
> =20
>  #include "exec/memory-internal.h"
>  #include "exec/ram_addr.h"
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 4eb9d1f7fd..f7b103467c 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -90,7 +90,7 @@
> =20
>  #include "disas/disas.h"
> =20
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
> +# Since requests are raised via monitor, not many tracepoints are needed=
.
> +balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
> +
> +# ioport.c
> +cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) va=
lue %u"
> +cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) v=
alue %u"
> +
> +# memory.c
> +memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t =
value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size=
 %u"
> +memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t=
 value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" siz=
e %u"
> +memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uin=
t64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
> +memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, ui=
nt64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
> +memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx6=
4" size %u"
> +memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
> +flatview_new(void *view, void *root) "%p (root %p)"
> +flatview_destroy(void *view, void *root) "%p (root %p)"
> +flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> +
> +# vl.c
> +vm_state_notify(int running, int reason, const char *reason_str) "runnin=
g %d reason %d (%s)"
> +load_file(const char *name, const char *path) "name %s location %s"
> +runstate_set(int current_state, const char *current_state_str, int new_s=
tate, const char *new_state_str) "current_run_state %d (%s) new_state %d (%=
s)"
> +system_wakeup_request(int reason) "reason=3D%d"
> +qemu_system_shutdown_request(int reason) "reason=3D%d"
> +qemu_system_powerdown_request(void) ""
> diff --git a/trace-events b/trace-events
> index 42107ebc69..5882c2d5fc 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -25,22 +25,6 @@
>  #
>  # The <format-string> should be a sprintf()-compatible format string.
> =20
> -# ioport.c
> -cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) va=
lue %u"
> -cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) v=
alue %u"
> -
> -# balloon.c
> -# Since requests are raised via monitor, not many tracepoints are needed=
.
> -balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
> -
> -# vl.c
> -vm_state_notify(int running, int reason, const char *reason_str) "runnin=
g %d reason %d (%s)"
> -load_file(const char *name, const char *path) "name %s location %s"
> -runstate_set(int current_state, const char *current_state_str, int new_s=
tate, const char *new_state_str) "current_run_state %d (%s) new_state %d (%=
s)"
> -system_wakeup_request(int reason) "reason=3D%d"
> -qemu_system_shutdown_request(int reason) "reason=3D%d"
> -qemu_system_powerdown_request(void) ""
> -
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=3D%p b=
s=3D%p offset=3D%" PRId64 " to_dev=3D%d"
>  dma_aio_cancel(void *dbs) "dbs=3D%p"
> @@ -55,17 +39,6 @@ ram_block_discard_range(const char *rbname, void *hva,=
 size_t length, bool need_
>  memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned=
 size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
>  memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
> =20
> -# memory.c
> -memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t =
value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size=
 %u"
> -memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t=
 value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" siz=
e %u"
> -memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uin=
t64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
> -memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, ui=
nt64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
> -memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx6=
4" size %u"
> -memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
> -flatview_new(void *view, void *root) "%p (root %p)"
> -flatview_destroy(void *view, void *root) "%p (root %p)"
> -flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> -
>  # gdbstub.c
>  gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
>  gdbstub_op_exiting(uint8_t code) "notifying exit with code=3D0x%02x"

scripts/cleanup-trace-events.pl finds these (and corrects them in-place,
which is not what we want here).  It finds a few more.  I'll look more
closely and report back.


