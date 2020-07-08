Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0338C206E2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL7CjHVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0338C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEYP-00033C-A6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 14:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtEXn-0002cS-2z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 14:11:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtEXl-0002A0-Kx
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 14:11:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id b9so974478plx.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TdYTZaq4RLhS6fQOmMN7Y+vbOuuOd/OAkIv2LLg33hU=;
 b=qL7CjHVe8BtESXppMTXz95cL6pCXFiapXFtOJjCxwTNIq6t/s8uXorCDnqgvt4uhB4
 OAAAD7V+ruKz4pbwBmCqJz4NssKIKYQkpX7h3Y6Zui1KzH6VLo99dup6UqJ/BFEaXjf1
 z9zodIyhMk3gLKZdH7VYlnENbiLhL+FOPfop++v7jhl+oFoknbXPSEqDsLPNKUDCNeWt
 Zmyplr7x+sRq7/JJgi3ASo/Bb/Z+AVJHtJYff39t8qHJBnAjxhqqaVqr7hcRrBKcBawT
 GI75RlV6boGqLhVf0+i8Lm2K0LYYRn7IOKE2U5/M1XbGSx8l9m7LJpZjuB4JHTT7Fpvi
 gi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TdYTZaq4RLhS6fQOmMN7Y+vbOuuOd/OAkIv2LLg33hU=;
 b=XBnTNx+ojTXlEIOFsnrdNqQVNyH8rhiKsqbRxKYqqjMpjJiSStfp8gfaNBlAi6Frzg
 H5IEX0ZXnw54r0EAoNykzmCNRPabAkv5eMc8bHY8z/21xwdMQwB5kH+o/ooo/g79F2TY
 lCro+/FCuV41Pg66dx0cCJS3mUNmcBeYUcb18g5J4gLgBY6YYL+FKoVOLZujT8fUuI6X
 oTM79Me8ZpwWrNI2rHA62l/IvzxW9Zaq/1V4JHvIu6RTWQ9/m0eMT3XKgcSgadHEoapX
 TuYIG5ymd3NYbtVPCD8PSHGtpFKpGcmSVxeYq+WrkjaUzvaOpUzTiF/35js7FgqIsaeK
 i1aA==
X-Gm-Message-State: AOAM531NuPr49rdvYtntpUe4UEMt6jv/8VEQ1ktGMZBMdePpou9omooi
 C7EvHZZAdkKrqIEq4IFxeLwWE5chujueVKe6lwU=
X-Google-Smtp-Source: ABdhPJzh/zZ8PKjczumStoGPJ/kpn/3/LgVi31uwpIOHXVtb61XvDfTaOaRiOzKz7k8pFoHS0VMNKdGOuURXplEbLRA=
X-Received: by 2002:a17:90a:20e9:: with SMTP id
 f96mr10990016pjg.13.1594231899431; 
 Wed, 08 Jul 2020 11:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-4-jcmvbkbc@gmail.com>
 <ed5c1993-1aa9-1c53-9038-1b32b863deee@linaro.org>
In-Reply-To: <ed5c1993-1aa9-1c53-9038-1b32b863deee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 8 Jul 2020 11:11:28 -0700
Message-ID: <CAMo8Bf+iftK_QUR+jXMPmrfAhjbg9fUn+Qd0qt8Wuaq-W7O3ww@mail.gmail.com>
Subject: Re: [PATCH 03/21] softfloat: add xtensa specialization for
 pickNaNMulAdd
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 9:07 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/6/20 4:47 PM, Max Filippov wrote:
> > pickNaNMulAdd logic on Xtensa is the same as pickNaN when applied to
> > the expression (a * b) + c. So with two pickNaN variants there must be
> > two pickNaNMulAdd variants.
>
> "Is the same as"?
>
> I question the non-use of the infzero parameter.
>
> When infzero, (a * b) = (Inf * 0), which will produce a default QNaN.  Your
> sentence above would suggest that pickNaN is applied twice, so that if
> use_first_nan, the default nan is chosen above any nan within c.

Apparently the description it's wrong: only NaNs in arguments are
considered, default NaN produced as a result of (a * b) is never
chosen when c is NaN.

> In addition, is the invalid flag raised for (Inf * 0) + NaN?  Does that happen
> regardless of the use_first_nan setting, or does the whole operation short-circuit?

Flag setting happens regardless of which NaN is chosen.
I'll post v3 with a fix for this and additional tests.

-- 
Thanks.
-- Max

