Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA76C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840BB20652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ul4Rrw20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840BB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL73R-0007PP-JN
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:14:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL723-0006er-8v
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL722-0001tR-HO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL722-0001sT-8C
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so8688674otk.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=KGS6nLGjRyQRSPCoMcorrfjk0TzCnufb7G0lr4c5UXw=;
	b=Ul4Rrw20x41ydUugsrn+or//mLxa9C36VoLQm4JcqFkjQxoQVTMtY1bYVtvE9YBsMn
	BXN2O28c/1HyExTIeZDgqe4Okl/6TNkZpITvJDiP+N4xZUn3c8q6i4QbX1xRy3UIGAG3
	CLNKWzX/FL8oQccq6FL7BDarefcCgNymrNKDrP6oOxobJgJ2+Bdhq1uha0wfWoPafbSn
	UU9Fkfei0NTpwD4Ykku4UfsT/QaUOAzgH+Ldd8rlB2a5uJytN2fAWBVJUzHXCjt5Kz8c
	usUk1gklt4kOAeFva5IHXB+UNjmGYdxWuCbes0B7WuUV3mvamDlRwjyQvq3T4lbzXwem
	bfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KGS6nLGjRyQRSPCoMcorrfjk0TzCnufb7G0lr4c5UXw=;
	b=WI4dJdvJImREs1IRWFt9x5xxWQy8xfejKBEJKvQTFRaQkkqSXdqT0VcLpI7feOP5MJ
	tcOwCoguVW8iYU569JPLsZGrmbozVEu8fDcqLkEMx+dg+Pvh9C+CzmV05/+q4zdhGQxT
	5EYpo78/gFLlyglqB85SGqvxS4Xpzbo1akBKGkioI+Dpg3z1D4LyVm/qb702oqvU5/m2
	rBAeIKLJAvc2qMp0r7xWky7va4jAol0dLUYQRIUDyOD695cg2NfZmQaUlMkSdVAyl2OV
	ISJREmCX1x8sv4Y4z3oW0/QGaQVx8+YYgcVXmWCB/Lxuv+zRV/dsE1/Q6Tm/XRHSK2rd
	c+vQ==
X-Gm-Message-State: APjAAAWhhcwh4jFEkiqXfXt0XM5ZGJdlpBqlOehC4Hp4UaCyW/wk+tL+
	4sTJ+vYlP5zD2WaiKV6FaOQhwYulD/ND6OkVFJcPzg==
X-Google-Smtp-Source: APXvYqys4gSTT2aDP1SiVTBh7SOCJD9FnRxA8iwtV/K5li4zh1y3DTQ0gMOFp88sDbtmJhtVFNVfW+T+mgo5Ebd2EC8=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr8661334otk.363.1556547201382; 
	Mon, 29 Apr 2019 07:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-13-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:13:10 +0100
Message-ID:
 <CAFEAcA_uC6mHb2p1cM=UxW7sXhmJGHi3f_aCtyakwSi9g_f2Rg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 12/36] target/i386: Use env_cpu,
 env_archcpu
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
Message-ID: <20190429141310.t8CRiScYpTZM1dTPGn0wCQvP8T1J7uWsagnnKRwqk00@z>

On Thu, 28 Mar 2019 at 23:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Combined uses of CPU(x86_env_get_cpu()) were failures to use
> the more proper, ENV_GET_CPU macro, now replaced by env_cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

