Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF4C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B3920820
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh6D9XG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B3920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hFt-00036y-5a
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3h2b-0001oS-Sp
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3h2T-0001P5-7c
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:34:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3h2N-0001IU-MW
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:34:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so4197794wrv.11
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=T1+mi4QBJL+nXG55WIQJQBjvbbmEG0WV2wziZrIsJM4=;
 b=nh6D9XG1YhmejB8ZwM1DiHkFPyYoeXoD3BhO7Xc8p0PHyv4pGoppPD4d7oeQocOBl/
 3b2yKChVmbYh/LNQiYfdPYaaMHpnfjUCTfqml1nfH6AVMgxBLYEbpjIeHSLCtFuvoB5a
 9o0juR1FKkUwCw1TySsyX/E7jcSTvGhdLVPyFflRxhKQ+/HxzjV+wQtL3HQf5m7jprD7
 22aY/uVjCVBySYgedBF5V2TWXRwZX/9DPh06kP+hEMfVdSie+EHeSeIjGDoJi3oEnb6p
 q08kXi9JNE9fpanHy6KLF72PKP9haevbylbKU0ax7BvOQYoAQQiKYSD0++RkcFUQqtF1
 0oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=T1+mi4QBJL+nXG55WIQJQBjvbbmEG0WV2wziZrIsJM4=;
 b=AA1jXKsY2lPv/BYI3v4QViqTXlHMBa7OgG466i2HzDbbcmwPrADCgZ48Kb230h2dLT
 AOyrP7A9fouHejLbzMRzUwIiy0OAAUAOKz8tMUUrqwBhbFDEg+mD7yNZYS099alEMbwk
 HLb9rgihiNpl4zrIqdTq3MgD2OZ4qBHWyL6iH3mzuIZFXBqUtWgUltJ0uJQMSI8CfA+Y
 jacx7cDhYQuoBodkOFbswyUtsb/w4Xog6vo4YlhCEJRm3rhs6U98mXLGNZ0mM4BJE/mk
 xoohms/tR//ZLmS8+Ex/Z5zo54KydXfz3QBGb9J3D6zbAgAiCLSS77ooTqqnv8o7occ8
 2A7g==
X-Gm-Message-State: APjAAAX3YyKFnJZkPdt5Jsf+VcXhN3vzo7ZBRGKaQmJnZYORiqbj1SE2
 AdsvmXydQLHz6/tbv1iQohI2c7tgSkU=
X-Google-Smtp-Source: APXvYqyYpGmjchR64pRS0544BH4DrXGiB04iZ1xLAx9oHX2d7SFEcB3Y/nqWY3NUKNGN6YNdkhafmg==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr9328290wrr.170.1567170758880; 
 Fri, 30 Aug 2019 06:12:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l62sm9785765wml.13.2019.08.30.06.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 06:12:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 914B41FF87;
 Fri, 30 Aug 2019 14:12:37 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-6-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190829173437.5926-6-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 14:12:37 +0100
