Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4295C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6E0208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTKcSQXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6E0208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDdW-0006rZ-GQ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJDas-00053n-Qp
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:26:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJDaq-000475-1V
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:26:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id w2so4803466wmi.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MhoWHUwgAV/GEwl4pYt0tRJ7V3kXWr5PLuEKr8XZQwg=;
 b=TTKcSQXijl1/qGBqKtE6e5zoQB+xtfQIRetJBTYU175XxePE5YuD/7QpCUY5DYAka9
 EIXIw3Fn7/ZHXoCzAQf8vsPUNkGMmXHRlIeDs6l11UfP29oMwYdv0NgJs8LqdfPken9Z
 e2rug4Stq++Nr3BGh16OcB61m7b6sq2kQJmx7v8+OpqUjryOiG5DX/HuS0tMKDprypbA
 /xl+Ghf0iVmJDRqHqt0nHvcosdfaW77rodP84YBstSv58LfgiGZwlxUaFoPMV7wW4vOd
 XPfaPhx3VmQAXt1fs898Q0E/5OHSOwz1aTL7Gets8yKyYF/3ykoXau90TSEL9WepVJIF
 nikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MhoWHUwgAV/GEwl4pYt0tRJ7V3kXWr5PLuEKr8XZQwg=;
 b=WvUuKHRJH3ZULVr0Q3YOAJ75cg7lEhzWYARiSpjU2c2qV4EtXMpcchtL/aINC31adn
 RkuAvbdlg/r9Rr1v3qoJWDe5onfgFWH10mb7egsmeXmIH7gFHs1kq5gG4bGpYqAXB4Mg
 6fi7snfSLWiLHNbdLNrQc7LuhjO8qKR0c7nmKGyJYjBulqNfeu8XzUQBxRzZNBaJuCUg
 NO0TakzhD3ook1Qw/izevovQQ7q37P2nCcpgL1JeJnOIwRviHv24Q0DbI++CjkyEas53
 oux0LLg2NFDyTZ6mNSGP4VHm44l4CqNTM6PWKaHDFYu/qY2NBAaJAw/G0CKFFxajUwom
 o6kg==
X-Gm-Message-State: AOAM533Cm2bm0iKa1N4TszPo+09WA/LjZSZ+1f7JLseyp7R+KaiPqC/P
 b6MMTfg8j8hBdv66Id1cw4eiXA==
X-Google-Smtp-Source: ABdhPJzvTqVbZuQMEBDMbOfMs1lgE5SKN4Ak6Ilh2+qrRkmh5gGcQmTNxv18Rb+lZlnTbcn7aryxTw==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr14788395wmc.35.1600424774168; 
 Fri, 18 Sep 2020 03:26:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l8sm4490234wrx.22.2020.09.18.03.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:26:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4CA801FF7E;
 Fri, 18 Sep 2020 11:26:12 +0100 (BST)
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-9-zhaolichang@huawei.com> <871rj0ztbc.fsf@linaro.org>
 <7bd9cc11-988f-47fc-ce08-2c159c763ea0@vivier.eu>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH V3 08/10] disas/: fix some comment spelling errors
In-reply-to: <7bd9cc11-988f-47fc-ce08-2c159c763ea0@vivier.eu>
Date: Fri, 18 Sep 2020 11:26:12 +0100
Message-ID: <87wo0rwfcr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: qemu-trivial@nongnu.org, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 17/09/2020 =C3=A0 10:44, Alex Benn=C3=A9e a =C3=A9crit :
>>=20
>> zhaolichang <zhaolichang@huawei.com> writes:
>>=20
>>> I found that there are many spelling errors in the comments of qemu,
>>> so I used the spellcheck tool to check the spelling errors
>>> and finally found some spelling errors in the disas folder.
>>>
>>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
>>=20
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> I suggest on your next posting you CC qemu-trivial@nongnu.org so the
>> patches can get pulled in via the trivial tree.
>
> It was.
>
> Applied to my trivial-patches branch.

I must be going blind, so it was. Thanks.

