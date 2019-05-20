Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ACEC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B100A20856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPv9J7lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B100A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShvF-0004yn-UB
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:01:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hShtO-0003ir-9h
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hShtL-0003kH-KY
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:59:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hShtL-0003k6-Cd
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:59:47 -0400
Received: by mail-ot1-x342.google.com with SMTP id j49so12796111otc.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=QmqnpPEQ27267a/j8Fgmsg0FbWWNt+dEUfvrII2Xw5c=;
	b=vPv9J7lHbsDD1aNerBCUk5BoKwQr01URIBBP0pBvfLaPshjSxSmxgE+wzLJNrJP3gy
	dgY933WdB5WMqAIPITvKBoABXn9nqsQhUX5CSHukkJ9g0MF+yY7BUjLbRlHpY93K7icw
	VcqVEKVZDpJu386PLa1cRSxRTxUBwx4DK/gC0kj57LeUDPU/dAkrUSbhRrt/ehjuTOjD
	3L2EzNKxZ/raVT5+BaQyqPI802ots1/YjP3RhaUA+rbGl5pQylo/sGlpPRLqbsAOpgfD
	bbbMZL+VWfAfstMBMQkMYV/KO8IwGCRuzoGCt7gU6hzHs6G4CuXqlwQLeNgO4ogMYNnM
	qZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=QmqnpPEQ27267a/j8Fgmsg0FbWWNt+dEUfvrII2Xw5c=;
	b=SpgB+Nhf3mGE4P4pUTQERh23cYyEVsIhLvBpNKIes8LS7iacfIlHR7xEP7MNdLFVmb
	rMih7BVJTWEQ2DM0OUrJxdJ1btKXbyXq8FHf8IhngFW+0eMuJpUT6wELxqwOn4lEeUv5
	Qm4KtJBTZLyqsISjxqp4d/VbJ/nf1HZ46vzMIfAzcJ4N4wNKxidJDIJA10IXO3TWd/tw
	cQFSh7LnY2Gz+rVZtV//GPLlugDF2ApCXMEfUyEgyu/Wc/5YQ/0EJekHj02gBmENQfgi
	EYft9xXie4xuFkE55wvBcmFN29vboDEBCbSbwbVwLHIVVsFNXKdsGsJ6O1qstUg/8XvK
	RJ1Q==
X-Gm-Message-State: APjAAAX2GvyBBPm0kiY3jMYtrpY0SmrcdnKkQu+578g1QiQXucWd0D4E
	GO1bUj2eCYBRMsQbwAZNhd5xh8KOK3lL5X52BfY=
X-Google-Smtp-Source: APXvYqwDoy45Odw/IXbObw/crv1GCzWysbi8j6YHMFzt+aFCnAqVKRiUud1rCHiHZlLY0az3k9BRaVAPJo+DAmOMkxg=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr72785otm.64.1558357186512;
	Mon, 20 May 2019 05:59:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 05:59:45
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 05:59:45
	-0700 (PDT)
In-Reply-To: <1554212605-16457-3-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 14:59:45 +0200
Message-ID: <CAL1e-=j6+P=WVAyUfbEqh1iXLiN6cAjgv0YPZj+RSFaWgEVFog@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/mips: Fix MSA instructions
 ST.<B|H|W|D> on big endian host
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 2, 2019 3:47 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.com>
wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Fix the case when the host is a big endian machine, and change
> the approach toward ST.<B|H|W|D> instruction helpers.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Hello, Mateja.

There is unfortunatelly still a slight problem with the new implementation:
it looks like the invocations to ensure_writable_pages() in new helpers are
missing. Or, perhaps, there is a reason you removed them. Please reanalyse
and reexplain. But thanks for previous efforts.

Yours,
Aleksandar

