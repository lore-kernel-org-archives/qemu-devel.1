Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960CCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FADE206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbE3LoQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FADE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83U4-0006fb-GC
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k82gl-0004ZZ-3h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:42114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k82gj-0002QZ-4p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id df16so15447451edb.9
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hGbAms5lZWU93ghlE15wqXMM8+dMONoiOmFTH+qIBFY=;
 b=FbE3LoQGZUaLNnZFzQRnkQNRS0YlFo38Kzml1FCOCoLCAD/qXSt90cchfiUgRUJHcf
 +dEc5WBWCxvwTkLUNpg6m5V2V0WXtrueyjjZWdWknRpM5JzZS9K2SRsi+wYnNJ68GJBG
 WeqwmEmWuQJlcV0oGo5d4kK/x8H2Q0FzWefm3VwNi8ccsOPh4rIaJmjn24uwhQMsIOzV
 TFQEdeUFNetrA9aiGOapH5V6XtBINwq1Pu/E7npJg2TdgTXvIF3abBCEQfX5RVKlYXAo
 bHbJ68DB+kwlH1Ha9cO+MoXRbbe718JM26Y1CFmQvAM0QAdkAOD/xsQyLjY0j+w+3sYg
 F0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hGbAms5lZWU93ghlE15wqXMM8+dMONoiOmFTH+qIBFY=;
 b=HCWNOIkVH5HPnbTOaGw+8jVJ+VC1NJvYj+A5iuGzXknrM7VmdmPt2GN1igOBRAVguo
 qneNr7Cavf0X7qlDE/itE1/MeBD6SA6WHkegrATjBhHwCaLRqR3DSE+iyOU13NzJ8ITN
 SUl2Fb7e9DRhEXOMIlxS19oowQcODKGiiRgd/i2WKGAhbDD9YZLephzj7opRIXAyiBg9
 Axdu8mFY3UkLPZDVedialTsCm6RDb5f8S7fJXkAesXRAgTF+a2IOXyy2r11WO6VTLX+z
 8WWsi52mOeEVYysD5pylMvS4P0FbhOdTDZtCAOmgoh8b2UpsLOeNMFI8N7iyWRpGu8UP
 hS9Q==
X-Gm-Message-State: AOAM533QYGAQ8QtT+X+ov5nm7rSXOmzV0qW2iBMENdcpfoj1PYErl+H+
 +3f4+IjVSn2uY2+CgH3KUV96sr2odyjXvZyhiURTDw==
X-Google-Smtp-Source: ABdhPJyhdTAhsXYG+PF1jWhy4w0z6noW8vha0oKlM+EW0GDl7cdQlH0lO+Y0HyDGz8eoksh+fYwjPxZ7el1ZEsoK2Bo=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr20322349edq.204.1597761247249; 
 Tue, 18 Aug 2020 07:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200818141025.21608-1-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2020 15:33:56 +0100
Message-ID: <CAFEAcA-5_iHm+6QiCrGigngrGuRfcc_HOtbDDv1QDUabCQg_WA@mail.gmail.com>
Subject: Re: [PULL 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 18 Aug 2020 at 15:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3aecbe785d65e3b92a3617c60e4d226362d9bdd5:
>
>   docs: convert build system documentation to rST (2020-08-18 10:02:43 -0400)
>
> New since v3:
> * C include files renamed from .inc to .c.inc
> * fixed pc-bios/s390-ccw clean targets
> * fixed error splat when doing "make" from unconfigured build directory
> * use --native-file to list tools chosen by configure
> * fixes for Windows (SDL, Wixl)
> * C++ compiler not mandatory anymore
> * remove useless .. search path for modules
>
> ----------------------------------------------------------------
> New build system.
>
> Missing:
> * converting configure tests
> * converting unit tests
> * converting some remaining parts of the installation
>

aarch32 fails like this:

In file included from /usr/include/SDL2/SDL.h:38:0,
                 from /home/peter.maydell/qemu/include/ui/sdl2.h:7,
                 from ../../ui/sdl2.c:30:
/usr/include/SDL2/SDL_cpuinfo.h:63:5: error: "HAVE_IMMINTRIN_H" is not
defined, evaluates to 0 [-Werror=undef]
 #if HAVE_IMMINTRIN_H && !defined(SDL_DISABLE_IMMINTRIN_H)
     ^~~~~~~~~~~~~~~~


windows crossbuild fails like this:

Linking target target/s390x/gen-features
cc: error: unrecognized command line option '-mthreads'; did you mean
'-pthread'?
Makefile.ninja:784: recipe for target 'target/s390x/gen-features' failed

thanks
-- PMM

