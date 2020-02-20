Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B885C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C836324672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uqef5LO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C836324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pSE-000172-Tr
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pRD-0000cf-4B
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pRB-0007jF-MF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:16:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4pRB-0007j7-Fe
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:16:33 -0500
Received: by mail-ot1-x341.google.com with SMTP id p8so4338565oth.10
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tR9pmiMInWv4mSnrTrDQVOYD9HUI1quRu5s8TXAhCXk=;
 b=Uqef5LO1vq9uJdYsNnx1b41JJM+J4q0q5gk4UEZOJ1GfICrWGLcbIamXBI6ZnPE456
 Cgxr62qEk+6zZUA7GVQ1Ei7xUdlklGwJB30Aq7k/2JYG8VtOXkNGbd6CKk9lBJOaJerj
 UpR8A2+IMmm9KzE3LXSGKZOmbkWAsKDgdic6Wwf3UGwR8TpqDlcvIAjlaKxh0VpzAJQN
 RF/LogA/BBhKieLzxf4Kg9DJmMY8qoPYoBs50wTnof8ueVr2CVIizchcwt0VS6GQ8J1+
 J1vcWOecvzKoeab5DapLO3CrN8p02hEMNi7xRvEKVDk+aSym5LxhqvjQVWPxlG0aPR0W
 pJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tR9pmiMInWv4mSnrTrDQVOYD9HUI1quRu5s8TXAhCXk=;
 b=btEZ2gywB3le3bRzOqhMC6jWB9XOhpTzmebjn55hW9FsnFK/Zw2FRcU+EjgrWwoBat
 ssI2S+6vweEaQG1KMyQVQnbSF9zaN3ojMYSsyk9iysG8q80BHNdAgSoWgLXh6/YWwv9R
 M7Jd/k/SQns0kacRlHx3IxtKBjTv6tOX7OvDDZ7amZiPXrnBTsNPNwZDwYmj2GfBMJo+
 6es5CEx2U7ousyo8nAOHUYtSyu/0Me4/YhHaXC7iwHTF3bv2AxwmbMqoBGwp+4FCxBHJ
 +3eN1FXkxpISnGRRt6XMIIMkaAY50BRim1yCTdAhqn6YOf27g7LFPUvo5FaSPxwfpUnL
 cZrQ==
X-Gm-Message-State: APjAAAUOR9i0GzYVLljxbqtBfqhwOOw9uaGxpOuleWSrq3rB7jtX1HZ7
 HMJSC8TLMIl3agEfHZ/oi0AH+iOjauqNeKl2xp9UDw==
X-Google-Smtp-Source: APXvYqziV+oKUXQWObYmwneDTLD+qs4Sb2XJv3Tl9ucusKeqLj8KfHbDxdRLvOyXC+Q580A5FgMY36G9K0EZz3BGYVY=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr12352116oto.135.1582218992492; 
 Thu, 20 Feb 2020 09:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-15-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:16:21 +0000
Message-ID: <CAFEAcA9OMmVoULYPKvj4T-6w7ZL5t8L+HT2XjV_Zo2jXvZXKUw@mail.gmail.com>
Subject: Re: [PATCH 14/19] target/arm: Move the vfp decodetree calls next to
 the base isa
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Have the calls adjacent as an intermediate step toward
> actually merging the decodes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 80 +++++++++++++-----------------------------
>  1 file changed, 24 insertions(+), 56 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b2641b4262..5cabe6b2e9 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2646,31 +2646,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
>      tcg_temp_free_i32(tmp);
>  }
>
> -/*
> - * Disassemble a VFP instruction.  Returns nonzero if an error occurred
> - * (ie. an undefined instruction).
> - */
> -static int disas_vfp_insn(DisasContext *s, uint32_t insn)
> -{
> -    /*
> -     * If the decodetree decoder handles this insn it will always
> -     * emit code to either execute the insn or generate an appropriate
> -     * exception; so we don't need to ever return non-zero to tell
> -     * the calling code to emit an UNDEF exception.
> -     */
> -    if (extract32(insn, 28, 4) == 0xf) {
> -        if (disas_vfp_uncond(s, insn)) {
> -            return 0;
> -        }
> -    } else {
> -        if (disas_vfp(s, insn)) {
> -            return 0;
> -        }
> -    }
> -    /* If the decodetree decoder didn't handle this insn, it must be UNDEF */
> -    return 1;
> -}

