Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD388C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8412F21880
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8412F21880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv7Fg-00089f-Sw
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 17:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hv7FB-0007Hg-DL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hv7FA-00072M-Ak
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:43:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hv7FA-00071N-3Y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:43:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so89264006wrl.7
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 14:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IX6nPM56vk/25QrLXlB3ikR5cSVcOfF8itYoe/f7z7Y=;
 b=JQGUijjCy+h1SAzuG+ShIXYdW5Haz7LJIWUjXqMszh4RwhRKoItuIkbfAKtXVlpMR6
 T7aPEyOh6AIIDwkMPYAZjM58kxUIzQtg25nOd8WGmzMJgqJA3IiLcEsgEZdlxjz4Mitg
 WdSNZAii+LQukXLvcrV+eykCGnnKDfHNBYU95hM3sqz4An0M22xOFgSF2UyrUujvrhBR
 MsA6OlaaOU2LofOamtK5pfsg8+1cTqqYB+XzdngIFoo8DlduUO61L/SNxWt2RI4cZbJR
 6/kFuARfQyF0BSn0K+YZg8HlI767zczoB9mafRdUxUpfTpbcglVw89Wv2e+ehY7NiFE2
 RS1A==
X-Gm-Message-State: APjAAAUKX4tCKfCMELwBg0VX80OpoZwQQA2HgU1UrZxLQMG+7eirqEVO
 /vRrOw9xhqICtZ+YtYgqe/qPpw==
X-Google-Smtp-Source: APXvYqwzImpm9iTGfKHmmdH0gWqSE4XD0019SL5uT9rQUSMP/cCSrx3dqT9ldpHmzi40kviK0p31tw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr6447434wrq.340.1565127823211; 
 Tue, 06 Aug 2019 14:43:43 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id g2sm80116964wmh.0.2019.08.06.14.43.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 14:43:42 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <61c30a12-110b-7c89-3e29-3a34ac699358@redhat.com>
Date: Tue, 6 Aug 2019 23:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726175032.6769-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 12/67] target/arm: Introduce gen_illegal_op
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 7:49 PM, Richard Henderson wrote:
> Unify the code sequence for generating an illegal opcode exception.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate-vfp.inc.c |  3 +--
>  target/arm/translate.c         | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 4066b2febf..1b08930649 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
>  
>      if (!s->vfp_enabled && !ignore_vfp_enabled) {
>          assert(!arm_dc_feature(s, ARM_FEATURE_M));
> -        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> -                           default_exception_el(s));
> +        gen_illegal_op(s);
>          return false;
>      }
>  
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4738b91957..0f21ee9ce7 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1279,6 +1279,12 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>  
> +static void gen_illegal_op(DisasContext *s)
> +{
> +    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
> +}
> +
>  /* Force a TB lookup after an instruction that changes the CPU state.  */
>  static inline void gen_lookup_tb(DisasContext *s)
>  {
> @@ -1309,8 +1315,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
>          return;
>      }
>  
> -    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    gen_illegal_op(s);
>  }
>  
>  static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
> @@ -7631,8 +7636,7 @@ static void gen_srs(DisasContext *s,
>      }
>  
>      if (undef) {
> -        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> -                           default_exception_el(s));
> +        gen_illegal_op(s);
>          return;
>      }
>  
> @@ -9299,8 +9303,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              break;
>          default:
>          illegal_op:
> -            gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> -                               default_exception_el(s));
> +            gen_illegal_op(s);
>              break;
>          }
>      }
> @@ -10990,8 +10993,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>      }
>      return;
>  illegal_op:
> -    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    gen_illegal_op(s);
>  }
>  
>  static void disas_thumb_insn(DisasContext *s, uint32_t insn)
> @@ -11816,8 +11818,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>      return;
>  illegal_op:
>  undef:
> -    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    gen_illegal_op(s);
>  }
>  
>  static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
> 

