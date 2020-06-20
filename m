Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE35C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9918922B39
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9uvmcCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9918922B39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmRmH-0001ni-R3
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 20:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmRlh-0001FF-Lt; Fri, 19 Jun 2020 20:54:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmRlf-0004et-W1; Fri, 19 Jun 2020 20:54:01 -0400
Received: by mail-io1-xd41.google.com with SMTP id u13so13360914iol.10;
 Fri, 19 Jun 2020 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bpHtGsnucc8pDkVJ+kTXa1rdUjAhmbWZsloyJ/trOtw=;
 b=d9uvmcCNF0ZaDgRgzNGi86kUSuHPaHaq6WkmLsPaemXeLIJ5nrrFdOfqMtzpYr+Qk8
 ewzkMJjP3DtI1yWbXClKte/MRQLKXIXWnD/g8biiM3x57Pwa8WhZnO7aOGoR0TEQss9G
 jMlbn+dcL1d+kJgo1nzhQy+i5kKP/ON09Jk7tRgyDm9YddS1VzYymLL9zxN39FTC4Mru
 Jf8kkQGA8aMQF0+9eUdYMPaPRNCvLG2eG3IC3MfdXa/IjQDIGx6jQoO2taLEO+7aiM1e
 EYgvSmQU23B4Fg022ALAsBx4g7ZQ0R1jdkEe3+KvY5SL0qUMyTudf8GKaNWNh2e1OWvB
 6HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bpHtGsnucc8pDkVJ+kTXa1rdUjAhmbWZsloyJ/trOtw=;
 b=Ebvr4bWFb3AxZm75kqQQczCubdOzTdETMyFJ1xAQxvFcZc0K14epIv7TzkS70QowMy
 RVdZNrAXf1Kw4eVDb8lnlhw4W+yz5U8gAByQMm64Gk/iXfVgiz0X3HxAgK4czVr7WI4o
 XOs0cZYjZ73q9klh62fiUvejnn1tCMyXgcCG+nNxrSMCGNoF3eCu1+miTOMfa6+W/iQS
 OZi7pVpVsuTWNaIINKb7Kj/8x/usr+okNjJtiBmvxN0UVputlphcIunfA210ZFnq+m/R
 rEnnCfCVM7IKUugycLQAUdQj8re/IyTqE7iAWet9ptIx8ngui0TlZ4oDNu5gBoV+5DMu
 aHJQ==
X-Gm-Message-State: AOAM532fM/A+SwwioaZR+Fqmt3mGiqZPVjqd98rQDgSpmzWXr5hpps04
 Mzw3yQt2s3xWFMYatEbE18bwim1oScb8A2jNA+8=
X-Google-Smtp-Source: ABdhPJzhkbr64b5qR9fomgAh0Efv/X44CsYUU/M8+dW3wXimYkZRlkyfaV70v9QIOs4RmaJPbhkRzItejD8a60omIP0=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr6507973jaj.106.1592614438483; 
 Fri, 19 Jun 2020 17:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
 <20200610113748.4754-58-zhiwei_liu@c-sky.com>
In-Reply-To: <20200610113748.4754-58-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jun 2020 17:44:30 -0700
Message-ID: <CAKmqyKN4pk=XgO-v-grTRvrQY-DEKap_Kouko6-gM-r3HynSjQ@mail.gmail.com>
Subject: Re: [PATCH v9 57/61] target/riscv: floating-point scalar move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 6:44 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Hello,

This patch fails to compile with this error:

target/riscv/insn32.decode:566: error: undefined format @r2rd

Do you mind looking into why this test fails?

Alistair


> ---
>  target/riscv/insn32.decode              |  2 +
>  target/riscv/insn_trans/trans_rvv.inc.c | 49 +++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 0741a25540..79f9b37b29 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -563,6 +563,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
>  vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
>  vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
>  vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
> +vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
> +vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index e67eff0a7f..884ad910b1 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2709,3 +2709,52 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>      }
>      return false;
>  }
> +
> +/* Floating-Point Scalar Move Instructions */
> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
> +{
> +    if (!s->vill && has_ext(s, RVF) &&
> +        (s->mstatus_fs != 0) && (s->sew != 0)) {
> +        unsigned int len = 8 << s->sew;
> +
> +        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
> +        if (len < 64) {
> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> +                            MAKE_64BIT_MASK(len, 64 - len));
> +        }
> +
> +        mark_fs_dirty(s);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +/* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
> +{
> +    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
> +        TCGv_i64 t1;
> +        /* The instructions ignore LMUL and vector register group. */
> +        uint32_t vlmax = s->vlen >> 3;
> +
> +        /* if vl == 0, skip vector register write back */
> +        TCGLabel *over = gen_new_label();
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> +
> +        /* zeroed all elements */
> +        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
> +
> +        /* NaN-box f[rs1] as necessary for SEW */
> +        t1 = tcg_temp_new_i64();
> +        if (s->sew == MO_64 && !has_ext(s, RVD)) {
> +            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
> +        } else {
> +            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
> +        }
> +        vec_element_storei(s, a->rd, 0, t1);
> +        tcg_temp_free_i64(t1);
> +        gen_set_label(over);
> +        return true;
> +    }
> +    return false;
> +}
> --
> 2.23.0
>
>