>  target/mips/op_helper.c | 188
++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 168 insertions(+), 20 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 45be406..d94909a 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -4565,31 +4565,179 @@ static inline void
ensure_writable_pages(CPUMIPSState *env,
>  #endif
>  }
>
> -#define MSA_ST_DF(DF, TYPE, ST_INSN, ...)                               \
> -void helper_msa_st_ ## TYPE(CPUMIPSState *env, uint32_t wd,             \
> -                            target_ulong addr)                          \
> -{                                                                       \
> -    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
> -    int mmu_idx = cpu_mmu_index(env, false);                           \
> -    int i;                                                              \
> -    MEMOP_IDX(DF)                                                       \
> -    ensure_writable_pages(env, addr, mmu_idx, GETPC());                 \
> -    for (i = 0; i < DF_ELEMENTS(DF); i++) {                             \
> -        ST_INSN(env, addr + (i << DF), pwd->TYPE[i], ##__VA_ARGS__);    \
> -    }                                                                   \
> +void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
> +                     target_ulong addr)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    MEMOP_IDX(DF_BYTE)
> +#if !defined(CONFIG_USER_ONLY)
> +#if !defined(HOST_WORDS_BIGENDIAN)
> +    helper_ret_stb_mmu(env, addr + (0  << DF_BYTE), pwd->b[0],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (1  << DF_BYTE), pwd->b[1],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (2  << DF_BYTE), pwd->b[2],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (3  << DF_BYTE), pwd->b[3],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (4  << DF_BYTE), pwd->b[4],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (5  << DF_BYTE), pwd->b[5],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (6  << DF_BYTE), pwd->b[6],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (7  << DF_BYTE), pwd->b[7],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (8  << DF_BYTE), pwd->b[8],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (9  << DF_BYTE), pwd->b[9],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (10 << DF_BYTE), pwd->b[10], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (11 << DF_BYTE), pwd->b[11], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (12 << DF_BYTE), pwd->b[12], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (13 << DF_BYTE), pwd->b[13], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (14 << DF_BYTE), pwd->b[14], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (15 << DF_BYTE), pwd->b[15], oi,
GETPC());
> +#else
> +    helper_ret_stb_mmu(env, addr + (7  << DF_BYTE), pwd->b[0],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (6  << DF_BYTE), pwd->b[1],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (5  << DF_BYTE), pwd->b[2],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (4  << DF_BYTE), pwd->b[3],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (3  << DF_BYTE), pwd->b[4],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (2  << DF_BYTE), pwd->b[5],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (1  << DF_BYTE), pwd->b[6],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (0  << DF_BYTE), pwd->b[7],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (15 << DF_BYTE), pwd->b[8],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (14 << DF_BYTE), pwd->b[9],  oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (13 << DF_BYTE), pwd->b[10], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (12 << DF_BYTE), pwd->b[11], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (11 << DF_BYTE), pwd->b[12], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (10 << DF_BYTE), pwd->b[13], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (9  << DF_BYTE), pwd->b[14], oi,
GETPC());
> +    helper_ret_stb_mmu(env, addr + (8  << DF_BYTE), pwd->b[15], oi,
GETPC());
> +#endif
> +#else
> +#if !defined(HOST_WORDS_BIGENDIAN)
> +    cpu_stb_data(env, addr + (0  << DF_BYTE), pwd->b[0]);
> +    cpu_stb_data(env, addr + (1  << DF_BYTE), pwd->b[1]);
> +    cpu_stb_data(env, addr + (2  << DF_BYTE), pwd->b[2]);
> +    cpu_stb_data(env, addr + (3  << DF_BYTE), pwd->b[3]);
> +    cpu_stb_data(env, addr + (4  << DF_BYTE), pwd->b[4]);
> +    cpu_stb_data(env, addr + (5  << DF_BYTE), pwd->b[5]);
> +    cpu_stb_data(env, addr + (6  << DF_BYTE), pwd->b[6]);
> +    cpu_stb_data(env, addr + (7  << DF_BYTE), pwd->b[7]);
> +    cpu_stb_data(env, addr + (8  << DF_BYTE), pwd->b[8]);
> +    cpu_stb_data(env, addr + (9  << DF_BYTE), pwd->b[9]);
> +    cpu_stb_data(env, addr + (10 << DF_BYTE), pwd->b[10]);
> +    cpu_stb_data(env, addr + (11 << DF_BYTE), pwd->b[11]);
> +    cpu_stb_data(env, addr + (12 << DF_BYTE), pwd->b[12]);
> +    cpu_stb_data(env, addr + (13 << DF_BYTE), pwd->b[13]);
> +    cpu_stb_data(env, addr + (14 << DF_BYTE), pwd->b[14]);
> +    cpu_stb_data(env, addr + (15 << DF_BYTE), pwd->b[15]);
> +#else
> +    cpu_stb_data(env, addr + (7  << DF_BYTE), pwd->b[0]);
> +    cpu_stb_data(env, addr + (6  << DF_BYTE), pwd->b[1]);
> +    cpu_stb_data(env, addr + (5  << DF_BYTE), pwd->b[2]);
> +    cpu_stb_data(env, addr + (4  << DF_BYTE), pwd->b[3]);
> +    cpu_stb_data(env, addr + (3  << DF_BYTE), pwd->b[4]);
> +    cpu_stb_data(env, addr + (2  << DF_BYTE), pwd->b[5]);
> +    cpu_stb_data(env, addr + (1  << DF_BYTE), pwd->b[6]);
> +    cpu_stb_data(env, addr + (0  << DF_BYTE), pwd->b[7]);
> +    cpu_stb_data(env, addr + (15 << DF_BYTE), pwd->b[8]);
> +    cpu_stb_data(env, addr + (14 << DF_BYTE), pwd->b[9]);
> +    cpu_stb_data(env, addr + (13 << DF_BYTE), pwd->b[10]);
> +    cpu_stb_data(env, addr + (12 << DF_BYTE), pwd->b[11]);
> +    cpu_stb_data(env, addr + (11 << DF_BYTE), pwd->b[12]);
> +    cpu_stb_data(env, addr + (10 << DF_BYTE), pwd->b[13]);
> +    cpu_stb_data(env, addr + (9  << DF_BYTE), pwd->b[14]);
> +    cpu_stb_data(env, addr + (8  << DF_BYTE), pwd->b[15]);
> +#endif
> +#endif
> +}
> +
> +void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
> +                     target_ulong addr)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    MEMOP_IDX(DF_HALF)
> +#if !defined(CONFIG_USER_ONLY)
> +#if !defined(HOST_WORDS_BIGENDIAN)
> +    helper_ret_stw_mmu(env, addr + (0 << DF_HALF), pwd->h[0], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (1 << DF_HALF), pwd->h[1], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (2 << DF_HALF), pwd->h[2], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (3 << DF_HALF), pwd->h[3], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (4 << DF_HALF), pwd->h[4], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (5 << DF_HALF), pwd->h[5], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (6 << DF_HALF), pwd->h[6], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (7 << DF_HALF), pwd->h[7], oi,
GETPC());
> +#else
> +    helper_ret_stw_mmu(env, addr + (3 << DF_HALF), pwd->h[0], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (2 << DF_HALF), pwd->h[1], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (1 << DF_HALF), pwd->h[2], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (0 << DF_HALF), pwd->h[3], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (7 << DF_HALF), pwd->h[4], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (6 << DF_HALF), pwd->h[5], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (5 << DF_HALF), pwd->h[6], oi,
GETPC());
> +    helper_ret_stw_mmu(env, addr + (4 << DF_HALF), pwd->h[7], oi,
GETPC());
> +#endif
> +#else
> +#if !defined(HOST_WORDS_BIGENDIAN)
> +    cpu_stw_data(env, addr + (0 << DF_HALF), pwd->h[0]);
> +    cpu_stw_data(env, addr + (1 << DF_HALF), pwd->h[1]);
> +    cpu_stw_data(env, addr + (2 << DF_HALF), pwd->h[2]);
> +    cpu_stw_data(env, addr + (3 << DF_HALF), pwd->h[3]);
> +    cpu_stw_data(env, addr + (4 << DF_HALF), pwd->h[4]);
> +    cpu_stw_data(env, addr + (5 << DF_HALF), pwd->h[5]);
> +    cpu_stw_data(env, addr + (6 << DF_HALF), pwd->h[6]);
> +    cpu_stw_data(env, addr + (7 << DF_HALF), pwd->h[7]);
> +#else
> +    cpu_stw_data(env, addr + (3 << DF_HALF), pwd->h[0]);
> +    cpu_stw_data(env, addr + (2 << DF_HALF), pwd->h[1]);
> +    cpu_stw_data(env, addr + (1 << DF_HALF), pwd->h[2]);
> +    cpu_stw_data(env, addr + (0 << DF_HALF), pwd->h[3]);
> +    cpu_stw_data(env, addr + (7 << DF_HALF), pwd->h[4]);
> +    cpu_stw_data(env, addr + (6 << DF_HALF), pwd->h[5]);
> +    cpu_stw_data(env, addr + (5 << DF_HALF), pwd->h[6]);
> +    cpu_stw_data(env, addr + (4 << DF_HALF), pwd->h[7]);
> +#endif
> +#endif
>  }
>
> +void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
> +                     target_ulong addr)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    MEMOP_IDX(DF_WORD)
>  #if !defined(CONFIG_USER_ONLY)
> -MSA_ST_DF(DF_BYTE,   b, helper_ret_stb_mmu, oi, GETPC())
> -MSA_ST_DF(DF_HALF,   h, helper_ret_stw_mmu, oi, GETPC())
> -MSA_ST_DF(DF_WORD,   w, helper_ret_stl_mmu, oi, GETPC())
> -MSA_ST_DF(DF_DOUBLE, d, helper_ret_stq_mmu, oi, GETPC())
> +#if !defined(HOST_WORDS_BIGENDIAN)
> +    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(),
pwd->w[0]);
> +    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(),
pwd->w[1]);
> +    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(),
pwd->w[2]);
> +    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(),
pwd->w[3]);
>  #else
> -MSA_ST_DF(DF_BYTE,   b, cpu_stb_data)
> -MSA_ST_DF(DF_HALF,   h, cpu_stw_data)
> -MSA_ST_DF(DF_WORD,   w, cpu_stl_data)
> -MSA_ST_DF(DF_DOUBLE, d, cpu_stq_data)
> +    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(),
pwd->w[0]);
> +    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(),
pwd->w[1]);
> +    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(),
pwd->w[2]);
> +    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(),
pwd->w[3]);
>  #endif
> +#else
> +#if !defined(HOST_WORDS_BIGENDIAN)
> +    cpu_stl_data(env, addr + (0 << DF_WORD), pwd->w[0]);
> +    cpu_stl_data(env, addr + (1 << DF_WORD), pwd->w[1]);
> +    cpu_stl_data(env, addr + (2 << DF_WORD), pwd->w[2]);
> +    cpu_stl_data(env, addr + (3 << DF_WORD), pwd->w[3]);
> +#else
> +    cpu_stl_data(env, addr + (1 << DF_WORD), pwd->w[0]);
> +    cpu_stl_data(env, addr + (0 << DF_WORD), pwd->w[1]);
> +    cpu_stl_data(env, addr + (3 << DF_WORD), pwd->w[2]);
> +    cpu_stl_data(env, addr + (2 << DF_WORD), pwd->w[3]);
> +#endif
> +#endif
> +}
> +
> +void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
> +                     target_ulong addr)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    MEMOP_IDX(DF_DOUBLE)
> +#if !defined(CONFIG_USER_ONLY)
> +    helper_ret_stq_mmu(env, addr + (0 << DF_DOUBLE), pwd->d[0], oi,
GETPC());
> +    helper_ret_stq_mmu(env, addr + (1 << DF_DOUBLE), pwd->d[1], oi,
GETPC());
> +#else
> +    cpu_stq_data(env, addr + (0 << DF_DOUBLE), pwd->d[0]);
> +    cpu_stq_data(env, addr + (1 << DF_DOUBLE), pwd->d[1]);
> +#endif
> +}
>
>  void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
>  {
> --
> 2.7.4
>
>
