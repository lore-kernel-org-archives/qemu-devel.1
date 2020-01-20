Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C447C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF5022522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcE9pXk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5022522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itg71-0004N1-8y
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itg4V-0002Ge-PL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itg4U-0003ra-60
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:03:03 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itg4T-0003qi-Uc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:03:02 -0500
Received: by mail-lf1-x143.google.com with SMTP id b15so601311lfc.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qcuEZU1rYgf6GCvIhlg6BiILr/oL9Ugd6h9vgP2i6fo=;
 b=mcE9pXk5vX1HWOXkrnr4xyFLtSHA83piwEYPir571q/EF/py/nE92wTpznnJziMyCx
 rooML9zZc6cKj6knOJaRUCN3tru9rnHnF8kuZEcA0Nm1kHaTuKxZWy5FhsVcHoHeaBRJ
 wT/5SzcDUGnB6eFDRK8ejdJUWduIBkqJG57AtCjdx8sRLHD45AopxbaL0pm+dk8wrmYN
 9z1kxNyvi02fz3/LpPpXBcPEpYz7vYxmanldwj4vMMo4t8yGGaWhtgtzMBj1Zj/ArL2Y
 cuWGYoxWxhbYmAMG5MzT1MvSw3eTFCL3BCPD1Fy0GE25glrZiSAsBfH6EngYjRp8nOUI
 SwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qcuEZU1rYgf6GCvIhlg6BiILr/oL9Ugd6h9vgP2i6fo=;
 b=jSlbzg+nPY7k9U4pQRK9mNRJqL08Sj2SnRXU5IFCRuyq4jQn6DiX2udMHeWRWNqor1
 g4Mw6aEFm2/oXy6DAK6NuPAgXk+hlxCaPga+3DzZ0pCVPoDI5LkZFdMC1Re0XwexSNRM
 WEXaRZPUD9esrJ/+GzqR4l1PuLLUWy94lpYSsGV0f3ySKKuxRP0R9/Q8wquchU0vnqEz
 uAHGF9nP+Fzogg6v8ATfx7h5WFmNmjH+uiyLO0A1mBIKgp/qkLfkLwJWxyfzCt3FV5uL
 VDK84tn8pPl3rzl7wcZxEsWnF07DSyjshxr2aVPunsCp6u3eqw2MNzj8wu1r9qT0qbtR
 3pqA==
X-Gm-Message-State: APjAAAXwxnI3LWf9qVC5sGmunimqEiPlqdtf+XUfllsKKU196614cwNC
 vzv7BZN0+wAN5ROwpW0r+lecPwfxfCGVj8tQEnk=
X-Google-Smtp-Source: APXvYqxzzz4gpTALdBVbwnsf+Re+qN3RoTHdFqushX5lOpozH1r+eeLh6lBKU6WKSePVNai1o6dKd69kCjZQ5fzWJ1c=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr859510lfn.137.1579561380532;
 Mon, 20 Jan 2020 15:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-10-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-10-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 09:02:31 +1000
Message-ID: <CAKmqyKMkVkrqjXgTjuq4KzNjPz0U2TEJ4j=23KZZauq8Kuzk0Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] cputlb: Hoist timestamp outside of loops over tlbs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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

On Thu, Jan 9, 2020 at 12:55 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not call get_clock_realtime() in tlb_mmu_resize_locked,
> but hoist outside of any loop over a set of tlbs.  This is
> only two (indirect) callers, tlb_flush_by_mmuidx_async_work
> and tlb_flush_page_locked, so not onerous.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 761e9d44d7..9f6cb36921 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -137,12 +137,12 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
>   * high), since otherwise we are likely to have a significant amount of
>   * conflict misses.
>   */
> -static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
> +static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
> +                                  int64_t now)
>  {
>      size_t old_size = tlb_n_entries(fast);
>      size_t rate;
>      size_t new_size = old_size;
> -    int64_t now = get_clock_realtime();
>      int64_t window_len_ms = 100;
>      int64_t window_len_ns = window_len_ms * 1000 * 1000;
>      bool window_expired = now > desc->window_begin_ns + window_len_ns;
> @@ -222,12 +222,13 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>      memset(desc->vtable, -1, sizeof(desc->vtable));
>  }
>
> -static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
> +static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx,
> +                                        int64_t now)
>  {
>      CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
>      CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
>
> -    tlb_mmu_resize_locked(desc, fast);
> +    tlb_mmu_resize_locked(desc, fast, now);
>      tlb_mmu_flush_locked(desc, fast);
>  }
>
> @@ -310,6 +311,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
>      CPUArchState *env = cpu->env_ptr;
>      uint16_t asked = data.host_int;
>      uint16_t all_dirty, work, to_clean;
> +    int64_t now = get_clock_realtime();
>
>      assert_cpu_is_self(cpu);
>
> @@ -324,7 +326,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
>
>      for (work = to_clean; work != 0; work &= work - 1) {
>          int mmu_idx = ctz32(work);
> -        tlb_flush_one_mmuidx_locked(env, mmu_idx);
> +        tlb_flush_one_mmuidx_locked(env, mmu_idx, now);
>      }
>
>      qemu_spin_unlock(&env_tlb(env)->c.lock);
> @@ -446,7 +448,7 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
>          tlb_debug("forcing full flush midx %d ("
>                    TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
>                    midx, lp_addr, lp_mask);
> -        tlb_flush_one_mmuidx_locked(env, midx);
> +        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
>      } else {
>          if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
>              tlb_n_used_entries_dec(env, midx);
> --
> 2.20.1
>
>

