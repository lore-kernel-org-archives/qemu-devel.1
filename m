Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5565AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4B5207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOix/pzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4B5207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPW6G-0003F0-GV
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPW4m-0001jC-Ey
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:23:12 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPW4j-0003UZ-Nj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:23:12 -0400
Received: by mail-ed1-x544.google.com with SMTP id c8so10727541edv.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jfIe+ax7/FYKwNc3Q73tdb1xfdCyd5kHUTSwCu2yi28=;
 b=LOix/pzZWUXv130EW4mNCyvbQN3jITwiB53XKl4t6lcvhrmJWMnin1+sllAGW/lsmm
 lSeCnmspCOElW+QIrrOJZBbeB6AMxyrYboYs0C/1/C21o0LQVIZoIbeZsmuPlTAHnr+t
 Pj90wKXK5Cljx9gnoHjfg+Eue7a+RDXfLBIGXuFOQoqJ0AEDBmMZJSaTMc66hGmtMn2x
 EAUJU/z7Xq0R8b3fBHEDBGgqNM7h1BxTlr6/CojXeoL6UFXSEXAUM2J6I4D+JjLFRzKw
 JTD/hX0LyqLD9sh07NquLijY86pJ/A6GgBPz0Z2T3cWzZh/kDY8oOZVw3jb+tJFJJ1Ks
 MKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfIe+ax7/FYKwNc3Q73tdb1xfdCyd5kHUTSwCu2yi28=;
 b=S0D1kJHzzNfsuFSUZAcCOxwK+MO4QZV/rJVXWdNwa8dbLWXw3W2W+fDCB+F5ZMofv4
 2ayJWjTPeF08G+LiuSFow2iNzyXZGMk63LJ/BwC5fPhsmyPGN0xC1ZcGZSkir0F1Pizc
 +7bbTJfKk33ap918lh49YAutu2Ia1d8M+8OAE4Ix0gkeefINdfJu6WQyDRWVjEHNVbNN
 7iYElwNR0BMSqtIt6AXuMbnEKrXaDvjUOeGm895P3rVJIO2Cy6SUWFkUdKAi9SeGFaXW
 NbJlk3hhhfw4/4tRtjjBNTmFu4oqtbjUAWKiiRDZUMRl4KQdZdQzdJIqYekzPpmyeCDx
 OgQw==
X-Gm-Message-State: AOAM530WxJGTJM+MUE5CVl8M1KeFvt9C9MGyvd9/2WVt9O05x+mDfYSz
 MmWHwXbVzurRP1ey8cCzXff/K+7kA8ppSe2jix9iOA==
X-Google-Smtp-Source: ABdhPJztg9Jl/vqrrvBKB6rrPrTKbntL6coa+W8TGAbGNB+vi7f2LYgEQaDfh61+8vTepoeKkizUye90zQ+vfx8la6U=
X-Received: by 2002:aa7:d75a:: with SMTP id a26mr1346328eds.36.1601925787570; 
 Mon, 05 Oct 2020 12:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201005172109.416-1-luoyonggang@gmail.com>
In-Reply-To: <20201005172109.416-1-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2020 20:22:56 +0100
Message-ID: <CAFEAcA95r2FZibphrO0N_rckWOKigM_d80Qi0grtpWWzN3d19A@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Convert qemu-version.sh to qemu-version.py
To: Yonggang Luo <luoyonggang@gmail.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 at 18:24, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> The sh script are harder to maintain for compatible different
> xsh environment
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  meson.build             |  2 +-
>  scripts/qemu-version.py | 30 ++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 31 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
>
> diff --git a/meson.build b/meson.build
> index 95a532bd29..20f653b6eb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1072,7 +1072,7 @@ tracetool = [
>     '--backend=' + config_host['TRACE_BACKENDS']
>  ]
>
> -qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
> +qemu_version_cmd = [find_program('scripts/qemu-version.py'),
>                      meson.current_source_dir(),
>                      config_host['PKGVERSION'], meson.project_version()]
>  qemu_version = custom_target('qemu-version.h',
> diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
> new file mode 100644
> index 0000000000..384c54027d
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env python3
> +
> +# Script for retrieve qemu git version information
> +# and output to stdout as QEMU_PKGVERSION and QEMU_FULL_VERSION header
> +# Author: Yonggang Luo <luoyonggang@gmail.com>

Can we have a license statement in all new files, please?

> +
> +import sys
> +import subprocess
> +
> +def main(args):
> +    if len(args) <= 3:
> +        sys.exit(0)
> +
> +    dir = args[1]
> +    pkgversion = args[2]
> +    version = args[3]
> +    pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
> +        stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, cwd=dir)
> +    if pc.returncode == 0:
> +        pkgversion = pc.stdout.decode('utf8').strip()
> +    fullversion = version
> +    if len(pkgversion) > 0:
> +        fullversion = "{} ({})".format(version, pkgversion)
> +
> +    version_header = '''#define QEMU_PKGVERSION "{}"
> +#define QEMU_FULL_VERSION "{}"'''.format(pkgversion, fullversion)
> +    sys.stdout.buffer.write(version_header.encode('utf8'))
> +
> +if __name__ == "__main__":
> +    main(sys.argv)

Wow, python really makes this kind of task clunky compared to shell...

This doesn't seem to be the same logic as the original shell.
I'm not too familiar with python, but:
 * the shell script doesn't run git if pkgversion is not the empty string
 * the shell script doesn't run git unless the .git directory exists
If these are intentional behaviour changes you should mention
them in the commit message.

Also worth mentioning that you're fixing the bug in the shell
script where we ignore the output from git (the intention was
to ignore a failure from git but otherwise to keep its output;
this patch:
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/
is the fix for that in the existing shell script).

> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> deleted file mode 100755
> index 03128c56a2..0000000000
> --- a/scripts/qemu-version.sh
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -#!/bin/sh
> -
> -set -eu
> -
> -dir="$1"
> -pkgversion="$2"
> -version="$3"
> -
> -if [ -z "$pkgversion" ]; then
> -    cd "$dir"
> -    if [ -e .git ]; then
> -        pkgversion=$(git describe --match 'v*' --dirty | echo "")
> -    fi
> -fi
> -
> -if [ -n "$pkgversion" ]; then
> -    fullversion="$version ($pkgversion)"
> -else
> -    fullversion="$version"
> -fi
> -
> -cat <<EOF
> -#define QEMU_PKGVERSION "$pkgversion"
> -#define QEMU_FULL_VERSION "$fullversion"
> -EOF

thanks
-- PMM

