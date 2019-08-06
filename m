Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B7BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 20:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A2B20C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 20:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A2B20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv6SC-0002L0-TP
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 16:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hv6Ro-0001lC-3M
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hv6Rm-0001Yf-Og
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 16:52:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hv6Rm-0001XV-I2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 16:52:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so79540283wmj.5
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 13:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u9ApZj2VaEXqX6eILsw6k22KOwSDwU0EqiPTvyHlhuY=;
 b=MEXOCOz7JPNuvOZW3RC+t3TKqO2W6yZYZ6E0v9do4fSDL58gkVghfSddujj7abUMxr
 UEzRlGE5Ezr0qbk5GK650ykyaznBe5z3DKC4fOuL6pBqtXIEOggEH9aZY+F+r1HDrOs5
 1/B3c374+/XleMUjsWKgGSYEUXBzl/x7M9q5YkvAc0ZCrB/BUNu/bkz7ysCu1nKE6t0h
 cZcj3iTxD1EbaAn0grnrNxn1m8N3pEaySPaXfxaVacubXptXHwAQNixjpBkArI7JfJyF
 l5EcUjV8cy7Mh4JBY4f+I8z5SmAR+IwztuanD2lQnEaWsTdGvlfOUv5JHuvrcUI3zl4L
 U+kQ==
X-Gm-Message-State: APjAAAV2qpxQ6oXaBXOg6mG18qIR7SsksGStqQGwfm3cXZNjl02dl4T9
 09oxVIVuab/t457Kv2luzeKBp2z8itY=
X-Google-Smtp-Source: APXvYqwFOMo+jp1PgJG7eCX9iw6D5+eYZ8pSQkl4P+iipZ4a7thDnUDlHSDrY19kScL04iVvqQAXwA==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr6312934wme.102.1565124760847; 
 Tue, 06 Aug 2019 13:52:40 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id g19sm109421077wmg.10.2019.08.06.13.52.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 13:52:40 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190805130952.4415-1-peter.maydell@linaro.org>
 <20190805130952.4415-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3b543e16-f6f7-0aa7-0c6b-94871fda62ff@redhat.com>
Date: Tue, 6 Aug 2019 22:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190805130952.4415-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Factor out 'generate
 singlestep exception' function
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 3:09 PM, Peter Maydell wrote:
> Factor out code to 'generate a singlestep exception', which is
> currently repeated in four places.
> 
> To do this we need to also pull the identical copies of the
> gen-exception() function out of translate-a64.c and translate.c
> into translate.h.
> 
> (There is a bug in the code: we're taking the exception to the wrong
> target EL.  This will be simpler to fix if there's only one place to
> do it.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate.h     | 23 +++++++++++++++++++++++
>  target/arm/translate-a64.c | 19 ++-----------------
>  target/arm/translate.c     | 20 ++------------------
>  3 files changed, 27 insertions(+), 35 deletions(-)
> 
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index a20f6e20568..45053190baa 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -2,6 +2,7 @@
>  #define TARGET_ARM_TRANSLATE_H
>  
>  #include "exec/translator.h"
> +#include "internals.h"
>  
>  
>  /* internal defines */
> @@ -232,6 +233,28 @@ static inline void gen_ss_advance(DisasContext *s)
>      }
>  }
>  
> +static inline void gen_exception(int excp, uint32_t syndrome,
> +                                 uint32_t target_el)
> +{
> +    TCGv_i32 tcg_excp = tcg_const_i32(excp);
> +    TCGv_i32 tcg_syn = tcg_const_i32(syndrome);
> +    TCGv_i32 tcg_el = tcg_const_i32(target_el);
> +
> +    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
> +                                       tcg_syn, tcg_el);
> +
> +    tcg_temp_free_i32(tcg_el);
> +    tcg_temp_free_i32(tcg_syn);
> +    tcg_temp_free_i32(tcg_excp);
> +}
> +
> +/* Generate an architectural singlestep exception */
> +static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
> +{
> +    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, isv, ex),
> +                  default_exception_el(s));
> +}
> +
>  /*
>   * Given a VFP floating point constant encoded into an 8 bit immediate in an
>   * instruction, expand it to the actual constant value of the specified
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d3231477a27..f6729b96fd0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -253,19 +253,6 @@ static void gen_exception_internal(int excp)
>      tcg_temp_free_i32(tcg_excp);
>  }
>  
> -static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
> -{
> -    TCGv_i32 tcg_excp = tcg_const_i32(excp);
> -    TCGv_i32 tcg_syn = tcg_const_i32(syndrome);
> -    TCGv_i32 tcg_el = tcg_const_i32(target_el);
> -
> -    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
> -                                       tcg_syn, tcg_el);
> -    tcg_temp_free_i32(tcg_el);
> -    tcg_temp_free_i32(tcg_syn);
> -    tcg_temp_free_i32(tcg_excp);
> -}
> -
>  static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
>  {
>      gen_a64_set_pc_im(s->pc - offset);
> @@ -305,8 +292,7 @@ static void gen_step_complete_exception(DisasContext *s)
>       * of the exception, and our syndrome information is always correct.
>       */
>      gen_ss_advance(s);
> -    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
> -                  default_exception_el(s));
> +    gen_swstep_exception(s, 1, s->is_ldex);
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>  
> @@ -14261,8 +14247,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>           * bits should be zero.
>           */
>          assert(dc->base.num_insns == 1);
> -        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
> -                      default_exception_el(dc));
> +        gen_swstep_exception(dc, 0, 0);
>          dc->base.is_jmp = DISAS_NORETURN;
>      } else {
>          disas_a64_insn(env, dc);
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 7853462b21b..19b9d8f2725 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -282,20 +282,6 @@ static void gen_exception_internal(int excp)
>      tcg_temp_free_i32(tcg_excp);
>  }
>  
> -static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
> -{
> -    TCGv_i32 tcg_excp = tcg_const_i32(excp);
> -    TCGv_i32 tcg_syn = tcg_const_i32(syndrome);
> -    TCGv_i32 tcg_el = tcg_const_i32(target_el);
> -
> -    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
> -                                       tcg_syn, tcg_el);
> -
> -    tcg_temp_free_i32(tcg_el);
> -    tcg_temp_free_i32(tcg_syn);
> -    tcg_temp_free_i32(tcg_excp);
> -}
> -
>  static void gen_step_complete_exception(DisasContext *s)
>  {
>      /* We just completed step of an insn. Move from Active-not-pending
> @@ -308,8 +294,7 @@ static void gen_step_complete_exception(DisasContext *s)
>       * of the exception, and our syndrome information is always correct.
>       */
>      gen_ss_advance(s);
> -    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
> -                  default_exception_el(s));
> +    gen_swstep_exception(s, 1, s->is_ldex);
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>  
> @@ -12024,8 +12009,7 @@ static bool arm_pre_translate_insn(DisasContext *dc)
>           * bits should be zero.
>           */
>          assert(dc->base.num_insns == 1);
> -        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
> -                      default_exception_el(dc));
> +        gen_swstep_exception(dc, 0, 0);
>          dc->base.is_jmp = DISAS_NORETURN;
>          return true;
>      }
> 

