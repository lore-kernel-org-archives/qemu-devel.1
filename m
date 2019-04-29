Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D0DC004C9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501CC205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLZ/INcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501CC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7e2-0004Uf-EX
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:52:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7dG-0004Ar-7G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7dF-0005XY-D1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:51:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7dF-0005X7-7K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:51:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id t189so5476720oih.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=foNJIiC25jo1dMbSqBE20eM3xnqucdEIyPB2E+dJnuw=;
	b=pLZ/INcWnWvX20yPHWidBiNltVULZcvxqsDphvdJBrTa/ZGWTENXSSYeFNtef4TCcq
	oCKeWep0hq8UnNLquMcG52VpqGu/BVc6QuWzu4j4HyeF0Tow/wmoQmi4DcLUdhBLQjve
	LM4p707PIXNqYEXJKTSs16ieTsQT7KR+ZccYjU9e+1UxBJhWSpwDW/ia+2H1gzz9rq7e
	4chyNWg6Bgl3XTr97Rqb07e/4leZSb8JlU3lllc3PLupBBSMC1ScNDkJP1tXhEcrNDKi
	NGVkvWM2lxZJam0djIErikq+CYUnS4kZimxMR+eRIPxWSspKtTevAyxwJdykkTYkR9cI
	5elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=foNJIiC25jo1dMbSqBE20eM3xnqucdEIyPB2E+dJnuw=;
	b=q6kKzMYX+jpgs2auU0MiqV5U0aQBpchzUrvLzCHD3QqrHpLspQuPM6VpPBnneCXLPU
	xMu8HyvR/1AMgfac3uj18z5LhUHqeza3+Hi9J8F5PVBvONbKenf+qQXmDmxhPenBEZX9
	MKq7daLVnA1c96MQL4NbBcfCAArKNVkzrqcgNo1cD1ETvBVW6HfyUqtTzFXtNyA4cAnY
	PVAG08qSLaBpFcXVeheDFcDPYjMNy5slQNJmKPKnjvBMLUWhaJei/w6lR/Nesc8QMo84
	OWS8xfxYUtpzhQTIuct8Ns15d1KFon/G7nvXPtHSJWdbuUlcudFlPkhnapaqJ1ToYP7p
	z0Og==
X-Gm-Message-State: APjAAAVREQoOc8I9hkMg+c7LMQ8UuXvRvSi5wK2pYySpKqbYvOESLWZY
	96/Ng/xmuLbuH0fXukEUzC/RjaBcKoh0oOY3xNciCA==
X-Google-Smtp-Source: APXvYqxjnBwUiHQZhhm/YF+spxKbn2eGqjJPgYT6fHeb17rncBYyr6N4Lw7g5Pr4OgVhxMh28dXe1IICLhZGWX610yA=
X-Received: by 2002:aca:e054:: with SMTP id x81mr15881733oig.146.1556549508229;
	Mon, 29 Apr 2019 07:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-35-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:51:37 +0100
Message-ID:
 <CAFEAcA_KM-rLtPvrHNNfF=FO91fBZbDD2J2j9kAqWwNC6TAQ6w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 34/36] cpu: Remove CPU_COMMON
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
Message-ID: <20190429145137.wJtG0wBoslYmRBYc8kxKwMKK0kqGQ9rjPyg4nXBfLNI@z>

On Thu, 28 Mar 2019 at 23:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This macro is now always empty, so remove it.  This leaves the
> entire contents of CPUArchState under the control of the guest
> architecture.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

