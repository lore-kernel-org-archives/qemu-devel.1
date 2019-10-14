Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48993C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194A220854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLG1zSqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194A220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4E9-0008MU-3b
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK4CD-0006ck-Ag
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK4CB-0002Mq-RM
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:31:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK4CB-0002MS-Mk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:31:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id g13so14465226otp.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+PylkFAinNF/+YOsbRGioXqyOk0p+MLPCh1W7xQRoRM=;
 b=MLG1zSqDtP4fACFhNnkKo8QiCn7E66NJ4T6WmRs7EKrvRVXtKW7GbU3M/zxq68usyw
 l5tzAJ9jULG1TW/LwHcd+fyByDvEsVqdMku0SwTXGiH/Ztq6ky2WXbD5wsVbkfUgLHjC
 psj2HJR8WgCie0mG3IVutj/jW3vmTXaot4QrMLNcQm/X+9APESnunp5tlob94U+wNlj4
 ufN/JyXfvYOt/y5ceGKeQNbHSxot2iktQnsR7DaQZj71F1Px1vNFVxvjqbw3p0VlHQzX
 8sExOCwmYQzgGuC/AxQyzfKy/6/0z6tY9Ch3UmnH3qCLMIfF9UdP6s2jACOzLRMPnQv6
 JiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+PylkFAinNF/+YOsbRGioXqyOk0p+MLPCh1W7xQRoRM=;
 b=MEYNKeUSlC+FcQcmTI0ZyREEaNHakbVbvVYXsvT+oBCvfSkxyjWwLYaR9LRazEh6uZ
 eBe59mBpAv7XkMCVneG4jBy/YXp1Mq2+PfGDyKJkJzsAFq6xBRMxZjtBdZCPxYW4omEc
 7REFVN4YITP0CR+o760lWzznCYJ4tC/Dgmz2+bFvb//yAz+OkEyWxmxnWz99JRB9cHXS
 CsUVX3odNj1cAWcjIuGSJ4Xt/ByUwsHqfY1oll5wuDewRru1Us+8fl5Fc2BbIAi9y+7P
 YZ93SyajBpfyF4DUKEFE0SeeIah33GZUSVPjZMqpUGDohzDiqyvbUxjarFU5cIikxAyf
 ZofA==
X-Gm-Message-State: APjAAAXN5l0AA1bPcDnLcPF9bWC+VtPj57zzwPe5Wcc+u1Kp2cBqIdUh
 +uepokcyN9ZmnBuy2qVGS1rD7IcYESwrNIosAaDRog==
X-Google-Smtp-Source: APXvYqyQzAPxg/5grI9rfk0IzZIC7EfJcDOs+Y6bz8IfdoliGf+xCs4390rcXXzxpJYyJ+phRGuOOzoh+Nt+QVkQuFM=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr23902709oto.221.1571074306488; 
 Mon, 14 Oct 2019 10:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-24-alex.bennee@linaro.org>
In-Reply-To: <20191014104948.4291-24-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 18:31:35 +0100
Message-ID: <CAFEAcA-PJ8V4to4SKu6PXZH6yFkrQ7FJBZR=2O-fJFoZgEq=TQ@mail.gmail.com>
Subject: Re: [PATCH v5 23/55] translator: add translator_ld{ub,sw,uw,l,q}
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.puhov@futurewei.com,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 12:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> From: "Emilio G. Cota" <cota@braap.org>
>
> We don't bother with replicating the fast path (tlb_hit) of the old
> cpu_ldst helpers as it has no measurable effect on performance. This
> probably indicates we should consider flattening the whole set of
> helpers but that is out of scope for this change.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: directly plumb into softmmu/user helpers]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index a38659ea5b..302533b463 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1317,6 +1317,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, targ=
et_ulong addr,
>  # define helper_ret_stl_mmu   helper_be_stl_mmu
>  # define helper_ret_stq_mmu   helper_be_stq_mmu
>  # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
> +# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
>  # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
>  # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
>  #else
> @@ -1330,6 +1331,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, targ=
et_ulong addr,
>  # define helper_ret_stl_mmu   helper_le_stl_mmu
>  # define helper_ret_stq_mmu   helper_le_stq_mmu
>  # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
> +# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
>  # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
>  # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
>  #endif

This looks odd. Why is it ok to define a 'lduw' helper
as the 'ldw' cmmu helper ? One ought to be sign
extending and the other not...

thanks
-- PMM

