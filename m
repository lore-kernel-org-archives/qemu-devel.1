Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4EFC33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CF4206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4ZrmuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CF4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itL63-0004cb-IK
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itL5F-00047f-Si
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itL5E-0004GO-Ni
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:38:25 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:32881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itL5E-0004Fm-Gq
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:38:24 -0500
Received: by mail-lj1-x244.google.com with SMTP id y6so32065597lji.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 16:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6kkSBjU9KcJIECujhqZi2tBv398h8qXlG2nD+oX3Rp0=;
 b=iU4ZrmuSgDhAffxRdohbzT9UyCkidf+IeTR+yZZgnaI+cYJh3Nl8omkbMJB/towVtS
 WOrn/2Z3SDH+tshCit7OU0cJv4+fkzTUyAyMKSpzKf7hLqB7+qcK6Mz++i2VZWH/UcXf
 64JrVwKoLuGsF3MSGJ/zMUn383wDJePB1FXTeSivQRgYc1LSXN1q5ouOJQhk+d2lnDUS
 Ce6eZuICC9msJIHqKrE7YfqBqk7eSF5ZxA+mHhre4kZNes/0FPFZBQ2ya48+NiBSaiWn
 1JHb2m89wAnpbMPUTO7zp9RljfbWIyYTym1pRaum6QsyhSCQ0Bh/75hsgsL1hnW67mNU
 g+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6kkSBjU9KcJIECujhqZi2tBv398h8qXlG2nD+oX3Rp0=;
 b=rLpLBZKfUhwoaLjNQq8+GhkVa7nIVrwcQMLi2SmonRHAqhKOCSW2GOyjE1lIH3SZ5k
 4OMka6gGh5o4LT8Ej+mEOSO9QE+JMuUt7ACtjInZ9Kq5a0yQn2EpTQBePYXejp9GJYK3
 QD+SpxsLNCh4pRq0jLVxqBs3ti5rw3n3JGhRqmutc0KigL3DLyX5IAOEP7s2eSXHy2uz
 CBTVZYQKyaXq8+0RadvXeSrBYJTnUEJ/yB4sK+c7lULZ/ataHpDYYgovTgk6Ftwu4Qav
 rNBBVjCERY6/SAiccIACppWg8B4nEvPc/fdDEG5KNr9iyzGQSi5zMKYqTekK6dKEXvCV
 ZPFg==
X-Gm-Message-State: APjAAAXxQA5Yysa0mDHm3+DwhsnUFm2XKmEo4arvd3P5XjWGtTGbMAo5
 g8X2CGDejjQE9Xc/UQaZEuPFctVaswCPMRai+/s=
X-Google-Smtp-Source: APXvYqwkzhidKukUfrZ4pbUAL8Ks7hLpqyRV6Vo8loS5pLkQoQfOlgAs/982pkdWcRjLMTV0OqHLlhUvg+nB/a/Ro3E=
X-Received: by 2002:a2e:8946:: with SMTP id b6mr11820789ljk.1.1579480703100;
 Sun, 19 Jan 2020 16:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-4-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-4-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jan 2020 10:37:56 +1000
Message-ID: <CAKmqyKM1_R9VRF2nC+cC3G8QYQ8X9wbh8vD_MrmdM5QJgV5jTg@mail.gmail.com>
Subject: Re: [PATCH 3/9] cputlb: Pass CPUTLBDescFast to tlb_n_entries and
 sizeof_tlb
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 12:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We do not need the entire CPUArchState to compute these values.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e4a8ed9534..49c605b6d8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,14 +80,14 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
>  QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>  #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>
> -static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> +static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
>  {
> -    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> +    return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
>  }
>
> -static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
> +static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
>  {
> -    return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
> +    return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
>  }
>
>  static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
> @@ -156,7 +156,7 @@ static void tlb_dyn_init(CPUArchState *env)
>  static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
>  {
>      CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
> -    size_t old_size = tlb_n_entries(env, mmu_idx);
> +    size_t old_size = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
>      size_t rate;
>      size_t new_size = old_size;
>      int64_t now = get_clock_realtime();
> @@ -236,7 +236,8 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>      env_tlb(env)->d[mmu_idx].large_page_addr = -1;
>      env_tlb(env)->d[mmu_idx].large_page_mask = -1;
>      env_tlb(env)->d[mmu_idx].vindex = 0;
> -    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
> +    memset(env_tlb(env)->f[mmu_idx].table, -1,
> +           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
>      memset(env_tlb(env)->d[mmu_idx].vtable, -1,
>             sizeof(env_tlb(env)->d[0].vtable));
>  }
> @@ -622,7 +623,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
>      qemu_spin_lock(&env_tlb(env)->c.lock);
>      for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          unsigned int i;
> -        unsigned int n = tlb_n_entries(env, mmu_idx);
> +        unsigned int n = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
>
>          for (i = 0; i < n; i++) {
>              tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].table[i],
> --
> 2.20.1
>
>

