Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB63C41517
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081C022CB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcHWLe3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081C022CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr26j-0002ZF-6D
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hr26P-0001YO-Ts
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hr26N-0000vP-Db
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:25:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hr26N-0000rs-2e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:25:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id u25so37662008wmc.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=B2UcVHqmHJ7/yr7MdEAs3z59zcAMu9VdPW0poRAJjhU=;
 b=zcHWLe3DRSTZ0P9Oy0dAZwH6OHlo5TsHt1y6w0AvQqxLJa0Awl2vNm9xa4NBbZkeHq
 8NBOymkCRCAEdBHrKEKfaAvDEi5Hh0jWFXvn7UTYKhHX7zn4MXOn4PdisxFxUsyXZ00R
 GfwNsPfxcDUCi6PXo7ryh1XgPgAat1TAcmBO1vlVEarArcbeaibntm5YuDJryDmMyUrp
 k+nFpOpCGEeicvyppjJH4aO3gXaCrYz9Z1iwcyUamqFCVOpY3IEE3GHLyZ/mABi7FiPL
 PMMOlQBof4hjVWyf1+X/fmsjcaruos0Yg9Isq/o0v5dK9W8j+GO7MX+lBUkzko540jlR
 GnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=B2UcVHqmHJ7/yr7MdEAs3z59zcAMu9VdPW0poRAJjhU=;
 b=XWd6EimUr/A5nRoxx8mzYqv4/mrQqojS1Ah0+RekvkQ830n/eaM0zm8PZ/MKRvS5VF
 7/xclxYruXfC4IrZyDmzNNRryz4hBnD4aXpQ5Je6l5+m1XhJVKQmNfHdYDjTf6nFTSAX
 4kCpY0H3B6Tzx6IaP9Q3z1wWeRoxvg/nfDgfL/ymiweS/HwmDGhGjza6A/wwq/KrHq6c
 KCsv0nrX4YfZY9cPgRgwlGbqTgOVSob+qpWsAUq3uPO+B7Ay9h/WHlsnQg5elKEqLums
 CfJmYRIfZU11z8sPDGx9uBKjOCbT4GFarSnUPgrH0cuj/Gimsb/cc4s2B4OaU491oWYX
 uoUg==
X-Gm-Message-State: APjAAAXgpFJrbaJENyStGxqc8K/+RqS3I74Vkyr5RWCfYiXivL014I62
 ZS+LUJop0hiT4UCpekaE0J/xmQ==
X-Google-Smtp-Source: APXvYqwFV11wNsM/VDWVTHIKNjL0dk3R6YpKeIChnpVtjfWVLON+3l1o5zH1+xKKjXcZUKS12owybw==
X-Received: by 2002:a05:600c:2199:: with SMTP id
 e25mr82417239wme.72.1564154745538; 
 Fri, 26 Jul 2019 08:25:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k124sm84337707wmk.47.2019.07.26.08.25.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 08:25:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5DB071FF87;
 Fri, 26 Jul 2019 16:25:44 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-5-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-5-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 16:25:44 +0100
