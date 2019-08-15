Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B8C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692CD206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoO7DmVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692CD206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyFyY-0001od-Db
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hyFxl-0001Mn-Or
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hyFxi-0001NM-QJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:38:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hyFxi-0001Mx-Ii
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:38:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so1287421wmf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Dpq8LIdtzqmuULyMcrM7HF/W+ZJ63nxtVWlu9d9aul8=;
 b=hoO7DmVdP+9U12QB1S1w14FcPq5tdN2ixoe8j9g0B+l3+K6KE5ZX+LBEBvFqLTJMuQ
 POfNoSEsCs3jxhg7V79aT5GC+sc19FFvicAqLCA75px+E4iOPgZq35mBQ5NOs9nAVGWh
 HfsuHokUQU5UrEt+2aB86n+cyJiUG7zAc870o8uri7ash6jCSCj0zMD/SeoqZHht4FS0
 CXfiD0am7hxV8DoLl6hwGiAPDV6ejKcKXnXi3QTvxpsg6fyABC8RW98rejxkAFp9F5Gi
 Ljjj2vz4W1+rY+g7AGdKwwzJQm3/ilerFDiaWqJmroZAMhvxRiMSDWUsbEiXjjgv6mBB
 Pweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Dpq8LIdtzqmuULyMcrM7HF/W+ZJ63nxtVWlu9d9aul8=;
 b=CQWbvPr85YuUvwdQUtdNOOYdNTfVtMBkLYj9D62pc8FALobG5iGQSW6wTgU8eciWj/
 tbpUNxB7eeLlBKIkbwpAuVYysrcngBC46w80Qfq/v9K6ICbUC+t5BnnmmK1MD1s6h/kJ
 2EE1ZZERhiyX5+qiEgkPlO7pRYQoQngFXksl649deB9s3S6B0aCidcbCKR/mfx2yDTJx
 tZQAvu0YrRoUoOi94uwzrk/g4jxfLloJS00wKS0GNWNtyDmO2sXkaclFK7VnMayK4svV
 9bNnvmoI9S9UrXUcAYVM0TOjH/Ltkgi5Onv1fp8EI/Kr3w83ure16YqGdVK7rKrqCqXH
 jxLw==
X-Gm-Message-State: APjAAAXOJbEe+JJotZMmIIw8qaPtWpVaQZMF7ZZVwq+EdrJlON1qarwX
 dU0PDPvQLwstqQT+XwEXhiatBA==
X-Google-Smtp-Source: APXvYqyruw8pOWBclJd9qItpml6l/bhcCOlIaVDeWAhJIfPmdHleQNF0sYL2+t9GPNwGkSUX2pzbQw==
X-Received: by 2002:a1c:343:: with SMTP id 64mr2972836wmd.116.1565876321076;
 Thu, 15 Aug 2019 06:38:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i93sm3251518wri.57.2019.08.15.06.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 06:38:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECC4C1FF87;
 Thu, 15 Aug 2019 14:38:39 +0100 (BST)
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
 <20190815021857.19526-3-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190815021857.19526-3-vandersonmr2@gmail.com>
Date: Thu, 15 Aug 2019 14:38:39 +0100
Message-ID: <87r25mmtuo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v5 02/10] accel: collecting TB execution
 count
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

