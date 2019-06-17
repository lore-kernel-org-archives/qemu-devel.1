Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F497C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04BC20833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwx2uxnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04BC20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcoUs-0006Dg-11
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 06:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34183)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcoQx-0003nJ-3C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcoQu-0005Hq-UM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:00:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcoQt-0005Ey-04
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:00:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id x15so8559210wmj.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=USAMscVYg90cUyhJdMd4+GvTc6Htx/N5gCAcAOWkTq4=;
 b=mwx2uxndGvVBv7OTzctYCw/gjKXmu8VLNw3yWsnNRE1PtH7Tbb/GpMJDqBxnYAltJD
 rlTT6Aji3seItiFgQvWA1g4xsJ0BSw8id6mmgmUA8R5fPtQr1ZpSvaGe/al7IzElWsK+
 rePIwIDDaLGSuIton+xPIq6+OjxbE45RtgDPfD3jB/l9HVwxHsXwPFRisMPeZUzKogAM
 +lzXf5NIyQgYnxPTH5Yj1HxQ+mUWScWX6i849/gFfr+esHjXk3WWkLjzrRLUbLYqToBh
 spTr/EZktnbPYd/GZwKq7mKkCapaVwmURENtINT8GHBnz1lGlYXZ5Llu1PZh6w5bbtE9
 zjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=USAMscVYg90cUyhJdMd4+GvTc6Htx/N5gCAcAOWkTq4=;
 b=agyj7FSF3a2OOv858Y5Jz3fv7jaEcYkFLZbQU077dnosWcEOlvYAnXbEfhE2T34sSJ
 s4oE8zh0kEKxTiHl+t6rY/CISQJ+wMuLTr/e8dvIS4zN5k8EcreW2ZWSpSaESg0hQdFS
 jbSKJC9XZXQbO0srSOmULPo81WKoE/y+JLubnHY306A6kqDYfb/hVtGRQoJMEfaF6hmR
 1ca/kxTDlA5HmYsAd3xHYZr5E39aoKkQfypMyzdVhQeypfAUXaisQwlFinC/TQmobCrw
 2Q7RKTPsHaiz961vzebUWb7IZoMnmoP/zygHJNHmE6YoCiHRkKdrt+EX+UTWLygQ2tYE
 OHkw==
X-Gm-Message-State: APjAAAUUDV75S4Lx6VZzKL7dMSnpVkpwb6A4/vJVtPBLYl1PMbOtya7x
 8T2auDUw0PiVHubyPb+Dkcz2DQ==
X-Google-Smtp-Source: APXvYqy0xdJGHsGbRygsSzQm8+CYkXbbUIRFytCfcdNNdT+dsc4+JchuzxF8cNGrHnJUP+YinUopTQ==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr17370449wmd.33.1560765608690; 
 Mon, 17 Jun 2019 03:00:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j18sm12413316wre.23.2019.06.17.03.00.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 03:00:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A9EC1FF87;
 Mon, 17 Jun 2019 11:00:07 +0100 (BST)
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
 <20190614135332.12777-3-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190614135332.12777-3-vandersonmr2@gmail.com>
Date: Mon, 17 Jun 2019 11:00:07 +0100
Message-ID: <87k1dkbkgo.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-Devel][PATCH 2/3] Saving counters between
 tb_flush events.
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

> A new hash map was added to store the accumulated execution
> frequency of the TBs even after tb_flush events. A dump
> function was also added as a way to visualize these frequencies.
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>

I forgot to mention the formatting looks a little off here. It should be
your full name (accents and all) before the email address, e.g:

  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 59 +++++++++++++++++++++++++++++++++++++++