Message-ID: <87pnlwhl6v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4 4/7] accel: replacing part of
 CONFIG_PROFILER with TBStats
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> We add some of the statistics collected in the TCGProfiler
> into the TBStats, having the statistics not only for the whole
> emulation but for each TB. Then, we removed these stats
> from TCGProfiler and reconstruct the information for the
> "info jit" using the sum of all TBStats statistics.
>
> The goal is to have one unique and better way of collecting
> emulation statistics. Moreover, checking dynamiclly if the
> profiling is enabled showed to have an insignificant impact
> on the performance:
> https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality#Overheads.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/Makefile.objs   |   2 +-
>  accel/tcg/tb-stats.c      | 107 ++++++++++++++++++++++++++++++++++++++
>  accel/tcg/translate-all.c |  10 ++--
>  include/exec/tb-stats.h   |   9 ++++
>  tcg/tcg.c                 |  93 ++++-----------------------------
>  tcg/tcg.h                 |  10 ----
>  6 files changed, 131 insertions(+), 100 deletions(-)
>  create mode 100644 accel/tcg/tb-stats.c
>
> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
> index d381a02f34..49ffe81b5d 100644
> --- a/accel/tcg/Makefile.objs
> +++ b/accel/tcg/Makefile.objs
> @@ -2,7 +2,7 @@ obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
>  obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
>  obj-y +=3D tcg-runtime.o tcg-runtime-gvec.o
>  obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
> -obj-y +=3D translator.o
> +obj-y +=3D translator.o tb-stats.o
>
>  obj-$(CONFIG_USER_ONLY) +=3D user-exec.o
>  obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D user-exec-stub.o
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> new file mode 100644
> index 0000000000..44497d4f9b
> --- /dev/null
> +++ b/accel/tcg/tb-stats.c
> @@ -0,0 +1,107 @@
> +#include "qemu/osdep.h"
> +
> +#include "disas/disas.h"
> +#include "exec/exec-all.h"
> +#include "tcg.h"
> +
> +#include "qemu/qemu-print.h"
> +
> +struct jit_profile_info {
> +    uint64_t translations;
> +    uint64_t aborted;
> +    uint64_t ops;
> +    unsigned ops_max;
> +    uint64_t del_ops;
> +    uint64_t temps;
> +    unsigned temps_max;
> +    uint64_t host;
> +    uint64_t guest;
> +    uint64_t host_ins;
> +    uint64_t search_data;
> +};
> +
> +/* accumulate the statistics from all TBs */
> +static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
> +{
> +    struct jit_profile_info *jpi =3D userp;
> +    TBStatistics *tbs =3D p;
> +
> +    jpi->translations +=3D tbs->translations.total;
> +    jpi->ops +=3D tbs->code.num_tcg_ops;
> +    if (tbs->translations.total && tbs->code.num_tcg_ops / tbs->translat=
ions.total
> +            > jpi->ops_max) {
> +        jpi->ops_max =3D tbs->code.num_tcg_ops / tbs->translations.total;
> +    }
> +    jpi->del_ops +=3D tbs->code.deleted_ops;
> +    jpi->temps +=3D tbs->code.temps;
> +    if (tbs->translations.total && tbs->code.temps / tbs->translations.t=
otal >
> +            jpi->temps_max) {
> +        jpi->temps_max =3D tbs->code.temps / tbs->translations.total;
> +    }
> +    jpi->host +=3D tbs->code.out_len;
> +    jpi->guest +=3D tbs->code.in_len;
> +    jpi->host_ins +=3D tbs->code.num_host_inst;
> +    jpi->search_data +=3D tbs->code.search_out_len;
> +}
> +
> +/* dump JIT statisticis using TCGProfile and TBStats */
> +void dump_jit_profile_info(TCGProfile *s)
> +{
> +    if (!tb_stats_collection_enabled()) {
> +        return;
> +    }
> +
> +    struct jit_profile_info *jpi =3D g_new0(struct jit_profile_info,
>  1);

This leaks and needs to be freed after we are done.

> +
> +    qht_iter(&tb_ctx.tb_stats, collect_jit_profile_info, jpi);
> +
> +    if (jpi->translations) {
> +        qemu_printf("translated TBs      %" PRId64 "\n", jpi->translatio=
ns);
> +        qemu_printf("avg ops/TB          %0.1f max=3D%d\n",
> +                jpi->ops / (double) jpi->translations, jpi->ops_max);
> +        qemu_printf("deleted ops/TB      %0.2f\n",
> +                jpi->del_ops / (double) jpi->translations);
> +        qemu_printf("avg temps/TB        %0.2f max=3D%d\n",
> +                jpi->temps / (double) jpi->translations, jpi->temps_max);
> +        qemu_printf("avg host code/TB    %0.1f\n",
> +                jpi->host / (double) jpi->translations);
> +        qemu_printf("avg host ins/TB     %0.1f\n",
> +                jpi->host_ins / (double) jpi->translations);
> +        qemu_printf("avg search data/TB  %0.1f\n",
> +                jpi->search_data / (double) jpi->translations);
> +
> +        if (s) {
> +            int64_t tot =3D s->interm_time + s->code_time;
> +            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4=
 GHz)\n",
> +                            tot, tot / 2.4e9);
> +            qemu_printf("cycles/op           %0.1f\n",
> +                        jpi->ops ? (double)tot / jpi->ops : 0);
> +            qemu_printf("cycles/in byte      %0.1f\n",
> +                        jpi->guest ? (double)tot / jpi->guest : 0);
> +            qemu_printf("cycles/out byte     %0.1f\n",
> +                        jpi->host ? (double)tot / jpi->host : 0);
> +            qemu_printf("cycles/out inst     %0.1f\n",
> +                        jpi->host_ins ? (double)tot / jpi->host_ins : 0);
> +            qemu_printf("cycles/search byte     %0.1f\n",
> +                        jpi->search_data ? (double)tot / jpi->search_dat=
a : 0);
> +            if (tot =3D=3D 0) {
> +                tot =3D 1;
> +            }
> +            qemu_printf("  gen_interm time   %0.1f%%\n",
> +                        (double)s->interm_time / tot * 100.0);
> +            qemu_printf("  gen_code time     %0.1f%%\n",
> +                        (double)s->code_time / tot * 100.0);
> +            qemu_printf("optim./code time    %0.1f%%\n",
> +                        (double)s->opt_time / (s->code_time ? s->code_ti=
me : 1)
> +                        * 100.0);
> +            qemu_printf("liveness/code time  %0.1f%%\n",
> +                    (double)s->la_time / (s->code_time ? s->code_time : =
1) * 100.0);
> +            qemu_printf("cpu_restore count   %" PRId64 "\n",
> +                    s->restore_count);
> +            qemu_printf("  avg cycles        %0.1f\n",
> +                    s->restore_count ? (double)s->restore_time / s->rest=
ore_count : 0);
> +        }
> +    }
> +}
> +
> +
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 3a47ac6f2c..bbdb0f23a4 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1773,8 +1773,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>   tb_overflow:
>
>  #ifdef CONFIG_PROFILER
> -    /* includes aborted translations because of exceptions */
> -    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
>      ti =3D profile_getclock();
>  #endif