Message-ID: <87zhjq7q62.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v8 05/11] accel: adding TB_JIT_TIME and
 full replacing CONFIG_PROFILER
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 vandersonmr <vandersonmr2@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Replace all others CONFIG_PROFILER statistics and migrate it to
> TBStatistics system. However, TCGProfiler still exists and can
> be use to store global statistics and times. All TB related
> statistics goes to TBStatistics.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c      |  91 +++++++++++++++++++---------
>  accel/tcg/translate-all.c |  47 ++++++++-------
>  configure                 |   3 -
>  cpus.c                    |  14 ++---
>  include/exec/tb-stats.h   |  19 +++++-
>  include/qemu/timer.h      |   5 +-
>  monitor/misc.c            |  28 ++-------
>  tcg/tcg.c                 | 124 +++++++++++---------------------------
>  tcg/tcg.h                 |  10 +--
>  vl.c                      |   8 +--
>  10 files changed, 156 insertions(+), 193 deletions(-)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 176da60e13..66abc97ad4 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -32,6 +32,8 @@
>
>  #include "exec/tb-stats.h"
>
> +uint64_t dev_time;
> +
>  struct jit_profile_info {
>      uint64_t translations;
>      uint64_t aborted;
> @@ -43,6 +45,13 @@ struct jit_profile_info {
>      uint64_t host;
>      uint64_t guest;
>      uint64_t search_data;
> +
> +    uint64_t interm_time;
> +    uint64_t code_time;
> +    uint64_t restore_count;
> +    uint64_t restore_time;
> +    uint64_t opt_time;
> +    uint64_t la_time;
>  };
>
>  /* accumulate the statistics from all TBs */
> @@ -64,6 +73,29 @@ static void collect_jit_profile_info(void *p, uint32_t=
 hash, void *userp)
>      jpi->host +=3D tbs->code.out_len;
>      jpi->guest +=3D tbs->code.in_len;
>      jpi->search_data +=3D tbs->code.search_out_len;
> +
> +    jpi->interm_time +=3D stat_per_translation(tbs, time.interm);
> +    jpi->code_time +=3D stat_per_translation(tbs, time.code);
> +    jpi->opt_time +=3D stat_per_translation(tbs, time.opt);
> +    jpi->la_time +=3D stat_per_translation(tbs, time.la);
> +    jpi->restore_time +=3D tbs->time.restore;
> +    jpi->restore_count +=3D tbs->time.restore_count;
> +}
> +
> +void dump_jit_exec_time_info(uint64_t dev_time)
> +{
> +    static uint64_t last_cpu_exec_time;
> +    uint64_t cpu_exec_time;
> +    uint64_t delta;
> +
> +    cpu_exec_time =3D tcg_cpu_exec_time();
> +    delta =3D cpu_exec_time - last_cpu_exec_time;
> +
> +    qemu_printf("async time  %" PRId64 " (%0.3f)\n",
> +                   dev_time, dev_time / (double) NANOSECONDS_PER_SECOND);
> +    qemu_printf("qemu time   %" PRId64 " (%0.3f)\n",
> +                   delta, delta / (double) NANOSECONDS_PER_SECOND);
> +    last_cpu_exec_time =3D cpu_exec_time;
>  }
>
>  /* dump JIT statisticis using TCGProfile and TBStats */
> @@ -90,34 +122,39 @@ void dump_jit_profile_info(TCGProfile *s)
>          qemu_printf("avg search data/TB  %0.1f\n",
>                  jpi->search_data / (double) jpi->translations);
>
> +        uint64_t tot =3D jpi->interm_time + jpi->code_time;
> +
> +        qemu_printf("JIT cycles          %" PRId64 " (%0.3fs at 2.4 GHz)=
\n",
> +                tot, tot / 2.4e9);
> +        qemu_printf("  cycles/op           %0.1f\n",
> +                jpi->ops ? (double)tot / jpi->ops : 0);
> +        qemu_printf("  cycles/in byte      %0.1f\n",
> +                jpi->guest ? (double)tot / jpi->guest : 0);
> +        qemu_printf("  cycles/out byte     %0.1f\n",
> +                jpi->host ? (double)tot / jpi->host : 0);
> +        qemu_printf("  cycles/search byte  %0.1f\n",
> +                jpi->search_data ? (double)tot / jpi->search_data : 0);
> +        if (tot =3D=3D 0) {
> +            tot =3D 1;
> +        }
> +
> +        qemu_printf("  gen_interm time     %0.1f%%\n",
> +                (double)jpi->interm_time / tot * 100.0);
> +        qemu_printf("  gen_code time       %0.1f%%\n",
> +                (double)jpi->code_time / tot * 100.0);
> +
> +        qemu_printf("    optim./code time    %0.1f%%\n",
> +                (double)jpi->opt_time / (jpi->code_time ? jpi->code_time=
 : 1) * 100.0);