>  accel/tcg/translate-all.h |  2 ++
>  exec.c                    |  7 +++++
>  include/exec/exec-all.h   |  3 ++
>  include/exec/tb-context.h |  9 ++++++
>  include/qom/cpu.h         |  2 ++
>  6 files changed, 82 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..0bc670ffad 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1118,6 +1118,12 @@ static inline void code_gen_alloc(size_t tb_size)
>      }
>  }
>
> +static bool statistics_cmp(const void* ap, const void *bp) {
> +    const TBStatistics *a =3D ap;
> +    const TBStatistics *b =3D bp;
> +    return a->pc =3D=3D b->pc && a->cs_base =3D=3D b->cs_base && a->flag=
s =3D=3D
> b->flags;

Looking at tb_cmp() bellow this I wonder if we should also take into
account the page_address values. Some TB's will be translated over a
page boundary and in theory that can change with new mappings so we need
to ensure they are really equivalent.

> +}
> +
>  static bool tb_cmp(const void *ap, const void *bp)
>  {
>      const TranslationBlock *a =3D ap;
> @@ -1137,6 +1143,7 @@ static void tb_htable_init(void)
>      unsigned int mode =3D QHT_MODE_AUTO_RESIZE;
>
>      qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
> +    qht_init(&tb_ctx.tb_statistics, statistics_cmp, CODE_GEN_HTABLE_SIZE=
, QHT_MODE_AUTO_RESIZE);
>  }
>
>  /* Must be called before using the QEMU cpus. 'tb_size' is the size
> @@ -1228,6 +1235,53 @@ static gboolean tb_host_size_iter(gpointer key, gp=
ointer value, gpointer data)
>      return false;
>  }
>
> +static void do_tb_dump_exec_freq(void *p, uint32_t hash, void *userp)
> +{
> +#if TARGET_LONG_SIZE =3D=3D 8
> +    TBStatistics *tbs =3D p;
> +    printf("%016lx\t%lu\n", tbs->pc, tbs->total_exec_freq);
> +#elif TARGET_LONG_SIZE =3D=3D 4
> +    TBStatistics *tbs =3D p;
> +    printf("%016x\t%lu\n", tbs->pc, tbs->total_exec_freq);
> +#endif
> +}

This will need some fixing up so deal with output to the HMP monitor. We
don't want to be directly spamming stdout with results.

> +
> +void tb_dump_all_exec_freq(void)
> +{
> +    tb_read_exec_freq();
> +    qht_iter(&tb_ctx.tb_statistics, do_tb_dump_exec_freq, NULL);
> +}

I would be tempted to insert these into a sorted GList first so we can
dump the first N hotblocks.

> +
> +static void do_tb_read_exec_freq(void *p, uint32_t hash, void *userp)
> +{
> +    TranslationBlock *tb =3D p;
> +    TBStatistics tbscmp;
> +    tbscmp.pc =3D tb->pc;
> +    tbscmp.cs_base =3D tb->cs_base;
> +    tbscmp.flags =3D tb->flags;
> +
> +    TBStatistics *tbs =3D qht_lookup(userp, &tbscmp, hash);
> +
> +    uint64_t exec_freq =3D tb_get_and_reset_exec_freq((TranslationBlock*=
) p);
> +
> +    if (tbs) {
> +        tbs->total_exec_freq +=3D exec_freq;
> +    } else {
> +        void *existing;
> +        tbs =3D malloc(sizeof(TBStatistics));

use g_new0(TBStatistics, 1)

> +        tbs->total_exec_freq =3D exec_freq;
> +        tbs->pc =3D tb->pc;
> +        tbs->cs_base =3D tb->cs_base;
> +        tbs->flags =3D tb->flags;
> +        qht_insert(userp, tbs, hash, &existing);
> +    }
> +}
> +

Comment here about what we are doing? Maybe tb_copy_old_counts()?

> +void tb_read_exec_freq(void)
> +{
> +    qht_iter(&tb_ctx.htable, do_tb_read_exec_freq, &tb_ctx.tb_statistics=
);
> +}
> +
>  /* flush all the translation blocks */
>  static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>  {
> @@ -1252,6 +1306,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_=
data tb_flush_count)
>          cpu_tb_jmp_cache_clear(cpu);
>      }
>
> +    if (enable_freq_count) {
> +        tb_read_exec_freq();
> +    }
> +
>      qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
>      page_flush_tb();
>
> @@ -1723,6 +1781,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tb->flags =3D flags;
>      tb->cflags =3D cflags;
>      tb->trace_vcpu_dstate =3D *cpu->trace_dstate;
> +    tb->exec_freq =3D 0;
>      tcg_ctx->tb_cflags =3D cflags;
>   tb_overflow:
>
> diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
> index 64f5fd9a05..e13088c36d 100644
> --- a/accel/tcg/translate-all.h
> +++ b/accel/tcg/translate-all.h
> @@ -32,6 +32,8 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start=
, tb_page_addr_t end,
>                                     int is_cpu_write_access);
>  void tb_check_watchpoint(CPUState *cpu);
>
> +extern bool enable_freq_count;
> +
>  #ifdef CONFIG_USER_ONLY
>  int page_unprotect(target_ulong address, uintptr_t pc);
>  #endif
> diff --git a/exec.c b/exec.c
> index e7622d1956..9b64a012ee 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1013,6 +1013,13 @@ const char *parse_cpu_option(const char *cpu_optio=
n)
>      return cpu_type;
>  }
>
> +uint64_t tb_get_and_reset_exec_freq(TranslationBlock *tb)
> +{
> +    uint64_t exec_freq =3D atomic_load_acquire(&tb->exec_freq);
> +    atomic_store_release(&tb->exec_freq, 0);

I'm not sure you need acquire/release semantics here as you are only
reading this in an exclusive period when all in-flight updates should
be synced (locks are implicit barriers). Folding this up into
do_tb_read_exec_freq might make this clearer.

> +    return exec_freq;
> +}
> +
>  #if defined(CONFIG_USER_ONLY)
>  void tb_invalidate_phys_addr(target_ulong addr)
>  {
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index a80407622e..5d3d829d18 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -513,4 +513,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>  /* vl.c */
>  extern int singlestep;
>
> +void tb_read_exec_freq(void);
> +void tb_dump_all_exec_freq(void);
> +
>  #endif
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index feb585e0a7..ba518d47a0 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -28,6 +28,14 @@
>
>  typedef struct TranslationBlock TranslationBlock;
>  typedef struct TBContext TBContext;
> +typedef struct TBStatistics TBStatistics;
> +
> +struct TBStatistics {
> +    target_ulong pc;
> +    target_ulong cs_base;
> +    uint32_t flags;
> +    uint64_t total_exec_freq;
> +};
>
>  struct TBContext {
>
> @@ -35,6 +43,7 @@ struct TBContext {
>
>      /* statistics */
>      unsigned tb_flush_count;
> +    struct qht tb_statistics;
>  };
>
>  extern TBContext tb_ctx;
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 5ee0046b62..593c1f1137 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -474,6 +474,8 @@ static inline void cpu_tb_jmp_cache_clear(CPUState *c=
pu)
>      }
>  }
>
> +uint64_t tb_get_and_reset_exec_freq(struct TranslationBlock*);
> +
>  /**
>   * qemu_tcg_mttcg_enabled:
>   * Check whether we are running MultiThread TCG or not.


--
Alex Benn=C3=A9e

