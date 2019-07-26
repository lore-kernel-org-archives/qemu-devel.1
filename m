Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F61C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B1D218DA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXVXGwT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B1D218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqypo-0000MR-7f
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqypb-0008OZ-H2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqypX-0002Gi-Kk
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:56:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqypW-00020y-8i
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:56:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so47776729wmj.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=606/bZupu2JxWdV3hjORXlmFssmp/hY01vY6WmAQl7o=;
 b=qXVXGwT+oza2aB7taATYlUC5s+fD/10cjkTGsnRsTumZx4YOyA2h5FIFtKgM8bdDN/
 70LxeHdImcRK3qWS88hL/s+xLU9zyFs6o9w2prBTTxj1nXFr9bRB+6y7aytHwUCTx+tY
 KNWBZcN/wqj/pS4RjGqnPVYeyCyLIsuoJ+5ijNLEh6srIJf6+f3xLgRdXZFJ2GXqZtsq
 BJVNxX9MoTWfsLCygeYr4XA7MgdqZGj9/q93f1PTykfJkwXCP1D0RTdNRpfGrtEXg7VA
 E8mqeFIOdkl3XpFbKEfE2jvKv+JYVjVs82wej+wZBCGCQOTIaPB+1Sfap/t+v7I42vWA
 O2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=606/bZupu2JxWdV3hjORXlmFssmp/hY01vY6WmAQl7o=;
 b=n+JILZi12XJP92u7R6XwqGkUjInCpcUWruJnZNHIpN/h5HvzUCshmU3EyIC8clpmps
 BqdfBm5IOiLu+KNMj3yPcMXAmXS2Iv+dwkz9BA756uvmhzy4PdR6KCRTRewsBmJmEGYR
 moFv426HkH8vbe4KPlwoOzmGpAVOgXOAiOQSXFCBVtAppTusGvD6NKKV4plbb7irZF2u
 6csnDXBmuoSqJT/PtR0I2aW9WcH97Ddd0x9zwGyUMrSqS4DAGlaP1Kdm8AbN6QlzCZvF
 os/135A+jneK13OGDMDCOkWK49L82lfJYyRETUIklZk2DXvEz1qB/UvRMa2ufrc1AYj9
 lagg==
X-Gm-Message-State: APjAAAWxvb6+xToXnujO+dtTUX/KnezI4gEB9kbF24UUN+5UDqNsnIEi
 8CmcprQyWZzTIfLDzLKfQqljPQ==
X-Google-Smtp-Source: APXvYqwhE52MIJgwyHc4mGoa7BudTPT+9VYt8B1+nhT6B1+nVZuHEzQ0Qph3xoERYo5qOzl2WjvFVQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr84465043wmh.63.1564142164686; 
 Fri, 26 Jul 2019 04:56:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p7sm30623810wrs.6.2019.07.26.04.56.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 04:56:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 021D61FF87;
 Fri, 26 Jul 2019 12:56:03 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-2-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-2-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 12:56:02 +0100
Message-ID: <87v9vpggbx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 1/7] accel: introducing TBStatistics
 structure
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

