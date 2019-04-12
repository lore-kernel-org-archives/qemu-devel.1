Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78909C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8AC218A3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8AC218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40319 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzhp-000763-JB
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:11:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzVH-0004bd-Lq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzVG-0002pN-IX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzVG-0002of-8q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:58:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 915D2C057F47
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:58:13 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4B266013A;
	Fri, 12 Apr 2019 16:58:12 +0000 (UTC)
Date: Fri, 12 Apr 2019 17:58:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412165809.GI2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-4-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 12 Apr 2019 16:58:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/17] tcg: Simplify how
 dump_opcount_info() prints
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
Message-ID: <20190412165810.o8neqG21U9-Rxmo5ioRCNzeLv5PNgYZfT1kIBYr-qEI@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> dump_opcount_info() takes an fprintf()-like callback and a FILE * to
> pass to it.
> 
> Its only caller hmp_info_opcount() passes monitor_fprintf() and the
> current monitor cast to FILE *.  monitor_fprintf() casts it right
> back, and is otherwise identical to monitor_printf().  The
> type-punning is ugly.
> 
> Drop the callback, and call qemu_printf() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/tcg/translate-all.c | 4 ++--
>  include/exec/cpu-all.h    | 2 +-
>  monitor.c                 | 2 +-
>  tcg/tcg.c                 | 9 +++++----
>  tcg/tcg.h                 | 2 +-
>  5 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 8f593b926f..85e80a1fad 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2333,9 +2333,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>      tcg_dump_info(f, cpu_fprintf);
>  }
>  
> -void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
> +void dump_opcount_info(void)
>  {
> -    tcg_dump_op_count(f, cpu_fprintf);
> +    tcg_dump_op_count();
>  }
>  
>  #else /* CONFIG_USER_ONLY */
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index b16c9ec513..40f5edf4dc 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -363,7 +363,7 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
>  }
>  
>  void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
> -void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
> +void dump_opcount_info(void);
>  #endif /* !CONFIG_USER_ONLY */
>  
>  int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
> diff --git a/monitor.c b/monitor.c
> index a3e66b7159..30a7ffe32b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1324,7 +1324,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  
>  static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  {
> -    dump_opcount_info((FILE *)mon, monitor_fprintf);
> +    dump_opcount_info();
>  }
>  #endif
>  
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 9b2bf7f439..cc5f4e2a03 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -33,6 +33,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
>  #include "qemu/host-utils.h"
> +#include "qemu/qemu-print.h"
>  #include "qemu/timer.h"
>  
>  /* Note: the long term plan is to reduce the dependencies on the QEMU
> @@ -3768,14 +3769,14 @@ static void tcg_profile_snapshot_table(TCGProfile *prof)
>      tcg_profile_snapshot(prof, false, true);
>  }
>  
> -void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
> +void tcg_dump_op_count(void)
>  {
>      TCGProfile prof = {};
>      int i;
>  
>      tcg_profile_snapshot_table(&prof);
>      for (i = 0; i < NB_OPS; i++) {
> -        cpu_fprintf(f, "%s %" PRId64 "\n", tcg_op_defs[i].name,
> +        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name,
>                      prof.table_op_count[i]);
>      }
>  }
> @@ -3795,9 +3796,9 @@ int64_t tcg_cpu_exec_time(void)
>      return ret;
>  }
>  #else
> -void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
> +void tcg_dump_op_count(void)
>  {
> -    cpu_fprintf(f, "[TCG profiler not compiled]\n");
> +    qemu_printf("[TCG profiler not compiled]\n");
>  }
>  
>  int64_t tcg_cpu_exec_time(void)
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 32b7cf3489..9f2b03f119 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1018,7 +1018,7 @@ int tcg_check_temp_count(void);
>  
>  int64_t tcg_cpu_exec_time(void);
>  void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf);
> -void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf);
> +void tcg_dump_op_count(void);
>  
>  #define TCG_CT_ALIAS  0x80
>  #define TCG_CT_IALIAS 0x40
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

