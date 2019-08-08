Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C7C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D018C2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D018C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvbDQ-0001FM-5q
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 01:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvbCy-0000jp-JR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvbCw-0000dD-UY
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:43:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvbCw-0000cx-NQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:43:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so90355319wrm.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 22:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ktMNMcifd96VH/C+Jk6LLfAiaM0PA0RVtXSt27cfhc=;
 b=AM+YEQonCJxWdCph1Be0m44Wwgi60FA29EjDNt2iniNmCTLWzJuQgAc6r4uO+M5LwG
 oSJ2v7WxXcbrW78apX66K8kFUscJC+Dmseukgb1eTW3NJAbMArfa6/AFqqO+UnTR2yyj
 c0KrMbtPh5fptuR94rTeZ4w+HtobWYEzyAM0uvHgmfA0ExEc+JRirdM4BXosS/oVedYc
 CdK2Ppm3qQkig9dROkz+W5f/RL8e6S4UliJyvPwU9i9Brafrobk5eOIMijom3K/I6Hai
 ZDJafaleHpUL6AaMYG0Z6oHOxBVPjYh+/0UYvpu9D4XaiqJ0suQW9E/NMKIIDwBDVWn3
 n+Dg==
X-Gm-Message-State: APjAAAVQ8yIFLXHXZU+VADfK/mw/DybFa/mDBznR7Bvo5hJRRFH1Eefv
 7kLD566DkIKtDLPzvBdAK46hlQ==
X-Google-Smtp-Source: APXvYqzFe4x94XmAH78Wcg5CR39HjOKWCWTiAtufyBv9S3DCqcpYhpxzWcyDZEjUhOfAIVbxakBLjA==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr14641086wrn.31.1565243005567; 
 Wed, 07 Aug 2019 22:43:25 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id v124sm2485574wmf.23.2019.08.07.22.43.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 22:43:25 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d1e54ad9-377a-5d57-c804-5bc587f02750@redhat.com>
