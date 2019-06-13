Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB03C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA9D2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNuV/J7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA9D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPnd-0004sa-Vk
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOmz-0003tH-Mh
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOmy-0005I1-I0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:25:09 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOmy-0005HB-DP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:25:08 -0400
Received: by mail-ot1-x334.google.com with SMTP id p4so15528860oti.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gt6p7Gu7ZVBOe8JIprcKrc7D983jNhF7rXbFbsbs85U=;
 b=hNuV/J7L4auepITy57lKANdiLsLbz3HTP5F5NfxsCbm9+8a265GduMDa8qRAs/iTlb
 aVSOIUZjfLVeEZC/ExQDckGxQiiYcKaAOtOdJDIkLy00j5yGQgQnc14gd9eqTg9sFuTp
 QIGZTsSyYvPnd5RAfbgVNWvJHzMEJY0rxWVyF+f8D2K3f3fk/c7dOlRnZH2AQo5t1+LO
 yBYGtKQbwQ16Ft6RHUbeC+wwNK5zabrL2nWrAg8wodsNP2sIxKINAn4vNPdEGTX5/5UG
 95ak+0tB61fD8v/xtkLCHZP1W2149Ca0QeogTDigFOenscl5a7DenyhfU6ITAW9uT8EV
 S4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gt6p7Gu7ZVBOe8JIprcKrc7D983jNhF7rXbFbsbs85U=;
 b=e6Y7P+6pJRxDy1NGEanW5+tBoyoo65NY4PMsabnvr+7ge5uOtcXyj/c2Zn9zjN4MPE
 o/fXzWCGHK7WDln5+IvYwOCxUWwIvaxCyPDjJWVUMmUitFEmQYbpHusRQjrPT4e9Xm6O
 oUKQR/s758sTNOYXvX/l216/tkLE1UtcPLSznZI2V69Kjsd4AoCfklFZBaXLc7p/zr7r
 5TwHc9wVwy02sjZujs2Sz/qI7lOz7y+SWmrxgepLFNG7dSBVo1viUIwanUkTAWYrqMCt
 +1w24OzLSCwMUxtYgnyywxjleB6p01kTjjqefMrv85HPG8rNbQvrLEFt/iOo4SvgKw8a
 Ea1g==
X-Gm-Message-State: APjAAAWicmeAQiXuj34XEgiUaF6xsXxHvUOvmf8N5PekAgpV/Qq8AvFS
 KO+HFbZzmI+UNkzaSp58Yo7slkI+v7JH9CLVaPBuNg==
X-Google-Smtp-Source: APXvYqyeVNPwkNAPwtEGboVOiC84ZIuBp2VAQxZj3Tb/WNsWnb0bMI9k1LNQmZtYveb9YIMlUWSVKlAOuXJWt9BDbyE=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr1315543otn.135.1560428707497; 
 Thu, 13 Jun 2019 05:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190613041619.32102-1-richard.henderson@linaro.org>
 <b03ab821-e6b1-dd8b-5d61-fb6d28018ee4@linaro.org>
In-Reply-To: <b03ab821-e6b1-dd8b-5d61-fb6d28018ee4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 13:24:56 +0100
Message-ID: <CAFEAcA9w7TOTsQuEctSNeXJp-0VB=DuDoV82LD6PEio8ZLoCfQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 0/1] tcg: queued patch
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Jun 2019 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Dang it, forgot the PULL tag.
>
>
> r~
>
>
> The following changes since commit a050901d4b40092dc356b59912c6df39e389c7b9:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612' into
> staging (2019-06-12 14:43:47 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190612
>
> for you to fetch changes up to 899f08ad1d1231dbbfa67298413f05ed2679fb02:
>
>   tcg: Fix typos in helper_gvec_sar{8,32,64}v (2019-06-12 21:08:38 -0700)
>
> ----------------------------------------------------------------
> Fix vector arithmetic right shift helpers.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