> +        qemu_printf("    liveness/code time  %0.1f%%\n",
> +                (double)jpi->la_time / (jpi->code_time ? jpi->code_time =
: 1) * 100.0);
> +
> +        qemu_printf("cpu_restore count   %" PRId64 "\n", jpi->restore_co=
unt);
> +        qemu_printf("  avg cycles        %0.1f\n",
> +                jpi->restore_count ? (double)jpi->restore_time / jpi->re=
store_count : 0);
> +
>          if (s) {
> -            int64_t tot =3D s->interm_time + s->code_time;
> -            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4=
 GHz)\n",
> -                            tot, tot / 2.4e9);
> -            qemu_printf("cycles/op           %0.1f\n",
> -                        jpi->ops ? (double)tot / jpi->ops : 0);
> -            qemu_printf("cycles/in byte      %0.1f\n",
> -                        jpi->guest ? (double)tot / jpi->guest : 0);
> -            qemu_printf("cycles/out byte     %0.1f\n",
> -                        jpi->host ? (double)tot / jpi->host : 0);
> -            qemu_printf("cycles/search byte     %0.1f\n",
> -                        jpi->search_data ? (double)tot / jpi->search_dat=
a : 0);
> -            if (tot =3D=3D 0) {
> -                tot =3D 1;
> -            }
> -            qemu_printf("  gen_interm time   %0.1f%%\n",
> -                        (double)s->interm_time / tot * 100.0);
> -            qemu_printf("  gen_code time     %0.1f%%\n",
> -                        (double)s->code_time / tot * 100.0);
> -            qemu_printf("optim./code time    %0.1f%%\n",
> -                        (double)s->opt_time / (s->code_time ? s->code_ti=
me : 1)
> -                        * 100.0);
> -            qemu_printf("liveness/code time  %0.1f%%\n",
> -                    (double)s->la_time / (s->code_time ? s->code_time : =
1) * 100.0);
> -            qemu_printf("cpu_restore count   %" PRId64 "\n",
> -                    s->restore_count);
> -            qemu_printf("  avg cycles        %0.1f\n",
> -                    s->restore_count ? (double)s->restore_time / s->rest=
ore_count : 0);
> +            qemu_printf("cpu exec time  %" PRId64 " (%0.3fs)\n",
> +                s->cpu_exec_time, s->cpu_exec_time / (double) NANOSECOND=
S_PER_SECOND);
>          }
>      }
>      g_free(jpi);
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fe890f0782..a2e65bb85c 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -337,10 +337,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu,=
 TranslationBlock *tb,
>      CPUArchState *env =3D cpu->env_ptr;
>      uint8_t *p =3D tb->tc.ptr + tb->tc.size;
>      int i, j, num_insns =3D tb->icount;
> -#ifdef CONFIG_PROFILER
> -    TCGProfile *prof =3D &tcg_ctx->prof;
> -    int64_t ti =3D profile_getclock();
> -#endif
> +    uint64_t ti =3D 0;
> +
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        ti =3D profile_getclock();
> +    }
>
>      searched_pc -=3D GETPC_ADJ;
>
> @@ -370,11 +371,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu,=
 TranslationBlock *tb,