> If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
> enabled, then we instrument the start code of this TB
> to atomically count the number of times it is executed.
> We count both the number of "normal" executions and atomic
> executions of a TB.
>
> The execution count of the TB is stored in its respective
> TBS.
>
> All TBStatistics are created by default with the flags from
> default_tbstats_flag.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/cpu-exec.c      |  4 ++++
>  accel/tcg/tb-stats.c      |  5 +++++
>  accel/tcg/tcg-runtime.c   |  7 +++++++
>  accel/tcg/tcg-runtime.h   |  2 ++
>  accel/tcg/translate-all.c |  7 +++++++
>  accel/tcg/translator.c    |  1 +
>  include/exec/gen-icount.h |  9 +++++++++
>  include/exec/tb-stats.h   | 19 +++++++++++++++++++
>  util/log.c                |  1 +
>  9 files changed, 55 insertions(+)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 6c85c3ee1e..e54be69499 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -252,6 +252,10 @@ void cpu_exec_step_atomic(CPUState *cpu)
>
>          start_exclusive();
>
> +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +            tb->tb_stats->executions.atomic++;
> +        }
> +
>          /* Since we got here, we know that parallel_cpus must be true.  =
*/
>          parallel_cpus =3D false;
>          in_exclusive_region =3D true;
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 02844717cb..3489133e9e 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -37,3 +37,8 @@ bool tb_stats_collection_paused(void)
>  {
>      return tcg_collect_tb_stats =3D=3D TB_STATS_PAUSED;
>  }
> +
> +uint32_t get_default_tbstats_flag(void)
> +{
> +    return default_tbstats_flag;
> +}
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..6f4aafba11 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(env_cpu(env), GETPC());
>  }
> +
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TBStatistics *stats =3D (TBStatistics *) ptr;
> +    g_assert(stats);
> +    atomic_inc(&stats->executions.normal);
> +}
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 4fa61b49b4..bf0b75dbe8 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, pt=
r, env)
>
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
> +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
> +
>  #ifdef CONFIG_SOFTMMU
>
>  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index b7bccacd3b..df08d183df 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1785,6 +1785,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       */
>      if (tb_stats_collection_enabled()) {
>          tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb);
> +        uint32_t flag =3D get_default_tbstats_flag();
> +
> +        if (qemu_log_in_addr_range(tb->pc)) {

Minor nit: the compiler should spot it but you could move the flag
fetching inside this block.

> +            if (flag & TB_EXEC_STATS) {
> +                tb->tb_stats->stats_enabled |=3D TB_EXEC_STATS;
> +            }
> +        }
>      } else {
>          tb->tb_stats =3D NULL;
>      }
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 9226a348a3..396a11e828 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
>
>      ops->init_disas_context(db, cpu);
>      tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
> +    gen_tb_exec_count(tb);
>
>      /* Reset the temp count so that we can identify leaks */
>      tcg_clear_temp_count();
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index f7669b6841..b3efe41894 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -7,6 +7,15 @@
>
>  static TCGOp *icount_start_insn;
>
> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +        TCGv_ptr ptr =3D tcg_const_ptr(tb->tb_stats);
> +        gen_helper_inc_exec_freq(ptr);
> +        tcg_temp_free_ptr(ptr);
> +    }
> +}
> +
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index cc8f8a6ce6..0265050b79 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -6,6 +6,9 @@
>  #include "exec/tb-context.h"
>  #include "tcg.h"
>
> +#define tb_stats_enabled(tb, JIT_STATS) \
> +    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
> +
>  typedef struct TBStatistics TBStatistics;
>
>  /*
> @@ -22,6 +25,15 @@ struct TBStatistics {
>      uint32_t     flags;
>      /* cs_base isn't included in the hash but we do check for matches */
>      target_ulong cs_base;
> +
> +    uint32_t stats_enabled;
> +
> +    /* Execution stats */
> +    struct {
> +        unsigned long normal;
> +        unsigned long atomic;
> +    } executions;
> +
>      /* current TB linked to this TBStatistics */
>      TranslationBlock *tb;
>  };
> @@ -32,7 +44,12 @@ void init_tb_stats_htable_if_not(void);
>
>  /* TBStatistic collection controls */
>  enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED=
 };
> +
> +#define TB_NOTHING    0
> +#define TB_EXEC_STATS 1

As this is going to be a bit field you should use:

 #define TB_NOTHING (1 << 0)

etc...

> +
>  extern int tcg_collect_tb_stats;
> +extern uint32_t default_tbstats_flag;
>
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
> @@ -40,4 +57,6 @@ void pause_collect_tb_stats(void);
>  bool tb_stats_collection_enabled(void);
>  bool tb_stats_collection_paused(void);
>
> +uint32_t get_default_tbstats_flag(void);
> +
>  #endif
> diff --git a/util/log.c b/util/log.c
> index 393a17115b..29021a4584 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -32,6 +32,7 @@ static int log_append =3D 0;
>  static GArray *debug_regions;
>
>  int tcg_collect_tb_stats;
> +uint32_t default_tbstats_flag;

This should static and in tb_stats.c (like the helper is)

>
>  /* Return the number of characters emitted.  */
>  int qemu_log(const char *fmt, ...)


--
Alex Benn=C3=A9e

