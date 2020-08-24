Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1C020656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Nrxxt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1C020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAL6q-0001LQ-Ez
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAL6K-0000tj-P7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:38:04 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAL6J-00048D-9C
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:38:04 -0400
Received: by mail-io1-xd41.google.com with SMTP id q132so29795iod.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bg6HztGPQ4U2EEDTCgO64MwmUpeg6+z8BBLeSVoC1eU=;
 b=m6Nrxxt4DdfBmKCbNs/kbBUqQ4Jm1qJw6hD3Ef+3m96sa+ZAQp4LEkf0MxxqazvRTd
 XIVnM6peb99Im2SK/el3Q1XBohIHeLluPwDgElGFrhby/bPaWlS7o3f2YDJa2+c3BIUe
 kZxA5/Rjo/pX5QeAs+SlPiIP2f2AXrfymhfGfMA1BQZu02RPwskK9WtqlTxEF8lZwdbq
 GG1H6PAbrw1Dwo+UCejZyHrM9SqbzoW9Fn7p83LtbadDa79J74KKgoEWVXgK4cT8ViJY
 SkV+5zIib7nI0FZ5uq6v36e+orHLVZrgJ4fH/pmY4A8ag9qwYmrd1SLMlQB2gGLtuW9o
 hTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bg6HztGPQ4U2EEDTCgO64MwmUpeg6+z8BBLeSVoC1eU=;
 b=gEZgZhoQ05c/o/HbyM9I4LZO+CoqNEJAOuqEoVQvmoyL6mLVM5ZPxlvWrbx9/YIDjJ
 gHOouco4zhK/OOAqMXXULQwuzptbSSrDOC/qVJk92zr0fL0tBbRHJ3BbkSasJLBHRWTR
 R0olVGsH0YhXCoy5GBl9/Uq1c0YYtKm6IUbGbXaQVhlIP8eKET5X5FjPpqlpF4J/k9m2
 Lm1fwgtGgg98FQdUv+6xNPHA4MvTlubjK+S1AYPXTIqT8KBw167cIeuk70QY2vHf3Zux
 5UJhfzI+KT0SuQgs1GRjSIrEzkRknmnKEn0IE8Bekoyzw2z6gp5x7eAuj8Fx0WCPpDvo
 a4aA==
X-Gm-Message-State: AOAM533ecONHktQnJqKrwsho0P+GsA/oJ0Dc7PUsYTEQcxquWkRTq3De
 V4jzPfMie5EXkh7XRb2locyDCVcVYwSDeabzta0=
X-Google-Smtp-Source: ABdhPJwSgRQ6U9sbp4n4a+G+haT8wLrvpptD/3xAuMYD0Hny/2z51hSRj6fUGIHx5aAKCtifZeoztpb0+fKyTtAQlXc=
X-Received: by 2002:a05:6638:1690:: with SMTP id
 f16mr7791484jat.91.1598308682229; 
 Mon, 24 Aug 2020 15:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200824074057.3673-1-kraxel@redhat.com>
In-Reply-To: <20200824074057.3673-1-kraxel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Aug 2020 15:27:21 -0700
Message-ID: <CAKmqyKPdXii7P0EYh+2t9nX_S8-b8DCOdFLiGxfrHQAbcmeO8Q@mail.gmail.com>
Subject: Re: [PATCH] meson: drop keymaps symlink
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 12:42 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> We are building the keymaps by default now.  Drop the keymaps symlink
> so the generated files are actually written to the build tree not the
> source tree.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 67832e3bab76..428fa33be140 100755
> --- a/configure
> +++ b/configure
> @@ -8119,7 +8119,7 @@ DIRS="$DIRS roms/seabios"
>  LINKS="Makefile"
>  LINKS="$LINKS tests/tcg/lm32/Makefile"
>  LINKS="$LINKS tests/tcg/Makefile.target"
> -LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
> +LINKS="$LINKS pc-bios/optionrom/Makefile"
>  LINKS="$LINKS pc-bios/s390-ccw/Makefile"
>  LINKS="$LINKS roms/seabios/Makefile"
>  LINKS="$LINKS pc-bios/qemu-icon.bmp"
> --
> 2.27.0
>
>

