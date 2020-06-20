Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46914C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 01:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7F7223AC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 01:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+fQCDqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7F7223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmS7L-0000Gj-74
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 21:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmS6b-0008Ap-LR; Fri, 19 Jun 2020 21:15:37 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmS6Z-00085t-PH; Fri, 19 Jun 2020 21:15:37 -0400
Received: by mail-io1-xd44.google.com with SMTP id f23so8103689iof.6;
 Fri, 19 Jun 2020 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8wtiGK2psx3pxl4l7Dq5bNG8XwtFfhBEu1XfSi3uF6w=;
 b=F+fQCDqvaFU9Rx9lkYUtb8V6QxyiNo6R23g6ehHIr5JzJD+PNlcIlMBWal3qMKkh5l
 ZhvUt7UPqYR7e4ZkIVwZ8/LJZAcXvPOKM4b4CU8jMFGyLTLOU5TMwJ0l0m/0MVGyT1n/
 iTmOop9xsIWk8/JIyIpKYY0NoumBXGIEjWmTTAGIAdx+l160ltJFAmBBatnwjMk9TrQO
 2yJ2Fzt24SM3lHkOCgo6s5Mf4K28lWUJOejhlasTJKMMCeR85e21Qrt3Adhwqv338aS+
 V4Ba5HTv9t6v9eWKW4hHdxY15iUgn3BvkDIHIx1c4lO8YkVcJi9iZOqGYakibqoji8dp
 J4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8wtiGK2psx3pxl4l7Dq5bNG8XwtFfhBEu1XfSi3uF6w=;
 b=SZzD/XbhbkBI+KHB5dkvSSLTKdHG6+TJQ+M2z9W9MQU/lj9BP3TgaKqYPfudnUQ4jo
 AxycbFpSDtUvbUz7vuMku9ZcwXnMh8Q4stPUI0RdxrguyD8ADzrjnJdN1KRlIJNp1mDW
 iYMRoHEswuKNeo+ytt3RwBF65Y7KWif2mgbd2KFgbDnKpQg4q+KiTNu42c4tou1B+YgX
 124UmcvEIh/DbNukkBft8m6jLs3viaWqvT8+mGR6d9vMQI+gUOAm3VYqe+fRNKte9eX6
 RPxqSTnj8OqF/SMlYpTZqHb06MtVfoKT0a2wlF8VZrR8FhoXLtIU03RDienLGXsPhThi
 b3rg==
X-Gm-Message-State: AOAM533shHb6ycCEWgti5S5pwME1ubWCmDJ+LHyL/St/By8AWDb63/My
 OuiUHs0cudYD5wnAAI9g2K7u8X5XYClfrueUo3o=
X-Google-Smtp-Source: ABdhPJxHvnZBB2Hlwe7GV3j4iiA+uVlhM1DYNe+5lL5d8gpFsLoRJNnN5XkpHKaH2l7kqZn23FfDM9UONjeUs8yVZGY=
X-Received: by 2002:a02:7f0e:: with SMTP id r14mr6550540jac.8.1592615734134;
 Fri, 19 Jun 2020 18:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
 <20200610113748.4754-58-zhiwei_liu@c-sky.com>
 <CAKmqyKN4pk=XgO-v-grTRvrQY-DEKap_Kouko6-gM-r3HynSjQ@mail.gmail.com>
 <6fdd0b58-3ea0-1052-feed-d2bf8312f211@c-sky.com>
In-Reply-To: <6fdd0b58-3ea0-1052-feed-d2bf8312f211@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jun 2020 18:06:05 -0700
Message-ID: <CAKmqyKOV0CqKXY=DcWcNn3wEjxjqYNYsnckpuCb5jqTOsmRtRw@mail.gmail.com>
Subject: Re: [PATCH v9 57/61] target/riscv: floating-point scalar move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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

On Fri, Jun 19, 2020 at 6:09 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/6/20 8:44, Alistair Francis wrote:
> > On Wed, Jun 10, 2020 at 6:44 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Hello,
> >
> > This patch fails to compile with this error:
> >
> > target/riscv/insn32.decode:566: error: undefined format @r2rd
> >
> > Do you mind looking into why this test fails?
> Sorry, it's a mistake.
>
> the @r2rd is defined in the next patch  "[PATCH v9 58/61] target/riscv:
> vector slide instructions",  where doesn't need the definition at all.
>
> When I split patch set, I must make a mistake here. After that I only
> build  and tested the whole patch set.
>
> Thanks for pointing it.

No worries.

Do you mind fixing that problem and also rebasing the series on this
branch (it should be in master in a few days):
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Then send a new patch series.

Alistair

>
> Zhiwei
> >
> > Alistair
> >
> >
> >> ---
> >>   target/riscv/insn32.decode              |  2 +
> >>   target/riscv/insn_trans/trans_rvv.inc.c | 49 +++++++++++++++++++++++++
> >>   2 files changed, 51 insertions(+)
> >>
> >> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> >> index 0741a25540..79f9b37b29 100644
> >> --- a/target/riscv/insn32.decode
> >> +++ b/target/riscv/insn32.decode
> >> @@ -563,6 +563,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
> >>   vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
> >>   vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
> >>   vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
> >> +vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
> >> +vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
> >>
> >>   vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
> >>   vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> >> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> >> index e67eff0a7f..884ad910b1 100644
> >> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> >> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> >> @@ -2709,3 +2709,52 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
> >>       }
> >>       return false;
> >>   }
> >> +
> >> +/* Floating-Point Scalar Move Instructions */
> >> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
> >> +{
> >> +    if (!s->vill && has_ext(s, RVF) &&
> >> +        (s->mstatus_fs != 0) && (s->sew != 0)) {
> >> +        unsigned int len = 8 << s->sew;
> >> +
> >> +        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
> >> +        if (len < 64) {
> >> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> >> +                            MAKE_64BIT_MASK(len, 64 - len));
> >> +        }
> >> +
> >> +        mark_fs_dirty(s);
> >> +        return true;
> >> +    }
> >> +    return false;
> >> +}
> >> +
> >> +/* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
> >> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
> >> +{
> >> +    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
> >> +        TCGv_i64 t1;
> >> +        /* The instructions ignore LMUL and vector register group. */
> >> +        uint32_t vlmax = s->vlen >> 3;
> >> +
> >> +        /* if vl == 0, skip vector register write back */
> >> +        TCGLabel *over = gen_new_label();
> >> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> >> +
> >> +        /* zeroed all elements */
> >> +        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
> >> +
> >> +        /* NaN-box f[rs1] as necessary for SEW */
> >> +        t1 = tcg_temp_new_i64();
> >> +        if (s->sew == MO_64 && !has_ext(s, RVD)) {
> >> +            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
> >> +        } else {
> >> +            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
> >> +        }
> >> +        vec_element_storei(s, a->rd, 0, t1);
> >> +        tcg_temp_free_i64(t1);
> >> +        gen_set_label(over);
> >> +        return true;
> >> +    }
> >> +    return false;
> >> +}
> >> --
> >> 2.23.0
> >>
> >>
>

