Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62DEC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B77625835
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tt1ZqW8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B77625835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52371 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJD8-0005uN-MF
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:27:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJCM-0005aO-EU
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJCL-0005Mb-Gw
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:26:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJCL-0005J7-6i
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:26:17 -0400
Received: by mail-ot1-x344.google.com with SMTP id s19so5241208otq.5
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SO4DtJtO0BqWBtWNzs37XLHwBXfwiBG7qSHhk+szrug=;
	b=tt1ZqW8fnTDkRYDXndGv2+9UE14oDAn5CheMwdCmMmAVBlPGrStICk4mWUlZNYIJRa
	v6O0oM2BcUbcdqBHB7b6BgD0j9k19TdxY4MZzsnlFLHQ8mEb9LLg/U8zoU00sP1hr1av
	KTdfmCi3P/fWWcd/3wbxkMjxIXz5Z/p2r1Of4WF1oMjQ/UEM6ObMCqublyTNDdH57O2m
	oCFG3g18zrXxDjJKhrl+nYVZ6Acogkk7K3DzdMkrrr/4QaR6HHuLFwa4102G2/VAVxXs
	I6yEoNTtU2EWP7oQf62//4GsIO2BqCvBKg7pxFzQb86g0wvaOrBZziLL136VgdzP1/xR
	iMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SO4DtJtO0BqWBtWNzs37XLHwBXfwiBG7qSHhk+szrug=;
	b=JFCDv3aGHfNwxl8ZLX3482ehTEXbskHOibkPGUE3pmxaqXNYz/gvwDPVHiZBWHhrqD
	gUoGfapCIZLUiVnf56Nbsm8w+zd8Cg/rlLTaIrwjkM5pj/nfVIFRFE5ZRPQfoyiUbGxx
	Xe0NGo8Qh1OkW6NiU/XMqPe6WyFZgcF0CLkncxavqkM/dVNK13Nx2tgEKTHxV4DnQJjV
	sukQpwOhSQ2ahKrYroxC02z39+Mi17PUY0XWcl3Flzx31dnRcRsvC3iUHWHKExTcsE4v
	io7KHaTJJkJQsvhKvWz3JfyUFENv/hub+LW3z2Jw8CiSrpRgd5qm7g6GCBqGBwV4YwrO
	Yw6w==
X-Gm-Message-State: APjAAAUPYnuwqPKnnQEkr/bouG7DzVNp4ifOg7ZTSfo+m0OlLYsjFI7n
	3tf14CfXdC33/L9zodrbEui5j6MOq4TVnr8bVKXdFg==
X-Google-Smtp-Source: APXvYqwXcmaCFEOSsZu8a/w1YSkpezCurfqXMdELdOuKdbxCbmw3UY99Jy3/JdW2obwDA9JOzMSt+HEFk55jlZ+AEEU=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr2229211otq.232.1559215576263; 
	Thu, 30 May 2019 04:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190522222821.23850-1-richard.henderson@linaro.org>
	<20190522222821.23850-9-richard.henderson@linaro.org>
In-Reply-To: <20190522222821.23850-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:26:05 +0100
Message-ID: <CAFEAcA9MTBqd5GO58hywGhYYGdbbvqiASwCvuKRBE+CVqVZTig@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 08/16] tcg/i386: Support vector comparison
 select value
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

On Wed, 22 May 2019 at 23:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We already had backend support for this feature.  Expand the new
> cmpsel opcode using vpblendb.  The combination allows us to avoid
> an extra NOT for some comparison codes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |  2 +-
>  tcg/i386/tcg-target.inc.c | 39 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 16a83a7f7b..928e8b87bb 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -191,7 +191,7 @@ extern bool have_avx2;
>  #define TCG_TARGET_HAS_sat_vec          1
>  #define TCG_TARGET_HAS_minmax_vec       1
>  #define TCG_TARGET_HAS_bitsel_vec       0
> -#define TCG_TARGET_HAS_cmpsel_vec       0
> +#define TCG_TARGET_HAS_cmpsel_vec       -1

This is the only place where we define a TCG_TARGET_HAS_* macro
to something other than 0 or 1, which means that Coverity
complains (CID 1401702) when we use it in a logical boolean expression
  return have_vec && TCG_TARGET_HAS_cmpsel_vec;
later on.

Should it really be -1, or is this a typo for 1 ?

thanks
-- PMM

