Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BBBC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D870B21901
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSG0LZIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D870B21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2xf-000101-UM
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 12:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37687)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hr2xV-0000c1-9F
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hr2xT-0007Ua-4H
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:20:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hr2xS-0007QQ-R4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:20:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id x1so5123957wrr.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QArzoDZVmokDybgWBo/hqHbqqcaJ2VBHt4qs2Buywkg=;
 b=wSG0LZIUseJ9WoMUyDI4dm4vBnECNI4aaktLT0aj23/UiEKN4I5VHoUKTqLV3DW65R
 bsZRlPOTsMCOg/jtt1IYXbE8bLFlK3383/uZmNIMghccDsYpi70DUsoj3TxOjj61bBBZ
 QhXAygXTpA835iVkeK2m6TVvhyXMBpVpVFArZ0vuHo+smCvZJ92owO6Y6gvKHny1O/UR
 6JRYl1SsciB2VLrQPZ6w75swk5A+29aGmqwAD6Rh93LZvLOi7qagI2cXNnMFJzSg2Jfm
 jFlL6S8N6ISzlpSInvA2iRS+YqHbEoGDtuusnLU0nm0SSgtcXmdtKiInp6b1KHcnirBM
 /QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QArzoDZVmokDybgWBo/hqHbqqcaJ2VBHt4qs2Buywkg=;
 b=lHR2gYmYMX8hIHWbUpzrLreUgBQkvkzaIUfdMYK5oXCWR8W5OKCeTCBUxo64gj0jUa
 8upBnHitwDpLuqIsZlZzFjehFD/5hsQMem8QOb71V7CKlOTI3I1F9zu+sY3TzWXhyRLm
 kza059TmCQX5Am9y8ugydoFmVavjIOk+x9vJUXbBzzVZfAc10BvhKNneORKovJSqTz5h
 15olnUiDgHBsPdBdFgOBXbZYxcMq334RLvTsJXLqme6X65uj9lURbqGLCP2oVQPJ/daN
 4TV1PdITSKg50hhe0x9t0gO9pIsY9E9Csb17LQsr7Nm4XuwlI9pGHLvVyuin+PsK4vYl
 qIwA==
X-Gm-Message-State: APjAAAXunGc3XJ2nQ/CsOuLvXF0glKc4XbXhh14Y7QQ1qB5kErBnlvUK
 n8/WaZb8N9+BGDyZczip2bJ5ew==
X-Google-Smtp-Source: APXvYqy7sbVQ73+q79HCLbn1MhusUnf3cv53mi4toTO7kfjfs+v2uF0QWnDHhvAp+Z7CiTJu5jIHlQ==
X-Received: by 2002:a5d:6911:: with SMTP id t17mr1046401wru.268.1564158037229; 
 Fri, 26 Jul 2019 09:20:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i66sm85648564wmi.11.2019.07.26.09.20.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 09:20:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D9CB1FF87;
 Fri, 26 Jul 2019 17:20:36 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-6-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-6-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 17:20:36 +0100
Message-ID: <87o91ghinf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 5/7] log: adding -d tb_stats to control
 tbstats
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Adding -d tb_stats:[limit:[all|jit|exec]] to control TBStatistics
> collection. "limit" is used to limit the number of TBStats in the
> linux-user dump. [all|jit|exec] control the profilling level used
> by the TBStats: all, only jit stats or only execution count stats.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  include/qemu/log.h |  1 +
>  util/log.c         | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 8cdfc268ca..93642603e5 100644
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
> diff --git a/util/log.c b/util/log.c
> index f81653d712..8109d19afb 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -30,6 +30,7 @@ FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
> +int32_t max_num_hot_tbs_to_dump;
>
>  /* Return the number of characters emitted.  */
>  int qemu_log(const char *fmt, ...)
> @@ -273,6 +274,8 @@ const QEMULogItem qemu_log_items[] =3D {
>      { CPU_LOG_TB_NOCHAIN, "nochain",
>        "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
>        "complete traces" },
> +    { CPU_LOG_TB_STATS, "tb_stats[:limit:(all,jit,exec)]",
> +      "show TBs statistics (until given a limit) ordered by their hotnes=
s.\n" },
>      { 0, NULL, NULL },
>  };
>
> @@ -294,6 +297,37 @@ int qemu_str_to_log_mask(const char *str)
>              trace_enable_events((*tmp) + 6);
>              mask |=3D LOG_TRACE;
>  #endif
> +        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
> +            if (g_str_has_prefix(*tmp, "tb_stats:") && (*tmp)[9] !=3D '\=
0') {
> +
> +                if (!g_ascii_isdigit(*((*tmp) + 9))) {
> +                    fprintf(stderr,
> +                            "should be a number follow by [all|jit|exec]=
, as tb_stats:10:all\n");
> +                    exit(1);
> +                }
> +                /* get limit */
> +                max_num_hot_tbs_to_dump =3D atoi((*tmp) + 9);

We probably want to handle -d tb_stats:[all|jit|exec] as well because we
might be doing interactive exploration for softmmu. I'd suggest
splitting the number processing off to a new patch and merging the exit
processing part of the later patches with it. As you don't have a HMP
for linux-user you can make the number required for linux-user or only
optional for softmmu.

> +
> +                /* get profilling level */
> +                char *s =3D (*tmp) + 9;
> +                while (*s !=3D '\0') {
> +                    if (*s++ =3D=3D ':') {
> +                        break;
> +                    }
> +                }
> +                if (g_str_equal(s, "jit") =3D=3D 0) {
> +                    set_default_tbstats_flag(TB_JIT_STATS);
> +                } else if (g_str_equal(s, "exec") =3D=3D 0) {
> +                    set_default_tbstats_flag(TB_EXEC_STATS);
> +                } else {
> +                    set_default_tbstats_flag(TB_JIT_STATS | TB_EXEC_STAT=
S);
> +                }

If additional stats types get added we shall want to be additive:

  -d host_tbs:jit,exec

> +            } else {
> +                set_default_tbstats_flag(TB_JIT_STATS | TB_EXEC_STATS);
> +            }
> +
> +            mask |=3D CPU_LOG_TB_STATS;
> +            enable_collect_tb_stats();
>          } else {
>              for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
>                  if (g_str_equal(*tmp, item->name)) {


--
Alex Benn=C3=A9e

