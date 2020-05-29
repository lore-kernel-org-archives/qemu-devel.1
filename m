Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073C8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C302068D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHWgApFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C302068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelxM-0007RN-Vd
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelwD-0006Ah-H6; Fri, 29 May 2020 16:49:09 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:39337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelwC-0005mI-5J; Fri, 29 May 2020 16:49:09 -0400
Received: by mail-io1-xd41.google.com with SMTP id c8so788266iob.6;
 Fri, 29 May 2020 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lfYJwYbsf3viRq0jEi9p4en5sgc/dXFv1cABxe72Y4g=;
 b=JHWgApFQkhmQYyEayQNbTMfv279Hd4HPuMm+4riC6elGKmxwNAaMIRI1PmEs57DyKj
 Xqi81eklcZ6QWW6epFnV1zYd/ZFsGhFeaFERC89Plh4Q9t1Y8wAhke+jBfMkCYaAGumH
 XRJffhebNBBo0OC01AMMqZeGAGC9UgIP5tYyGqVs0TgTXhkwuZvS+Glg6kIzoCrls9wS
 bY3TugfIG2TPGwGm/kVromoTwn1U6OCyZNVMVzttpo40bOpm5RyEC9WWqymV919FDqcw
 adUCLvimikG+akLYqtV8Qhw6LkhUTSAu1O50voeWt2heEpBCBFNrACEWXt/M21blcBOT
 S3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lfYJwYbsf3viRq0jEi9p4en5sgc/dXFv1cABxe72Y4g=;
 b=JuaOdOx46AvGR3MxAYP+04sXy+sdrJyJuaCgtT1YA1LLpDnJcuxV670KQa04CJMwre
 KzDg4m4WG8P2Q4NZgdGFdOdECcZMLAlJbtiwcwR0bCfNgExkSU+wnfJcBane1GQjgrMw
 f9d96Bpyb07WJd8GjdNlidPqdEH5gvHlsLFEnlJEbUaXTrviZFLQ+ZzSSxgfh14suhqI
 xeXIsrCCMOlibKr3QLJq8VanDqvxrSTiskCpyLBXFF/FCpPeNsCRj8Ggh3yp/mcb2s8X
 XrtaAVx5kGYSYGbJ5LQCYNibqeZa/G6ZZDEi5XJXm49Rx3jnPmAWXMBBfoQa55MGlFaP
 K1ng==
X-Gm-Message-State: AOAM530uyJv0GMSC5+5hjj9yAHp32/KEk7lsO6rVrE1bBgGUpKVx832b
 TfT8cPBAFFA885dVBxYXoZ4S2GJwbGA48+nxXv4=
X-Google-Smtp-Source: ABdhPJxA/O8VOQj6PvtK9fw3e1ssHI4WUV3LYuHb7eB7X/sn2OdgVRcUgW2Axg/AobVkoHKFmw2cEUp0hRjrKV7TppA=
X-Received: by 2002:a5e:dd45:: with SMTP id u5mr7142530iop.118.1590785346588; 
 Fri, 29 May 2020 13:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-44-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-44-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:40:01 -0700
Message-ID: <CAKmqyKP04ZQ-EwURWVQDoe2on_NqNkW-OoqNOBk136+WG1L5+w@mail.gmail.com>
Subject: Re: [PATCH v8 43/62] target/riscv: vector floating-point/integer
 type-convert instructions
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 4:11 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 13 ++++++++++
>  target/riscv/insn32.decode              |  4 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  6 +++++
>  target/riscv/vector_helper.c            | 33 +++++++++++++++++++++++++
>  4 files changed, 56 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 21054cc957..05f8fb5ffc 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -998,3 +998,16 @@ DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_5(vfcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_xu_f_v_d, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_x_f_v_d, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 14cb4e2e66..53562c6663 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -515,6 +515,10 @@ vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
>  vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
>  vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
>  vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
> +vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
> +vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
> +vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
> +vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index dfa2177331..6db460177d 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2215,3 +2215,9 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>      }
>      return false;
>  }
> +
> +/* Single-Width Floating-Point/Integer Type-Convert Instructions */
> +GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
> +GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
> +GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
> +GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 018293570d..34b21c8deb 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4217,3 +4217,36 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
>  GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
>  GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
>  GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
> +
> +/* Single-Width Floating-Point/Integer Type-Convert Instructions */
> +/* vfcvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
> +RVVCALL(OPFVV1, vfcvt_xu_f_v_h, OP_UU_H, H2, H2, float16_to_uint16)
> +RVVCALL(OPFVV1, vfcvt_xu_f_v_w, OP_UU_W, H4, H4, float32_to_uint32)
> +RVVCALL(OPFVV1, vfcvt_xu_f_v_d, OP_UU_D, H8, H8, float64_to_uint64)
> +GEN_VEXT_V_ENV(vfcvt_xu_f_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfcvt_xu_f_v_w, 4, 4, clearl)
> +GEN_VEXT_V_ENV(vfcvt_xu_f_v_d, 8, 8, clearq)
> +
> +/* vfcvt.x.f.v vd, vs2, vm # Convert float to signed integer. */
> +RVVCALL(OPFVV1, vfcvt_x_f_v_h, OP_UU_H, H2, H2, float16_to_int16)
> +RVVCALL(OPFVV1, vfcvt_x_f_v_w, OP_UU_W, H4, H4, float32_to_int32)
> +RVVCALL(OPFVV1, vfcvt_x_f_v_d, OP_UU_D, H8, H8, float64_to_int64)
> +GEN_VEXT_V_ENV(vfcvt_x_f_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfcvt_x_f_v_w, 4, 4, clearl)
> +GEN_VEXT_V_ENV(vfcvt_x_f_v_d, 8, 8, clearq)
> +
> +/* vfcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to float. */
> +RVVCALL(OPFVV1, vfcvt_f_xu_v_h, OP_UU_H, H2, H2, uint16_to_float16)
> +RVVCALL(OPFVV1, vfcvt_f_xu_v_w, OP_UU_W, H4, H4, uint32_to_float32)
> +RVVCALL(OPFVV1, vfcvt_f_xu_v_d, OP_UU_D, H8, H8, uint64_to_float64)
> +GEN_VEXT_V_ENV(vfcvt_f_xu_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfcvt_f_xu_v_w, 4, 4, clearl)
> +GEN_VEXT_V_ENV(vfcvt_f_xu_v_d, 8, 8, clearq)
> +
> +/* vfcvt.f.x.v vd, vs2, vm # Convert integer to float. */
> +RVVCALL(OPFVV1, vfcvt_f_x_v_h, OP_UU_H, H2, H2, int16_to_float16)
> +RVVCALL(OPFVV1, vfcvt_f_x_v_w, OP_UU_W, H4, H4, int32_to_float32)
> +RVVCALL(OPFVV1, vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
> +GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
> +GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
> --
> 2.23.0
>
>