> To store statistics for each TB we created a TBStatistics structure
> which is linked with the TBs. The TBStatistics can stay alive after
> tb_flush and be relinked to a regenerated TB. So the statistics can
> be accumulated even through flushes.
>
> TBStatistics will be also referred to as TBS or tbstats.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c | 57 +++++++++++++++++++++++++++++++++++++++
>  include/exec/exec-all.h   | 15 +++--------
>  include/exec/tb-context.h | 12 +++++++++
>  include/exec/tb-hash.h    |  7 +++++
>  include/exec/tb-stats.h   | 29 ++++++++++++++++++++
>  include/qemu/log.h        |  6 +++++
>  util/log.c                | 28 +++++++++++++++++++
>  7 files changed, 143 insertions(+), 11 deletions(-)
>  create mode 100644 include/exec/tb-stats.h
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..a574890a80 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1118,6 +1118,23 @@ static inline void code_gen_alloc(size_t tb_size)
>      }
>  }
>
> +/*
> + * This is the more or less the same compare,

We should reference "same compare as tb_cmp"

> but the data persists
> + * over tb_flush. We also aggregate the various variations of cflags
> + * under one record and ignore the details of page overlap (although
> + * we can count it).
> + */
> +bool tb_stats_cmp(const void *ap, const void *bp)
> +{
> +    const TBStatistics *a =3D ap;
> +    const TBStatistics *b =3D bp;
> +
> +    return a->phys_pc =3D=3D b->phys_pc &&
> +        a->pc =3D=3D b->pc &&
> +        a->cs_base =3D=3D b->cs_base &&
> +        a->flags =3D=3D b->flags;
> +}
> +
>  static bool tb_cmp(const void *ap, const void *bp)
>  {
>      const TranslationBlock *a =3D ap;
> @@ -1137,6 +1154,9 @@ static void tb_htable_init(void)
>      unsigned int mode =3D QHT_MODE_AUTO_RESIZE;
>
>      qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
> +    if (tb_stats_collection_enabled()) {
> +        qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE, m=
ode);
> +    }
>  }
>
>  /* Must be called before using the QEMU cpus. 'tb_size' is the size
> @@ -1666,6 +1686,32 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t =
phys_pc,
>      return tb;
>  }
>
> +static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong p=
c,
> +                                  target_ulong cs_base, uint32_t flags)
> +{
> +    TBStatistics *new_stats =3D g_new0(TBStatistics, 1);
> +    uint32_t hash =3D tb_stats_hash_func(phys_pc, pc, flags);
> +    void *existing_stats =3D NULL;
> +    new_stats->phys_pc =3D phys_pc;
> +    new_stats->pc =3D pc;
> +    new_stats->cs_base =3D cs_base;
> +    new_stats->flags =3D flags;
> +
> +    qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
> +
> +    if (unlikely(existing_stats)) {
> +        /*
> +         * If there is already a TBStatistic for this TB from a previous=
 flush
> +         * then just make the new TB point to the older TBStatistic
> +         */
> +        g_free(new_stats);
> +        return existing_stats;
> +    } else {
> +        return new_stats;
> +    }
> +}
> +
> +
>  /* Called with mmap_lock held for user mode emulation.  */
>  TranslationBlock *tb_gen_code(CPUState *cpu,
>                                target_ulong pc, target_ulong cs_base,
> @@ -1732,6 +1778,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      ti =3D profile_getclock();
>  #endif
>
> +    /*
> +     * We want to fetch the stats structure before we start code
> +     * generation so we can count interesting things about this
> +     * generation.
> +     */
> +    if (tb_stats_collection_enabled()) {
> +        tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags);
> +    } else {
> +        tb->tb_stats =3D NULL;
> +    }
> +
>      tcg_func_start(tcg_ctx);
>
>      tcg_ctx->cpu =3D env_cpu(env);
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 16034ee651..24bd6a0a0c 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -22,21 +22,11 @@
>
>  #include "exec/tb-context.h"
>  #include "sysemu/cpus.h"
> +#include "exec/tb-stats.h"
>
>  /* allow to see translation results - the slowdown should be negligible,=
 so we leave it */
>  #define DEBUG_DISAS
>
> -/* Page tracking code uses ram addresses in system mode, and virtual
> -   addresses in userspace mode.  Define tb_page_addr_t to be an appropri=
ate
> -   type.  */
> -#if defined(CONFIG_USER_ONLY)
> -typedef abi_ulong tb_page_addr_t;
> -#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
> -#else
> -typedef ram_addr_t tb_page_addr_t;
> -#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
> -#endif
> -

Why are we moving this? I suspect it would be better to split the move
into a separate patch for the purposes of bisection.

