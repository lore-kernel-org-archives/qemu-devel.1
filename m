Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2AEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB25820645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB25820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIw8B-00038L-4L
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:10:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw2g-0006ra-Ou
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvrj-0006Kc-HF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:53:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIvrj-0006Io-Ao
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:53:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so20321218wre.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=q5FuXSXPJOgWOx6UkEnZd5i7FYtvm69q2cxg/WGmmSg=;
	b=acfoQlG9WNdrTANuGXK97UuQT2ddjVUKYliqLl8K9EGgWiO6aRhPO6qDdzb6P3iV3J
	e/PJ11Z8VEHA0o83ph1dZxXhmNPrMCqD5vzRb+pObeQzydZ35ZueAsfbWL+ULidfSBD4
	1CIEuOYyhCyi17yQQQ8vMEKBB/28PdmZSrKenoeMtTtk2RbrRwGcJZ6SnwkkDZmWISc1
	zxU3b8+ZOoaOwNwztyB9oVFjxBYGsurEjMkxxAALddDmWAa3Dt7gbdZFhVT/w47fkb+s
	A/Fx/zLkt8MpcgwG4Ibg1BKPaSRsnImLMTwRtOOCBysYLPeHPRi60VaV4WnCj0281bqg
	Xhfw==
X-Gm-Message-State: APjAAAWpgmcCHNs2Uu7FrG3LH+Z19HYj6+oo4PgcePiTSeK359gv4dHd
	d6y+sHx4KEewzI1bEaNMBvlwwQ==
X-Google-Smtp-Source: APXvYqxUyJWfE3OLgIe9OgiUM1gYMfLOFREgrUCtpDJtHMpXGGjJZJHBUYOhZMwN+UsUG59XtIy1sQ==
X-Received: by 2002:adf:e683:: with SMTP id r3mr17852827wrm.286.1556027622341; 
	Tue, 23 Apr 2019 06:53:42 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	l12sm16486134wrt.31.2019.04.23.06.53.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 06:53:41 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556018982-3715-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <132f9a99-412b-666e-b37c-4232d8525ab1@redhat.com>
Date: Tue, 23 Apr 2019 15:53:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556018982-3715-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 5/8] target/mips: Clean up dsp_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423135340.tiWAInVlD0t1KSRRTSU5AawSf7c9aXXHBv9iR7SSDLg@z>

On 4/23/19 1:29 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove several minor checkpatch warnings and errors.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/dsp_helper.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
> index 739b69d..8c58eeb 100644
> --- a/target/mips/dsp_helper.c
> +++ b/target/mips/dsp_helper.c
> @@ -22,8 +22,10 @@
>  #include "exec/helper-proto.h"
>  #include "qemu/bitops.h"
>  
> -/* As the byte ordering doesn't matter, i.e. all columns are treated
> -   identically, these unions can be used directly.  */
> +/*
> + * As the byte ordering doesn't matter, i.e. all columns are treated
> + * identically, these unions can be used directly.
> + */
>  typedef union {
>      uint8_t  ub[4];
>      int8_t   sb[4];
> @@ -1445,9 +1447,15 @@ target_ulong helper_precr_ob_qh(target_ulong rs, target_ulong rt)
>      return temp;
>  }
>  
> -#define PRECR_QH_PW(name, var) \
> -target_ulong helper_precr_##name##_qh_pw(target_ulong rs, target_ulong rt, \
> -                                    uint32_t sa)                      \
> +
> +/*
> + * In case sa == 0, use rt2, rt0, rs2, rs0.
> + * In case sa != 0, use rt3, rt1, rs3, rs1.
> + */
> +#define PRECR_QH_PW(name, var)                                        \
> +target_ulong helper_precr_##name##_qh_pw(target_ulong rs,             \
> +                                         target_ulong rt,             \
> +                                         uint32_t sa)                 \
>  {                                                                     \
>      uint16_t rs3, rs2, rs1, rs0;                                      \
>      uint16_t rt3, rt2, rt1, rt0;                                      \
> @@ -1456,8 +1464,6 @@ target_ulong helper_precr_##name##_qh_pw(target_ulong rs, target_ulong rt, \
>      MIPSDSP_SPLIT64_16(rs, rs3, rs2, rs1, rs0);                       \
>      MIPSDSP_SPLIT64_16(rt, rt3, rt2, rt1, rt0);                       \
>                                                                        \
> -    /* When sa = 0, we use rt2, rt0, rs2, rs0;                        \
> -     * when sa != 0, we use rt3, rt1, rs3, rs1. */                    \
>      if (sa == 0) {                                                    \
>          tempD = rt2 << var;                                           \
>          tempC = rt0 << var;                                           \
> @@ -1965,7 +1971,8 @@ SHIFT_PH(shra_r, rnd16_rashift);
>  #undef SHIFT_PH
>  
>  /** DSP Multiply Sub-class insns **/
> -/* Return value made up by two 16bits value.
> +/*
> + * Return value made up by two 16bits value.
>   * FIXME give the macro a better name.
>   */
>  #define MUL_RETURN32_16_PH(name, func, \
> @@ -3274,11 +3281,15 @@ target_ulong helper_dextr_l(target_ulong ac, target_ulong shift,
>                              CPUMIPSState *env)
>  {
>      uint64_t temp[3];
> +    target_ulong ret;
>  
>      shift = shift & 0x3F;
>  
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> -    return (temp[1] << 63) | (temp[0] >> 1);
> +
> +    ret = (temp[1] << 63) | (temp[0] >> 1);
> +
> +    return ret;
>  }
>  
>  target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
> @@ -3286,6 +3297,7 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
>  {
>      uint64_t temp[3];
>      uint32_t temp128;
> +    target_ulong ret;
>  
>      shift = shift & 0x3F;
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> @@ -3305,7 +3317,9 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
>          set_DSPControl_overflow_flag(1, 23, env);
>      }
>  
> -    return (temp[1] << 63) | (temp[0] >> 1);
> +    ret = (temp[1] << 63) | (temp[0] >> 1);
> +
> +    return ret;
>  }
>  
>  target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
> @@ -3313,6 +3327,7 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
>  {
>      uint64_t temp[3];
>      uint32_t temp128;
> +    target_ulong ret;
>  
>      shift = shift & 0x3F;
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> @@ -3338,7 +3353,10 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
>          }
>          set_DSPControl_overflow_flag(1, 23, env);
>      }
> -    return (temp[1] << 63) | (temp[0] >> 1);
> +
> +    ret = (temp[1] << 63) | (temp[0] >> 1);
> +
> +    return ret;
>  }
>  #endif
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

