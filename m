Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C952C0650E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED23B212F5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED23B212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajJN-0005qL-8l
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1haivs-0000JZ-4h
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1haivq-0004bJ-JP
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1haiqn-0008Ih-TZ; Tue, 11 Jun 2019 11:38:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB9F48110C;
 Tue, 11 Jun 2019 15:38:10 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6682960925;
 Tue, 11 Jun 2019 15:38:09 +0000 (UTC)
Date: Tue, 11 Jun 2019 16:38:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190611153806.GF2777@work-vm>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611134043.9524-7-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 15:38:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/11] Move monitor.c to monitor/misc.c
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Create a new monitor/ subdirectory and move monitor.c there. As the plan
> is to move the monitor core into separate files, use the chance to
> rename it to misc.c.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  docs/devel/writing-qmp-commands.txt |  2 +-
>  monitor.c => monitor/misc.c         |  2 +-
>  MAINTAINERS                         |  4 ++--
>  Makefile.objs                       |  1 +
>  Makefile.target                     |  3 ++-
>  monitor/Makefile.objs               |  1 +
>  monitor/trace-events                | 11 +++++++++++
>  trace-events                        | 10 ----------
>  8 files changed, 19 insertions(+), 15 deletions(-)
>  rename monitor.c => monitor/misc.c (99%)
>  create mode 100644 monitor/Makefile.objs
>  create mode 100644 monitor/trace-events
> 
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
> index 9dfc62bf5a..cc6ecd6d5d 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -470,7 +470,7 @@ it's good practice to always check for errors.
>  
>  Another important detail is that HMP's "info" commands don't go into the
>  hmp-commands.hx. Instead, they go into the info_cmds[] table, which is defined
> -in the monitor.c file. The entry for the "info alarmclock" follows:
> +in the monitor/misc.c file. The entry for the "info alarmclock" follows:
>  
>      {
>          .name       = "alarmclock",
> diff --git a/monitor.c b/monitor/misc.c
> similarity index 99%
> rename from monitor.c
> rename to monitor/misc.c
> index 56af8ed448..ea3de5cac1 100644
> --- a/monitor.c
> +++ b/monitor/misc.c
> @@ -62,7 +62,7 @@
>  #include "qapi/qmp/json-parser.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qom/object_interfaces.h"
> -#include "trace-root.h"
> +#include "trace.h"
>  #include "trace/control.h"
>  #include "monitor/hmp-target.h"
>  #ifdef CONFIG_TRACE_SIMPLE
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be1225415..10c082314c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1924,7 +1924,7 @@ F: qapi/run-state.json
>  Human Monitor (HMP)
>  M: Dr. David Alan Gilbert <dgilbert@redhat.com>
>  S: Maintained
> -F: monitor.c
> +F: monitor/misc.c
>  F: hmp.[ch]
>  F: hmp-commands*.hx
>  F: include/monitor/hmp-target.h
> @@ -2046,7 +2046,7 @@ QMP
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: qmp.c
> -F: monitor.c
> +F: monitor/misc.c
>  F: docs/devel/*qmp-*
>  F: docs/interop/*qmp-*
>  F: scripts/qmp/
> diff --git a/Makefile.objs b/Makefile.objs
> index c8337fa34b..dd39a70b48 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -130,6 +130,7 @@ trace-events-subdirs =
>  trace-events-subdirs += accel/kvm
>  trace-events-subdirs += accel/tcg
>  trace-events-subdirs += crypto
> +trace-events-subdirs += monitor
>  ifeq ($(CONFIG_USER_ONLY),y)
>  trace-events-subdirs += linux-user
>  endif
> diff --git a/Makefile.target b/Makefile.target
> index ecd856e3a3..72c267f7dc 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -148,9 +148,10 @@ endif #CONFIG_BSD_USER
>  #########################################################
>  # System emulator target
>  ifdef CONFIG_SOFTMMU
> -obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
> +obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o numa.o
>  obj-y += qtest.o
>  obj-y += hw/
> +obj-y += monitor/
>  obj-y += qapi/
>  obj-y += memory.o
>  obj-y += memory_mapping.o
> diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> new file mode 100644
> index 0000000000..e783b0616b
> --- /dev/null
> +++ b/monitor/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y += misc.o
> diff --git a/monitor/trace-events b/monitor/trace-events
> new file mode 100644
> index 0000000000..abfdf20b14
> --- /dev/null
> +++ b/monitor/trace-events
> @@ -0,0 +1,11 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# misc.c
> +monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
> +monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
> +monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
> +handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
> +handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
> +monitor_suspend(void *ptr, int cnt) "mon %p: %d"
> +monitor_qmp_cmd_in_band(const char *id) "%s"
> +monitor_qmp_cmd_out_of_band(const char *id) "%s"
> diff --git a/trace-events b/trace-events
> index 844ee58dd9..aeea3c2bdb 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -41,16 +41,6 @@ system_wakeup_request(int reason) "reason=%d"
>  qemu_system_shutdown_request(int reason) "reason=%d"
>  qemu_system_powerdown_request(void) ""
>  
> -# monitor.c
> -monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
> -monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
> -monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
> -handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
> -handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
> -monitor_suspend(void *ptr, int cnt) "mon %p: %d"
> -monitor_qmp_cmd_in_band(const char *id) "%s"
> -monitor_qmp_cmd_out_of_band(const char *id) "%s"
> -
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
>  dma_aio_cancel(void *dbs) "dbs=%p"
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

