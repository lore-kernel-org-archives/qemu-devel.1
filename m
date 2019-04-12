Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DC1C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057E42077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057E42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzpj-00021X-8g
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:19:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzoo-0001iv-Od
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzon-0002ZP-QY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzon-0002ZD-GO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C2F459463
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:18:24 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E52B6091F;
	Fri, 12 Apr 2019 17:18:23 +0000 (UTC)
Date: Fri, 12 Apr 2019 18:18:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412171820.GK2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-6-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 12 Apr 2019 17:18:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/17] tcg: Simplify how dump_drift_info()
 prints
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412171820.BZCFTlH2bi32mnkjACypwuAEk2b7BUTemJxe6rUXdAA@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> dump_drift_info() takes an fprintf()-like callback and a FILE * to pass
> to it.

Me thinks there's a pattern here....

> Its only caller hmp_info_jit() passes monitor_fprintf() and a Monitor
> * cast to FILE *.  monitor_fprintf() casts it right back, and is
> otherwise identical to monitor_printf().  The type-punning is ugly.
> 
> Drop the callback, and call qemu_printf() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  cpus.c                | 15 +++++++++------
>  include/sysemu/cpus.h |  2 +-
>  monitor.c             |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index e83f72b48b..684aa9679a 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -31,6 +31,7 @@
>  #include "qapi/qapi-events-run-state.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/block-backend.h"
>  #include "exec/gdbstub.h"
> @@ -2454,19 +2455,21 @@ void qmp_inject_nmi(Error **errp)
>      nmi_monitor_handle(monitor_get_cpu_index(), errp);
>  }
>  
> -void dump_drift_info(FILE *f, fprintf_function cpu_fprintf)
> +void dump_drift_info(void)
>  {
>      if (!use_icount) {
>          return;
>      }
>  
> -    cpu_fprintf(f, "Host - Guest clock  %"PRIi64" ms\n",
> +    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
>                  (cpu_get_clock() - cpu_get_icount())/SCALE_MS);
>      if (icount_align_option) {
> -        cpu_fprintf(f, "Max guest delay     %"PRIi64" ms\n", -max_delay/SCALE_MS);
> -        cpu_fprintf(f, "Max guest advance   %"PRIi64" ms\n", max_advance/SCALE_MS);
> +        qemu_printf("Max guest delay     %"PRIi64" ms\n",
> +                    -max_delay / SCALE_MS);
> +        qemu_printf("Max guest advance   %"PRIi64" ms\n",
> +                    max_advance / SCALE_MS);
>      } else {
> -        cpu_fprintf(f, "Max guest delay     NA\n");
> -        cpu_fprintf(f, "Max guest advance   NA\n");
> +        qemu_printf("Max guest delay     NA\n");
> +        qemu_printf("Max guest advance   NA\n");
>      }
>  }
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index eea0010b53..ef13a120cc 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -19,7 +19,7 @@ extern int icount_align_option;
>  /* drift information for info jit command */
>  extern int64_t max_delay;
>  extern int64_t max_advance;
> -void dump_drift_info(FILE *f, fprintf_function cpu_fprintf);
> +void dump_drift_info(void);
>  
>  /* Unblock cpu */
>  void qemu_cpu_kick_self(void);
> diff --git a/monitor.c b/monitor.c
> index 24e4d49d11..7573689585 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1319,7 +1319,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>      }
>  
>      dump_exec_info();
> -    dump_drift_info((FILE *)mon, monitor_fprintf);
> +    dump_drift_info();
>  }
>  
>  static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

