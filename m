Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F173C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B6620739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJyg+KdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B6620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js9GC-0005Kh-1O
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 14:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js9Fa-0004rN-Br
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:20:26 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:45736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js9FY-0004KL-94
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:20:25 -0400
Received: by mail-ot1-x333.google.com with SMTP id h1so7922892otq.12
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fev7Vi7RbfMP/3CjoSfv3+EGxAPyUimnEomSshhQnHY=;
 b=jJyg+KdNsC0Mvb5pqpvaXUpnLW39YGdqEna5a/7pRea724L3qZB+ZJi6rE01vG5POU
 SE7MBSOr9/lA1CE4TNE8/zVfkCh0hN18RTjHweGpdpvQq2El9CGlcD21ZohsQXTcJNP+
 Y9dt32Ar7aa8Df206KQ1yu1SP4nuQlqXwpk4JgYqGy5IMmVWgOpgdVbXPiVz7HP31hRU
 jajSIiLFViSqNorTJYl9pZAMb1AwWfmgjtHVEdxBkuwX4UW7eB2uh3eyZHgEg3pkHwQq
 upqQxWNdEZe9Q6g2t8tkL4puM+UO1wcSqcJIHinx2t/NIFjqiOjRIjMByxHWGpn2ofSi
 gf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fev7Vi7RbfMP/3CjoSfv3+EGxAPyUimnEomSshhQnHY=;
 b=jfLVjP7MBHZ2RVI8J6xxJ8akA2pzaY2DJf8LU3+P5K5r57CGgyeV95QDRNAaG/1oia
 Edg4pxmfWMyY6L+xvbckIEtVOJAHECWRF/lCoE7tSA4i9Xr6gp3znD4Ot3eu2HzXs0ar
 Ez34P9/sOKyWa14lJzu3yjEI4nXOIoBq+U/1prJTwDh8KUBU95b0YWAhbKxzekxORCbK
 90cqxSl2TmfPn4yJZjEDLra3k7T1UGK7Zxru/4o1oUFZVvOr+tn4lqL8hP1Hg6k3CGKP
 PiGo2hvY5zyU8eOvQObJJbpPgzauque+K2RiKUEy3pl6n83AohTW7LvlqXdEHXOwEuLp
 REHQ==
X-Gm-Message-State: AOAM53167S3N4KFMwpqlfSZcuGFgmJnKrH+KCDDnbZ8PNddmHdAgGBld
 ZE8qv8S3VUeCJGltp15oWWRsMV9ppC4gExlNl9/9sQ==
X-Google-Smtp-Source: ABdhPJwnXy+SMAtoPNCZnGdZR/VB8O6RLl7KnFNHd/JTvcyDX7p5pqjvtWyCY+OGRMgrvdLbiUhppuh6geKBdKSSRyg=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr36037919ota.91.1593973222743; 
 Sun, 05 Jul 2020 11:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200702162354.928528-1-alistair.francis@wdc.com>
 <20200702162354.928528-13-alistair.francis@wdc.com>
In-Reply-To: <20200702162354.928528-13-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 Jul 2020 19:20:11 +0100
Message-ID: <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
Subject: Re: [PULL v2 12/64] target/riscv: add vector amo operations
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 17:33, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Vector AMOs operate as if aq and rl bits were zero on each element
> with regard to ordering relative to other instructions in the same hart.
> Vector AMOs provide no ordering guarantee between element operations
> in the same vector AMO instruction

Hi; Coverity thinks (probably wrongly) that there might be an array
overflow here:

> +static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
> +{
> +    uint32_t data = 0;
> +    gen_helper_amo *fn;
> +    static gen_helper_amo *const fnsw[9] = {

This is a 9-element array...

> +        /* no atomic operation */
> +        gen_helper_vamoswapw_v_w,
> +        gen_helper_vamoaddw_v_w,
> +        gen_helper_vamoxorw_v_w,
> +        gen_helper_vamoandw_v_w,
> +        gen_helper_vamoorw_v_w,
> +        gen_helper_vamominw_v_w,
> +        gen_helper_vamomaxw_v_w,
> +        gen_helper_vamominuw_v_w,
> +        gen_helper_vamomaxuw_v_w
> +    };

> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +        gen_helper_exit_atomic(cpu_env);
> +        s->base.is_jmp = DISAS_NORETURN;
> +        return true;
> +    } else {
> +        if (s->sew == 3) {
> +#ifdef TARGET_RISCV64
> +            fn = fnsd[seq];
> +#else
> +            /* Check done in amo_check(). */
> +            g_assert_not_reached();
> +#endif
> +        } else {
> +            fn = fnsw[seq];

...which we here index via 'seq'...


> +#ifdef TARGET_RISCV64
> +GEN_VEXT_TRANS(vamoswapd_v, 9, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamoaddd_v, 10, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamoxord_v, 11, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamoandd_v, 12, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamoord_v, 13, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamomind_v, 14, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
> +GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
> +#endif

...which in the calls that these macros expand out to can
be 9 or greater.

If it's in fact impossible to get into that code path
with a value of seq that's larger than the array, it
would help Coverity if we asserted so, maybe
   assert(seq < ARRAY_SIZE(fnsw));

This is CID 1430177, 1430178, 1430179, 1430180, 1430181,
1430182, 1430183, 1430184, 1430185, 14305186.

thanks
-- PMM

