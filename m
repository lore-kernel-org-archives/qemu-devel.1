Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4D6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B2920673
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydj6hCWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B2920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bak-0005mN-9O
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2bZO-0005Jl-3V
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2bZM-0004AK-3B
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:31:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2bZL-00048H-QW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:31:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id d16so3060384wme.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=M0M6shkvkyuQl6x9JyXrGtyzGJCvsxTALaLL9u58TCk=;
 b=ydj6hCWo6Q6UpRjSeKaZku0z5cpVqEK2/UNNH/QanEk/uBzoNlxauXNbpRAuKjq4vL
 73Q6/AiTk4e4C+dJz6cMicYJ4nuwmF6LOPRpKjPHruMlSVyVT2z9Rf1wSNfDvs1UZ/NC
 AvlEoi5YzBX5zpth32JgWt6eRhPX8taBegny2X8xhEyXzsnPelsPL1hfaWq5z7N2KyDC
 8TBF4MCnkceCR7SJvD3QJa+RqxID1qYPROv3mAtf716ylYoIVVrTQ/rcZzPZp7RlhhJ1
 sDnauCTAf9Rx56oUdDFnf3bvuva7oJP+8ubHj/Xle8Ge2YgsE0ZKyLnPAnJr5ItiLGMI
 OcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=M0M6shkvkyuQl6x9JyXrGtyzGJCvsxTALaLL9u58TCk=;
 b=Y1wV2GIJ3FWZduLmO3EWbZGh9ruCVZGrhGwJ6KVocVHuB74DiLfcttTM7q7eMTonGp
 Uy3rBY4lE1ddU/Zw19OTf8ihx6rdlfHEoa4Igd9BvEHmXTzuKth+D3rc7BdtJsnz98B9
 32AzZEdxsLCl9bDAbaD/4JZAjupW8VX3Rzsums6JqRsmnnuDFRKOxW1EpMYkzFQpgjWf
 lVNoppMMmbC+3TIVEHnkqSg6XBXAjcrQKtgrBJxJIA1oZlVHFL+zhlQo8f9835g0drFZ
 cZ8/rIEwgqgUJA7DJ3BJxn9s7RqMqlrr+whVnf1DzGBqsSThsTiUrLRJKd+8keo5efM3
 2oIQ==
X-Gm-Message-State: APjAAAUDmNb3+/VkDD8Iveog89DqcfT8Aa5jGIKAUaiVpRnHK5We/V3I
 TKSesxT6LQp4Iaxi3YUwP/vXYQ==
X-Google-Smtp-Source: APXvYqyKSioe+MuwGNzAQ+PSIPf0uOpCsOUUTYcE8zwkD3Ppn+NXbR2qyDLzmRGmAKbR451I9Z+vbw==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr28330891wmb.41.1566912683131; 
 Tue, 27 Aug 2019 06:31:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f192sm2760484wmg.30.2019.08.27.06.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 06:31:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C25D91FF87;
 Tue, 27 Aug 2019 14:31:21 +0100 (BST)
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
 <20190821172329.2062-7-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190821172329.2062-7-vandersonmr2@gmail.com>
Date: Tue, 27 Aug 2019 14:31:21 +0100
Message-ID: <87o90a68gm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v6 06/10] log: adding -d tb_stats to
 control tbstats
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

> Adding -d tb_stats to control TBStatistics collection:
>
>  -d tb_stats[[,level=3D(+all+jit+exec+time)][,dump_limit=3D<number>]]
>
> "dump_limit" is used to limit the number of dumped TBStats in
> linux-user mode.
>
> [all+jit+exec+time] control the profilling level used
> by the TBStats. Can be used as follow:
>
> -d tb_stats
> -d tb_stats,level=3Djit+time
> -d tb_stats,dump_limit=3D15
> ...
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c      |  1 +
>  accel/tcg/translator.c    |  1 +
>  include/exec/gen-icount.h |  1 +
>  include/exec/tb-stats.h   | 15 ---------------
>  include/qemu-common.h     | 15 +++++++++++++++
>  include/qemu/log.h        |  1 +
>  tcg/tcg.c                 |  1 +
>  util/log.c                | 35 +++++++++++++++++++++++++++++++++++
>  8 files changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index e0ac254fc1..8554174360 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -3,6 +3,7 @@
>  #include "disas/disas.h"
>  #include "exec/exec-all.h"
>  #include "tcg.h"
> +#include "qemu-common.h"
>
>  #include "qemu/qemu-print.h"
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 834265d5be..ea7c3a9f77 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -16,6 +16,7 @@
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
>  #include "exec/translator.h"
> +#include "qemu-common.h"
>
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index b3efe41894..6f54586dd6 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -2,6 +2,7 @@
>  #define GEN_ICOUNT_H
>
>  #include "qemu/timer.h"
> +#include "qemu-common.h"
>
>  /* Helpers for instruction counting code generation.  */
>
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 0ea2639fd2..a607ceaa53 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -79,21 +79,6 @@ void init_tb_stats_htable_if_not(void);
>  void dump_jit_profile_info(TCGProfile *s);
>
>  /* TBStatistic collection controls */
> -enum TBStatsStatus {
> -    TB_STATS_DISABLED =3D 0,
> -    TB_STATS_RUNNING,
> -    TB_STATS_PAUSED,
> -    TB_STATS_STOPPED
> -};
> -
> -#define TB_NOTHING    (1 << 0)
> -#define TB_EXEC_STATS (1 << 1)
> -#define TB_JIT_STATS  (1 << 2)
> -#define TB_JIT_STATS  (1 << 3)
> -
> -extern int tcg_collect_tb_stats;
> -extern uint32_t default_tbstats_flag;
> -
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
>  void pause_collect_tb_stats(void);
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 0235cd3b91..3930b61ec0 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -130,4 +130,19 @@ void page_size_init(void);
>   * returned. */
>  bool dump_in_progress(void);
>
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED =3D 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED
> +};
> +
> +#define TB_NOTHING    (1 << 0)
> +#define TB_EXEC_STATS (1 << 1)
> +#define TB_JIT_STATS  (1 << 2)
> +#define TB_JIT_TIME   (1 << 3)
> +
> +extern int tcg_collect_tb_stats;
> +extern uint32_t default_tbstats_flag;
> +

