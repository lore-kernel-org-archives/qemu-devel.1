Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1447C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB6020693
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvO8akZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB6020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYC4L-00005p-Uy
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:13:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYC3b-00086q-R3
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYC3a-0001DP-UV
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:13:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYC3a-0001Bf-PB
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:13:02 -0400
Received: by mail-ot1-x344.google.com with SMTP id 107so14255378otj.8
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=aunJS4wmex7HPHE5PeWpmvBZom243rSsNdnUhZ4I23c=;
	b=BvO8akZ7APDTiXdo0k+VUuIcNpAMtrpwBOi01dlPeGy5m/RmkRA79DvGQTW2BcFYH9
	ArK0xh5BosmtRvW7wJHLZPe6Qi27rUmw4JpXRrj+5nGXMfv8roaTzgcKL5+0RMjnmuaM
	WUXgi4XohVhk2IxNZIc9X4VUtLhn99UjEbbTnXfSKwIL51/6SQWnj956r+/5me7hlZ5q
	uNQkFkQAu0YRZR5Fw8FxacY1OmnB0tCxA8qu7u8Dzx/WbgP6fqiLHyr07qQxy3W43cg4
	QL0LQmCLs7Rh4lBBvIf9HgDH8P/gworG9PXks3BOhlcsqIsdZESbT4qzeVT3HInWwhY9
	49hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=aunJS4wmex7HPHE5PeWpmvBZom243rSsNdnUhZ4I23c=;
	b=GxcAnN+SSlkojh8UL2HG8Ki/go+WiHJVr30Z/XEDprNaqQbewPiOW9fmm7cfh+48+B
	IQIlhrynPpTOTgisidkePKnGqFCmn2zR0DioXGrlP5uMqQ+Nb2HGncVMxoW6V+hs/srE
	jqrTX6q3Abgluv1BSeJtnoqLvzsAYzx8e0dmFC5gl+hIudV4qRcxKKr89moA2V2GVpXp
	55VS30poDfmhd4338LwI6lFW9BdbsR6Gqiut2Jab/544D/W/3FiK8x0mxXJq2VYRHNGe
	RCl981xZMLCL07GIQ/EK3/BuVncxvjnJ168kSmvWLuAwvfp1asQV+vUBIJg/G8iFq0wv
	7CQA==
X-Gm-Message-State: APjAAAXBdB/pNhMf8sf8DD+s+mqtZvKaofB8O+0cxmAu2HMvsjlOYJFh
	Whm7xE5IslWAN18TeHVKLpyRLKsTbNhV5/wiCun5IA==
X-Google-Smtp-Source: APXvYqwyNkLtX7HnLtH0glqdNViXy35Fc242DPhSGot0vF3aBvdDSKLFmEaS1iY8uP5MOUl/gK7UoGfxoFhXjO0bEM0=
X-Received: by 2002:a9d:193:: with SMTP id e19mr5187743ote.135.1559664781774; 
	Tue, 04 Jun 2019 09:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190604154225.26992-1-richard.henderson@linaro.org>
In-Reply-To: <20190604154225.26992-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jun 2019 17:12:50 +0100
Message-ID: <CAFEAcA9KzVZLg4NdXMzU4jyWkV8rMjoZVAo_odgWSQh=zOMpHw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] decodetree: Fix comparison of Field
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 16:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Typo comparing the sign of the field, twice, instead of also comparing
> the mask of the field (which itself encodes both position and length).
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 81874e22cc..d7a59d63ac 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -184,7 +184,7 @@ class Field:
>          return '{0}(insn, {1}, {2})'.format(extr, self.pos, self.len)
>
>      def __eq__(self, other):
> -        return self.sign == other.sign and self.sign == other.sign
> +        return self.sign == other.sign and self.mask == other.mask
>
>      def __ne__(self, other):
>          return not self.__eq__(other)
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This fixes the problems I was seeing with the VFP decodetree
conversion I was working on.

thanks
-- PMM

