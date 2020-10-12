Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD46FC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EF5206CA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QW5C2Qlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EF5206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS54t-0004JB-GE
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oanderso@google.com>)
 id 1kS4oX-0003OH-9F
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:53:01 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oanderso@google.com>)
 id 1kS4oV-0004mD-7H
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:53:00 -0400
Received: by mail-ej1-x644.google.com with SMTP id c22so25169335ejx.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JqFHzGgcxqwZV2/YDF+Qvo/aHtYinSBMy2I3HesfEVw=;
 b=QW5C2Qlm9SbvYck+SOVnU+mWM5XYiuofQZIEupLgL6gCUrE7ILfSeGkQfES4ucWmzN
 0xZNL/1RGosx48D/4eNj9aABFFvsGXoBGVFYmx0hsdEZIIUWHlUkGenxNjX+sey124do
 ALQtxw/t3MdyT0psBmUVX6eNhy4BiCZc6YExysyvY1Ms3obUGUq6uJT6Z4SIbiigLh2f
 IB3ebQcz2iBmJOHUFUO0GS8Io+52peGC2VBobJvXcCiFIAMxMv45aPeMPWkbGC4T3K8j
 DKpXDUOIXekgmgc5vhrmQTlncxEjXHO1DWCffYtx6JHjrmPhB6YAuCWD6LcdQsKLYoBc
 LkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JqFHzGgcxqwZV2/YDF+Qvo/aHtYinSBMy2I3HesfEVw=;
 b=NQkw5BjAxorYpcvczAoLoN/xDHZEOu2I0EaAMCR15vlrj9A2iErQY8r2UtfjUioTSI
 +A056At+J0CgkoR1op2TNq0smkJ8aCsYO/kYa1CEEAjQtzrpIANhPOaMEgW/6IknsPRj
 eqsQY0lulHIbgKp9OkVOyIVxzsprWn6fvLKpmeq/4+KNtcCD4kPS3eH3v9CAEtrncwSF
 jDD84UTVhgGqCrW6QqIk6BtfG+Z01bvsfrAyD844Qc932BF3XhjcoTR054Fdt7v+SU3O
 y9j3f7x395ohAZIDKcqpRuKJEv/Z6yW8YT2UnRRareOR6CiI7pss4wVHX42PRzWB0S/l
 P10w==
X-Gm-Message-State: AOAM530h0pmd7JkuCztoeoax6qQ/QqXCZvVuPqISVZN07G90HmXfKV6K
 ybvDndyqIgk5W8fFNaPKpf2gwSET31iJk0677GQ17TyjG1M=
X-Google-Smtp-Source: ABdhPJzuFzO74A8/guxLUtbGe9nXjtxJet8H/oHEgdwsZdLmc87QfayQ9kGiHi+UZst562a6zmdlB/DtdyRConDn6mE=
X-Received: by 2002:a17:906:3799:: with SMTP id
 n25mr18425890ejc.6.1602535975932; 
 Mon, 12 Oct 2020 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
In-Reply-To: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
From: Owen Anderson <oanderso@google.com>
Date: Mon, 12 Oct 2020 13:52:45 -0700
Message-ID: <CAKs3XfJnyuZi85=7iX2eG2viP+X893qBGG=a7dAtd8=ovN-p9g@mail.gmail.com>
Subject: Re: [RFC] Don't lookup full CPU state in the indirect branch fast
 path on AArch64 when running in user mode.
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=oanderso@google.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

I'd like to get feedback on how/whether this could be developed into a
landable version.

Thanks,

--Owen

On Tue, Sep 29, 2020 at 2:32 PM Owen Anderson <oanderso@google.com> wrote:
>
> Hello,
>
> I would like to request feedback on the following patch, which I do
> not believe should be applied to master as-is.  The idea here is to
> avoid gathering the full CPU state in the fast path of an indirect
> branch lookup when running in user mode on a platform where the flags
> can only be changed in privileged mode.  I believe this is true on the
> AArch64 scenario that I care about, but clearly not true in general.
> I'm particularly seeking feedback on how to clean this up into a
> version that checks the correct necessary and sufficient conditions to
> allow all users that can benefit from it to do so.
>
> On the workload that I am targeting (aarch64 on x86), this patch
> reduces execution wall time by approximately 20%, and eliminates
> indirect branch lookups from the hot stack traces entirely.
>
> Thank you,
>
> --Owen
>
> From 3d96db17d3baacb92ef1bc5e70ef06b97d06a0ae Mon Sep 17 00:00:00 2001
> From: Owen Anderson <oanderso@google.com>
> Date: Tue, 29 Sep 2020 13:47:00 -0700
> Subject: [RFC] Don't lookup full CPU state in the indirect branch fast path on
>  AArch64 when running in user mode.
>
> Most of the CPU state can't be changed in user mode, so this is useless work.
>
> Signed-off-by: Owen Anderson <oanderso@google.com>
> ---
>  include/exec/tb-lookup.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
> index 9cf475bb03..f4ea0eb4c0 100644
> --- a/include/exec/tb-lookup.h
> +++ b/include/exec/tb-lookup.h
> @@ -25,7 +25,15 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong
> *pc, target_ulong *cs_base,
>      TranslationBlock *tb;
>      uint32_t hash;
>
> +#if !defined(TARGET_ARM) || !defined(CONFIG_USER_ONLY)
>      cpu_get_tb_cpu_state(env, pc, cs_base, flags);
> +#else
> +    if (is_a64(env)) {
> +      *pc = env->pc;
> +    } else {
> +      *pc = env->regs[15];
> +    }
> +#endif
>      hash = tb_jmp_cache_hash_func(*pc);
>      tb = qatomic_rcu_read(&cpu->tb_jmp_cache[hash]);
>
> @@ -34,12 +42,19 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong
> *pc, target_ulong *cs_base,
>
>      if (likely(tb &&
>                 tb->pc == *pc &&
> +#if !defined(TARGET_ARM) || !defined(CONFIG_USER_ONLY)
>                 tb->cs_base == *cs_base &&
>                 tb->flags == *flags &&
> +#endif
>                 tb->trace_vcpu_dstate == *cpu->trace_dstate &&
>                 (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == cf_mask)) {
>          return tb;
>      }
> +
> +#ifdef CONFIG_USER_ONLY
> +    cpu_get_tb_cpu_state(env, pc, cs_base, flags);
> +#endif
> +
>      tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags, cf_mask);
>      if (tb == NULL) {
>          return NULL;
> --
> 2.28.0.709.gb0816b6eb0-goog

