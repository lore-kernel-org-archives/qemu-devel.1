Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C09FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A32022257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb+DgWyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A32022257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTAq-0005cP-8c
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUT9m-00057O-Pl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:16:50 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUT9k-00052W-KR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:16:50 -0400
Received: by mail-ej1-x643.google.com with SMTP id c22so13367400ejx.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aNBn1YYnT6VGFENmC7r/V5TDnkulW3nbtUHsR3o5qmk=;
 b=Wb+DgWyNEpM8UKGq8xaMh7q5ZRULXtfgfQpwb9TY1WwCW5zgjEcb4mj7OT4s3qs4wG
 cGvj0o2i6Wex6oGi2QKx6QxeFrxx8NUSwdQp99NEgk1W/eWWYnu7EjfMMdluz+4HLXWe
 Nh6mz3zdovpKtqv3ARaBMA9er7TJjt/M8akMyB//+y3IPjLhPnulS3VpfAU6VMDVcUpp
 zpnDgxQsuYOnfXzMnjsLRvXA0sUz1SZoZcmS6DKIfZlCjyGkjETyQg6Z9jQN9VU36wKY
 vl/bPb1cOMbiVNKQCTSsHK3RaA1EOkwwxBnvPjsD/MYGupeos8JarHt0He2XvR8yQluP
 HWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aNBn1YYnT6VGFENmC7r/V5TDnkulW3nbtUHsR3o5qmk=;
 b=arky8T82qnqZQdDbZmQQwfyLrSoKbz343RpXvadbcl4KZ0QRk2PHpwzCRpfm3iy7Zw
 INZNBbT0P19tHHttukkmxEbzCplH5ZFTaWYzArpcy1g71oYybN1+mDazNzjzEakUHjKb
 1e6PySB/IGCXIiwI60jpe7GzB01Xlyqlrg9gE8kU8anj9PuOniHFlJ/7yVytpAFQWRAU
 wdjQoCLJdPbZ6gg8XQvIgsziBjhat/QvYakn1icweVwDidOGSDbTPYLt1oHcTlWlbY3v
 S4f+/cKypJWTEjjhlo+k+ieiWTrwRbbKSeZTq+hJa/jU2V6RcLwPm3NWaDwdTFpwQpKM
 +aBA==
X-Gm-Message-State: AOAM531pq1AwyCdZRsqzB8cGeaZknVKLT0UQkcshRUF4cCseeUSVGvp0
 mUWzv2Cvw0sP8u7Gj0rFXzC5a9JhtPs8x6w1AwSimw==
X-Google-Smtp-Source: ABdhPJxDjYBU+G16bYYKX2qUgls+K5J5cSzKUyf85p80M4aRYR+DqAHFb5erMtgtwkgBEkOCi1uwMgupMLXLe+s+szM=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr16026392ejk.382.1603106206875; 
 Mon, 19 Oct 2020 04:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200928160402.7961-1-peter.maydell@linaro.org>
 <0cbbe621-cae0-548b-fecf-0dd0e7b30fec@redhat.com>
In-Reply-To: <0cbbe621-cae0-548b-fecf-0dd0e7b30fec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 12:16:35 +0100
Message-ID: <CAFEAcA_nKtDRzV9YUdMoNXRV_o_rp-y2aai3zH2JsM7yWhJ9eg@mail.gmail.com>
Subject: Re: [PATCH] configure: Test that gio libs from pkg-config work
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 17:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/09/20 18:04, Peter Maydell wrote:
> > I wanted a statically-linked system emulation binary (which, yes,
> > I know is not really something we support :-)). I got one with
> > suitably liberal use of --disable-foo configure options, and
> > this was the only thing I couldn't work around that way.
> > The patch is needed because there's no --disable-gio. I suppose
> > we could add that instead (or as well)...
> > Possibly meson offers a nicer way to do this, but this was
> > simple and gnutls is doing the check this way already.
>
> No, you'd get just that warning about static libraries not being
> available; so I think either this patch or --disable-gio is fine.

Could I have a Reviewed-by: if you're happy with this patch?

thanks
-- PMM