Before this change, if this was a cp10/11 insn and
neither disas_vfp_uncond() nor disas_vfp() returned true,
we would UNDEF it.

> -
>  static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
>  {
>  #ifndef CONFIG_USER_ONLY
> @@ -10524,7 +10499,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>          ARCH(5);
>
>          /* Unconditional instructions.  */
> -        if (disas_a32_uncond(s, insn)) {
> +        /* TODO: Perhaps merge these into one decodetree output file.  */
> +        if (disas_a32_uncond(s, insn) ||
> +            disas_vfp_uncond(s, insn)) {
>              return;
>          }
>          /* fall back to legacy decoder */
> @@ -10551,13 +10528,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              }
>              return;
>          }
> -        if ((insn & 0x0f000e10) == 0x0e000a00) {
> -            /* VFP.  */
> -            if (disas_vfp_insn(s, insn)) {
> -                goto illegal_op;
> -            }
> -            return;
> -        }
>          if ((insn & 0x0e000f00) == 0x0c000100) {
>              if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
>                  /* iWMMXt register transfer.  */
> @@ -10588,7 +10558,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>          arm_skip_unless(s, cond);
>      }
>
> -    if (disas_a32(s, insn)) {
> +    /* TODO: Perhaps merge these into one decodetree output file.  */
> +    if (disas_a32(s, insn) ||
> +        disas_vfp(s, insn)) {
>          return;
>      }
>      /* fall back to legacy decoder */
> @@ -10597,12 +10569,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>      case 0xc:
>      case 0xd:
>      case 0xe:
> -        if (((insn >> 8) & 0xe) == 10) {
> -            /* VFP.  */
> -            if (disas_vfp_insn(s, insn)) {
> -                goto illegal_op;
> -            }
> -        } else if (disas_coproc_insn(s, insn)) {
> +        if (((insn >> 8) & 0xe) != 10 && disas_coproc_insn(s, insn)) {
>              /* Coprocessor.  */
>              goto illegal_op;
>          }

But now if the VFP decodetree doesn't handle the insn,
we'll fall into this case here, I think, the
"(((insn >> 8) & 0xe) != 10" part of the condition will
be false, and we'll end up at a 'break' statement, which
I think means we'll end up doing a NOP rather than an UNDEF.



> @@ -10691,7 +10658,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>          ARCH(6T2);
>      }
>
> -    if (disas_t32(s, insn)) {
> +    /*
> +     * TODO: Perhaps merge these into one decodetree output file.
> +     * Note disas_vfp is written for a32 with cond field in the
> +     * top nibble.  The t32 encoding requires 0xe in the top nibble.
> +     */
> +    if (disas_t32(s, insn) ||
> +        disas_vfp_uncond(s, insn) ||
> +        ((insn >> 28) == 0xe && disas_vfp(s, insn))) {
>          return;
>      }
>      /* fall back to legacy decoder */
> @@ -10708,17 +10682,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                  goto illegal_op; /* op0 = 0b11 : unallocated */
>              }
>
> -            if (disas_vfp_insn(s, insn)) {
> -                if (((insn >> 8) & 0xe) == 10 &&
> -                    dc_isar_feature(aa32_fpsp_v2, s)) {
> -                    /* FP, and the CPU supports it */
> -                    goto illegal_op;
> -                } else {
> -                    /* All other insns: NOCP */
> -                    gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
> -                                       syn_uncategorized(),
> -                                       default_exception_el(s));
> -                }
> +            if (((insn >> 8) & 0xe) == 10 &&
> +                dc_isar_feature(aa32_fpsp_v2, s)) {
> +                /* FP, and the CPU supports it */
> +                goto illegal_op;
> +            } else {
> +                /* All other insns: NOCP */
> +                gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
> +                                   syn_uncategorized(),
> +                                   default_exception_el(s));
>              }
>              break;
>          }
> @@ -10740,10 +10712,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>              if (disas_neon_data_insn(s, insn)) {
>                  goto illegal_op;
>              }
> -        } else if (((insn >> 8) & 0xe) == 10) {
> -            if (disas_vfp_insn(s, insn)) {
> -                goto illegal_op;
> -            }
>          } else {
>              if (insn & (1 << 28))
>                  goto illegal_op;

Here in the thumb decoder there's a similar issue I think:
now for insns which are in the VFP space but don't exist
(ie where the decodetree has returned false) we'll end up
now falling through into disas_coproc_insn() rather than
just UNDEFing them.

thanks
-- PMM

