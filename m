Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A847DC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791C02085A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aqg2aw12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791C02085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2O2-0007RF-Q9
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hj2MR-0005zK-LC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hj2MP-0002I1-W0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:05:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hj2MP-0002Gk-NY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:05:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id v14so6785696wrr.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yOc+FT73bSFye+f0boFL5bW3c5gDM63iQK3ih1Joo6M=;
 b=Aqg2aw12r3Q2oTapGqnSvdTPkgYVg4SJG49v294WCCMhZ7ZtfY/uKK5FqCAVIsTb0x
 av9IiO8b+FKuBQyKBdjAZ8Ce5v2Kaxo3lsBMDz5FI4OKNsJwMzqhkWg5gJlFMW1Hfxf1
 IQ12W3VXqS1vnaw1xcbhYh6mhwmKMSm4YXBdZ7LAetShtZAJAkWPFZ5RANJRVqcwHl72
 jZKoZTgvo58C1jJxSw64mXBxBCnUlkdgW/V4uyE8ZZGYLtvPAWD347XfIM594PBNgpHB
 p0QT4sZzQz9F0QjT0lDh/Ya/HcKCTxn5EU0/WVrQYNas5OjmcaJ8NhHMoqF7Ik4EqsWm
 n9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yOc+FT73bSFye+f0boFL5bW3c5gDM63iQK3ih1Joo6M=;
 b=GmVHhPqF+GCPw1HVCcAsmVxNa20apfuHe9d90tLHV2O8grqirJauraNhh+czq96BsV
 8pMSfRkBQqKmlqm9eI60BMBa4aiQ/lyIIVGVSnsPmM182mD7WE/Hystg1pHHZbivyV9I
 kVQyWaQzGxfy6inJ02dX3BjEk+mD9yy3F+cBkCUXlssL7TrzlbGYyrexGC8brljwQjdr
 FY368Vea2PNkgYls/HF++PFsWIeJKLQI1g+5iE9jaL2j06yHW4eEXfnFyoQhYNSnYAgC
 dt6MOky6655wTZJXR5rDDi6LCg9xszRT8t77cyDzduROmoBZ/R0zsbkeD+DdwQE/9hy8
 ckEg==
X-Gm-Message-State: APjAAAVzcSn94p9mHs4UUfR1GX0SO/Z4PgDmqfSXNk+j3QwyK0xyuuVQ
 r/7b/bFoRIyGxQMY3mC1A1kiyA==
X-Google-Smtp-Source: APXvYqzUuoiQA1R71KwDaHojmsAfawl9V3oC/GRsKi3NzCg7fpC1/nC5bs9vrtL2ZfJt7lKlVM3vDA==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr34213511wre.205.1562249116249; 
 Thu, 04 Jul 2019 07:05:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t17sm7800574wrs.45.2019.07.04.07.05.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 07:05:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 627581FF87;
 Thu,  4 Jul 2019 15:05:15 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190702210017.4275-1-vandersonmr2@gmail.com>
Date: Thu, 04 Jul 2019 15:05:15 +0100
Message-ID: <87bly9x5d0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 1/6] accel/tcg: adding structure to
 store TB statistics
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