Date: Thu, 8 Aug 2019 07:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807045335.1361-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 04/11] target/arm: Introduce add_reg_for_lit
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 6:53 AM, Richard Henderson wrote:
> Provide a common routine for the places that require ALIGN(PC, 4)
> as the base address as opposed to plain PC.  The two are always
> the same for A32, but the difference is meaningful for thumb mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Note: This patch is easier to read with -b, as there are several
> large-ish indentation changes as the if statements fold together.
> ---
>  target/arm/translate-vfp.inc.c |  38 ++------
>  target/arm/translate.c         | 166 +++++++++++++++------------------
>  2 files changed, 82 insertions(+), 122 deletions(-)
> 
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 092eb5ec53..262d4177e5 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -941,14 +941,8 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
>          offset = -offset;
>      }
>  
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> -    tcg_gen_addi_i32(addr, addr, offset);
> +    /* For thumb, use of PC is UNPREDICTABLE.  */
> +    addr = add_reg_for_lit(s, a->rn, offset);
>      tmp = tcg_temp_new_i32();
>      if (a->l) {
>          gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
> @@ -983,14 +977,8 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
>          offset = -offset;
>      }
>  
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> -    tcg_gen_addi_i32(addr, addr, offset);
> +    /* For thumb, use of PC is UNPREDICTABLE.  */
> +    addr = add_reg_for_lit(s, a->rn, offset);
>      tmp = tcg_temp_new_i64();
>      if (a->l) {
>          gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
> @@ -1029,13 +1017,8 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
>          return true;
>      }
>  
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> +    /* For thumb, use of PC is UNPREDICTABLE.  */
> +    addr = add_reg_for_lit(s, a->rn, 0);
>      if (a->p) {
>          /* pre-decrement */
>          tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
> @@ -1112,13 +1095,8 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
>          return true;
>      }
>  
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> +    /* For thumb, use of PC is UNPREDICTABLE.  */
> +    addr = add_reg_for_lit(s, a->rn, 0);
>      if (a->p) {
>          /* pre-decrement */
>          tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 61933865d5..71d94c053b 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -220,6 +220,23 @@ static inline TCGv_i32 load_reg(DisasContext *s, int reg)
>      return tmp;
>  }
>  
> +/*
> + * Create a new temp, REG + OFS, except PC is ALIGN(PC, 4).
> + * This is used for load/store for which use of PC implies (literal),
> + * or ADD that implies ADR.
> + */
> +static TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
> +{
> +    TCGv_i32 tmp = tcg_temp_new_i32();
> +
> +    if (reg == 15) {
> +        tcg_gen_movi_i32(tmp, (read_pc(s) & ~3) + ofs);
> +    } else {
> +        tcg_gen_addi_i32(tmp, cpu_R[reg], ofs);
> +    }
> +    return tmp;
> +}
> +
>  /* Set a CPU register.  The source must be a temporary and will be
>     marked as dead.  */
>  static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
> @@ -9472,16 +9489,12 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                   */
>                  bool wback = extract32(insn, 21, 1);
>  
> -                if (rn == 15) {
> -                    if (insn & (1 << 21)) {
> -                        /* UNPREDICTABLE */
> -                        goto illegal_op;
> -                    }
> -                    addr = tcg_temp_new_i32();
> -                    tcg_gen_movi_i32(addr, s->pc & ~3);
> -                } else {
> -                    addr = load_reg(s, rn);
> +                if (rn == 15 && (insn & (1 << 21))) {
> +                    /* UNPREDICTABLE */
> +                    goto illegal_op;
>                  }
> +
> +                addr = add_reg_for_lit(s, rn, 0);
>                  offset = (insn & 0xff) * 4;
>                  if ((insn & (1 << 23)) == 0) {
>                      offset = -offset;
> @@ -10682,27 +10695,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                          store_reg(s, rd, tmp);
>                      } else {
>                          /* Add/sub 12-bit immediate.  */
> -                        if (rn == 15) {
> -                            offset = s->pc & ~(uint32_t)3;
> -                            if (insn & (1 << 23))
> -                                offset -= imm;
> -                            else
> -                                offset += imm;
> -                            tmp = tcg_temp_new_i32();
> -                            tcg_gen_movi_i32(tmp, offset);
> -                            store_reg(s, rd, tmp);
> +                        if (insn & (1 << 23)) {
> +                            imm = -imm;

:)

> +                        }
> +                        tmp = add_reg_for_lit(s, rn, imm);
> +                        if (rn == 13 && rd == 13) {
> +                            /* ADD SP, SP, imm or SUB SP, SP, imm */
> +                            store_sp_checked(s, tmp);
>                          } else {
> -                            tmp = load_reg(s, rn);
> -                            if (insn & (1 << 23))
> -                                tcg_gen_subi_i32(tmp, tmp, imm);
> -                            else
> -                                tcg_gen_addi_i32(tmp, tmp, imm);
> -                            if (rn == 13 && rd == 13) {
> -                                /* ADD SP, SP, imm or SUB SP, SP, imm */
> -                                store_sp_checked(s, tmp);
> -                            } else {
> -                                store_reg(s, rd, tmp);
> -                            }
> +                            store_reg(s, rd, tmp);
>                          }
>                      }
>                  }
> @@ -10816,61 +10817,53 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>              }
>          }
>          memidx = get_mem_index(s);
> -        if (rn == 15) {
> -            addr = tcg_temp_new_i32();
> -            /* PC relative.  */
> -            /* s->pc has already been incremented by 4.  */
> -            imm = s->pc & 0xfffffffc;
> -            if (insn & (1 << 23))
> -                imm += insn & 0xfff;
> -            else
> -                imm -= insn & 0xfff;
> -            tcg_gen_movi_i32(addr, imm);
> +        imm = insn & 0xfff;
> +        if (insn & (1 << 23)) {
> +            /* PC relative or Positive offset.  */
> +            addr = add_reg_for_lit(s, rn, imm);
> +        } else if (rn == 15) {
> +            /* PC relative with negative offset.  */
> +            addr = add_reg_for_lit(s, rn, -imm);
>          } else {
>              addr = load_reg(s, rn);
> -            if (insn & (1 << 23)) {
> -                /* Positive offset.  */
> -                imm = insn & 0xfff;
> -                tcg_gen_addi_i32(addr, addr, imm);
> -            } else {
> -                imm = insn & 0xff;
> -                switch ((insn >> 8) & 0xf) {
> -                case 0x0: /* Shifted Register.  */
> -                    shift = (insn >> 4) & 0xf;
> -                    if (shift > 3) {
> -                        tcg_temp_free_i32(addr);
> -                        goto illegal_op;
> -                    }
> -                    tmp = load_reg(s, rm);
> -                    if (shift)

'diff -b' shows me you removed this 'if (shift)' but ...

> -                        tcg_gen_shli_i32(tmp, tmp, shift);
> -                    tcg_gen_add_i32(addr, addr, tmp);
> -                    tcg_temp_free_i32(tmp);
> -                    break;
> -                case 0xc: /* Negative offset.  */
> -                    tcg_gen_addi_i32(addr, addr, -imm);
> -                    break;
> -                case 0xe: /* User privilege.  */
> -                    tcg_gen_addi_i32(addr, addr, imm);
> -                    memidx = get_a32_user_mem_index(s);
> -                    break;
> -                case 0x9: /* Post-decrement.  */
> -                    imm = -imm;
> -                    /* Fall through.  */
> -                case 0xb: /* Post-increment.  */
> -                    postinc = 1;
> -                    writeback = 1;
> -                    break;
> -                case 0xd: /* Pre-decrement.  */
> -                    imm = -imm;
> -                    /* Fall through.  */
> -                case 0xf: /* Pre-increment.  */
> -                    writeback = 1;
> -                    break;
> -                default:
> +            imm = insn & 0xff;
> +            switch ((insn >> 8) & 0xf) {
> +            case 0x0: /* Shifted Register.  */
> +                shift = (insn >> 4) & 0xf;
> +                if (shift > 3) {
>                      tcg_temp_free_i32(addr);
>                      goto illegal_op;
>                  }
> +                tmp = load_reg(s, rm);
> +                if (shift) {

... I'm seeing it here. Odd.

> +                    tcg_gen_shli_i32(tmp, tmp, shift);
> +                }
> +                tcg_gen_add_i32(addr, addr, tmp);
> +                tcg_temp_free_i32(tmp);
> +                break;
> +            case 0xc: /* Negative offset.  */
> +                tcg_gen_addi_i32(addr, addr, -imm);
> +                break;
> +            case 0xe: /* User privilege.  */
> +                tcg_gen_addi_i32(addr, addr, imm);
> +                memidx = get_a32_user_mem_index(s);
> +                break;
> +            case 0x9: /* Post-decrement.  */
> +                imm = -imm;
> +                /* Fall through.  */
> +            case 0xb: /* Post-increment.  */
> +                postinc = 1;
> +                writeback = 1;
> +                break;
> +            case 0xd: /* Pre-decrement.  */
> +                imm = -imm;
> +                /* Fall through.  */
> +            case 0xf: /* Pre-increment.  */
> +                writeback = 1;
> +                break;
> +            default:
> +                tcg_temp_free_i32(addr);
> +                goto illegal_op;
>              }
>          }
>  
> @@ -11066,10 +11059,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>          if (insn & (1 << 11)) {
>              rd = (insn >> 8) & 7;
>              /* load pc-relative.  Bit 1 of PC is ignored.  */
> -            val = read_pc(s) + ((insn & 0xff) * 4);
> -            val &= ~(uint32_t)2;
> -            addr = tcg_temp_new_i32();
> -            tcg_gen_movi_i32(addr, val);
> +            addr = add_reg_for_lit(s, 15, (insn & 0xff) * 4);
>              tmp = tcg_temp_new_i32();
>              gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
>                                 rd | ISSIs16Bit);
> @@ -11447,16 +11437,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>           *  - Add PC/SP (immediate)
>           */
>          rd = (insn >> 8) & 7;
> -        if (insn & (1 << 11)) {
> -            /* SP */
> -            tmp = load_reg(s, 13);
> -        } else {
> -            /* PC. bit 1 is ignored.  */
> -            tmp = tcg_temp_new_i32();
> -            tcg_gen_movi_i32(tmp, read_pc(s) & ~(uint32_t)2);
> -        }
>          val = (insn & 0xff) * 4;
> -        tcg_gen_addi_i32(tmp, tmp, val);
> +        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
>          store_reg(s, rd, tmp);
>          break;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


