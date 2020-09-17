Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B155C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7922075E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7pww15Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7922075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpXE-0001Zx-Pj
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIpWY-00012k-09
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:44:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIpWV-0000Ie-Ai
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:44:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so1133657wrv.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=I+pwgnpkj56d7gdUixPSwknpD7B6sGS5HCnPB2RrnTc=;
 b=p7pww15Za380/prz3FG+EufMW7RcJOHZgOQRXpasGwqljJ9HkwrS+gSYxy2u1h2N7B
 /co0n8g3EKpOOdCmEy/nlaahwc3NS1ExsC6pQwZ5be6A7YPdSXv1QFOVkWbgtCMhXl+N
 8DND56qE2p8UWrkYXUrJVp5c3ec/4VcWkQKzEISo9T5jU5ruU/IeDGJtvFTDVvylhDTC
 OqcQ9J5jLk05RT0wpwP/wbhlZbjlkPbjSE4rLrVwEFsjIKQuTBUGqTLPi9Y5N5EVJq8N
 jcS2KrMHmbiTXEK3EIiQxkjNkrsTIsGqfn1b5Rqx4HMDbmKVEv69FGzkH/9P24alcnih
 EOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=I+pwgnpkj56d7gdUixPSwknpD7B6sGS5HCnPB2RrnTc=;
 b=BXZtlwcA7lLscX3LJamNVUhBvIii+yph3mqln0Vs4AUSZBn3wwhB2oVCMwu/WWpxyX
 wbTR522nOylB6io910wfQYdexfbKl2zsJNlZeBpckM39silCC6Mkj7frlYz9BUiFXt5+
 qOGQC6Oi9xtlUsfrPRijKR6UhA436aRt8282bZFqjWi6A06jlbxSdWHDZwgzQMvqFY1x
 NddBQLvfcOmMFM+uKa0fIERJscpL7kIesa0DYJ5caNQultLtDinhs6MFxBrTXMrvZsyo
 JObHLRUyyxzBe2zpEdcBGf7iuJwUwUY2l3VFcyNBSe/r0AWqcePCdS5VByiX/Tkcst7k
 c3yQ==
X-Gm-Message-State: AOAM532+MqFgms4i6OjoUEDvf0KsNBku2MvTvZSRsFfj26Mc2GmGCZbC
 yFehs0Y64Zr/BcIR3F96sguG0g==
X-Google-Smtp-Source: ABdhPJzxC61hhUltYQMi2x4zUJqEyjf8btGRoUYPYHhk/nbm2wNmxQowwZgbCUctHEK90mWmtBW2Vg==
X-Received: by 2002:adf:b602:: with SMTP id f2mr29649230wre.186.1600332249728; 
 Thu, 17 Sep 2020 01:44:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 70sm10414212wme.15.2020.09.17.01.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 01:44:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B3BF1FF7E;
 Thu, 17 Sep 2020 09:44:07 +0100 (BST)
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-9-zhaolichang@huawei.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: zhaolichang <zhaolichang@huawei.com>
Subject: Re: [PATCH V3 08/10] disas/: fix some comment spelling errors
In-reply-to: <20200917075029.313-9-zhaolichang@huawei.com>
Date: Thu, 17 Sep 2020 09:44:07 +0100
Message-ID: <871rj0ztbc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


zhaolichang <zhaolichang@huawei.com> writes:

> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the disas folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I suggest on your next posting you CC qemu-trivial@nongnu.org so the
patches can get pulled in via the trivial tree.

> ---
>  disas/hppa.c | 2 +-
>  disas/m68k.c | 8 ++++----
>  disas/ppc.c  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/disas/hppa.c b/disas/hppa.c
> index 2dbd1fc445..dcf9a47f34 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -2021,7 +2021,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info =
*info)
>  			fput_fp_reg (GET_FIELD (insn, 6, 10), info);
>  		      break;
>=20=20
> -		      /* 'fA' will not generate a space before the regsiter
> +		      /* 'fA' will not generate a space before the register
>  			 name.  Normally that is fine.  Except that it
>  			 causes problems with xmpyu which has no FP format
>  			 completer.  */
> diff --git a/disas/m68k.c b/disas/m68k.c
> index 863409c67c..aefaecfbd6 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -70,7 +70,7 @@ struct floatformat
>    unsigned int exp_start;
>    unsigned int exp_len;
>    /* Bias added to a "true" exponent to form the biased exponent.  It
> -     is intentionally signed as, otherwize, -exp_bias can turn into a
> +     is intentionally signed as, otherwise, -exp_bias can turn into a
>       very large number (e.g., given the exp_bias of 0x3fff and a 64
>       bit long, the equation (long)(1 - exp_bias) evaluates to
>       4294950914) instead of -16382).  */
> @@ -479,7 +479,7 @@ struct m68k_opcode_alias
>        and remaining 3 bits of register shifted 9 bits in first word.
>        Indicate upper/lower in 1 bit shifted 7 bits in second word.
>        Use with `R' or `u' format.
> -   n  `m' withouth upper/lower indication. (For M[S]ACx; 4 bits split
> +   n  `m' without upper/lower indication. (For M[S]ACx; 4 bits split
>        with MSB shifted 6 bits in first word and remaining 3 bits of
>        register shifted 9 bits in first word.  No upper/lower
>        indication is done.)  Use with `R' or `u' format.
> @@ -854,7 +854,7 @@ fetch_arg (unsigned char *buffer,
>=20=20
>  /* Check if an EA is valid for a particular code.  This is required
>     for the EMAC instructions since the type of source address determines
> -   if it is a EMAC-load instruciton if the EA is mode 2-5, otherwise it
> +   if it is a EMAC-load instruction if the EA is mode 2-5, otherwise it
>     is a non-load EMAC instruction and the bits mean register Ry.
>     A similar case exists for the movem instructions where the register
>     mask is interpreted differently for different EAs.  */
> @@ -1080,7 +1080,7 @@ print_indexed (int basereg,
>=20=20
>  /* Returns number of bytes "eaten" by the operand, or
>     return -1 if an invalid operand was found, or -2 if
> -   an opcode tabe error was found.
> +   an opcode table error was found.
>     ADDR is the pc for this arg to be relative to.  */
>=20=20
>  static int
> diff --git a/disas/ppc.c b/disas/ppc.c
> index 63e97cfe1d..02be878198 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -5226,7 +5226,7 @@ operand_value_powerpc (const struct powerpc_operand=
 *operand,
>        if ((operand->flags & PPC_OPERAND_SIGNED) !=3D 0)
>  	{
>  	  /* BITM is always some number of zeros followed by some
> -	     number of ones, followed by some numer of zeros.  */
> +	     number of ones, followed by some number of zeros.  */
>  	  unsigned long top =3D operand->bitm;
>  	  /* top & -top gives the rightmost 1 bit, so this
>  	     fills in any trailing zeros.  */


--=20
Alex Benn=C3=A9e

