Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F37C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C8622522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQi147/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C8622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itg1S-0007jp-Hh
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itg0T-0007Cb-0W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itg0R-0001Se-Tc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:58:52 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:34242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itg0R-0001SH-Jv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:58:51 -0500
Received: by mail-lf1-x142.google.com with SMTP id l18so611059lfc.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rCbisD4Cbn7O3hmlXpaq3F8ISNYsT/+qRXAc4pA8Zaw=;
 b=dQi147/pArneo5Np7PbSB5zoG4Bcc8A1uodjqbtEReh0rwk9UZ/L6iEGJWm1cIDEl4
 Ry4Gc7cfOAXJ+b1U+NPHSZzPfBIpA7rGldQdSkaZ6uWpaaHkkcGSUZqbSmDnU3bNVEtg
 QBvCugeoEBHbAQThQQ9KiPTNtKihXwJ57H9EqaLyHwZcIP7vULZCOn7DaQpXmHMi67xO
 gzeAGT6c3u8MsdcUZ/njwkWF/41t7h4NQzHoTy8vFYYUiWQGgo/PLMTLtXFU/7Xd+Ckg
 V7bp4qL/4EcWgRaD/6RTZsJKzjy1Y6FNL/dt7VlmYO/v0SXFUtd17mB1ru+yI2zsDzh4
 3AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rCbisD4Cbn7O3hmlXpaq3F8ISNYsT/+qRXAc4pA8Zaw=;
 b=RneKfYcvkf7tjhLjXsLWBNAoVx0h/tKNNEj+RbdF35aEZo+wb2hqjzAA2FCwuDo1Qy
 ugek6plLAm5Ov2limg6kpC58muQ1fxk/i4nt2cyXwNIypXegiHH2WxU3UDCYmHEqpl7o
 Bj9BkmkQdpE15Giuer99CIE1onXjtwEgZq9QEFp2I6Bmfja4rE++WnV96EZ4wvhgZXkG
 iv2hOpc3pXzac0FttmtQZ0AgF9egapXByYLbZ/Z+4r56VX9mU6Emi2IPiBEgXnDqGMeD
 wzVEuHkCcajoeSMLdIFNl8uRkosBJbsZ87Lmt4nC+5pt+dtY728lGCyaiA/Ey7lAU+CT
 0n3Q==
X-Gm-Message-State: APjAAAUR9GRX3gBMu+sZ7xeRV0pb799guwM/DtaWSXuUDsoQMsQ/q1r/
 KWSecucJz2JkyKdw2vSxPi3/4CJOk3MaKRhKA6c=
X-Google-Smtp-Source: APXvYqzDazpNOH7wc0Ru4Luj+/h5kSb98UqlRG39fQ5uUzzW7zPS7NkZRP4ITBWePgvNrYWMFWdE9Rvyoyq3zjgID/4=
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr844529lfc.196.1579561130324;
 Mon, 20 Jan 2020 14:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-7-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-7-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 08:58:20 +1000
Message-ID: <CAKmqyKM=dZObzO7JPcDAm-b+CDhrWh7U0fV32nj3rwXn686gDw@mail.gmail.com>
Subject: Re: [PATCH 6/9] cputlb: Split out tlb_mmu_flush_locked
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
> We will want to be able to flush a tlb without resizing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index eff427f137..e60e501334 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -228,12 +228,8 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>      }
>  }
>
> -static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
> +static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>  {
> -    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
> -    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
> -
> -    tlb_mmu_resize_locked(desc, fast);
>      desc->n_used_entries = 0;
>      desc->large_page_addr = -1;
>      desc->large_page_mask = -1;
> @@ -242,6 +238,15 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>      memset(desc->vtable, -1, sizeof(desc->vtable));
>  }
>
> +static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
> +{
> +    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
> +    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
> +
> +    tlb_mmu_resize_locked(desc, fast);
> +    tlb_mmu_flush_locked(desc, fast);
> +}
> +
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
>  {
>      env_tlb(env)->d[mmu_idx].n_used_entries++;
> --
> 2.20.1
>
>

