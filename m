Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB63C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615D921E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615D921E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPrI-0003f0-O3
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvPqp-0002Xi-1k
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvPqn-0002H6-N5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:35:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvPqn-0002F8-HD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:35:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so6342058wrq.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HYrgFBsUh/JwzlsP+KSAQpJRfwY5SoFff50j98OSet0=;
 b=olH0ydX9GSjRK/ruNGGJxs1P2DwGD6uC38Oe9y1qrng3vTJ2INszwtqz7nea5tU6Ii
 3KPG+Zrjyk064OOsWuiAF5qWLUexRGew0QkFB+BUucXf+RZIDseeNZQrqTFX72rzpZOj
 crAkIOWGZ2ex8L5zrvGbLRP2j/eoiEF+vYRkNlqoGBRADG8A/b2lYvyuD4NXNzZzSZDF
 b7lNs58d5Lb0kdt2r4OE7VbF7ICiBvzq1Niu8ITVLxlHz30TItIUOcgJ9wCCIbYFH9nv
 mzWPvN/52dIdghC4xsPi6OZPuPXJtDCRXYf3JeR8vhGj+/DTuxz+IED1lzma7grrw4Yd
 JXmw==
X-Gm-Message-State: APjAAAWF66Wn0US38aqBeDS0TN1VWlomC07yZsRIPzNcAfQb5DwdsOhg
 NqnGfjKzD0RSe1fLMXJdtpEvrw==
X-Google-Smtp-Source: APXvYqw+G7Qdg+wUqZx2e3qBUbRkCQ2s1NExo4zm2j3AjrIwRzdjld4n/pjO0bX1Pokqjp6W0FR+3w==
X-Received: by 2002:a5d:4d4c:: with SMTP id a12mr2018839wru.343.1565199348523; 
 Wed, 07 Aug 2019 10:35:48 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id u13sm3498266wrw.45.2019.08.07.10.35.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:35:47 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b8a42bb2-829f-e330-3135-d4d128b3e5be@redhat.com>
Date: Wed, 7 Aug 2019 19:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807045335.1361-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 10/11] target/arm: Use unallocated_encoding
 for aarch32
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
> Promote this function from aarch64 to fully general use.
> Use it to unify the code sequences for generating illegal
> opcode exceptions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.h     |  2 --
>  target/arm/translate.h         |  2 ++
>  target/arm/translate-a64.c     |  7 -------
>  target/arm/translate-vfp.inc.c |  3 +--
>  target/arm/translate.c         | 22 ++++++++++++----------
>  5 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
> index 9cd2b3d238..12ad8ac6ed 100644
> --- a/target/arm/translate-a64.h
> +++ b/target/arm/translate-a64.h
> @@ -18,8 +18,6 @@
>  #ifndef TARGET_ARM_TRANSLATE_A64_H
>  #define TARGET_ARM_TRANSLATE_A64_H
>  
> -void unallocated_encoding(DisasContext *s);
> -
>  #define unsupported_encoding(s, insn)                                    \
>      do {                                                                 \
>          qemu_log_mask(LOG_UNIMP,                                         \
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index de600073d8..6a65df0b27 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -98,6 +98,8 @@ typedef struct DisasCompare {
>      bool value_global;
>  } DisasCompare;
>  
> +void unallocated_encoding(DisasContext *s);
> +
>  /* Share the TCG temporaries common between 32 and 64 bit modes.  */
>  extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
>  extern TCGv_i64 cpu_exclusive_addr;
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d68bfc66d3..9e1ffe9cfb 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -352,13 +352,6 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
>      }
>  }
>  
> -void unallocated_encoding(DisasContext *s)
> -{
> -    /* Unallocated and reserved encodings are uncategorized */
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> -}
> -
>  static void init_tmp_a64_array(DisasContext *s)
>  {
>  #ifdef CONFIG_DEBUG_TCG
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 5065d4524c..3e8ea80493 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
>  
>      if (!s->vfp_enabled && !ignore_vfp_enabled) {
>          assert(!arm_dc_feature(s, ARM_FEATURE_M));
> -        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                           default_exception_el(s));
> +        unallocated_encoding(s);
>          return false;
>      }
>  
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d6b0ab7247..2d447d4b90 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1285,6 +1285,13 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>  
> +void unallocated_encoding(DisasContext *s)
> +{
> +    /* Unallocated and reserved encodings are uncategorized */
> +    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
> +}
> +
>  /* Force a TB lookup after an instruction that changes the CPU state.  */
>  static inline void gen_lookup_tb(DisasContext *s)
>  {
> @@ -1315,8 +1322,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
>          return;
>      }
>  
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    unallocated_encoding(s);
>  }
>  
>  static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
> @@ -7638,8 +7644,7 @@ static void gen_srs(DisasContext *s,
>      }
>  
>      if (undef) {
> -        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                           default_exception_el(s));
> +        unallocated_encoding(s);
>          return;
>      }
>  
> @@ -9266,8 +9271,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              break;
>          default:
>          illegal_op:
> -            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                               default_exception_el(s));
> +            unallocated_encoding(s);
>              break;
>          }
>      }
> @@ -10955,8 +10959,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>      }
>      return;
>  illegal_op:
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    unallocated_encoding(s);
>  }
>  
>  static void disas_thumb_insn(DisasContext *s, uint32_t insn)
> @@ -11779,8 +11782,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>      return;
>  illegal_op:
>  undef:
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    unallocated_encoding(s);
>  }
>  
>  static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
> 

I wanted to suggest naming it gen_unallocated_encoding_exception() but
it is already used ~250 times, so no :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

