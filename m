Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E289C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFC020678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqj6HqR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFC020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgcck-0006VT-CW
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 19:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgcc2-00062k-Ma
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:15:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgcc1-0000Tm-Rm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:15:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id t18so4105606wru.6
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=0KEqTBW8IThfIgfTAllVrjTbMErsnRaDZ7i00be4o1U=;
 b=sqj6HqR6XrErkJexByMtE2kyHrLHBF1dmavs6cJaDakVR7gjp+awvqafpPTGFvksau
 t1BPJdVeD1vQd2Nq/iNLq9mSRookoRab1Fc8Cuga3cJPsr1L1d+jKB2S+BO474lK9qNX
 5c5pZRmKK1Ar2cl3Xq7V0DdECrSVTnXsE84EPljal/Q0HnAd2+ZycmrNlEMQt6wOj8dk
 t6MxAAb0SdX4m8ns9O0MSUVzjkunGeyt1m2JevgJ2za8Id5zcdMrgT9r7FSE36ufBR2a
 Tgs61xqIVdOcc33gfo9f85mjvbg8KY/E6auHkLf1eqW1w8chQA88YEOzdINuDrF0mV82
 KN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=0KEqTBW8IThfIgfTAllVrjTbMErsnRaDZ7i00be4o1U=;
 b=lqsVccWWrJGRl34OQ39CvXkrkw33k3TY74NkytExHNwFXjhx4zK/1AxHyMhxiYQe1h
 Yu6v2qDyZ4XBn/jRFc5laHF4RIjF0SVZ0nzrwoUBfRirQqqZ3B81EZDx6Ixq2s88TtRZ
 cEn/Qpp8tgtfGZtEfiuFjwXIYMXaXpP3Wj+v+fBIZql68kxhF+rcc4TtWqYGh2JDkIJS
 pPnX/DII9rkrrGlXg8XT7ifoUq+H7Ppn0bqQle1+MMSePHVoBgESZGRSC8ti5Ky42Xlc
 2bq8iPW5ijb7ZCAzC7QLRfaJXaCEb6K8i+TaWdxtoF/kOE9W2G1ktx48idNlDHKZZ2gW
 Scdg==
X-Gm-Message-State: AOAM530Fa/MESXSl2aoNzdJ9McrubqE2ybbz+MiJFmOFB7FN15pkDgfO
 MPVmrN8lvXunpXnZr5ZZSQxDZoV+zYZKx3WO5mk=
X-Google-Smtp-Source: ABdhPJxuSzsYy1GsJ2t/ekkFe0lVz/n1PB4yKM+WX0Dq3eemqA8sNl0dgV/Y5bCsDAfXF6RYdk5lmVE22XYKmKpe64s=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr1512649wrm.93.1591226155835;
 Wed, 03 Jun 2020 16:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200603231330.5819-1-agrecascino123@gmail.com>
In-Reply-To: <20200603231330.5819-1-agrecascino123@gmail.com>
From: "Catherine A. Frederick / mptcultist" <agrecascino123@gmail.com>
Date: Wed, 3 Jun 2020 19:15:42 -0400
Message-ID: <CAMEuMr+k4+Mu37_RYd6F5fgsHyO21j2bWoNhehQ0XJPoS2G_XQ@mail.gmail.com>
Subject: Re: [PATCH v3] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=agrecascino123@gmail.com; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oh dear, I did it to myself again.

On Wed, Jun 3, 2020 at 7:13 PM <agrecascino123@gmail.com> wrote:
>
> From: "Catherine A. Frederick" <mptcultist@floorchan.org>
>
> Signed-off-by: Catherine A. Frederick <mptcultist@floorchan.org>
> ---
>  tcg/ppc/tcg-target.inc.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 7da67086c6..3cab56fe91 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -790,21 +790,25 @@ static inline void tcg_out_ext32u(TCGContext *s, TCGReg dst, TCGReg src)
>
>  static inline void tcg_out_shli32(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    tcg_debug_assert((c < 32) && (c >= 0));
>      tcg_out_rlw(s, RLWINM, dst, src, c, 0, 31 - c);
>  }
>
>  static inline void tcg_out_shli64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    tcg_debug_assert((c < 64) && (c >= 0));
>      tcg_out_rld(s, RLDICR, dst, src, c, 63 - c);
>  }
>
>  static inline void tcg_out_shri32(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    tcg_debug_assert((c < 32) && (c >= 0));
>      tcg_out_rlw(s, RLWINM, dst, src, 32 - c, c, 31);
>  }
>
>  static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    tcg_debug_assert((c < 64) && (c >= 0));
>      tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
>  }
>
> @@ -2610,21 +2614,27 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
>
>      case INDEX_op_shl_i32:
>          if (const_args[2]) {
> -            tcg_out_shli32(s, args[0], args[1], args[2]);
> +            /* Limit shift immediate to prevent illegal instruction
> +               from bitmask corruption */
> +            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
>          } else {
>              tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
>          }
>          break;
>      case INDEX_op_shr_i32:
>          if (const_args[2]) {
> -            tcg_out_shri32(s, args[0], args[1], args[2]);
> +            /* Both use RLWINM, which has a 5 bit field for the
> +               shift mask. */
> +            tcg_out_shri32(s, args[0], args[1], args[2] & 31);
>          } else {
>              tcg_out32(s, SRW | SAB(args[1], args[0], args[2]));
>          }
>          break;
>      case INDEX_op_sar_i32:
>          if (const_args[2]) {
> -            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2]));
> +            /* SRAWI has a 5 bit sized field for the shift mask
> +               as well. */
> +            tcg_out32(s, SRAWI | RS(args[1]) | RA(args[0]) | SH(args[2] & 31));
>          } else {
>              tcg_out32(s, SRAW | SAB(args[1], args[0], args[2]));
>          }
> @@ -2696,21 +2706,27 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
>
>      case INDEX_op_shl_i64:
>          if (const_args[2]) {
> -            tcg_out_shli64(s, args[0], args[1], args[2]);
> +            /* Limit shift immediate to prevent illegal instruction from
> +               from bitmask corruption */
> +            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
>          } else {
>              tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
>          }
>          break;
>      case INDEX_op_shr_i64:
>          if (const_args[2]) {
> -            tcg_out_shri64(s, args[0], args[1], args[2]);
> +            /* Same applies here, as both RLDICL, and RLDICR have a
> +               6 bit large mask for the shift value */
> +            tcg_out_shri64(s, args[0], args[1], args[2] & 63);
>          } else {
>              tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
>          }
>          break;
>      case INDEX_op_sar_i64:
>          if (const_args[2]) {
> -            int sh = SH(args[2] & 0x1f) | (((args[2] >> 5) & 1) << 1);
> +            /* Same for SRADI, except there's no function
> +               to call into. */
> +            int sh = SH(((args[2] & 63) & 0x1f) | ((((args[2] & 63) >> 5) & 1) << 1));
>              tcg_out32(s, SRADI | RA(args[0]) | RS(args[1]) | sh);
>          } else {
>              tcg_out32(s, SRAD | SAB(args[1], args[0], args[2]));
> --
> 2.26.2
>

