Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFE522525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pp2q3IBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFE522525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYGK-0001bk-Kv
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itY9s-0002aX-IN
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itY9r-00078I-B3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itY9r-00077x-3E
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id d73so14713179wmd.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=g9cPzyKjJ+SyWL+bWCuIM3xq4g02fDlancVCQYQ6rmM=;
 b=pp2q3IBxahkbTZwAzYC/ulZhP3sjdDhOfDk046q5RftoxpSZYtZeN4SWzgS2Fh91xP
 HaMMOyZnUq0LYy4IIVwqEVF2OFdCOPHghQCbUqYLwLHdoo9xUKxd/I9FGWnMI/scv2Kq
 JihJWU/bRCqXg2FuoYiqe2myRgZxM8oKICK3BhPyGrYFzqhqW6y9iLkoiF41pombAQ0c
 8demwXCHP2bDQA2ki0AN8OK2cHAJSf4qCuDNy8g0vWv6CjwzSCCzA5DtuyMIJzHsXAqG
 ioPRUbyuCw1wrSCx5kmJ+mVUNk309Hy/qHRhzc/rZzLd0KjsldB8zoXW2I9jZwZvRhln
 bRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=g9cPzyKjJ+SyWL+bWCuIM3xq4g02fDlancVCQYQ6rmM=;
 b=glNcufYkBfVPOK7XjFlbBN8Ai3SgyYTlqxFp1x7Lkm8PHPgRxIQ+5x9rGn5/tF5Q3K
 qzgmfl6xjfi1ciLCc80jQS6IiYjX9zcaMugQtydeVXJNqTXm4TrFToCoBae/x1/GlSEv
 bqG9Gw6ovIp8cCRUJ4J27HZV0jluyFXgN+IS7QLbqb9omVcxOytKDcE9eqTsz85a0acX
 kaaLIYZFN/VhqGBaNGy3za+pKqyD2V3rYx9D/w1o9BdkJr1KAon+8DUwRzCOtX8ihkd8
 93c58sYCKP16JtzmawtR0eqmO0ubH+R+N3/RLCvMkx8krTj1a6QzUi5hCwZtPJaWP2hX
 k9fg==
X-Gm-Message-State: APjAAAWeRK3OE83X+ueY+HByFLDXCwkqBEs9Mxwf4ihRJRvqOBfGqIIs
 04z0TCdvaTL4eN0+BKo+uGHnbw==
X-Google-Smtp-Source: APXvYqzy9/Zcu995Jt/ZqkFTaSltiDg8eLNyNfnTj7ayW3u727w7EJS79GPMHeSJeLgXpJo8FeTFAg==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr20008294wml.83.1579530962070; 
 Mon, 20 Jan 2020 06:36:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c17sm47712498wrr.87.2020.01.20.06.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:36:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 42F141FF87;
 Mon, 20 Jan 2020 14:36:00 +0000 (GMT)
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 9/9] cputlb: Hoist timestamp outside of loops over tlbs
In-reply-to: <20200109024907.2730-10-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 14:36:00 +0000
Message-ID: <87wo9m19gv.fsf@linaro.org>
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

> Do not call get_clock_realtime() in tlb_mmu_resize_locked,
> but hoist outside of any loop over a set of tlbs.  This is
> only two (indirect) callers, tlb_flush_by_mmuidx_async_work
> and tlb_flush_page_locked, so not onerous.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cputlb.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 761e9d44d7..9f6cb36921 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -137,12 +137,12 @@ static void tlb_window_reset(CPUTLBDesc *desc, int6=
4_t ns,
>   * high), since otherwise we are likely to have a significant amount of
>   * conflict misses.
>   */
> -static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
> +static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
> +                                  int64_t now)
>  {
>      size_t old_size =3D tlb_n_entries(fast);
>      size_t rate;
>      size_t new_size =3D old_size;
> -    int64_t now =3D get_clock_realtime();
>      int64_t window_len_ms =3D 100;
>      int64_t window_len_ns =3D window_len_ms * 1000 * 1000;
>      bool window_expired =3D now > desc->window_begin_ns + window_len_ns;
> @@ -222,12 +222,13 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, =
CPUTLBDescFast *fast)
>      memset(desc->vtable, -1, sizeof(desc->vtable));
>  }
>=20=20
> -static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
> +static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx,
> +                                        int64_t now)
>  {
>      CPUTLBDesc *desc =3D &env_tlb(env)->d[mmu_idx];
>      CPUTLBDescFast *fast =3D &env_tlb(env)->f[mmu_idx];
>=20=20
> -    tlb_mmu_resize_locked(desc, fast);
> +    tlb_mmu_resize_locked(desc, fast, now);
>      tlb_mmu_flush_locked(desc, fast);
>  }
>=20=20
> @@ -310,6 +311,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>      CPUArchState *env =3D cpu->env_ptr;
>      uint16_t asked =3D data.host_int;
>      uint16_t all_dirty, work, to_clean;
> +    int64_t now =3D get_clock_realtime();
>=20=20
>      assert_cpu_is_self(cpu);
>=20=20
> @@ -324,7 +326,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>=20=20
>      for (work =3D to_clean; work !=3D 0; work &=3D work - 1) {
>          int mmu_idx =3D ctz32(work);
> -        tlb_flush_one_mmuidx_locked(env, mmu_idx);
> +        tlb_flush_one_mmuidx_locked(env, mmu_idx, now);
>      }
>=20=20
>      qemu_spin_unlock(&env_tlb(env)->c.lock);
> @@ -446,7 +448,7 @@ static void tlb_flush_page_locked(CPUArchState *env, =
int midx,
>          tlb_debug("forcing full flush midx %d ("
>                    TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
>                    midx, lp_addr, lp_mask);
> -        tlb_flush_one_mmuidx_locked(env, midx);
> +        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
>      } else {
>          if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
>              tlb_n_used_entries_dec(env, midx);


--=20
Alex Benn=C3=A9e

