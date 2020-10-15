Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D93206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFsML8qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D93206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9vG-0002DP-QT
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT9tt-0001kU-Qm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:31:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:37603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT9tj-0003lK-RD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:30:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id o18so101761edq.4
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wrFLeU4SetJryMzz+UIdokuxNryLKkguIZpQdQh3h70=;
 b=VFsML8qA403FXa4mzGm0z31mokoIsA5HT3ReiO37UrxHNqkUqS5qYOm9zw/W0+6EgW
 a34FoP29gKG3q/2On4n1CvtanN0VDILaJ74hfPq3zNKh+Wgi0w5c6cwhya//beYIHkke
 pxJ9Xjx90LiniC+bUwOx66hNWOXeZg8a3C7TjD2UoBkllOO2KuYDwdYu928OfwSXb/fb
 OAL9C+jS7diOx1av9xivMs4DJte8inV8vf5ClcE4HSv343Ub6Md7EAtl5Si7WaM1h7hY
 7Sx7D7Zi8G/z26fMUxVdwcP0UshIF6f+kmtqHX+QS4xbKfyKXmQnnljS1DI7S3YKP+/r
 MEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wrFLeU4SetJryMzz+UIdokuxNryLKkguIZpQdQh3h70=;
 b=Z+lMChxUtpcZNqxKhfSO1qPsCcKg8R1osGnSiD8weKi5QNrsvXUuDZQwrdjuIDw2K+
 l72CKR1kDEVSqoiQQuF4HqJHIEgRySxlkIz1E6nCEpkpsOdQJa1HpqAHSYgMifgK19oQ
 YQrvjyc9qG46i9ojtKs4i+7up3B0hXtabi8fd4qzIo2tw3VTskHEyW8NBcR/WrSxbsW8
 qJdG3AGZJot3KsjUkJlogYLWOh0oxs70xIT9FQlFuRfgPSafdMJUMZsWf3LD1vSLN7a4
 hCMM2IFqcK8stBZ7yc3SwONGwHXuWmSvv1w+YI8BCaWNMCMr6py3pCVynq/Q1iPKrwA3
 Lrbw==
X-Gm-Message-State: AOAM5335qdK08a11WW65eV8X0G5ZhTV25/ioZgT7/v0F2EFA/B+DGH+G
 5axtpiKwOQ2DYwiM0KIyuVnii63dCDK6URn0IcIdWA==
X-Google-Smtp-Source: ABdhPJy1zAEkQDUm+Jk20MRUuxMiuWgffaKK9M+/gFdH4u3THF6QU59n5Yq/GAbxWoo8EH6ipgmmyqdcpfslwiobiv4=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr284272edf.52.1602793849478;
 Thu, 15 Oct 2020 13:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <20201015201035.1964-2-luoyonggang@gmail.com>
In-Reply-To: <20201015201035.1964-2-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2020 21:30:38 +0100
Message-ID: <CAFEAcA_BtP6vgHpV8zS6U4dCgmB3npfbCOKGd1XOg9Jd0j8=nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] docs: Fixes build docs on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 21:13, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  docs/conf.py                  |  2 +-
>  docs/sphinx/kerneldoc.py      |  2 +-
>  scripts/rst-sanitize.py       | 21 +++++++++++++++++++++
>  tests/qapi-schema/meson.build |  5 +++--
>  4 files changed, 26 insertions(+), 4 deletions(-)
>  create mode 100644 scripts/rst-sanitize.py
>
> diff --git a/scripts/rst-sanitize.py b/scripts/rst-sanitize.py
> new file mode 100644
> index 0000000000..26060f1208
> --- /dev/null
> +++ b/scripts/rst-sanitize.py
> @@ -0,0 +1,21 @@
> +#!/usr/bin/env python3
> +
> +#
> +# Script for remove cr line ending in file
> +#
> +# Authors:
> +#  Yonggang Luo <luoyonggang@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or, at your option, any later version.  See the COPYING file in
> +# the top-level directory.
> +
> +import sys
> +
> +def main(_program, file, *unused):
> +    with open(file, 'rb') as content_file:
> +        content = content_file.read()
> +        sys.stdout.buffer.write(content.replace(b'\r', b''))
> +
> +if __name__ == "__main__":
> +    main(*sys.argv)

Why doesn't the perl rune work? Your commit message doesn't say.

> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index 1f222a7a13..20a7641af8 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -251,18 +251,19 @@ qapi_doc_out = custom_target('QAPI rST doc',
>  # using an explicit '\' character in the command arguments to
>  # a custom_target(), as Meson will unhelpfully replace it with a '/'
>  # (https://github.com/mesonbuild/meson/issues/1564)
> +rst_sanitize_cmd = [find_program('../../scripts/rst-sanitize.py'), '@INPUT@']
>  qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
>                                    output: ['doc-good.txt.nocr'],
>                                    input: qapi_doc_out[0],
>                                    build_by_default: build_docs,
> -                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
> +                                  command: rst_sanitize_cmd,
>                                    capture: true)
>
>  qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
>                                    output: ['doc-good.ref.nocr'],
>                                    input: files('doc-good.txt'),
>                                    build_by_default: build_docs,
> -                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
> +                                  command: rst_sanitize_cmd,
>                                    capture: true)

thanks
-- PMM

