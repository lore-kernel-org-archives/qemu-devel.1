Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A7C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFF3218A3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFF3218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzhx-0007O4-15
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:11:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzgR-00062j-5U
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzgP-0006vy-I7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzgP-0006vY-6Y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB300308FC4D
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:09:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 193C3600C2;
	Fri, 12 Apr 2019 17:09:42 +0000 (UTC)
Date: Fri, 12 Apr 2019 18:09:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412170939.GJ2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-5-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 17:09:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/17] tcg: Simplify how dump_exec_info()
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
Message-ID: <20190412170940.I8QopPNOqmpsfLWX72VUWcjzaW3cXhShEbfvs3UKtfc@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> dump_exec_info() takes an fprintf()-like callback and a FILE * to pass
> to it.
> 
> Its only caller hmp_info_jit() passes monitor_fprintf() and the
> current monitor cast to FILE *.  monitor_fprintf() casts it right
> back, and is otherwise identical to monitor_printf().  The
> type-punning is ugly.
> 
> Drop the callback, and call qemu_printf() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/tcg/translate-all.c | 45 ++++++++++++++++++++-------------------
>  include/exec/cpu-all.h    |  2 +-
>  monitor.c                 |  2 +-
>  tcg/tcg.c                 | 41 ++++++++++++++++++-----------------
>  tcg/tcg.h                 |  2 +-
>  5 files changed, 47 insertions(+), 45 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 85e80a1fad..75a6cf49f1 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -50,6 +50,7 @@
>  #include "translate-all.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  #include "qemu/timer.h"
>  #include "qemu/main-loop.h"
>  #include "exec/log.h"
> @@ -2214,8 +2215,7 @@ void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr)
>      tb_jmp_cache_clear_page(cpu, addr);
>  }
>  
> -static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
> -                                 struct qht_stats hst)
> +static void print_qht_statistics(struct qht_stats hst)
>  {
>      uint32_t hgram_opts;
>      size_t hgram_bins;
> @@ -2224,7 +2224,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
>      if (!hst.head_buckets) {
>          return;
>      }
> -    cpu_fprintf(f, "TB hash buckets     %zu/%zu (%0.2f%% head buckets used)\n",
> +    qemu_printf("TB hash buckets     %zu/%zu (%0.2f%% head buckets used)\n",
>                  hst.used_head_buckets, hst.head_buckets,
>                  (double)hst.used_head_buckets / hst.head_buckets * 100);
>  
> @@ -2234,7 +2234,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
>          hgram_opts |= QDIST_PR_NODECIMAL;
>      }
>      hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
> -    cpu_fprintf(f, "TB hash occupancy   %0.2f%% avg chain occ. Histogram: %s\n",
> +    qemu_printf("TB hash occupancy   %0.2f%% avg chain occ. Histogram: %s\n",
>                  qdist_avg(&hst.occupancy) * 100, hgram);
>      g_free(hgram);
>  
> @@ -2247,7 +2247,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
>          hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
>      }
>      hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
> -    cpu_fprintf(f, "TB hash avg chain   %0.3f buckets. Histogram: %s\n",
> +    qemu_printf("TB hash avg chain   %0.3f buckets. Histogram: %s\n",
>                  qdist_avg(&hst.chain), hgram);
>      g_free(hgram);
>  }
> @@ -2285,7 +2285,7 @@ static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
>      return false;
>  }
>  
> -void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
> +void dump_exec_info(void)
>  {
>      struct tb_tree_stats tst = {};
>      struct qht_stats hst;
> @@ -2294,43 +2294,44 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>      tcg_tb_foreach(tb_tree_stats_iter, &tst);
>      nb_tbs = tst.nb_tbs;
>      /* XXX: avoid using doubles ? */
> -    cpu_fprintf(f, "Translation buffer state:\n");
> +    qemu_printf("Translation buffer state:\n");
>      /*
>       * Report total code size including the padding and TB structs;
>       * otherwise users might think "-tb-size" is not honoured.
>       * For avg host size we use the precise numbers from tb_tree_stats though.
>       */
> -    cpu_fprintf(f, "gen code size       %zu/%zu\n",
> +    qemu_printf("gen code size       %zu/%zu\n",
>                  tcg_code_size(), tcg_code_capacity());
> -    cpu_fprintf(f, "TB count            %zu\n", nb_tbs);
> -    cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
> +    qemu_printf("TB count            %zu\n", nb_tbs);
> +    qemu_printf("TB avg target size  %zu max=%zu bytes\n",
>                  nb_tbs ? tst.target_size / nb_tbs : 0,
>                  tst.max_target_size);
> -    cpu_fprintf(f, "TB avg host size    %zu bytes (expansion ratio: %0.1f)\n",
> +    qemu_printf("TB avg host size    %zu bytes (expansion ratio: %0.1f)\n",
>                  nb_tbs ? tst.host_size / nb_tbs : 0,
>                  tst.target_size ? (double)tst.host_size / tst.target_size : 0);
> -    cpu_fprintf(f, "cross page TB count %zu (%zu%%)\n", tst.cross_page,
> -            nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
> -    cpu_fprintf(f, "direct jump count   %zu (%zu%%) (2 jumps=%zu %zu%%)\n",
> +    qemu_printf("cross page TB count %zu (%zu%%)\n", tst.cross_page,
> +                nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
> +    qemu_printf("direct jump count   %zu (%zu%%) (2 jumps=%zu %zu%%)\n",
>                  tst.direct_jmp_count,
>                  nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
>                  tst.direct_jmp2_count,
>                  nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
>  
>      qht_statistics_init(&tb_ctx.htable, &hst);
> -    print_qht_statistics(f, cpu_fprintf, hst);
> +    print_qht_statistics(hst);
>      qht_statistics_destroy(&hst);
>  
> -    cpu_fprintf(f, "\nStatistics:\n");
> -    cpu_fprintf(f, "TB flush count      %u\n",
> +    qemu_printf("\nStatistics:\n");
> +    qemu_printf("TB flush count      %u\n",
>                  atomic_read(&tb_ctx.tb_flush_count));
> -    cpu_fprintf(f, "TB invalidate count %zu\n", tcg_tb_phys_invalidate_count());
> +    qemu_printf("TB invalidate count %zu\n",
> +                tcg_tb_phys_invalidate_count());
>  
>      tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
> -    cpu_fprintf(f, "TLB full flushes    %zu\n", flush_full);
> -    cpu_fprintf(f, "TLB partial flushes %zu\n", flush_part);
> -    cpu_fprintf(f, "TLB elided flushes  %zu\n", flush_elide);
> -    tcg_dump_info(f, cpu_fprintf);
> +    qemu_printf("TLB full flushes    %zu\n", flush_full);
> +    qemu_printf("TLB partial flushes %zu\n", flush_part);
> +    qemu_printf("TLB elided flushes  %zu\n", flush_elide);
> +    tcg_dump_info();
>  }
>  
>  void dump_opcount_info(void)
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 40f5edf4dc..da07ce311f 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -362,7 +362,7 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
>      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
>  }
>  
> -void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
> +void dump_exec_info(void);
>  void dump_opcount_info(void);
>  #endif /* !CONFIG_USER_ONLY */
>  
> diff --git a/monitor.c b/monitor.c
> index 30a7ffe32b..24e4d49d11 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1318,7 +1318,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>          return;
>      }
>  
> -    dump_exec_info((FILE *)mon, monitor_fprintf);
> +    dump_exec_info();
>      dump_drift_info((FILE *)mon, monitor_fprintf);
>  }
>  
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index cc5f4e2a03..6a22c8746c 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4015,7 +4015,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>  }
>  
>  #ifdef CONFIG_PROFILER
> -void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf)
> +void tcg_dump_info(void)
>  {
>      TCGProfile prof = {};
>      const TCGProfile *s;
> @@ -4029,52 +4029,53 @@ void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf)
>      tb_div_count = tb_count ? tb_count : 1;
>      tot = s->interm_time + s->code_time;
>  
> -    cpu_fprintf(f, "JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
> +    qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
>                  tot, tot / 2.4e9);
> -    cpu_fprintf(f, "translated TBs      %" PRId64 " (aborted=%" PRId64 " %0.1f%%)\n", 
> +    qemu_printf("translated TBs      %" PRId64 " (aborted=%" PRId64
> +                " %0.1f%%)\n",
>                  tb_count, s->tb_count1 - tb_count,
>                  (double)(s->tb_count1 - s->tb_count)
>                  / (s->tb_count1 ? s->tb_count1 : 1) * 100.0);
> -    cpu_fprintf(f, "avg ops/TB          %0.1f max=%d\n", 
> +    qemu_printf("avg ops/TB          %0.1f max=%d\n",
>                  (double)s->op_count / tb_div_count, s->op_count_max);
> -    cpu_fprintf(f, "deleted ops/TB      %0.2f\n",
> +    qemu_printf("deleted ops/TB      %0.2f\n",
>                  (double)s->del_op_count / tb_div_count);
> -    cpu_fprintf(f, "avg temps/TB        %0.2f max=%d\n",
> +    qemu_printf("avg temps/TB        %0.2f max=%d\n",
>                  (double)s->temp_count / tb_div_count, s->temp_count_max);
> -    cpu_fprintf(f, "avg host code/TB    %0.1f\n",
> +    qemu_printf("avg host code/TB    %0.1f\n",
>                  (double)s->code_out_len / tb_div_count);
> -    cpu_fprintf(f, "avg search data/TB  %0.1f\n",
> +    qemu_printf("avg search data/TB  %0.1f\n",
>                  (double)s->search_out_len / tb_div_count);
>      
> -    cpu_fprintf(f, "cycles/op           %0.1f\n", 
> +    qemu_printf("cycles/op           %0.1f\n",
>                  s->op_count ? (double)tot / s->op_count : 0);
> -    cpu_fprintf(f, "cycles/in byte      %0.1f\n", 
> +    qemu_printf("cycles/in byte      %0.1f\n",
>                  s->code_in_len ? (double)tot / s->code_in_len : 0);
> -    cpu_fprintf(f, "cycles/out byte     %0.1f\n", 
> +    qemu_printf("cycles/out byte     %0.1f\n",
>                  s->code_out_len ? (double)tot / s->code_out_len : 0);
> -    cpu_fprintf(f, "cycles/search byte     %0.1f\n",
> +    qemu_printf("cycles/search byte     %0.1f\n",
>                  s->search_out_len ? (double)tot / s->search_out_len : 0);
>      if (tot == 0) {
>          tot = 1;
>      }
> -    cpu_fprintf(f, "  gen_interm time   %0.1f%%\n", 
> +    qemu_printf("  gen_interm time   %0.1f%%\n",
>                  (double)s->interm_time / tot * 100.0);
> -    cpu_fprintf(f, "  gen_code time     %0.1f%%\n", 
> +    qemu_printf("  gen_code time     %0.1f%%\n",
>                  (double)s->code_time / tot * 100.0);
> -    cpu_fprintf(f, "optim./code time    %0.1f%%\n",
> +    qemu_printf("optim./code time    %0.1f%%\n",
>                  (double)s->opt_time / (s->code_time ? s->code_time : 1)
>                  * 100.0);
> -    cpu_fprintf(f, "liveness/code time  %0.1f%%\n", 
> +    qemu_printf("liveness/code time  %0.1f%%\n",
>                  (double)s->la_time / (s->code_time ? s->code_time : 1) * 100.0);
> -    cpu_fprintf(f, "cpu_restore count   %" PRId64 "\n",
> +    qemu_printf("cpu_restore count   %" PRId64 "\n",
>                  s->restore_count);
> -    cpu_fprintf(f, "  avg cycles        %0.1f\n",
> +    qemu_printf("  avg cycles        %0.1f\n",
>                  s->restore_count ? (double)s->restore_time / s->restore_count : 0);
>  }
>  #else
> -void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf)
> +void tcg_dump_info(void)
>  {
> -    cpu_fprintf(f, "[TCG profiler not compiled]\n");
> +    qemu_printf("[TCG profiler not compiled]\n");
>  }
>  #endif
>  
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 9f2b03f119..a394d78237 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1017,7 +1017,7 @@ int tcg_check_temp_count(void);
>  #endif
>  
>  int64_t tcg_cpu_exec_time(void);
> -void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf);
> +void tcg_dump_info(void);
>  void tcg_dump_op_count(void);
>  
>  #define TCG_CT_ALIAS  0x80
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

