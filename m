Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6EC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7963320679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urDcK7gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7963320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDMu-0004K7-K5
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxDMO-0003nt-Vw
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxDMO-0006ap-4L
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:39:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxDMN-0006aS-VJ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:39:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id k18so29076216otr.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=22ACQm0I/TMpU8Y4cYRjIH02JqCCteh4p73DvdIam8U=;
 b=urDcK7gvcUQbH076Qln8AY6ZJHFmXi0mhVeTaunX41LhgBPIIBKLN1x/5xgxXzwbs4
 G9GJQWuPqq2KwrS38knRksNt11Hclp/J6zAhWne5iaZIlPNGuGU04FBkXbY6rMAhmnQc
 28dSH5QgTDARaeNIY/4TTfTACEbZiqlatmpjYt0j1I5PlB4q5L9mQNH7+ZrHZIxYYcX+
 7CwKM3Rft6r0HFpwNh4yo89j031uJSj3Hasm1yFBD0LXUOyO7GQN5HfmboBweNe2CPH7
 j5yLkgg3d4gNhiNCAnXQsOKQXrOvzkUMVjO00lM3Uui6A29k4KVnjN/naDlLKkGdTbR8
 cQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=22ACQm0I/TMpU8Y4cYRjIH02JqCCteh4p73DvdIam8U=;
 b=fPOkNfMw6T5Cs5F0HrU8vX5TdWn/I/JjNcqC9l9sjhOtzeo7Yc8F6CAJVsWYA3VBEO
 DVW6NlgILxKT9JiR40UxOJoP3ac1fUDDkRwyyW2kIBb7EwBUx7i1to6/JzKCFDgSwX15
 mRyoyGstUeCFmKUkAc2cFaSL2qtJ3zBG7esqkNU01QsA01SmfPJXhxXpT0yRuFUvhTd0
 lCnmYiySuV1akg+JtIDUTYrbCzf5a3o42CFr0CzGApT6vTmAPv+XZBAOWfrMTo+ZXjGt
 zEjfrCj0awY+V7AMa6sLlkBnDGHzkF2A8g+n9sK9RvvFioGOJ9pdsOyLWp83ndfACBdN
 nisg==
X-Gm-Message-State: APjAAAXsW+xRAIbP/HBmKBYImiip2+Cf87xaEaRzoY3PuVyg4qsZ6eiI
 QHvHNTvBek5FqhzCW2D/8IvtNDmiuaW/Sh2fLvNTdA==
X-Google-Smtp-Source: APXvYqw+4qdH1h1rtRx38Jq5OlvBoaAzFVoZlfNcKR/1a3FJlo+eGKXu1PZtWG5d2LSHi88E7exeSSCqC5ylOrVocJo=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr31318759otr.232.1565627990914; 
 Mon, 12 Aug 2019 09:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190809171156.3476-1-richard.henderson@linaro.org>
In-Reply-To: <20190809171156.3476-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 17:39:39 +0100
Message-ID: <CAFEAcA_PJho=wwMiDHRuND1itJctctv9GUDFKp6VT4+QnbV4CQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add AT_HWCAP2 for
 aarch64-linux-user
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 18:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the HWCAP2_* bits from kernel version v5.3-rc3.
> Enable the bits corresponding to ARMv8.5-CondM and ARMv8.5-FRINT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> ---
>
> The HWCAP2_FLAGM2 and HWCAP2_FRINT bits came in during the
> last merge window and will be in the upcoming v5.3 release.
> We don't yet implement any of the other extensions that make
> up the rest of the HWCAP2 bits.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

