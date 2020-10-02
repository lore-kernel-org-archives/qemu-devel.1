Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC19C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E876206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbbHMyGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E876206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLiD-0008Uj-Sy
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kOLhZ-0007y7-SH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:06:25 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kOLhU-0000Ev-8o
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:06:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so828432pgm.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZiZGpOz0igLCK49f4SgGqroASsXYSEsr3M9TqW+MP0o=;
 b=WbbHMyGJ9vtz/1R/DQAl0Hpa5fwv67SlCcTGxpW8jk6cKx+3ym2VLzERfZMOeE8XUX
 xfhluRXs1NhlKIuOiVg1i1dDqgtrHO4Iy0FbFzbyI3mObq9LGl4Xpk293ROwNZfel+Zs
 l/ANJQju8GBreMVnvxe2HGqff/kwaJ4YxWHnB8eays1eqx9UlYMZtFJW59kVyte7P1uw
 AVN+cXiOiTolWl4oU7YIeud34WSHLCYlOPws0RmfrGwHUPnWC7kZDmrDL7Of9MckfbsY
 ZZya7qM8NIVXEJZKsy9/I8npyz9SVZnMTFe1qTlfI9A10PUjq4OK2fjxUNqA9CFRi4kw
 Ksqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZiZGpOz0igLCK49f4SgGqroASsXYSEsr3M9TqW+MP0o=;
 b=tdtxItEuZTJ1Um+i74k9TMFkqoNcyZ0M6TuRONq5YMMX1MMlKgLxLGRGrcFRHSFiNr
 RLkbTfyy4+jLIxj0YJcLoaebbybTJvZeo7+VRg1/asR2sfR+iOCJJHiH4eYxDLUL9ZSz
 qCDFh+zl5DhF5x1Vt0HgBtwFTF4kHgBmxDqqWZ1BBRR3oHkzTjfC4ygznXCq7IiPCAtS
 1rJpXZbjM/ozFHesDwhqqhqqHYPzuwV1zumPLjmVzSH3iMt0HTjdjeEZS9zRsiU5xHEw
 nLsvVgkq9wjIRL1K0V+36ndKd1ms6bJbDZFBaEvH1bL6ay7XT47awOpP65VfHrtVjbd5
 UJqw==
X-Gm-Message-State: AOAM5320mt5UrL/RKhzYmUlBqHxJzmEDeLLCyCS0YEmEXys54XhriR2F
 zQjX8Wk6LgE4cePHXnEuFRxanWuxDouZSz3WI3WaJg==
X-Google-Smtp-Source: ABdhPJzsRc7kTNYTV0mPmCLnSGhjH3hwst7kmjTHacLR0xKM0qY4m2O5HtJ8eMNKTllLZkS/bnQ9ApKFCwyHzM/HKzs=
X-Received: by 2002:a62:6c2:0:b029:142:2501:397c with SMTP id
 185-20020a6206c20000b02901422501397cmr2876618pfg.65.1601647578563; Fri, 02
 Oct 2020 07:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201001193659.21685-1-maxim.uvarov@linaro.org>
 <CAFEAcA_76y5DoNw3tirFFaC9FfE6NnxwAkdgV5eSv9NUeBxdhw@mail.gmail.com>
In-Reply-To: <CAFEAcA_76y5DoNw3tirFFaC9FfE6NnxwAkdgV5eSv9NUeBxdhw@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Fri, 2 Oct 2020 17:06:07 +0300
Message-ID: <CAD8XO3ZWW87Ze+gX9xWtrZ=XaETvE63WqzobQamoGM2_tb-4Zw@mail.gmail.com>
Subject: Re: [PATCH] hw: wdt: implement sbsa watchdog
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 23:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 1 Oct 2020 at 20:37, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > Initial virtual driver matching linux kernel sbsa_gwdt
> > driver. Driver implements basic functionality and makes
> > watchdog works on virtual machine and allows to reboot
> > secure OS. I.e. atf->optee->efi/uboot->kernel. More
> > information about that device can be found under:
> > ARM DEN0029B - Server Base System Architecture (SBSA)
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>
> Hi; what's the relationship between this SBSA watchdog
> device model and the one that Shashi posted recently?
> https://patchew.org/QEMU/20200929180410.33058-1-shashi.mallela@linaro.org/
>
> thanks
> -- PMM

Nice it's the same driver written a little bit differently. I did not
see his patch before. 2 things missing in Sashis driver which are
useful for me:
1. Add sbsa watchdog to machine virt also. That helped me to reboot a
virtual machine with secure payload.
2. I specially did not disable timer on driver close. I.e. "reboot"
linux path reboots with that watchdog.  And make timeout lower to not
wait for a long period.

Can this driver also be considered for virt machine?

Regards,
Maxim.

