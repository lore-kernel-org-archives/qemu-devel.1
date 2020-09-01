Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE85C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EB7206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYikDvpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EB7206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5AT-0005WX-7g
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD59F-0003vl-Ow
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:12:25 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:35416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD59D-0005mt-Sm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:12:25 -0400
Received: by mail-ej1-x635.google.com with SMTP id a26so1310449ejc.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DxQTgVlGvYzqUOzmpbQVZIkhQxZKqcnl+cOYBVhVUwU=;
 b=WYikDvpl2JHus5owK7bZvIpWTsn9l5mxYosbnIIxsK/s2Ttncp0IrZ9sDu8qgcvLNL
 h1CdNYKsRDY2M3bU0fUDx3n3//+KwOjmbmQCWj/wIkqEYcwk5v4FrGO7pwYeIb8Kh3BN
 QtUXqB3mqttO+50I+ybHqqVLt54z3sdAuOidAF1QLfbRsCw1V3dzAWRCHxwVDwNqFQS/
 a3AXmO2I6FLoiQ2vgg83KX+oQWMnUQRiLzDirONSagePwcFxq1UDAw4G/ATmFaVEA/vM
 g8J9WpwyvFkfNrvlobzBT0ZuLwc+blmDXPuOXrUA5KMjjVgxm0hWnqNRsexK/N0sRpgr
 wjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DxQTgVlGvYzqUOzmpbQVZIkhQxZKqcnl+cOYBVhVUwU=;
 b=nWuEwPva4fLvWN9Bqa4VvHjO1dS/Fw5WUlzDkCBdSbNgk5+DXnY9lPx0Btq9y2hYug
 8svtnymeiOd7wEnXGBt1soOEOJPGfpNoGgh3lMQNBtTY05ATKSmL5rTCEXzp3J8DNaY1
 sKRJYSD9pB46EBwy3xpLiepROtkiLjbclZh27fYa+4baxiYn0450Lw9U8fYTUJFFlm2B
 t0xfP3gyO0w20NoPaYA3JK3A8HZG/bACH7A2S8rfpWeXdsMJS5U1CtHGBK3LAoAroJSi
 JFaeqTm9QvC9D/XfatjbyXjHP5jp5DOptOhecXkPLrcmjvJfDmfzxbWH8qE6uTX4n1Wr
 yNjQ==
X-Gm-Message-State: AOAM531VSCw3j8d1bR+Zok9wfxUTdGCly0Lxik6MdbGbO32M3A3rEGd+
 v70FTKfFiti7zurTFkrZfun5eUrsnm8G2K+p8k8PCw==
X-Google-Smtp-Source: ABdhPJwSZs4MRx1Bv/ZVB+XTn6S5gomq0EAfprC0Ut/oyPLg4LvYiaIY0sTGaQRH4k4YhuKXIb0hxBr3b3mNjFyK+qM=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr1144771ejb.85.1598962341896; 
 Tue, 01 Sep 2020 05:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200901091132.29601-1-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:12:10 +0100
Message-ID: <CAFEAcA-AB4Up=Sdh3KB-YogkqemF+6M8uM-KPA64bjNu=avNjA@mail.gmail.com>
Subject: Re: [PULL 00/24] Meson changes for 2020-09-01
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 at 10:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 703230593ffda7699ae81811967b4d2c76a425c1:
>
>   meson: add description to options (2020-09-01 03:10:36 -0400)
>
> ----------------------------------------------------------------
> meson fixes:
> * bump submodule to 0.55.1
> * SDL, pixman and zlib fixes
> * firmwarepath fix
> * fix firmware builds
>
> meson related:
> * move install to Meson
> * move NSIS to Meson
> * do not make meson use cmake
> * add description to options

This fails to link on the all-linux-static config:

Linking target qemu-arm
/usr/bin/ld: attempted static link of dynamic object
`/usr/lib/x86_64-linux-gnu/libz.so'
collect2: error: ld returned 1 exit status

thanks
-- PMM

