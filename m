Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E37C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47E620B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYiQ9GHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47E620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYy3-0001Ke-Td
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYx7-0000g4-6W
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYx5-0005Zq-TA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:55:13 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYx5-0005Xz-Ov; Fri, 17 Apr 2020 17:55:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id i3so3984336ioo.13;
 Fri, 17 Apr 2020 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mrDaV4mGqUQph+k8yeoTK7cMhAGVxKGCLsk+WnYVjtw=;
 b=eYiQ9GHrGohNhONd0sX8mtkTpc/t2hbGNfnjKUYnjncR8aMLzV57+ZDNroWzPivmNs
 dHt1GILsMxL7BjdN46Da7pBor42KS57ilvw9WXUhyWG3XNj7YE26vvRhl0OtJUx7tnV+
 6Pey8eamHf0QKlZLuFCPIjvLw8oG3Nkzt287Nl+clTZA8146i8PgBrJCjbDCkfL/8nmZ
 kFPyfFwqpCz9Yk67Hwu9wJh6eLYh0A32k2V5DAmd8tTdLs+q922D3qBHkzm5iZ7bjmVM
 CW5tKfIYVkshhgR5sAflqNah4nTedf4Px3xDb89Y0sdkAmVZDMGQTCO0eHMSo8xjhSR8
 7bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mrDaV4mGqUQph+k8yeoTK7cMhAGVxKGCLsk+WnYVjtw=;
 b=bolPAKpTo3Z1GEnecvHRKGTvxuLpuwFU+x6dxmZHqZPh5kFNGXRHUNHaupFhkJHpaD
 lxiozYXvH2y26z998hIFAPzYsTsxcBuRUIPrL9wuBq7pG/1FT8qz6P7HKsAAlm3uYSwd
 SpUG/8kDxtnWWpEsXti4YguTcOeYDYbDOqPECSvLGPn+IYHS5n+abhAT2wyIxR8GXaqZ
 c2Ynm9KMqZag7I8pmym3GdXkXzxnPrka29RNycB8pDtGE6ZVfJWCK43M/A2n43TblhqQ
 ltX5UwL5OHdZER6KjdRrZO/Pvz0xUQrZwmDI4NNP3rLkjMIH6AwUX8bV52JXhbAWD8dT
 yDNg==
X-Gm-Message-State: AGi0PuZj0Om/pzTniGk42u8CT1jj6gCp9hWAp2jjeke/Di8ylRNf2k50
 /neJesR1XmFF7IVHMzVLKEeL8qBB5hNB3nmpv3o=
X-Google-Smtp-Source: APiQypJSdbI7ZjejPcPgxwFxNxUijhKdNAPktDdqYddptosi3bNEtcnkDB9jzDtljed7RxWIVwAZsNNSyDQgkHhCJeM=
X-Received: by 2002:a02:6414:: with SMTP id t20mr5570014jac.8.1587160510977;
 Fri, 17 Apr 2020 14:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-34-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-34-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:46:47 -0700
Message-ID: <CAKmqyKNzYSNJ4VdabAE5q65Y+=B7czohK4ey3C0qoeCa88zMYg@mail.gmail.com>
Subject: Re: [PATCH v7 33/61] target/riscv: vector widening floating-point
 multiply
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 9:43 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  5 +++++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
>  target/riscv/vector_helper.c            | 22 ++++++++++++++++++++++
>  4 files changed, 33 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index fa1558179a..5b3340a4af 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -846,3 +846,8 @@ DEF_HELPER_6(vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 16fd938261..1d963f0b8a 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -461,6 +461,8 @@ vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
>  vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
>  vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
>  vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 77c5222c4d..5395063b1b 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2075,3 +2075,7 @@ GEN_OPFVV_TRANS(vfdiv_vv, opfvv_check)
>  GEN_OPFVF_TRANS(vfmul_vf,  opfvf_check)
>  GEN_OPFVF_TRANS(vfdiv_vf,  opfvf_check)
>  GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
> +
> +/* Vector Widening Floating-Point Multiply */
> +GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a9fdf47c2a..bbe3719e69 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3409,3 +3409,25 @@ RVVCALL(OPFVF2, vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
>  GEN_VEXT_VF(vfrdiv_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfrdiv_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfrdiv_vf_d, 8, 8, clearq)
> +
> +/* Vector Widening Floating-Point Multiply */
> +static uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return float32_mul(float16_to_float32(a, true, s),
> +            float16_to_float32(b, true, s), s);
> +}
> +
> +static uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return float64_mul(float32_to_float64(a, s),
> +            float32_to_float64(b, s), s);
> +
> +}
> +RVVCALL(OPFVV2, vfwmul_vv_h, WOP_UUU_H, H4, H2, H2, vfwmul16)
> +RVVCALL(OPFVV2, vfwmul_vv_w, WOP_UUU_W, H8, H4, H4, vfwmul32)
> +GEN_VEXT_VV_ENV(vfwmul_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwmul_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
> +RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
> +GEN_VEXT_VF(vfwmul_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwmul_vf_w, 4, 8, clearq)
> --
> 2.23.0
>