>      }
>      restore_state_to_opc(env, tb, data);
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->restore_time,
> -                prof->restore_time + profile_getclock() - ti);
> -    atomic_set(&prof->restore_count, prof->restore_count + 1);
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.restore, profile_getclock() - ti);
> +        atomic_inc(&tb->tb_stats->time.restore_count);
> +    }
> +
>      return 0;
>  }
>
> @@ -1724,10 +1725,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      target_ulong virt_page2;
>      tcg_insn_unit *gen_code_buf;
>      int gen_code_size, search_size, max_insns;
> -#ifdef CONFIG_PROFILER
> -    TCGProfile *prof =3D &tcg_ctx->prof;
> -    int64_t ti;
> -#endif
> +    uint64_t ti =3D 0;
> +
>      assert_memory_lock();
>
>      phys_pc =3D get_page_addr_code(env, pc);
> @@ -1773,9 +1772,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tcg_ctx->tb_cflags =3D cflags;
>   tb_overflow:
>
> -#ifdef CONFIG_PROFILER
> -    ti =3D profile_getclock();
> -#endif
>
>      /*
>       * We want to fetch the stats structure before we start code
> @@ -1796,6 +1792,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>              tb->tb_stats->stats_enabled |=3D TB_JIT_STATS;
>              atomic_inc(&tb->tb_stats->translations.total);
>          }
> +
> +        if (flag & TB_JIT_TIME) {
> +            tb->tb_stats->stats_enabled |=3D TB_JIT_TIME;
> +            ti =3D profile_getclock();
> +        }
>      } else {
>          tb->tb_stats =3D NULL;
>      }
> @@ -1820,10 +1821,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          tcg_ctx->tb_jmp_target_addr =3D tb->jmp_target_arg;
>      }
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock(=
) - ti);
> -    ti =3D profile_getclock();
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.interm, profile_getclock() - ti);
> +        ti =3D profile_getclock();
> +    }
>
>      gen_code_size =3D tcg_gen_code(tcg_ctx, tb);
>      if (unlikely(gen_code_size < 0)) {
> @@ -1865,9 +1866,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      }
>      tb->tc.size =3D gen_code_size;
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->code_time, prof->code_time + profile_getclock() - =
ti);
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.code, profile_getclock() - ti);
> +    }
>
>      if (tb_stats_enabled(tb, TB_JIT_STATS)) {
>          atomic_add(&tb->tb_stats->code.in_len, tb->size);
> diff --git a/configure b/configure
> index e44e454c43..af8ff2e6dc 100755
> --- a/configure
> +++ b/configure
> @@ -6611,9 +6611,6 @@ fi
>  if test "$static" =3D "yes" ; then
>    echo "CONFIG_STATIC=3Dy" >> $config_host_mak
>  fi
> -if test "$profiler" =3D "yes" ; then
> -  echo "CONFIG_PROFILER=3Dy" >> $config_host_mak
> -fi
>  if test "$want_tools" =3D "yes" ; then
>    echo "CONFIG_TOOLS=3Dy" >> $config_host_mak
>  fi
> diff --git a/cpus.c b/cpus.c
> index 85cd451a86..c1844a412b 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1433,21 +1433,17 @@ static void process_icount_data(CPUState *cpu)
>  static int tcg_cpu_exec(CPUState *cpu)
>  {
>      int ret;
> -#ifdef CONFIG_PROFILER
> -    int64_t ti;
> -#endif
> +    uint64_t ti;
>
>      assert(tcg_enabled());
> -#ifdef CONFIG_PROFILER
>      ti =3D profile_getclock();
> -#endif
> +
>      cpu_exec_start(cpu);
>      ret =3D cpu_exec(cpu);
>      cpu_exec_end(cpu);
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&tcg_ctx->prof.cpu_exec_time,
> -               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
> -#endif
> +
> +    atomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
> +
>      return ret;
>  }
>
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index b9d5a343be..0b9a6e2f72 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -81,22 +81,39 @@ struct TBStatistics {
>          unsigned long spanning;
>      } translations;
>
> +    struct {
> +        int64_t restore;
> +        uint64_t restore_count;
> +        int64_t interm;
> +        int64_t code;
> +        int64_t opt;
> +        int64_t la;
> +    } time;
> +
>      /* current TB linked to this TBStatistics */
>      TranslationBlock *tb;
>  };
>
>  bool tb_stats_cmp(const void *ap, const void *bp);
>
> +void dump_jit_exec_time_info(uint64_t dev_time);
> +
>  void init_tb_stats_htable_if_not(void);
>
>  void dump_jit_profile_info(TCGProfile *s);
>
>  /* TBStatistic collection controls */
> -enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED=
 };
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED =3D 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED
> +};
>
>  #define TB_NOTHING    (1 << 0)
>  #define TB_EXEC_STATS (1 << 1)
>  #define TB_JIT_STATS  (1 << 2)
> +#define TB_JIT_TIME   (1 << 3)
>
>  extern int tcg_collect_tb_stats;
>  extern uint32_t default_tbstats_flag;
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 85bc6eb00b..641ca3ddd0 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -1006,13 +1006,10 @@ static inline int64_t cpu_get_host_ticks(void)
>  }
>  #endif
>
> -#ifdef CONFIG_PROFILER
>  static inline int64_t profile_getclock(void)
>  {
>      return get_clock();
>  }
>
> -extern int64_t dev_time;
> -#endif
> -
> +extern uint64_t dev_time;
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index aef16f6cfb..ac4ff58d96 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -472,6 +472,11 @@ static void hmp_info_jit(Monitor *mon, const QDict *=
qdict)
>
>  static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  {
> +    if (!tb_stats_collection_enabled()) {
> +        error_report("TB information not being recorded.");
> +        return;
> +    }
> +
>      dump_opcount_info();
>  }
>  #endif
> @@ -1082,32 +1087,11 @@ static void hmp_info_mtree(Monitor *mon, const QD=
ict *qdict)
>      mtree_info(flatview, dispatch_tree, owner);
>  }
>
> -#ifdef CONFIG_PROFILER
> -
> -int64_t dev_time;
> -
>  static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>  {
> -    static int64_t last_cpu_exec_time;
> -    int64_t cpu_exec_time;
> -    int64_t delta;
> -
> -    cpu_exec_time =3D tcg_cpu_exec_time();
> -    delta =3D cpu_exec_time - last_cpu_exec_time;
> -
> -    monitor_printf(mon, "async time  %" PRId64 " (%0.3f)\n",
> -                   dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
> -    monitor_printf(mon, "qemu time   %" PRId64 " (%0.3f)\n",
> -                   delta, delta / (double)NANOSECONDS_PER_SECOND);
> -    last_cpu_exec_time =3D cpu_exec_time;
> +    dump_jit_exec_time_info(dev_time);
>      dev_time =3D 0;
>  }
> -#else
> -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
> -{
> -    monitor_printf(mon, "Internal profiler not compiled\n");
> -}
> -#endif
>
>  /* Capture support */
>  static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 03b11495aa..4986ff3984 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3884,82 +3884,34 @@ static void tcg_reg_alloc_call(TCGContext *s, TCG=
Op *op)
>      }
>  }
>
> -#ifdef CONFIG_PROFILER
> -
>  /* avoid copy/paste errors */
>  #define PROF_ADD(to, from, field)                       \
>      do {                                                \
>          (to)->field +=3D atomic_read(&((from)->field));   \
>      } while (0)
>
> -#define PROF_MAX(to, from, field)                                       \
> -    do {                                                                \
> -        typeof((from)->field) val__ =3D atomic_read(&((from)->field));  =
  \
> -        if (val__ > (to)->field) {                                      \
> -            (to)->field =3D val__;                                      =
  \
> -        }                                                               \
> -    } while (0)
> -
> -/* Pass in a zero'ed @prof */
> -static inline
> -void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
> +static void collect_tcg_profiler(TCGProfile *prof)
>  {
> +    int i;
>      unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
> -    unsigned int i;
>
>      for (i =3D 0; i < n_ctxs; i++) {
>          TCGContext *s =3D atomic_read(&tcg_ctxs[i]);
>          const TCGProfile *orig =3D &s->prof;
>
> -        if (counters) {
> -            PROF_ADD(prof, orig, cpu_exec_time);
> -            PROF_ADD(prof, orig, interm_time);
> -            PROF_ADD(prof, orig, code_time);
> -            PROF_ADD(prof, orig, la_time);
> -            PROF_ADD(prof, orig, opt_time);
> -            PROF_ADD(prof, orig, restore_count);
> -            PROF_ADD(prof, orig, restore_time);
> -        }
> -        if (table) {
> -            int i;
> +        PROF_ADD(prof, orig, cpu_exec_time);
>
> -            for (i =3D 0; i < NB_OPS; i++) {
> -                PROF_ADD(prof, orig, table_op_count[i]);
> -            }
> +        for (i =3D 0; i < NB_OPS; i++) {
> +            PROF_ADD(prof, orig, table_op_count[i]);


I've just noticed we've run into the same problem we had with the
original exec count patch of breaking on the 32 bit builds, e.g:

  make docker-test-build@debian-mipsel-cross V=3D1 J=3D9 TARGET_LIST=3Dmips=
el-linux-user,mips-softmmu

Gives:

  In file included from /tmp/qemu-test/src/include/qemu/osdep.h:51:0,
                   from /tmp/qemu-test/src/tcg/tcg.c:28:
  /tmp/qemu-test/src/tcg/tcg.c: In function 'collect_tcg_profiler':
  /tmp/qemu-test/src/include/qemu/compiler.h:86:36: error: static assertion=
 failed: "not expecting: sizeof(*&((orig)->cpu_exec_time)) > ATOMIC_REG_SIZ=
E"
   #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                      ^
  /tmp/qemu-test/src/include/qemu/compiler.h:94:30: note: in expansion of m=
acro 'QEMU_BUILD_BUG_MSG'
   #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                                ^~~~~~~~~~~~~~~~~~
  /tmp/qemu-test/src/include/qemu/atomic.h:133:5: note: in expansion of mac=
ro 'QEMU_BUILD_BUG_ON'
       QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
       ^~~~~~~~~~~~~~~~~
  /tmp/qemu-test/src/tcg/tcg.c:3890:24: note: in expansion of macro 'atomic=
_read'
           (to)->field +=3D atomic_read(&((from)->field));   \
                          ^~~~~~~~~~~
  /tmp/qemu-test/src/tcg/tcg.c:3902:9: note: in expansion of macro 'PROF_AD=
D'
           PROF_ADD(prof, orig, cpu_exec_time);
           ^~~~~~~~

Of course this would have happened if you had enabled CONFIG_PROFILER on
a 32 bit build anyway. So what options do we have:

1. Gate the code on something based of ATOMIC_REG_SIZE

not desirable - the newer code is a lot nicer than having lots of ugly
#ifdefs

2. Defer the summing of the work with async work

Much like we do at the moment with TB stats info

3. Maybe consider an RCU approach?

This would mean the numbers weren't exact at time of calculation but if
you want precise numbers you would have halted the machine somehow
anyway right?

>          }
>      }
>  }
>=20=20
> -#undef PROF_ADD
> -#undef PROF_MAX
> -
> -static void tcg_profile_snapshot_counters(TCGProfile *prof)
> -{
> -    tcg_profile_snapshot(prof, true, false);
> -}
> -
> -static void tcg_profile_snapshot_table(TCGProfile *prof)
> -{
> -    tcg_profile_snapshot(prof, false, true);
> -}
> -
> -void tcg_dump_op_count(void)
> -{
> -    TCGProfile prof =3D {};
> -    int i;
> -
> -    tcg_profile_snapshot_table(&prof);
> -    for (i =3D 0; i < NB_OPS; i++) {
> -        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name,
> -                    prof.table_op_count[i]);
> -    }
> -}
> -
> -int64_t tcg_cpu_exec_time(void)
> +uint64_t tcg_cpu_exec_time(void)
>  {
>      unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
>      unsigned int i;
> -    int64_t ret =3D 0;
> +    uint64_t ret =3D 0;
>
>      for (i =3D 0; i < n_ctxs; i++) {
>          const TCGContext *s =3D atomic_read(&tcg_ctxs[i]);
> @@ -3969,25 +3921,9 @@ int64_t tcg_cpu_exec_time(void)
>      }
>      return ret;
>  }
> -#else
> -void tcg_dump_op_count(void)
> -{
> -    qemu_printf("[TCG profiler not compiled]\n");
> -}
> -
> -int64_t tcg_cpu_exec_time(void)
> -{
> -    error_report("%s: TCG profiler not compiled", __func__);
> -    exit(EXIT_FAILURE);
> -}
> -#endif
> -
>
>  int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>  {
> -#ifdef CONFIG_PROFILER
> -    TCGProfile *prof =3D &s->prof;
> -#endif
>      int i, num_insns;
>      TCGOp *op;
>
> @@ -4040,18 +3976,18 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      }
>  #endif
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.opt, -profile_getclock());
> +    }
>
>  #ifdef USE_TCG_OPTIMIZATIONS
>      tcg_optimize(s);
>  #endif
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
> -    atomic_set(&prof->la_time, prof->la_time - profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.opt, profile_getclock());
> +        atomic_add(&tb->tb_stats->time.la,  -profile_getclock());
> +    }
>
>      reachable_code_pass(s);
>      liveness_pass_1(s);
> @@ -4074,9 +4010,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>          }
>      }
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->la_time, prof->la_time + profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.la, profile_getclock());
> +    }
>
>  #ifdef DEBUG_DISAS
>      if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
> @@ -4109,14 +4045,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      s->pool_labels =3D NULL;
>  #endif
>
> +    if (!tb_stats_collection_enabled()) {
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            TCGOpcode opc =3D op->opc;
> +            atomic_add(&s->prof.table_op_count[opc], 1);
> +        }
> +    }
> +
>      num_insns =3D -1;
>      QTAILQ_FOREACH(op, &s->ops, link) {
>          TCGOpcode opc =3D op->opc;
>
> -#ifdef CONFIG_PROFILER
> -        atomic_set(&prof->table_op_count[opc], prof->table_op_count[opc]=
 + 1);
> -#endif
> -
>          switch (opc) {
>          case INDEX_op_mov_i32:
>          case INDEX_op_mov_i64:
> @@ -4209,14 +4148,23 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      return tcg_current_code_size(s);
>  }
>
> +void tcg_dump_op_count(void)
> +{
> +    TCGProfile prof =3D {};
> +    int i;
> +
> +    collect_tcg_profiler(&prof);
> +    for (i =3D 0; i < NB_OPS; i++) {
> +        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name, prof.table_=
op_count[i]);
> +    }
> +}
> +
>  void tcg_dump_info(void)
>  {
>      TCGProfile *s =3D NULL;
> -#ifdef CONFIG_PROFILER
>      TCGProfile prof =3D {};
> -    tcg_profile_snapshot_counters(&prof);
>      s =3D &prof;
> -#endif
> +    collect_tcg_profiler(s);
>      dump_jit_profile_info(s);
>  }
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index a8d779f7e6..3550d22873 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -646,12 +646,6 @@ QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
>
>  typedef struct TCGProfile {
>      int64_t cpu_exec_time;
> -    int64_t interm_time;
> -    int64_t code_time;
> -    int64_t la_time;
> -    int64_t opt_time;
> -    int64_t restore_count;
> -    int64_t restore_time;
>      int64_t table_op_count[NB_OPS];
>  } TCGProfile;
>
> @@ -679,9 +673,7 @@ struct TCGContext {
>
>      tcg_insn_unit *code_ptr;
>
> -#ifdef CONFIG_PROFILER
>      TCGProfile prof;
> -#endif
>
>  #ifdef CONFIG_DEBUG_TCG
>      int temps_in_use;
> @@ -1013,7 +1005,7 @@ int tcg_check_temp_count(void);
>  #define tcg_check_temp_count() 0
>  #endif
>
> -int64_t tcg_cpu_exec_time(void);
> +uint64_t tcg_cpu_exec_time(void);
>  void tcg_dump_info(void);
>  void tcg_dump_op_count(void);
>
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..4203cc728c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1796,17 +1796,11 @@ static bool main_loop_should_exit(void)
>
>  static void main_loop(void)
>  {
> -#ifdef CONFIG_PROFILER
> -    int64_t ti;
> -#endif
> +    uint64_t ti;
>      while (!main_loop_should_exit()) {
> -#ifdef CONFIG_PROFILER
>          ti =3D profile_getclock();
> -#endif
>          main_loop_wait(false);
> -#ifdef CONFIG_PROFILER
>          dev_time +=3D profile_getclock() - ti;
> -#endif
>      }
>  }


--
Alex Benn=C3=A9e

