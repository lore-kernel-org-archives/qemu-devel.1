Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A41C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7657B20735
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHv4LPHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7657B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnfj-0004nJ-VL
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHndw-00042a-JH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:31:40 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHndr-0000BD-E1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:31:36 -0400
Received: by mail-ed1-x544.google.com with SMTP id i1so17418647edv.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uTjO00w5lmowq0jE0QoOxZDYI4Y5K99mjBn52injmVE=;
 b=yHv4LPHZhKWH7hGpZplmgstWtqpGBgSVc5VhCPkaSwTz0myIQZYye6OXsNSYi437vr
 BPdMTs5tY9CO+lQ1JsKYdyiyba1+no+7asCeOA6ER/AHvC2r3070IuMb0kgmSXDqGsF3
 o69KjdXEUuaHS0BWTYjLSoxrEsckdpqtRDhDApNCdVlhQF31adDcRo08sfv/uUqCebJZ
 BdNP0EK3SvgywgTz50F3g566XKkHLFRjsMdhe73Ojziu1csY7gRWgOmyOFCUgF259/Kh
 9bjcYz3y/xMw5r6BDzfd5b6qzN4ido9/knhR3R4FBPJmCWPXPzecZxkXsth+Lm+lbtDw
 7Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uTjO00w5lmowq0jE0QoOxZDYI4Y5K99mjBn52injmVE=;
 b=ZPxVxNxivUbAcKsrKYYwUNPmAebgEnK/bdDk/A3zX9pG+Dwxn3OShaeGYQmNEm0BOe
 h23CIx7IAYw86Yi9YYFCQnUgXIXrfHndslC0W0ZD5PT5H3sBD452ABNe9sfP9xvP4CTk
 RfFHvl4QkmRuR5P0aZPj1wCLEU+mS9zXECTwb8tG6bdx/h9kod15QuLM2bkREtCL4NEE
 sHtl6Co36FiibWatTttfmb6n9viWxnYO+spaKF9Laa0F/+Q5wIZwDrH4H/pVsNlVpY9g
 KG+loUkotu9ak9X2ugH1dyG0hPK6nQRMxHHQ0o9QM7z+/Ndm8nSiwgAHgGREVpQUMVmi
 RJjA==
X-Gm-Message-State: AOAM530Oj9gHaupx9mc0MCZEObxQhLShshjdcOu05R2CSfHpYAo3d0Qp
 zPPQHhz9nHXvQdVC+Owh2KWo8g+i07Drc5eP4cwYHA==
X-Google-Smtp-Source: ABdhPJxBioiOEEhz1K3OB94EwRXsux3e7utvoXivr2Z2N/Rob2Jhw5FXocgDJSvQBkPC7jxEvMmPHaRFW6OU9l28UX4=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr17569402edm.100.1600086689267; 
 Mon, 14 Sep 2020 05:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200914113809.63640-1-mreitz@redhat.com>
In-Reply-To: <20200914113809.63640-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 13:31:18 +0100
Message-ID: <CAFEAcA-jN39TufevHy6sng-53NAzqfdm=4NEzGe1Yg+oFzfFQg@mail.gmail.com>
Subject: Re: [PATCH] iotests: Work around failing readlink -f
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 12:39, Max Reitz <mreitz@redhat.com> wrote:
>
> On macOS, (out of the box) readlink does not have -f.  If the recent
> "readlink -f" call introduced by b1cbc33a397 fails, just fall back to
> the old behavior (which means you can run the iotests only from the
> build tree, but that worked fine for six years, so it should be fine
> still).
>
> Keep any potential error message on stderr.  If users want to run the
> iotests from outside the build tree, this may point them to what's wrong
> (with their system).
>
> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
>        ("iotests: Allow running from different directory")
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Hi Thomas,
>
> I thought this would be quicker than writing a witty response on whether
> you or me should write this patch. O:)
> ---
>  tests/qemu-iotests/check | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e14a1f354d..75675e1a18 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -45,6 +45,10 @@ then
>      fi
>      source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
>      build_iotests=$(readlink -f $(dirname "$0"))
> +    if [ "$?" -ne 0 ]; then
> +        # Perhaps -f is unsupported, revert to pre-b1cbc33a397 behavior
> +        build_iotests=$PWD
> +    fi
>  else

This still prints
  readlink: illegal option -- f
  usage: readlink [-n] [file ...]

(you can see it in the build log that Thomas links to).

   build_iotests=$(readlink -f $(dirname "$0") 2>/dev/null)

should avoid that, I think.

thanks
-- PMM

