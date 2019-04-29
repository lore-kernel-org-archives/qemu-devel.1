Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70323C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3649C2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdNlNC5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3649C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8i7-0001m0-C5
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:00:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8gp-0001E9-OX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8go-0002Lq-Rr
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:59:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8go-0002LV-Mg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:59:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id n187so8712480oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nMcYSLSJTvYGMsLxJjeagRATBN4MalnwvSEOkwcaEoE=;
	b=RdNlNC5dOV5s2TXDE9DYD4B7Rr0fikxaSEOHbYPkDg6O76hu119g/mrX6+1KP3LESx
	HBfsDk78HeNhmvbsBwFCKkddG++BObjGkI8MXeAvZO6lUcxmoqSJ5q6wjeg6z0yp2Xp7
	R4OZjyZ86tDI8o8zPYB8cbwChOcV3Cy4h01Mgu7chSTROMcvlOsMk/Ld5cXUqaHgvnc9
	aGN0P3oTJ9BNtKv86M7GG11fA16OupaTT9MT3fg4qFZCn23+LLv4wT8E3S+5L7Uf7PM4
	9gGiWQjFzapYk6vXyxTDW0DOpF8GVF1htsjtT+4/t2bp6e547lk2BnMNkaNdVSKwC/so
	SoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nMcYSLSJTvYGMsLxJjeagRATBN4MalnwvSEOkwcaEoE=;
	b=Ypyvqct6cXzmmINv1t19mzMACBngbQIV/edf3ikWbCrEGaxG3AVjME4TBFVjBu9Lwp
	ZJkUjlc9B3k/tUAdmlmUCL3S7w/MtlA2BxNiqhre4XBE4MEJHksJL8EaePtCXAJ77l1L
	Bdop9WBfDH/MYET/UpaMu72B5wV5YALAv5RuGNNTYMjNvHdJdvvkn7VRWTLANN1VMQk6
	f8Cd3Cj+Xs879klMhPfmiWWpVxgts+zXb4g+J6RicOgsoaOQ3PU/d3MAFGLzG2qVB4Em
	O2RDUlsvJORSlMhxgJebZ4iBAv1pbcKVK9mnu8NS68Y10KhaVkjZ2OPY01PdwUU4PT2W
	/gmA==
X-Gm-Message-State: APjAAAX9zMyuEgOFsDeDi+pagSjKsMNKUMpleVnp9jNSIc7lX9/mFyeZ
	a0dM+0Q53UMeVyi0t6tcDR8xht0yJrx/m2OneqDpog==
X-Google-Smtp-Source: APXvYqz+zrxpS5hWAyPpyVG4KLv5uEBXJRbcd1dxq56hSnU4y8ECby4Ru/53GDlFBM2hVSqb0KRc2wUDQUehopgCTdA=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr4108797oie.48.1556553573986; 
	Mon, 29 Apr 2019 08:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-2-richard.henderson@linaro.org>
In-Reply-To: <20190330005900.17282-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:59:22 +0100
Message-ID:
 <CAFEAcA_LuA8qU4YLHrJrB-Hick9Eyg9eAWhV_uBRyG4n19YVXA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v4 1/4] linux-user/aarch64: Reset btype for
 syscalls and signals
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429155922.kTNr0_JK7bbvDO19jBlyKlOrDqCt4RhkKq6kKhND0Pc@z>

On Sat, 30 Mar 2019 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The value of btype for syscalls is CONSTRAINED UNPREDICTABLE,
> so we need to make sure that the value is 0 before clone,
> fork, or syscall return.
>
> The value of btype for signals is defined, but it does not make
> sense for a SIGILL handler to enter with the btype set as for
> the indirect branch that caused the SIGILL.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

