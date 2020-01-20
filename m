Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D9C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9CB22522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX4vTvDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9CB22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itg4t-0002Eu-1x
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itg3d-0000zL-VE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itg3c-0003Om-7a
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:02:09 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itg3b-0003Nk-Vr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:02:08 -0500
Received: by mail-lj1-x243.google.com with SMTP id z22so771314ljg.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fy1ztcbx6ZRlKDogYMy+cxilOtZIa14pESZqNPtWIQ8=;
 b=iX4vTvDwD/4k7oihdbbJIiLtMRGOQ669ziJ2UYU7yEKgMpcrmboPjIUgREwjPKZjvr
 /0GPD8Eu2h/TrWt8xMfogY1o46TTQfo6uLhSb7ymZTI6LRIxWnR5Qn2HPh8Isd/LFeTn
 ktb8t8RyYogVyuVh5N9YmE/Ylw0mAZHlazI+/+GVRFUMD2uGZLcIBRc51V6l+tKb57mA
 /5gLjmuYtmpwnjUuRMWVZ2v9ofzeIKVS8iPZj9f11ZdRahLrO0ZzWyzHIwXzFjoD5v9b
 Dz1r6MiPltsvZotSjnEIgB8CaBG9/BrcoKr/4Y8hQeUVB7hC/xajCM12wxPUYvVIInN3
 UkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fy1ztcbx6ZRlKDogYMy+cxilOtZIa14pESZqNPtWIQ8=;
 b=ocStRT+loKMSwNz/OiACnanMEssbQ+9itGvVh14i1uLsNuePQKvx/5WfQbzrM1bJnX
 8b48j3sKN7rcirbJHdBkPRX3RVf7XM6Dpbux+2S1GuF0x6J5Yv+VExBzEkUWs1MkcClk
 t+L+k46yT5QQOXFSFIW13tGuD6URq/t0MwJzSB+OOgeMf3FMdhBdS3Dq+dXgCytCDHft
 fkiBNn6N2fcjtWjfKZsl/EWbarQhb4lscHPYKQtcqnN5LKyWaYa1YQhFMSDPVx83gJS4
 43WG1vs2Z2I7gG04MtW3dYUA0ENa/HkRS9u0BUlh58BvDrVXP2ntzRMYETwSbnfBkGdE
 ibQQ==
X-Gm-Message-State: APjAAAWQSQpSNFE9pCrzyFyk10KxmJ5tcoyvm3QYkNy2JmDHEV+6dZa+
 e88LKQ4nkBDWDqpX8Vw2C0iFSJVOkR+CTncdQCds3XGx
X-Google-Smtp-Source: APXvYqyB0loO5rpjLBmBsNYcf6HvJezP07za9gPMZ+ftZNZtxOT0uZTwLtNiB8ze5g0wanrrTcn6AXyC192/pPv8RpE=
X-Received: by 2002:a2e:b5d5:: with SMTP id g21mr15109589ljn.89.1579561326089; 
 Mon, 20 Jan 2020 15:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-9-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-9-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 09:01:37 +1000
Message-ID: <CAKmqyKMBYPZ4Tz1kTuM29NPWGNCoOYCV+-aYexbjZ9Bvx_zEqw@mail.gmail.com>
Subject: Re: [PATCH 8/9] cputlb: Initialize tlbs as flushed
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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

On Thu, Jan 9, 2020 at 12:57 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There's little point in leaving these data structures half initialized,
> and relying on a flush to be done during reset.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c7c34b185b..761e9d44d7 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -240,6 +240,7 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
>      fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>      fast->table = g_new(CPUTLBEntry, n_entries);
>      desc->iotlb = g_new(CPUIOTLBEntry, n_entries);
> +    tlb_mmu_flush_locked(desc, fast);
>  }
>
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
> @@ -260,8 +261,8 @@ void tlb_init(CPUState *cpu)
>
>      qemu_spin_init(&env_tlb(env)->c.lock);
>
> -    /* Ensure that cpu_reset performs a full flush.  */
> -    env_tlb(env)->c.dirty = ALL_MMUIDX_BITS;
> +    /* All tlbs are initialized flushed. */
> +    env_tlb(env)->c.dirty = 0;
>
>      for (i = 0; i < NB_MMU_MODES; i++) {
>          tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
> --
> 2.20.1
>
>

