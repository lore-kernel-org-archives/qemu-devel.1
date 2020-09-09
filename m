Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257772087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXEQl4CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257772087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0Bh-0003ll-VW
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG0B5-0003Ca-Rl
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:30:23 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:36729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG0B4-0005Vr-5u
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:30:23 -0400
Received: by mail-ed1-x535.google.com with SMTP id w1so2658014edr.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eOcESL+duDyuq8ih8RGJEmvgMI+ZLi/+u2JNrmSs/lU=;
 b=sXEQl4CVsqL6woushW07fTVGAN8k6gNkQjQyv0AlOk2G3lFec55Y9ne5AuyxUBhBje
 6wpwHRKGkhuH/E0mA23RXVeJCa/ueTVLTSa9OXJven85zCw/nsyqiQTshm+9P4Csw+SW
 UYWdLMzQbUecyQTdg6zkMU3yEP4Z8jL7G3e6Dos6iPmv6MhOuqxp74xZBuppaPVFXt4J
 ZNdQO5bkWjfNkePxiP2Wh9wZHa9VgMMnYTx5r+8Y1HZIvdhEFIUdRA2a/g3+M1MPWvTh
 ok7qG67fSgf+YfbiviplbqvFv362+XzQ9cWLqT5uHR7NNmoGvjVFJtiq3F8Xp82KjnFY
 jcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eOcESL+duDyuq8ih8RGJEmvgMI+ZLi/+u2JNrmSs/lU=;
 b=eFOs1iAuvH/D3kWUnBQ+XixgC+0ud/1medK3N15LVR7AltYV8dOW9FBhVRL35wvA5P
 zF9ZCp3eZf4gqazApSyAkuW05sglVrxhcSGUL3CESjyIUsP4ne+e3bqTecSt1v5+ZmmO
 irnpKDqI8up/dCxFYXYBoD4y1Bu4p8BkedNcFICtLoVSy9qWOABXkP9CjPgmGFW2d9bL
 jpnIeJKI9xwc72er5pBJr+tg9Yqh+yDq+HadWF5jzlpE0BSvurHmJlVsJMHc5rQFyQXL
 aE9iH+QELCFzATAEbthhr0w0fOPpcmQ/i6QScRUoYnlk7BOuwbNaSImg2brOcHSU1Ya9
 IuxQ==
X-Gm-Message-State: AOAM531dJeyxhVqHGkPxUd+B36hcCgXhI2WaXbOzZvYiA4B+/BFtzLT1
 VeCD+pOXh4q+hBZUcPZbKjfGOZQlbz9nB9SmIFcJFQ==
X-Google-Smtp-Source: ABdhPJwQi4QyCCQg4yAiLc8fIDNUfD2f9wMDlBYVHmxksNmBl3ujYLPeJLLFOHjczWr4djPqEeXuzi7FCg8C7NZVyDw=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr3973551edw.251.1599658220678; 
 Wed, 09 Sep 2020 06:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <2764135.D4k31Gy3CM@silver>
In-Reply-To: <2764135.D4k31Gy3CM@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 14:30:09 +0100
Message-ID: <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 13:56, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> I've recently been thinking about how feasible a stripped down Xcode project
> for QEMU would be, i.e. you just get the QEMU sources, click on
> qemu.xcodeproj, Cmd + B, done. No extra installation, no configure, nothing.

How would this work? Can you have an XCode project that just
says "to build this program we will run configure and make" ?
We definitely don't want to have two parallel mechanisms for
specifying how to build QEMU, because they'll just get out of sync.

> each individually on macOS. Or right, you could alternatively "just install"
> them from Homebrew, MacPorts, Fink. But no matter which solution you choose,
> it easily ends up in a mess (conflicts, misbehaviours) on macOS to install
> libs and apps globally. And I think that's the problem why there are currently
> relatively little contribution for QEMU coming from devs on macOS. Because you
> don't want to install things globally on a macOS system, it's simply not
> working well there as it does with Linux distros.

My experience with homebrew has been pretty good overall.
If there's a better way to handle OSX hosts that doesn't
require us to carry around all our dependencies (which is
impractical) that would be interesting to investigate.

> The question is, and I don't have the big picture of QEMU yet to judge that,
> how much is auto generated for QEMU i.e. with custom scripts that would
> probably destroy this plan? There are these trace calls that are auto
> generated, is there more like the TCG part for instance?

Lots of stuff is autogenerated, yes.

thanks
-- PMM

