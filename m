Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C825CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4C222314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcQx1Me+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4C222314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYEk-0007jE-KS
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itY7J-0007cc-8W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itY7H-0005f2-RM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:33:24 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itY7H-0005eE-Jp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:33:23 -0500
Received: by mail-wm1-x341.google.com with SMTP id m24so14710231wmc.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/3NkyKVdAdpx2I5Y+3Wjoiq3Wwlmf8JiHrQyzTpXLSU=;
 b=QcQx1Me+vZf9bJrdqTWJwmm/tNY+ZtXFBxmgTzvV9KO5LWmBhaCoBEYdNe8YbE85HO
 8K05d96DzLx4t6TsDhM7+VY2nFR56MKhUBfpHD3ueLE7Aza9YCJrop8CSh8QsWykzML1
 zpmIqs7IpyV21G9WJ9jDVZAZse1o4zWFgwSFcd2IOrVECbjry227QNJMFcGL6tvEODB4
 P2gdahZTvO5VRzrF9mAeVlLifeDwCJbTf5MogCADt9O50EzQj3DWAlTJCo2eVt2Fwcwi
 hNMnJKftuao57YptEFq9JZOgo+4zozZyoeHwoOcOzrJqBFx8Kdptc8Q6S9rh6+XOsqXt
 BGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/3NkyKVdAdpx2I5Y+3Wjoiq3Wwlmf8JiHrQyzTpXLSU=;
 b=DpBmN5LgNj+OEb2XK0FHL0jG6G1VC9QICUOcHN2atrVbWNE69lQH1Jcif7DxGP2MWW
 PtD8kgqNGXQK7GHs5QijLMadg4AJtsRoXCvuz5Y42Z8R4L0kzpRcEeEZ8pGyZW1+KSNS
 kGN+0XtEjknOhNycFfFLERFeBCbCqrxwlYuLnArMWd6hPWEkFJPbKBmb4egLssp8vN3+
 9y/UGYm7h7ZFC5KG/Wb80MucQVaakJkQ2J6UvrS7uYE5kxSXzL0pAKny4xX5A76OjxaA
 niQZQeXQ/niw7+ZYlzYxN7cn+kHwRV8JX4lh/yla1sJHh1GspzFy9nUFviCjjJQVj8ne
 cseQ==
X-Gm-Message-State: APjAAAXK6O9/FqV7h9yyoRMXb+SvVJipQ7MYf433ly5z4zVsMuCyYSJ5
 VcToGQ9MemqucrQaWR/vhh6qg0jV3y0=
X-Google-Smtp-Source: APXvYqx23RpCqCf0S14iXYoRetcDOLvJVq/w1AkBEDUXIeJe80nhZWZDeVw+Qz85tZN5AXapV/AEKg==
X-Received: by 2002:a1c:3dd5:: with SMTP id k204mr19127164wma.92.1579530802243; 
 Mon, 20 Jan 2020 06:33:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n14sm22905574wmi.26.2020.01.20.06.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:33:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 64D8A1FF87;
 Mon, 20 Jan 2020 14:33:20 +0000 (GMT)
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 7/9] cputlb: Partially merge tlb_dyn_init into tlb_init
In-reply-to: <20200109024907.2730-8-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 14:33:20 +0000
Message-ID: <8736ca2o5r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Merge into the only caller, but at the same time split
> out tlb_mmu_init to initialize a single tlb entry.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cputlb.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e60e501334..c7c34b185b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -97,22 +97,6 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t=
 ns,
>      desc->window_max_entries =3D max_entries;
>  }
>=20=20
> -static void tlb_dyn_init(CPUArchState *env)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < NB_MMU_MODES; i++) {
> -        CPUTLBDesc *desc =3D &env_tlb(env)->d[i];
> -        size_t n_entries =3D 1 << CPU_TLB_DYN_DEFAULT_BITS;
> -
> -        tlb_window_reset(desc, get_clock_realtime(), 0);
> -        desc->n_used_entries =3D 0;
> -        env_tlb(env)->f[i].mask =3D (n_entries - 1) << CPU_TLB_ENTRY_BIT=
S;
> -        env_tlb(env)->f[i].table =3D g_new(CPUTLBEntry, n_entries);
> -        env_tlb(env)->d[i].iotlb =3D g_new(CPUIOTLBEntry, n_entries);
> -    }
> -}
> -
>  /**
>   * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if n=
ecessary
>   * @desc: The CPUTLBDesc portion of the TLB
> @@ -247,6 +231,17 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState=
 *env, int mmu_idx)
>      tlb_mmu_flush_locked(desc, fast);
>  }
>=20=20
> +static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t=
 now)
> +{
> +    size_t n_entries =3D 1 << CPU_TLB_DYN_DEFAULT_BITS;
> +
> +    tlb_window_reset(desc, now, 0);
> +    desc->n_used_entries =3D 0;
> +    fast->mask =3D (n_entries - 1) << CPU_TLB_ENTRY_BITS;
> +    fast->table =3D g_new(CPUTLBEntry, n_entries);
> +    desc->iotlb =3D g_new(CPUIOTLBEntry, n_entries);
> +}
> +
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t m=
mu_idx)
>  {
>      env_tlb(env)->d[mmu_idx].n_used_entries++;
> @@ -260,13 +255,17 @@ static inline void tlb_n_used_entries_dec(CPUArchSt=
ate *env, uintptr_t mmu_idx)
>  void tlb_init(CPUState *cpu)
>  {
>      CPUArchState *env =3D cpu->env_ptr;
> +    int64_t now =3D get_clock_realtime();
> +    int i;
>=20=20
>      qemu_spin_init(&env_tlb(env)->c.lock);
>=20=20
>      /* Ensure that cpu_reset performs a full flush.  */
>      env_tlb(env)->c.dirty =3D ALL_MMUIDX_BITS;
>=20=20
> -    tlb_dyn_init(env);
> +    for (i =3D 0; i < NB_MMU_MODES; i++) {
> +        tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
> +    }
>  }
>=20=20
>  /* flush_all_helper: run fn across all cpus


--=20
Alex Benn=C3=A9e

