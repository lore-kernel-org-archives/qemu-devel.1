Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D555C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2F5214C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2F5214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvbHZ-0003OD-5u
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 01:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvbH6-0002Wd-5L
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvbH4-0003NU-7j
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:47:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvbH3-0003Mx-Ty
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:47:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so1090742wmf.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 22:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nT8CFJH0PbI6qES+XnXT2/ec7olOa95JWIULhILjm9I=;
 b=hrDRr6mVgMj6RI6CVHdFqKqfV+LfgqYy73/hwo0ZF09kmlDVqg0CPiR9p8x1HE3QcF
 dje9FZFlMiKKSd80+T4ksoKhh3ZJRWjmUTPRAwc9hLv0FhJb+OoIfeARs4F9yRUb/92U
 VunxEhlRVamZKEV1lNT4DHzm9/wlWjMDxsAr+9H5UYZSPikjA9R8hTHBbhBFBXjolhFA
 G00bMafwx8Okmsr+HJdUDX+MHDcpG43dwAt0cSxFKP5IHhkcQCFQvSqvzILoeps06hhX
 EJw0ouJmY/M+7PqwBxcAYd1z0kwFFsgBNXY/sRbtrjNyu8b87BJK9hLRcFmhgjMCwF/I
 KwFg==
X-Gm-Message-State: APjAAAWaknotgWnTb9roHKjEm/HwDg/d3QuImQV6rS5nlFS01JQxzVlH
 10JW3Q7f3cpkKxjuAeNeEa6LYg==
X-Google-Smtp-Source: APXvYqx2xq9N/UFlBQfxaQP25sq4rJYXWLBXvuvyImsrVX49W1rsBjqEDZfPOzl4XV3aLKl/3cgRIw==
X-Received: by 2002:a1c:c005:: with SMTP id q5mr1920839wmf.59.1565243259768;
 Wed, 07 Aug 2019 22:47:39 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id g7sm2085858wmg.8.2019.08.07.22.47.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 22:47:39 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f1eaba6a-6f7d-b37d-52d5-88f16dbaf871@redhat.com>
Date: Thu, 8 Aug 2019 07:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807045335.1361-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 01/11] target/arm: Pass in pc to
 thumb_insn_is_16bit
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
> This function is used in two different contexts, and it will be
> clearer if the function is given the address to which it applies.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 7853462b21..1f15f14022 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9261,11 +9261,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>      }
>  }
>  
> -static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
> +static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
>  {
> -    /* Return true if this is a 16 bit instruction. We must be precise
> -     * about this (matching the decode).  We assume that s->pc still
> -     * points to the first 16 bits of the insn.
> +    /*
> +     * Return true if this is a 16 bit instruction. We must be precise
> +     * about this (matching the decode).
>       */
>      if ((insn >> 11) < 0x1d) {
>          /* Definitely a 16-bit instruction */
> @@ -9285,7 +9285,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
>          return false;
>      }
>  
> -    if ((insn >> 11) == 0x1e && s->pc - s->page_start < TARGET_PAGE_SIZE - 3) {
> +    if ((insn >> 11) == 0x1e && pc - s->page_start < TARGET_PAGE_SIZE - 3) {
>          /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix, and the suffix
>           * is not on the next page; we merge this into a 32-bit
>           * insn.
> @@ -11824,7 +11824,7 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
>       */
>      uint16_t insn = arm_lduw_code(env, s->pc, s->sctlr_b);
>  
> -    return !thumb_insn_is_16bit(s, insn);
> +    return !thumb_insn_is_16bit(s, s->pc, insn);
>  }
>  
>  static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
> @@ -12122,7 +12122,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>      }
>  
>      insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
> -    is_16bit = thumb_insn_is_16bit(dc, insn);
> +    is_16bit = thumb_insn_is_16bit(dc, dc->pc, insn);
>      dc->pc += 2;
>      if (!is_16bit) {
>          uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
> 