I assume from the conversation on IRC we can add the profile clocks here
as well. I wonder if execution time could also be added (under a new
tbstats flag)? The data might be too noisy given the time to collect
timestamps vs the relatively short block length.

>
> @@ -1822,7 +1820,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      }
>
>  #ifdef CONFIG_PROFILER
> -    atomic_set(&prof->tb_count, prof->tb_count + 1);
>      atomic_set(&prof->interm_time, prof->interm_time + profile_getclock(=
) - ti);
>      ti =3D profile_getclock();
>  #endif
> @@ -1869,12 +1866,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>
>  #ifdef CONFIG_PROFILER
>      atomic_set(&prof->code_time, prof->code_time + profile_getclock() - =
ti);
> -    atomic_set(&prof->code_in_len, prof->code_in_len + tb->size);
> -    atomic_set(&prof->code_out_len, prof->code_out_len + gen_code_size);
> -    atomic_set(&prof->search_out_len, prof->search_out_len + search_size=
);
>  #endif
>
>      if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        atomic_add(&tb->tb_stats->code.in_len, tb->size);
> +        atomic_add(&tb->tb_stats->code.out_len, gen_code_size);

If we are switching num_host_insns to num_host_bytes we don't need a
duplicate here.

> +        atomic_add(&tb->tb_stats->code.search_out_len, search_size);
> +
>          size_t code_size =3D gen_code_size;
>          if (tcg_ctx->data_gen_ptr) {
>              code_size =3D tcg_ctx->data_gen_ptr - tb->tc.ptr;
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 6584b78c4a..7d775f2c0d 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -40,6 +40,13 @@ struct TBStatistics {
>          unsigned num_tcg_ops;
>          unsigned num_tcg_ops_opt;
>          unsigned spills;
> +
> +        /* CONFIG_PROFILE */
> +        unsigned temps;
> +        unsigned deleted_ops;
> +        unsigned in_len;
> +        unsigned out_len;
> +        unsigned search_out_len;
>      } code;
>
>      struct {
> @@ -51,4 +58,6 @@ struct TBStatistics {
>
>  bool tb_stats_cmp(const void *ap, const void *bp);
>
> +void dump_jit_profile_info(TCGProfile *s);
> +
>  #endif
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 446e3d1708..46b31a2f68 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2295,9 +2295,9 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
>      QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
>      s->nb_ops--;
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
> -#endif
> +    if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
> +        atomic_inc(&s->current_tb->tb_stats->code.deleted_ops);
> +    }
>  }
>
>  static TCGOp *tcg_op_alloc(TCGOpcode opc)
> @@ -3914,16 +3914,6 @@ void tcg_profile_snapshot(TCGProfile *prof, bool c=
ounters, bool table)
>
>          if (counters) {
>              PROF_ADD(prof, orig, cpu_exec_time);
> -            PROF_ADD(prof, orig, tb_count1);
> -            PROF_ADD(prof, orig, tb_count);
> -            PROF_ADD(prof, orig, op_count);
> -            PROF_MAX(prof, orig, op_count_max);
> -            PROF_ADD(prof, orig, temp_count);
> -            PROF_MAX(prof, orig, temp_count_max);
> -            PROF_ADD(prof, orig, del_op_count);
> -            PROF_ADD(prof, orig, code_in_len);
> -            PROF_ADD(prof, orig, code_out_len);
> -            PROF_ADD(prof, orig, search_out_len);
>              PROF_ADD(prof, orig, interm_time);
>              PROF_ADD(prof, orig, code_time);
>              PROF_ADD(prof, orig, la_time);
> @@ -4003,26 +3993,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      TCGOp *op;
>
>      s->current_tb =3D tb;
> -
> -#ifdef CONFIG_PROFILER
> -    {
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
>          int n =3D 0;
>
>          QTAILQ_FOREACH(op, &s->ops, link) {
>              n++;
>          }
> -        atomic_set(&prof->op_count, prof->op_count + n);
> -        if (n > prof->op_count_max) {
> -            atomic_set(&prof->op_count_max, n);
> -        }
> +        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
>
>          n =3D s->nb_temps;
> -        atomic_set(&prof->temp_count, prof->temp_count + n);
> -        if (n > prof->temp_count_max) {
> -            atomic_set(&prof->temp_count_max, n);
> -        }
> +        atomic_add(&tb->tb_stats->code.temps, n);
>      }
> -#endif
>
>  #ifdef DEBUG_DISAS
>      if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
> @@ -4229,70 +4210,16 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      return tcg_current_code_size(s);
>  }
>
> -#ifdef CONFIG_PROFILER
>  void tcg_dump_info(void)
>  {
> +    TCGProfile *s =3D NULL;
> +#ifdef CONFIG_PROFILER
>      TCGProfile prof =3D {};
> -    const TCGProfile *s;
> -    int64_t tb_count;
> -    int64_t tb_div_count;
> -    int64_t tot;
> -
>      tcg_profile_snapshot_counters(&prof);
>      s =3D &prof;
> -    tb_count =3D s->tb_count;
> -    tb_div_count =3D tb_count ? tb_count : 1;
> -    tot =3D s->interm_time + s->code_time;
> -
> -    qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
> -                tot, tot / 2.4e9);
> -    qemu_printf("translated TBs      %" PRId64 " (aborted=3D%" PRId64
> -                " %0.1f%%)\n",
> -                tb_count, s->tb_count1 - tb_count,
> -                (double)(s->tb_count1 - s->tb_count)
> -                / (s->tb_count1 ? s->tb_count1 : 1) * 100.0);
> -    qemu_printf("avg ops/TB          %0.1f max=3D%d\n",
> -                (double)s->op_count / tb_div_count, s->op_count_max);
> -    qemu_printf("deleted ops/TB      %0.2f\n",
> -                (double)s->del_op_count / tb_div_count);
> -    qemu_printf("avg temps/TB        %0.2f max=3D%d\n",
> -                (double)s->temp_count / tb_div_count, s->temp_count_max);
> -    qemu_printf("avg host code/TB    %0.1f\n",
> -                (double)s->code_out_len / tb_div_count);
> -    qemu_printf("avg search data/TB  %0.1f\n",
> -                (double)s->search_out_len / tb_div_count);
> -
> -    qemu_printf("cycles/op           %0.1f\n",
> -                s->op_count ? (double)tot / s->op_count : 0);
> -    qemu_printf("cycles/in byte      %0.1f\n",
> -                s->code_in_len ? (double)tot / s->code_in_len : 0);
> -    qemu_printf("cycles/out byte     %0.1f\n",
> -                s->code_out_len ? (double)tot / s->code_out_len : 0);
> -    qemu_printf("cycles/search byte     %0.1f\n",
> -                s->search_out_len ? (double)tot / s->search_out_len : 0);
> -    if (tot =3D=3D 0) {
> -        tot =3D 1;
> -    }
> -    qemu_printf("  gen_interm time   %0.1f%%\n",
> -                (double)s->interm_time / tot * 100.0);
> -    qemu_printf("  gen_code time     %0.1f%%\n",
> -                (double)s->code_time / tot * 100.0);
> -    qemu_printf("optim./code time    %0.1f%%\n",
> -                (double)s->opt_time / (s->code_time ? s->code_time : 1)
> -                * 100.0);
> -    qemu_printf("liveness/code time  %0.1f%%\n",
> -                (double)s->la_time / (s->code_time ? s->code_time : 1) *=
 100.0);
> -    qemu_printf("cpu_restore count   %" PRId64 "\n",
> -                s->restore_count);
> -    qemu_printf("  avg cycles        %0.1f\n",
> -                s->restore_count ? (double)s->restore_time / s->restore_=
count : 0);
> -}
> -#else
> -void tcg_dump_info(void)
> -{
> -    qemu_printf("[TCG profiler not compiled]\n");
> -}
>  #endif
> +    dump_jit_profile_info(s);
> +}
>
>  #ifdef ELF_HOST_MACHINE
>  /* In order to use this feature, the backend needs to do three things:
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index bf6f3bcba3..026a066b9a 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -644,16 +644,6 @@ QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
>
>  typedef struct TCGProfile {
>      int64_t cpu_exec_time;
> -    int64_t tb_count1;
> -    int64_t tb_count;
> -    int64_t op_count; /* total insn count */
> -    int op_count_max; /* max insn per TB */
> -    int temp_count_max;
> -    int64_t temp_count;
> -    int64_t del_op_count;
> -    int64_t code_in_len;
> -    int64_t code_out_len;
> -    int64_t search_out_len;
>      int64_t interm_time;
>      int64_t code_time;
>      int64_t la_time;


--
Alex Benn=C3=A9e

