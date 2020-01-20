Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4083FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0930F22522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzquKfqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0930F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itg0A-0006dc-5g
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itfyy-0005GZ-TZ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itfyx-0000T8-QY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:57:20 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itfyx-0000Rb-Jd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:57:19 -0500
Received: by mail-lf1-x143.google.com with SMTP id y1so575831lfb.6
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WRsBqK5dYZrGKHxIlsgZ+pXZREyyBA71SEpLenHDywE=;
 b=NzquKfqvq21MPkdIFOk6Hheh+GucoAmEcb+ZxGV1YIrEK5Y8TRRr8VbFl15vezRQqa
 fVutVqswbJm55xSXxCCwsqLV5NlaKf+ey6YVtSsDxy+GNjjZSbbuk9s4021v5rZzj4Fy
 SbE0S+Qpulm+zz573wcyOTRlesZppKsbYs13MOtkQEU+cExG1kCnJOh327BVJJcidmfM
 ko4cYVOtYGwAOGFWlt5bLT4Vuq7YqzY9dLVuL/u7sr+0AeS9EmtWRZ+re9QSOI31K2S0
 uxExqQJf7l2RESmxWJlBvZLEOY05LZ3ppjEcaq60nY8COMDEZ9Q+ehIgOZDpzBNpxWBT
 p3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WRsBqK5dYZrGKHxIlsgZ+pXZREyyBA71SEpLenHDywE=;
 b=RmAXddAM/iSh5y77bIhplhIgzqaj03Z6NQmMo3aPo2pCkrXII0ifPMjqfz9ZXXW3bW
 mMjZhwiekuZSC2OkZB50UWYECbCUR8lactybq9JzXzwk5y5m5Nqp/AZ0hZnKIHU3epdH
 +UnDDsAFGpZkHClhOFJPpE4Xx2sr7x2qK5hwgv6ww2AOSKujO5HXLDjrq+MSvZXz/tuK
 nNorqdpcKVcBOb2TMZfoIlP4lPehSHCXNEjYJSTjGl2tao80PhhvpuYO7vc8KuMpDm+B
 1rrApZbiM6osmIT9uGf1/lrcRTk9qJyWvMpeNUOGJVd3rQ1dfnhOT5AlTppmE+uSGWvr
 +Dqw==
X-Gm-Message-State: APjAAAVQM31h2wbF9Ly9A0Oui7K3sdkYnjlOqIEV3uSgHNHepnDN6VYb
 OFot+wG/ykuWZr4/76PsVqh+1XnffgVJZIHCz5c=
X-Google-Smtp-Source: APXvYqymoKX1rJIAIEJft7In2aGiIAPo9P2wuANDsr/iUGoPtK9LDmdgW7GaTPKIXoowAkC2j6M+zUHYiT+d/zwFmYo=
X-Received: by 2002:a05:6512:15d:: with SMTP id
 m29mr899243lfo.51.1579561037711; 
 Mon, 20 Jan 2020 14:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-6-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-6-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 08:56:48 +1000
Message-ID: <CAKmqyKOHdd8MG_+KtsjsKnMXR2m3feiaufTWy2OMaJt=np9Hww@mail.gmail.com>
Subject: Re: [PATCH 5/9] cputlb: Hoist tlb portions in
 tlb_flush_one_mmuidx_locked
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
> No functional change, but the smaller expressions make
> the code easier to read.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c7dc1dc85a..eff427f137 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -230,15 +230,16 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>
>  static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>  {
> -    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mmu_idx]);
> -    env_tlb(env)->d[mmu_idx].n_used_entries = 0;
> -    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
> -    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
> -    env_tlb(env)->d[mmu_idx].vindex = 0;
> -    memset(env_tlb(env)->f[mmu_idx].table, -1,
> -           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
> -    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
> -           sizeof(env_tlb(env)->d[0].vtable));
> +    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
> +    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
> +
> +    tlb_mmu_resize_locked(desc, fast);
> +    desc->n_used_entries = 0;
> +    desc->large_page_addr = -1;
> +    desc->large_page_mask = -1;
> +    desc->vindex = 0;
> +    memset(fast->table, -1, sizeof_tlb(fast));
> +    memset(desc->vtable, -1, sizeof(desc->vtable));
>  }
>
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
> --
> 2.20.1
>
>

