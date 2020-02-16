Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E4CC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 20:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD6420729
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUYcd7tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD6420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Qro-0001Bk-6h
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 15:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3QrC-0000ax-RJ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 15:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3QrB-0002SK-Lo
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 15:49:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3QrB-0002RA-G0
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 15:49:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id h9so14115961otj.11
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=14QYsuapzbDaPwF+vtYMIhYK6HSjTpn5v3qbb5kuPmQ=;
 b=lUYcd7tKHnMnPkYv3KqcIs65fQvfwi/24hctUKwYjo4C7flZw9FDmOQoiUvLJLLVoq
 YIGIjpA+fPt8CsKIUZ1joe34kSqYlvcsYq/HbtgIZ8cLF5nR4O5dNiCXbuiyGmWJmbGx
 sRpjNdQoYsTpiDB95iTSgQl75UENCEHwEmJc7X+fFkiqGTSUXUubICGVIdgk5842WUMs
 cJSoVGe61wHK+OkuozKZ5Fg7As6Jl2v/G69yyMEnVRoRfjEMudjL9A6QvnU67idKtGyB
 EtRaeh23tIgWxaZ6IW7EPtamIFjdaYaSDTTCgT6JscCDhHlfl8gj84T9nAkilKWRsG90
 0XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=14QYsuapzbDaPwF+vtYMIhYK6HSjTpn5v3qbb5kuPmQ=;
 b=q6G8ShAEYdoFoT4zYzlpde78JD6fMrw/ApqNhdcUaP2siw7prS0DmOLYbT2GT+orws
 jXWI6gT3KEGm6wRENrLZAR0T3kkpbksRqxtZMqpa4VKozybaDBzhbNfAYQA/meSMQQIA
 v1eyISGg4YhuqTjhh0SsFJkEHaN86bBlKQsjnbDjvA5vYX6tipVbTanrGodpWINzO6oC
 pC8qkf1eMcAoKjFizmY1Za3AwhinxGvXrOm6PESPvBnKW9QgLH7aqwD4w6XLgjzgrUz8
 K/oFYyDgsF+sUU8s46uUC/Up/c0FhywcGARIW6s/s+Mbowaws5uJxQEczPtviKBzWQt0
 rmow==
X-Gm-Message-State: APjAAAV5MC+dffb4w06+m7OlaCZCYWkLDPtNI02E22Pou0k/MjyMwlji
 RlXlqMj4KE/Aqs2S05VDujIyMCrqW+6SszYhVNwpcA==
X-Google-Smtp-Source: APXvYqzB+7qqC2aCzWXE0MNmgGfNbDf4t9nEuO8FhoLsEmYQhfGRk3dkiZsOwJwuQBjWulbCrvlKx10C1GHKJFrSm/I=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr10032085ota.232.1581886176266; 
 Sun, 16 Feb 2020 12:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20200216194343.21331-1-richard.henderson@linaro.org>
 <20200216194343.21331-2-richard.henderson@linaro.org>
In-Reply-To: <20200216194343.21331-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Feb 2020 20:49:25 +0000
Message-ID: <CAFEAcA9zuhhUa5YFn=TKX45H60x664xs4gjkFsPOk50MaSnnZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] target/arm: Use bit 55 explicitly for pauth
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Feb 2020 at 19:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The psuedocode in aarch64/functions/pac/auth/Auth and
> aarch64/functions/pac/strip/Strip always uses bit 55 for
> extfield and do not consider if the current regime has 2 ranges.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/pauth_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

('pseudocode', but I'll fix the typo when I apply it if
it doesn't need a respin for some other reason)

thanks
-- PMM