> We want to store statistics for each TB even after flushes.
> We do not want to modify or grow the TB struct.
> So we create a new struct to contain this statistics and
> we link one of it to each TB as they are generated.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c | 60 +++++++++++++++++++++++++++++++++++++++
>  include/exec/exec-all.h   | 46 ++++++++++++++++++++++++++++++
>  include/exec/tb-context.h |  1 +
>  include/exec/tb-hash.h    |  7 +++++
>  include/qemu/log.h        |  1 +
>  5 files changed, 115 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..d05803a142 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1132,11 +1132,31 @@ static bool tb_cmp(const void *ap, const void *bp)
>          a->page_addr[1] =3D=3D b->page_addr[1];
>  }
>
> +/*
> + * This is the more or less the same compare, but the data persists
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
>  static void tb_htable_init(void)
>  {
>      unsigned int mode =3D QHT_MODE_AUTO_RESIZE;
>
>      qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {

So this should be a separate flag, not using qemu_loglevel_mask to
check. Something like tcg_collect_tbstats? Then the various things that
might need stats can just enable it.

> +        qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE, m=
ode);
> +    }
>  }
>
>  /* Must be called before using the QEMU cpus. 'tb_size' is the size
> @@ -1586,6 +1606,31 @@ static inline void tb_page_add(PageDesc *p, Transl=
ationBlock *tb,
>  #endif
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
>  /* add a new TB and link it to the physical page tables. phys_page2 is
>   * (-1) to indicate that only one page contains the TB.
>   *
> @@ -1732,6 +1777,21 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      ti =3D profile_getclock();
>  #endif
>
> +    /*
> +     * We want to fetch the stats structure before we start code
> +     * generation so we can count interesting things about this
> +     * generation.
> +     *
> +     * XXX: using loglevel is fugly - we should have a general flag
> +     */
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb=
->pc)) {

As the XXX says use a common flag. So something like:


  if (tcg_collect_tb_stats) {
     tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags);
     ...
  } else {
     tb->tb_stats =3D NULL;
  }

And then later inside that:

   if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb->pc=
))
   {
        tb->tb_stats.stats_enabled |=3D TB_EXEC_STATS;
   }


> +        tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags);
> +        /* XXX: should we lock and update in bulk? */
> +        atomic_inc(&tb->tb_stats->translations.total);

XXX is a todo note for later... make a decision and remove the comment.

> +    } else {
> +        tb->tb_stats =3D NULL;
> +    }
> +
>      tcg_func_start(tcg_ctx);
>
>      tcg_ctx->cpu =3D env_cpu(env);
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 16034ee651..a4bcd9b6df 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -324,6 +324,49 @@ static inline void tlb_flush_by_mmuidx_all_cpus_sync=
ed(CPUState *cpu,
>  #define CODE_GEN_AVG_BLOCK_SIZE 150
>  #endif
>
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
> +
> +    /* Translation stats */
> +    struct {
> +        unsigned long total;
> +        unsigned long uncached;
> +        unsigned long spanning;
> +        /* XXX: count invalidation? */
> +    } translations;
> +
> +    /* Execution stats */
> +    struct {
> +        unsigned long total;
> +        unsigned long atomic;
> +    } executions;
> +
> +    struct {
> +        unsigned num_guest_inst;
> +        unsigned num_host_inst;
> +        unsigned num_tcg_inst;
> +    } code;
> +
> +    /* HMP information - used for referring to previous search */
> +    int display_id;

Usually we introduce the fields into the structure in the patches that
need them. Otherwise you run the risk of adding a bunch of fields that
you planned to add but never quite got around to the initial code. Of
course usually you write code and then start splitting the commits up
when you are cleaning up your branch.


> +};
> +
> +bool tb_stats_cmp(const void *ap, const void *bp);
> +
>  /*
>   * Translation Cache-related fields of a TB.
>   * This struct exists just for convenience; we keep track of TB's in a b=
inary
> @@ -403,6 +446,9 @@ struct TranslationBlock {
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
> index feb585e0a7..a4decb5d1f 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -35,6 +35,7 @@ struct TBContext {
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
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index b097a6cae1..2fca65dd01 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
>  /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
>  #define CPU_LOG_TB_OP_IND  (1 << 16)
>  #define CPU_LOG_TB_FPU     (1 << 17)
> +#define CPU_LOG_HOT_TBS    (1 << 18)

this flag can be punted to when we introduce the actual tracking because
we are going to have a specific (internal) flag for initialising the
tracking machinery.

>
>  /* Lock output for a series of related logs.  Since this is not needed
>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we


--
Alex Benn=C3=A9e

