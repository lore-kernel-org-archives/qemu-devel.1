Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21453206C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+i3eUE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21453206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiHM-00082X-5A
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKiCD-00037L-Qw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:19:01 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKiC6-0006ro-BM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:19:01 -0400
Received: by mail-ed1-x541.google.com with SMTP id w1so16167485edr.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rVKaaQfdqgnqcB39rX+gHRcKcPho03HmuQBe2EGwK8I=;
 b=E+i3eUE5CLeZVucxA2g3yw26QEoa5CIQntJoKgBT2RALVeA1BVB3vikaXSltZQBPdY
 OQd2wLijIBaNePViidbwO7eba9LwZaLI6ToQh4Mqz3iwFsSSw0WraQ7bSE2Kdk02THdG
 if+7CmfW7Qk1Q/ecBOSyu0JMMdGoLOJpLOCt50ex8D1pz+9RziKtd5/lp45OtDSOC8g4
 Hgv0TPPcqyBs7aXp/74BRRLJUZwzjtVbf8Fkn7EjuxhjatYvtv+QXH9h6tM6bx8fjWfo
 hfjBtX7URAnqqAGSefq7BcZ/0jzywC4kZT027bQDKl07VGE8j1B0hscKBMSoPSajnoxq
 do0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rVKaaQfdqgnqcB39rX+gHRcKcPho03HmuQBe2EGwK8I=;
 b=Axa1NFo0oNpUS3Ioz9U32UvS52sVpGO2CaI5PWHcj6xFDbrL+BR4nAQb0+6Wajrsle
 FOY45mmSNiwtyW91A+yz3LeHtYXM7BIF2yv2EtRwIN59A51IUvx+JUqrz/de/edPrgeV
 mzutRkfFfm7naOsSpz3AyVXucJ9E2QVaMFanT7FNarWeuRKsNgR7edfH9m/e220MTPoc
 rDNpW3Mka1RvzRPVFp88qFiKTtp95HL3+cFR7x/SisdCBYEqgBCJ8v6PMJdXYfsKhF7a
 dowQVleTQNsWErw2r2PpALpi0SspDvAD4m8i0RHHcbL85WY6Kcd4MWjGQ4SKv7zk5SjJ
 FbVg==
X-Gm-Message-State: AOAM532YkRORD9PamhB5KVz5hdinWOYaq/c5pn0haD6PaPCi9M2rt1lL
 87TAYdDqQhLd3AyQiUEtZseRhxfi9YILl/kVw6ir1g==
X-Google-Smtp-Source: ABdhPJx3beQLA6Exa34usZeWGS90LrFIRhJdB6bFa0aoD9WnPvbYQSNgzWCFK78zxakZi46J/AfYpiP05Zuk0luuy8g=
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr4086753edq.52.1600780732624; 
 Tue, 22 Sep 2020 06:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200922130806.1506324-1-pbonzini@redhat.com>
In-Reply-To: <20200922130806.1506324-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 14:18:41 +0100
Message-ID: <CAFEAcA8kovt998Ds0jbEAJTqkHmJETcHvfwqCS-JZWWW+=wLrw@mail.gmail.com>
Subject: Re: [PATCH] coverity_scan: switch to vpath build
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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

On Tue, 22 Sep 2020 at 14:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This is the patch that has been running on the coverity cronjob
> for a few weeks now.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-scan/run-coverity-scan | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
> index 6eefb4b558..7395bbfad4 100755
> --- a/scripts/coverity-scan/run-coverity-scan
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -380,15 +380,17 @@ export PATH="$TOOLBIN:$PATH"
>
>  cd "$SRCDIR"
>
> -echo "Doing make distclean..."
> -make distclean
> +echo "Nuking build directory..."
> +rm -rf +build

As Philippe points out, odd name choice.

It might also be nice to steal the logic from configure
that avoids blowing away the build directory if it
wasn't created by this script in the first place.

> +mkdir +build
> +cd +build

I think this 'cd' will break use of the --results-tarball
option with a relative path (eg "--results-tarball my-tarball.tgz")
because it will now end up interpreted relative to the build
subdir rather than relative to the source directory.

>  echo "Configuring..."
>  # We configure with a fixed set of enables here to ensure that we don't
>  # accidentally reduce the scope of the analysis by doing the build on
>  # the system that's missing a dependency that we need to build part of
>  # the codebase.
> -./configure --disable-modules --enable-sdl --enable-gtk \
> +../configure --disable-modules --enable-sdl --enable-gtk \
>      --enable-opengl --enable-vte --enable-gnutls \
>      --enable-nettle --enable-curses --enable-curl \
>      --audio-drv-list=oss,alsa,sdl,pa --enable-virtfs \

This comment at the top of the script:

# This script assumes that you're running it from a QEMU source
# tree, and that tree is a fresh clean one, because we do an in-tree
# build. (This is necessary so that the filenames that the Coverity
# Scan server sees are relative paths that match up with the component
# regular expressions it uses; an out-of-tree build won't work for this.)

is now out of date and needs rephrasing.

PS: on the subject of component regexes, they seem to have
vanished from the Coverity website. I don't suppose you have
a backup of them, do you ? (I have a list of what the component
names were, but not the associated regexes.)

thanks
-- PMM

