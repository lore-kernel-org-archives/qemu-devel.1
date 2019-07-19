Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF3DC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A66C2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0tqkDjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A66C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPCB-0003ao-J7
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37834)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoPAG-0003a9-GO
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoPAF-00069S-8u
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:56 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoPAF-00068H-1m
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id n5so32122577otk.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jdNjR34OKI7Ej46Hk3igSxontJpeuY0X73uYU0QCzZ0=;
 b=Q0tqkDjra/X4Sz9lCX8dhAoGC2BvfFFtm4yWG2YuorjktxxqH0IqY6wh3/PMN3Kmwu
 MAmGbGJgaWGgLJzY1dSQ3Z/TczFRjL34IFg7FCwlRflcSQXxzDwf5XTY49VIs0Aj02jB
 PEUm6W4bb3CntFEdGDQxegtWRayq0oeLDnUq9p5QnMpWF10kFdiNGnV5TsLvCIXR+PPa
 T5Kh0rCi6JApSySimaHq8xwlSp6TFucGa87gm3L270XWu2Fd3NtwNtqf9kg86aFjdOo4
 DSBjeVw3kqr3YITeLkukz9ki4EWxlJBQrkaEzkkuO5hPTOPS2OYdSzuO1RqZ0bJm0PaJ
 aGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jdNjR34OKI7Ej46Hk3igSxontJpeuY0X73uYU0QCzZ0=;
 b=Ur37TlFBynlhfsOCvsDfaYXGoB/gzdRmsdR3/ge25z1JB4daA/7nxSdPbBIwy5wDvV
 m9eep+ja5xOc6dGb8eAA7eBtNtarA36ql3duisUigucrxB/Gd3gnvYfXwJzOsM3rsCVA
 0fcBZd3nWjSsLWqhVrAp9r7nLZ5nVG0qWDvTPuiXd0tvOugv46bZUhQWILFwNWHfk2KO
 Uhqp1UO+8uibkKlA3rGGA9jbGQjFHuWRSmyzS3YGd/Nch41nvhwsqVh5v6ZiTnUrR6DS
 VSy8HtX000NLYPTPYIMQkxo/TeBfk5+gsPat2BwSd39ohXHqyvxf4bDGkT+hD0YGQ9MU
 2kKA==
X-Gm-Message-State: APjAAAWAcyNL1RMCuTUi0i+5Wct7zSlkZhCoOxBk20ysB9O6LuRKKhvU
 LFzNdg9SJICoIRQGOX9hTGLCg7v6GFO+PrUHv1Jo6w==
X-Google-Smtp-Source: APXvYqzTb6WXl0w9LyvTMa9WDi+Ia9JvtJAz+c2g7btDvb+jbLFCg1GC8mwgOtyc+25acW+bsGQoqRF6TXJJpv/dn8k=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr36115751otj.97.1563528413284; 
 Fri, 19 Jul 2019 02:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190719080610.1607-1-laurent@vivier.eu>
In-Reply-To: <20190719080610.1607-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 10:26:42 +0100
Message-ID: <CAFEAcA-Ht1MCtiQ87TsJ0qY2ktj1d0T9VS5mKZ298Js_jCRPnw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL v2 0/3] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 09:07, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit a1a4d49f60d2b899620ee2be4ebb991c4a90a026:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20190716' into staging (2019-07-16 17:02:44 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 6d5d5dde9adb5acb32e6b8e3dfbf47fff0f308d2:
>
>   linux-user: fix to handle variably sized SIOCGSTAMP with new kernels (2019-07-19 09:33:55 +0200)
>
> ----------------------------------------------------------------
> fix access_ok() to allow to run LTP on AARCH64,
> fix SIOCGSTAMP with 5.2 kernel headers,
> fix structure target_ucontext for MIPS
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