>  #include "qemu/log.h"
>
>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_=
insns);
> @@ -403,6 +393,9 @@ struct TranslationBlock {
>      uintptr_t jmp_list_head;
>      uintptr_t jmp_list_next[2];
>      uintptr_t jmp_dest[2];
> +
> +    /* Pointer to a struct where statistics from the TB is stored */
> +    TBStatistics *tb_stats;
>  };
>
>  extern bool parallel_cpus;
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index feb585e0a7..3cfb62a338 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -23,6 +23,17 @@
>  #include "qemu/thread.h"
>  #include "qemu/qht.h"
>
> +/* Page tracking code uses ram addresses in system mode, and virtual
> +   addresses in userspace mode.  Define tb_page_addr_t to be an appropri=
ate
> +   type.  */
> +#if defined(CONFIG_USER_ONLY)
> +typedef abi_ulong tb_page_addr_t;
> +#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
> +#else
> +typedef ram_addr_t tb_page_addr_t;
> +#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
> +#endif
> +
>  #define CODE_GEN_HTABLE_BITS     15
>  #define CODE_GEN_HTABLE_SIZE     (1 << CODE_GEN_HTABLE_BITS)
>
> @@ -35,6 +46,7 @@ struct TBContext {
>
>      /* statistics */
>      unsigned tb_flush_count;
> +    struct qht tb_stats;
>  };
>
>  extern TBContext tb_ctx;
> diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
> index 4f3a37d927..54c477fe79 100644
> --- a/include/exec/tb-hash.h
> +++ b/include/exec/tb-hash.h
> @@ -64,4 +64,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_u=
long pc, uint32_t flags,
>      return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
>  }
>
> +static inline
> +uint32_t tb_stats_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
> +                            uint32_t flags)
> +{
> +    return qemu_xxhash5(phys_pc, pc, flags);
> +}
> +
>  #endif
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> new file mode 100644
> index 0000000000..0913155ec3
> --- /dev/null
> +++ b/include/exec/tb-stats.h
> @@ -0,0 +1,29 @@
> +#ifndef TB_STATS_H
> +
> +#define TB_STATS_H
> +
> +#include "exec/cpu-common.h"
> +#include "exec/tb-context.h"
> +#include "tcg.h"
> +
> +typedef struct TBStatistics TBStatistics;
> +
> +/*
> + * This struct stores statistics such as execution count of the
> + * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
> + * has its own TBStatistics which will persist over tb_flush.
> + *
> + * We include additional counters to track number of translations as
> + * well as variants for compile flags.
> + */
> +struct TBStatistics {
> +    tb_page_addr_t phys_pc;
> +    target_ulong pc;
> +    uint32_t     flags;
> +    /* cs_base isn't included in the hash but we do check for matches */
> +    target_ulong cs_base;
> +};
> +
> +bool tb_stats_cmp(const void *ap, const void *bp);
> +
> +#endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index b097a6cae1..e175d4d5d0 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -129,4 +129,10 @@ void qemu_log_flush(void);
>  /* Close the log file */
>  void qemu_log_close(void);
>
> +void enable_collect_tb_stats(void);
> +void disable_collect_tb_stats(void);
> +void pause_collect_tb_stats(void);
> +bool tb_stats_collection_enabled(void);
> +bool tb_stats_collection_paused(void);
> +
>  #endif
> diff --git a/util/log.c b/util/log.c
> index 1d1b33f7d9..ab73fdc100 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -326,3 +326,31 @@ void qemu_print_log_usage(FILE *f)
>      fprintf(f, "\nUse \"-d trace:help\" to get a list of trace events.\n=
\n");
>  #endif
>  }
> +
> +int tcg_collect_tb_stats;
> +
> +void enable_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats =3D 1;
> +}

Do we check we have created the qht table? Perhaps this should be
wrapped into here? I suspect that's why I got:

  (qemu) help tb_stats
  tb_stats command [stats_level] -- Control tb statistics collection:tb_sta=
ts (start|pause|stop|filter) [all|jit_stats|exec_stats]
  (qemu) tb_stats start
  (qemu) fish: =E2=80=9C./aarch64-softmmu/qemu-system-a=E2=80=A6=E2=80=9D t=
erminated by signal SIGILL (Illegal instruction)

You'll want a memory barrier before you throw the switch of enabling so
qht_init is fully visible.

> +
> +void disable_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats =3D 0;
> +}
> +
> +void pause_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats =3D 2;
> +}
> +
> +bool tb_stats_collection_enabled(void)
> +{
> +    return tcg_collect_tb_stats;
> +}
> +
> +bool tb_stats_collection_paused(void)
> +{
> +    return tcg_collect_tb_stats =3D=3D 2;
> +}

While we are at it can we move these helpers into tb_stats as log.c can
be built for all versions of QEMU but tb_stats only exists when TCG is
built in.

--
Alex Benn=C3=A9e

