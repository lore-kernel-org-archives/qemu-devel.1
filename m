Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30631C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87E4208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUXO2F9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87E4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgDh-00026l-6K
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itgCp-0001gn-D4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itgCo-0008FU-9R
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:11:39 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itg2W-0002gm-LC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:01:00 -0500
Received: by mail-lj1-x242.google.com with SMTP id m26so701310ljc.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s/UsMPCcv7IJGjQ2SU2nwT/sFk05QKW2DeuQI0b3ESE=;
 b=oUXO2F9W5wtmunK0h2SSpy3kPfyXBPFlDHLOmfrq8PQVd0oRQor5rbY0Xwj1vHSR3r
 QfDy4YomCTFLyt2DOF3kXLMk9a4eAA8ZuKkgh5/XIJEgzRM0jNPBFfXqJj9cpMvvPZag
 AZk1wf8DQNaJMw1r/wwaUnRHpDSEjKukrXTTqRhQ3R08RgpwhgYWi5vs7PTe4I5qUT4X
 gaYDuDu8ccXY6ApWZ+yYNx/l3JquF7JXCstxgeN6h0ilxWV4ZQDgLHCWJnG/GwGAK9O7
 W0iX21n6Tm2yqXZiHCNAHPzbR2fNAestQu9dbQIqLIhZUL4erhSzhFEexZPmsqOBbWX9
 KjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s/UsMPCcv7IJGjQ2SU2nwT/sFk05QKW2DeuQI0b3ESE=;
 b=lXNda3qudybUo+6MSpWeNSy81Tgh4aVL1x03Xe1ofdPqPGrZchA7KXrB+wwC1cG4g0
 HYho0uS0XdCjCrSVAmsYJ1XQy3kTjB6d4PqVTb58nbUnNXwvTpAC4RCcg1tZC19oPQnA
 WscwOtOhT1bP191YvaXdYA7J1Da25zgRXF5//7cJ88oXbBA5IroJCjKEhAN+7fVbLxi0
 ettveETPjbUcUdLW3qI3wQM+OFv4lf2axCbvf7inuCwvEao39nH0DTLSOHksKoKyxUrZ
 LjdXlw7X4aKciik/3eBqqZn5OXH+N//8AVRV1LxbQRCSXsgzDKAOn+gup02HflHODEZh
 5FWw==
X-Gm-Message-State: APjAAAUtc5JaYKffSdJWp9Ia+rKUDfNS6wd5L8Lhykj1xMuSK8LVZpzz
 ZHixBfQZ0grSPErma+eS3MVajYUo3hXdfnyyQNc=
X-Google-Smtp-Source: APXvYqz91r+odhd2wktDbQNX7k2RJNftCnqI/Z8mO/0XPmG0JewqTVgm1boOSk8m9yh3MV0v6GCCGG7RYZ0oKzX//pU=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr14783931ljj.156.1579561259106; 
 Mon, 20 Jan 2020 15:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-8-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-8-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 09:00:30 +1000
Message-ID: <CAKmqyKNGoDtWK462rvaZyRT=oAVrgmY5miOv_r0HVVwRcC5NSA@mail.gmail.com>
Subject: Re: [PATCH 7/9] cputlb: Partially merge tlb_dyn_init into tlb_init
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

On Thu, Jan 9, 2020 at 12:52 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge into the only caller, but at the same time split
> out tlb_mmu_init to initialize a single tlb entry.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e60e501334..c7c34b185b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -97,22 +97,6 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
>      desc->window_max_entries = max_entries;
>  }
>
> -static void tlb_dyn_init(CPUArchState *env)
> -{
> -    int i;
> -
> -    for (i = 0; i < NB_MMU_MODES; i++) {
> -        CPUTLBDesc *desc = &env_tlb(env)->d[i];
> -        size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
> -
> -        tlb_window_reset(desc, get_clock_realtime(), 0);
> -        desc->n_used_entries = 0;
> -        env_tlb(env)->f[i].mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
> -        env_tlb(env)->f[i].table = g_new(CPUTLBEntry, n_entries);
> -        env_tlb(env)->d[i].iotlb = g_new(CPUIOTLBEntry, n_entries);
> -    }
> -}
> -
>  /**
>   * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if necessary
>   * @desc: The CPUTLBDesc portion of the TLB
> @@ -247,6 +231,17 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>      tlb_mmu_flush_locked(desc, fast);
>  }
>
> +static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
> +{
> +    size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
> +
> +    tlb_window_reset(desc, now, 0);
> +    desc->n_used_entries = 0;
> +    fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
> +    fast->table = g_new(CPUTLBEntry, n_entries);
> +    desc->iotlb = g_new(CPUIOTLBEntry, n_entries);
> +}
> +
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
>  {
>      env_tlb(env)->d[mmu_idx].n_used_entries++;
> @@ -260,13 +255,17 @@ static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
>  void tlb_init(CPUState *cpu)
>  {
>      CPUArchState *env = cpu->env_ptr;
> +    int64_t now = get_clock_realtime();
> +    int i;
>
>      qemu_spin_init(&env_tlb(env)->c.lock);
>
>      /* Ensure that cpu_reset performs a full flush.  */
>      env_tlb(env)->c.dirty = ALL_MMUIDX_BITS;
>
> -    tlb_dyn_init(env);
> +    for (i = 0; i < NB_MMU_MODES; i++) {
> +        tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
> +    }
>  }
>
>  /* flush_all_helper: run fn across all cpus
> --
> 2.20.1
>
>

