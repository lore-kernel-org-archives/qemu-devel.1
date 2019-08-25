Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529ACC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 16:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162AB2173E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqN6AGra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162AB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1vTl-000569-B1
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 12:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1vSx-0004dt-E2
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1vSw-00025A-Hj
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:34:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1vSw-00024d-Bc
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:34:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id g128so10461845oib.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oNCaMGvGREEX75/VlM9oLd59WHqau5CTCVkdJ7UYST8=;
 b=UqN6AGradN4wpWQtKIZWBpErunT3aJepMHtp5639fYp6pBinkShky3JbKw+vdlN8KQ
 9xB3ANNEKyjINCAAUyhinFnU+btZaZjU24kUkzN2PHVmdlX5Lhx24q/JFf4eUSvDgqtX
 Yem7qvM/9yIf/nPLJgVbl0Hk50NQjs+r9iWF4yl5T1Ywhjnlp3+PYbHo7EetDXjGv/e5
 usU4hBXBAewcE95TQayw/xmcvSYegK/XGqXa4Vzdw9QGF1XlXxHq/NqecKxjp7A0lYLy
 AzgOArsqXU2uIcmt+VPRIxuAbyuDnylvkuGH+XrgxTMZeeCLFDifEZox1Hjwr9y/fpE6
 oNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oNCaMGvGREEX75/VlM9oLd59WHqau5CTCVkdJ7UYST8=;
 b=aPjeJvvb0uGQ/e73+aFennFe2T7LEplhlzcrMeLyN6Pcxt+IyYm6AZT2yio+m7SLRa
 TGFx1ALAVcWMdln4XycyD62zh8826izUWHumfYXACP1rXOvuJtLP6fjD7ZwuSkbQfhxZ
 l97Xf1g7B/ovnynAP9EEIHL7KAFAumLXUYnRAXlrWpWdS+JNbYfBeJ7RTKnkmwm+EOab
 tbwvxBEJF0qezWNy87BwiY4Q6W88QSZaJBnDTKyFkl6TvEsWqtB/hMezuifTWzJOfYZD
 0A4UKbtbLR0gGskwIWn+T1fGaVWSq4mzomqECtYzUbT7BBD4gCHPxbYaLpve4wqAfwuF
 VoPw==
X-Gm-Message-State: APjAAAUT019OVybrZxC/PLnP1OscjuiIDTE43IZpw5Dl1fBaQgS5TelM
 lkkd5TkY5j21RYhUju/2KxurV/fp4AwPm2SI3Fy8bGfW0NY=
X-Google-Smtp-Source: APXvYqzjt12jIzRkjWSUU5hXJXhwfRIo7YrrnFvPNoL7w+PHjBROBXKXsYhMwmIi/mzEZ9yR+efxlxEIVv63ieJbsII=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr9045422oib.48.1566750845311; 
 Sun, 25 Aug 2019 09:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-42-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 17:33:54 +0100
Message-ID: <CAFEAcA9C7sKoR4HAOdWLt+Uz6i87tXsNRYD+zS2Trjeoq-tqYA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 41/68] target/arm: Convert TT
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 87 +++++++++++++-----------------------------
>  target/arm/t32.decode  |  5 ++-
>  2 files changed, 31 insertions(+), 61 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