>
> Thanks,
> Laurent
>
>>=20
>>> ---
>>>  disas/hppa.c | 2 +-
>>>  disas/m68k.c | 8 ++++----
>>>  disas/ppc.c  | 2 +-
>>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/disas/hppa.c b/disas/hppa.c
>>> index 2dbd1fc445..dcf9a47f34 100644
>>> --- a/disas/hppa.c
>>> +++ b/disas/hppa.c
>>> @@ -2021,7 +2021,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_inf=
o *info)
>>>  			fput_fp_reg (GET_FIELD (insn, 6, 10), info);
>>>  		      break;
>>>=20=20
>>> -		      /* 'fA' will not generate a space before the regsiter
>>> +		      /* 'fA' will not generate a space before the register
>>>  			 name.  Normally that is fine.  Except that it
>>>  			 causes problems with xmpyu which has no FP format
>>>  			 completer.  */
>>> diff --git a/disas/m68k.c b/disas/m68k.c
>>> index 863409c67c..aefaecfbd6 100644
>>> --- a/disas/m68k.c
>>> +++ b/disas/m68k.c
>>> @@ -70,7 +70,7 @@ struct floatformat
>>>    unsigned int exp_start;
>>>    unsigned int exp_len;
>>>    /* Bias added to a "true" exponent to form the biased exponent.  It
>>> -     is intentionally signed as, otherwize, -exp_bias can turn into a
>>> +     is intentionally signed as, otherwise, -exp_bias can turn into a
>>>       very large number (e.g., given the exp_bias of 0x3fff and a 64
>>>       bit long, the equation (long)(1 - exp_bias) evaluates to
>>>       4294950914) instead of -16382).  */
>>> @@ -479,7 +479,7 @@ struct m68k_opcode_alias
>>>        and remaining 3 bits of register shifted 9 bits in first word.
>>>        Indicate upper/lower in 1 bit shifted 7 bits in second word.
>>>        Use with `R' or `u' format.
>>> -   n  `m' withouth upper/lower indication. (For M[S]ACx; 4 bits split
>>> +   n  `m' without upper/lower indication. (For M[S]ACx; 4 bits split
>>>        with MSB shifted 6 bits in first word and remaining 3 bits of
>>>        register shifted 9 bits in first word.  No upper/lower
>>>        indication is done.)  Use with `R' or `u' format.
>>> @@ -854,7 +854,7 @@ fetch_arg (unsigned char *buffer,
>>>=20=20
>>>  /* Check if an EA is valid for a particular code.  This is required
>>>     for the EMAC instructions since the type of source address determin=
es
>>> -   if it is a EMAC-load instruciton if the EA is mode 2-5, otherwise it
>>> +   if it is a EMAC-load instruction if the EA is mode 2-5, otherwise it
>>>     is a non-load EMAC instruction and the bits mean register Ry.
>>>     A similar case exists for the movem instructions where the register
>>>     mask is interpreted differently for different EAs.  */
>>> @@ -1080,7 +1080,7 @@ print_indexed (int basereg,
>>>=20=20
>>>  /* Returns number of bytes "eaten" by the operand, or
>>>     return -1 if an invalid operand was found, or -2 if
>>> -   an opcode tabe error was found.
>>> +   an opcode table error was found.
>>>     ADDR is the pc for this arg to be relative to.  */
>>>=20=20
>>>  static int
>>> diff --git a/disas/ppc.c b/disas/ppc.c
>>> index 63e97cfe1d..02be878198 100644
>>> --- a/disas/ppc.c
>>> +++ b/disas/ppc.c
>>> @@ -5226,7 +5226,7 @@ operand_value_powerpc (const struct powerpc_opera=
nd *operand,
>>>        if ((operand->flags & PPC_OPERAND_SIGNED) !=3D 0)
>>>  	{
>>>  	  /* BITM is always some number of zeros followed by some
>>> -	     number of ones, followed by some numer of zeros.  */
>>> +	     number of ones, followed by some number of zeros.  */
>>>  	  unsigned long top =3D operand->bitm;
>>>  	  /* top & -top gives the rightmost 1 bit, so this
>>>  	     fills in any trailing zeros.  */
>>=20
>>=20


--=20
Alex Benn=C3=A9e

