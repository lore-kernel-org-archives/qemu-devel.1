Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C33C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE102073E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjiFSns7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE102073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluR5-0000g5-Hl
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jluQG-00006y-SE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:17:45 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jluQC-0004kb-BG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:17:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id d67so5014038oig.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=newU3v53ZM90+fgWgn75vARkrf41mvienMtSYmaaQqk=;
 b=IjiFSns7jacOqmZ5amJOmH+ugaw0+qXgPo9Y35MNnRtJ85s524UYnQs3Pt63gKX4k3
 N/ba1NfOO2EyKaB2Go8je/3WRHCpoLTFCDbo2UrlI+9uH61Egy/s5aIaTBoq/TOuDTOM
 jUPP474ak//bvtYKHauAvG6Mfq+VW/RX4tiZ8InjiElvfKY3D+ySYV27RiTZ0LbsaV1n
 G4EMiilLvmsjtwZc3ePL4nHWec74+j2EpBl9u81iW8/QcyhDaVhlhkj9Um77xtloh9Uy
 km4Dy/xqRD4sMd6zbCisv+NkjuxQ7E5OUYV88GRCaJBtZdZCMFTukysPPJc+5a7VmfWZ
 z9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=newU3v53ZM90+fgWgn75vARkrf41mvienMtSYmaaQqk=;
 b=UaaSGCH+4Xc+TYydZEdTwA8wLmwCwMkvwsrRLmZQaHpfOv94ybiNDHi36q0pW/i3Ts
 CCQf2NSiV+GealXoreuIEOXzdSixv/OXf+qiVV70uyg/19gZBQiLI/mhuYEG6h0spkx9
 qk1l3IAIXqYy5RWPkfGvIXhfX0BVkCPMp4ipPlVdvxP5Q89mZVgr+3P/Abl7hT/skMMy
 TRc72rB7gpFT0vNxP9nYRtYmJCcMhgsMyiifI76kJZLais7BC2xWBjnTJnljutgIdp5u
 I2I3U9PA1E0TqJQ4AMb1GuOrCA/EyKes0Tgwe4rXbaVugMftzbLubpyfjA9SQNSsEE0q
 6c9A==
X-Gm-Message-State: AOAM5312ihdgCnlrj5DBUicigCrQcAxLthr1ICMAKqq8vP+K8l6bf+St
 o7i7b7oxsp9vPwCHGnd5t9UtAokKNEbify53dtM+2g==
X-Google-Smtp-Source: ABdhPJwitj92myVbU9H0XttcOHVMwQmJ2kUpnzJc6OzYAkZ9JoDmVH4EKt26wSlz9ralK0z1bXT1poODyf6rWtBsEYA=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2794395oia.163.1592486254943; 
 Thu, 18 Jun 2020 06:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-11-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 14:17:23 +0100
Message-ID: <CAFEAcA-QZ_D1tQMv785xsxWwcEKmM76dK4Mvgx=y7eyb_mUqEg@mail.gmail.com>
Subject: Re: [PATCH v7 10/42] target/arm: Implement the ADDG, SUBG instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Shift offset in translate; use extract32.
> v6: Implement inline for !ATA.

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2481561925..a18d71ad98 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3753,17 +3753,20 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
>   *    sf: 0 -> 32bit, 1 -> 64bit
>   *    op: 0 -> add  , 1 -> sub
>   *     S: 1 -> set flags
> - * shift: 00 -> LSL imm by 0, 01 -> LSL imm by 12
> + * shift: 00 -> LSL imm by 0,
> + *        01 -> LSL imm by 12
> + *        10 -> ADDG, SUBG
>   */
>  static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
>  {
>      int rd = extract32(insn, 0, 5);
>      int rn = extract32(insn, 5, 5);
> -    uint64_t imm = extract32(insn, 10, 12);
> +    int imm = extract32(insn, 10, 12);
>      int shift = extract32(insn, 22, 2);
>      bool setflags = extract32(insn, 29, 1);
>      bool sub_op = extract32(insn, 30, 1);
>      bool is_64bit = extract32(insn, 31, 1);
> +    bool is_tag = false;
>
>      TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
>      TCGv_i64 tcg_rd = setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
> @@ -3775,11 +3778,40 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
>      case 0x1:
>          imm <<= 12;
>          break;
> +    case 0x2:
> +        /* ADDG, SUBG */
> +        if (!is_64bit || setflags || (imm & 0x30) ||
> +            !dc_isar_feature(aa64_mte_insn_reg, s)) {
> +            goto do_unallocated;
> +        }
> +        is_tag = true;
> +        break;
>      default:
> +    do_unallocated:
>          unallocated_encoding(s);
>          return;
>      }
>
> +    if (is_tag) {
> +        imm = (imm >> 6) << LOG2_TAG_GRANULE;
> +        if (sub_op) {
> +            imm = -imm;
> +        }
> +
> +        if (s->ata) {
> +            TCGv_i32 tag_offset = tcg_const_i32(imm & 15);
> +            TCGv_i32 offset = tcg_const_i32(imm);
> +
> +            gen_helper_addsubg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
> +            tcg_temp_free_i32(tag_offset);
> +            tcg_temp_free_i32(offset);
> +        } else {
> +            tcg_gen_addi_i64(tcg_rd, tcg_rn, imm);
> +            gen_address_with_allocation_tag0(tcg_rd, tcg_rd);
> +        }
> +        return;
> +    }

Given that we don't really share any of the codegen with the
existing disas_add_sub_imm() insns, and the insn format isn't
the same (uimm6/op3/uimm4 rather than an imm12), I'm tempted
to suggest we should structure this the same way the Arm ARM
decode tables do, where "Add/subtract (immediate, with tags)"
is a separate subtable from "Add/subtract (immediate)": so
instead of disas_data_proc_imm() sending both case
0x22 and 0x23 to disas_add_sub_imm(), it would send 0x23
to a new disas_add_sub_tag().

But this patch is functionally correct, so if you don't
feel like making that change you can have
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
for this version.

thanks
-- PMM

