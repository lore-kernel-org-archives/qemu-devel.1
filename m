Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A335C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C77217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRw8O4wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C77217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrBm-00075X-0I
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHqx5-0006tV-5F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:03:35 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHqx2-0001kp-PO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:03:34 -0400
Received: by mail-ed1-x542.google.com with SMTP id ay8so83786edb.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V/UDdBoWK9pWEEsoecoaUUQjAedJZIbXzMh6LSmsPIY=;
 b=RRw8O4wMwSYs7cpmSua22LfuEnujR56rv2w0h/Yh/KeWgeVuVwBV7IaB7bMV0r8EOU
 8hJixVNGlUhQ9CHXi/CF+9zFQzj1t2faRpPHXuaxIUHRrcTvRXAGR6tXAsH/yaesPAJI
 jyCP7cOkfu32u4FKtal7H6rH0FjbBt/YkYsK61GVSjSPMpX9gGyymVZBfr1k6KWWQ+6Y
 GWmGex0QrHsd+wlCMtrHazIIsRp0FvWTvfxKKLpHeNevRmGcinACzEkaRF7zy52QdG3b
 2BQ05P5MxwSjp5EJZxD6R41FXzh/Y4/0v4Sa9w3mAk96fip6SZColxpifxd4ufEEcP2p
 xKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V/UDdBoWK9pWEEsoecoaUUQjAedJZIbXzMh6LSmsPIY=;
 b=JkQ1bG5H7iLJhA2c/0htymA42Z0wMXmOuAe9BIJLBSHNNgYvJrlHSVFMnUwa407Fme
 dTFhdMPHzLa9S0LOKp+zQrMuKhwJbX3EsfrhwM44OEkdCYrBrove90WFwKNIdRfX6oFD
 go330TMLSQ/1lyCS0rIHxi3sQsLdV2tHkkoO117LWWIVFlVakULkXHJb3GPH8SAUO8Ir
 SRvTZ9WmIldZ5aS7y1t+E6uDZQ2nYD5f4b5eCYUVOvMwcLY8Vs0BebajtHUNumzTbKCm
 bL0sZBvvEqWDIPuUFUFEIc6wUr349cX+kwQ/PcMyFXwan9iBJCHQmgpLUpSVaGUKcvqF
 91cg==
X-Gm-Message-State: AOAM533WVGvT2C1Iuh9k8Rqzc1ESsJkfDk1aVnQZTaEiwzh6Jv9ZUCRL
 qXVhTtD/bld2T4xEVRPDhSid0nNkALYOcqtecyf32Q==
X-Google-Smtp-Source: ABdhPJyESGSfg1NxedCAwVeXSyH95ZqzmGPvi/fev54UmfdUnPgAXxkYd+yQr/Xp20ZFWHuZuTSJsAzhQHH3IhmgnqY=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr18295599edl.204.1600099409020; 
 Mon, 14 Sep 2020 09:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200914145606.94620-1-mreitz@redhat.com>
 <424302b6-c326-f0f8-9bec-8d5805e04f6e@redhat.com>
In-Reply-To: <424302b6-c326-f0f8-9bec-8d5805e04f6e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 17:03:17 +0100
Message-ID: <CAFEAcA9Uv2JoK0PypfdPqMNCpS0bMJT1-yHr+8z2vmJUAS98-w@mail.gmail.com>
Subject: Re: [PATCH v3] iotests: Drop readlink -f
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 16:43, Thomas Huth <thuth@redhat.com> wrote:
>
> On 14/09/2020 16.56, Max Reitz wrote:
> > On macOS, (out of the box) readlink does not have -f.  We do not really
> > need readlink here, though, it was just a replacement for realpath
> > (which is not available on our BSD test systems), which we needed to
> > make the $(dirname) into an absolute path.
> >
> > Instead of using either, just use "cd; pwd" like is done for
> > $source_iotests.
> >
> > Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
> >        ("iotests: Allow running from different directory")
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Reported-by: Claudio Fontana <cfontana@suse.de>
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  tests/qemu-iotests/check | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index e14a1f354d..678b6e4910 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -44,7 +44,7 @@ then
> >          _init_error "failed to obtain source tree name from check symlink"
> >      fi
> >      source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
> > -    build_iotests=$(readlink -f $(dirname "$0"))
> > +    build_iotests=$(cd "$(dirname "$0")"; pwd)
>
> I assume the nested quotes are ok here? ... shell scripts always confuse
> me in that regard...

Yes, the quoting is right here
(cf https://unix.stackexchange.com/questions/118433/quoting-within-command-substitution-in-bash)
 -- $() creates a new quoting context and within it you quote
the command the same way you would if it were a standalone
commandline.

thanks
-- PMM