This seems like a regression, why move from tb-stats.h? We should
certainly resist dumping more stuff in qemu-common.h.

>  #endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index b097a6cae1..a8d1997cde 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
>  /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
>  #define CPU_LOG_TB_OP_IND  (1 << 16)
>  #define CPU_LOG_TB_FPU     (1 << 17)
> +#define CPU_LOG_TB_STATS   (1 << 18)
>
>  /* Lock output for a series of related logs.  Since this is not needed
>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 1a306e1ec9..08f3d50199 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -35,6 +35,7 @@
>  #include "qemu/host-utils.h"
>  #include "qemu/qemu-print.h"
>  #include "qemu/timer.h"
> +#include "qemu-common.h"
>
>  /* Note: the long term plan is to reduce the dependencies on the QEMU
>     CPU definitions. Currently they are used for qemu_ld/st
> diff --git a/util/log.c b/util/log.c
> index 29021a4584..09cfb13b45 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -19,17 +19,20 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/qemu-print.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "trace/control.h"
> +#include "qemu-common.h"

So the root problem you are trying to get around is we can't pollute
common code like logging with CPU definitions (which are required for
ram_addr_t stuff).

The solution for this is to split the enums and "common code facing" API
functions into another header (tb-stats-flags.h?) which doesn't need to
pull in the target specific bits.

>
>  static char *logfilename;
>  FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
> +int32_t max_num_hot_tbs_to_dump;
>
>  int tcg_collect_tb_stats;
>  uint32_t default_tbstats_flag;
> @@ -276,6 +279,9 @@ const QEMULogItem qemu_log_items[] =3D {
>      { CPU_LOG_TB_NOCHAIN, "nochain",
>        "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
>        "complete traces" },
> +    { CPU_LOG_TB_STATS, "tb_stats[[,level=3D(+all+jit+exec+time)][,dump_=
limit=3D<number>]]",
> +      "enable collection of TBs statistics"
> +      "(and dump until given a limit if in user mode).\n" },
>      { 0, NULL, NULL },
>  };
>
> @@ -297,6 +303,35 @@ int qemu_str_to_log_mask(const char *str)
>              trace_enable_events((*tmp) + 6);
>              mask |=3D LOG_TRACE;
>  #endif
> +        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
> +            mask |=3D CPU_LOG_TB_STATS;
> +            default_tbstats_flag =3D TB_JIT_STATS | TB_EXEC_STATS | TB_J=
IT_TIME;
> +            tcg_collect_tb_stats =3D TB_STATS_RUNNING;
> +        } else if (tcg_collect_tb_stats =3D=3D TB_STATS_RUNNING &&
> +                g_str_has_prefix(*tmp, "dump_limit=3D")) {
> +
> +            max_num_hot_tbs_to_dump =3D atoi((*tmp) + 11);
> +        } else if (tcg_collect_tb_stats =3D=3D TB_STATS_RUNNING &&
> +                g_str_has_prefix(*tmp, "level=3D")) {
> +
> +            default_tbstats_flag =3D 0;
> +            char **level_parts =3D g_strsplit(*tmp + 6, "+", 0);
> +            char **level_tmp;
> +            for (level_tmp =3D level_parts; level_tmp && *level_tmp; lev=
el_tmp++) {
> +                if (g_str_equal(*level_tmp, "jit")) {
> +                    default_tbstats_flag |=3D TB_JIT_STATS;
> +                } else if (g_str_equal(*level_tmp, "exec")) {
> +                    default_tbstats_flag |=3D TB_EXEC_STATS;
> +                } else if (g_str_equal(*level_tmp, "time")) {
> +                    default_tbstats_flag |=3D TB_JIT_TIME;
> +                } else if (g_str_equal(*level_tmp, "all")) {
> +                    default_tbstats_flag |=3D TB_JIT_STATS | TB_EXEC_STA=
TS | TB_JIT_TIME;
> +                } else {
> +                    fprintf(stderr, "no option level=3D%s, valid options=
 are:"
> +                            "all, jit, exec or/and time\n", *level_tmp);
> +                    exit(1);
> +                }
> +            }

I'm pretty sure the string vector needs freeing once your done (g_strfreev(=
))

>          } else {
>              for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
>                  if (g_str_equal(*tmp, item->name)) {


--
Alex Benn=C3=A9e

