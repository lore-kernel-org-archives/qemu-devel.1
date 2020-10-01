Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3293C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E0820848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atY/SgjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E0820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1Rm-0006yh-R2
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO1JN-0004to-3Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:20:05 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:45072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO1JH-0001uV-AY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:20:04 -0400
Received: by mail-ej1-x631.google.com with SMTP id i26so8909729ejb.12
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fACvkjdIp2dRgU84Sw76gBLwcnBk+NosZs9b/5Adz2g=;
 b=atY/SgjBojm5sht9njDKUwfhTh1cjg2mILfJveRkGWAroautZV1OMMCaCRu6WwCQBq
 JlAmmXatOHT5HaHaw4yaCB402S5xF6XGkAIUjlSSKvbgQshXIoOMZUuOI9yMgl07kzrO
 FZ11GkOo78OWDY6YDQnRudJdLKRrGlnA2jBu4fv5nuBDHyjkV53uy2B9KDxXho8Rnzsj
 SOF+7I/epZHGpDWgN3arp/xMcqmGD+1L05dnj9YHKy7702omtcxhxtIjkboSqPx09PC3
 lHbkKTeNHcDiZrjhwfZ7BHOzIwh4fo9eBTP+MlW/5J7ftoSSnZCTvz2DECcqCRIkwvzo
 vhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fACvkjdIp2dRgU84Sw76gBLwcnBk+NosZs9b/5Adz2g=;
 b=jedFtP8qL1dNAawnY24bCIbi4ZniyxzNKrvO9SNMvG3df6B1B5M3eKZvtyMCBLOGYY
 swCBJCo70vtzVwc8z37rkSUlL7gsBJd5CXu//VMIWQc63yFcQk7YnVx9R4h6wVwHqyiD
 rGFrP11Y4nG6T8ophSQKLY3odniRWpUqzVSi8HcFBCLpUxNheJjWWL6L59e5uQueuzRN
 uQhxKQLD3uX2NhBXYFv56+OEc0BPKz3+BWgWh3kyBAMmLJP89x9MoGPTCxoYkSMWTWtp
 SuI2C2aphi663fC4EDSMSnxcyBUvpbMea59EJGQXDuPru/jLsbQmSrkqxMKK9YKhjUXc
 Yssw==
X-Gm-Message-State: AOAM530lbZjQpmwNrwR42FRkf+d4InU2H5VSpbwjlwWHJ4XayPmklj8b
 xKy/pb3NAfCyEUUvwDM03fsVsUa2PLOCxafRbW83nA==
X-Google-Smtp-Source: ABdhPJzA482UiskCAWmJ9q8QyMy6uqwnC4y/2RnE9ul/x3c2rAKOAaBH/AieJJAxRTU1GHb5wPITnhJbmjdRst/qTPM=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr8772084ejk.407.1601569197741; 
 Thu, 01 Oct 2020 09:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <20200930195850.278104-2-pbonzini@redhat.com>
In-Reply-To: <20200930195850.278104-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 17:19:46 +0100
Message-ID: <CAFEAcA98nJiysUkGEUaq4OMJ815pQRTKz4TWxZFHqzzNX2r2uw@mail.gmail.com>
Subject: Re: [PULL 29/86] meson: move libudev test
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Sep 2020 at 21:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure   | 14 --------------
>  meson.build |  7 ++++---
>  2 files changed, 4 insertions(+), 17 deletions(-)

Hi; this commit seems to have broken my static build.
Previously configure did not include libudev in the link
for a static build (there is no libudev.a, at least on my
system). Now it does, and then the link fails with
  /usr/bin/ld: cannot find -ludev

>  ##########################################
> -# Do we have libudev
> -if test "$libudev" != "no" ; then
> -  if $pkg_config libudev && test "$static" != "yes"; then
> -    libudev="yes"
> -    libudev_libs=$($pkg_config --libs libudev)
> -  else
> -    libudev="no"
> -  fi
> -fi

This is the old code, which doesn't enable libudev for
static builds.

> --- a/meson.build
> +++ b/meson.build
> @@ -257,8 +257,8 @@ if 'CONFIG_CURL' in config_host
>                              link_args: config_host['CURL_LIBS'].split())
>  endif
>  libudev = not_found
> -if 'CONFIG_LIBUDEV' in config_host
> -  libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
> +if targetos == 'linux' and (have_system or have_tools)
> +  libudev = dependency('libudev', static: enable_static)
>  endif

I'm not very confident about reading meson.build logic, but it
looks like this trusts meson/pkg-config to tell it about
whether it can do a static link against this library,
which doesn't work on my system, at least. (Ubuntu 18.04.4).

>  brlapi = not_found
>  if 'CONFIG_BRLAPI' in config_host

thanks
-- PMM

