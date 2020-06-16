Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94479C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630CA2098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fas/Qeq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630CA2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlGOu-0006v4-MF
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 14:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlGNz-0006Il-LW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:32:39 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlGNw-00069w-PI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:32:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id i74so20193411oib.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bzYyUbnYXAeNe9Bej6UR4BBIi1PkOJ2G7dYBf27O9Gs=;
 b=Fas/Qeq8YhBamSEKgJBSeCrFQwyECQM9FM4uHd1q+yXlMAE7uRxahzf+t1zr8IZ50l
 KinlDkCCwNRy2ygF3AfP8v1AfREhdg3EqfZQbSAEYF1HMDHEZNTJMeET/adkpxISgJWw
 1QuzgsFeWow58OPstP2MSotYm0nwFLvGvaSCliyMb+q/D8xGQYNXkV6UIfraZOVMRsbO
 OvpINem6CI8Jb9D3uSbL/wv7j9bSC0vOsuiiXwLawQuw5CnIjZBr/BSNiY/SPUA5Twzt
 IAnOM2Y+ZsY2+50MPKl5keXB9hNQspqZ46VGNDAB7BwPZ5XOe6XMbABo/sir+4LeKeJJ
 SNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bzYyUbnYXAeNe9Bej6UR4BBIi1PkOJ2G7dYBf27O9Gs=;
 b=XhbBP7VIJNdfrk/tDdWfmHfAhVIYCLGAwgYLlWpA6NHdjJO0opvTZTCrMtxR8gAloY
 wCnAaEf7ODoTAx1pAz6KkpGKq+axhzyWurXFbQAMRx+4INDh3hX32vi5YQ0Jj6E8tosQ
 C9MLDv7VONt5ekjvLxHInxLWVSeZKXw6sYj+ucRhvWBSO8yLfX8zkimSDyahT+/SW0I7
 AdhKQlcjUSB/sb7uHbWN+YVjaxmNMUIJoOWCC60eJSNZpuREuh+YawCRdhkDCD7ROfe9
 Io40nLgVOd/YBGbxi0AHtHlHDjmYdQsmwpDZaD3Pb+D1IQT3M8C3V6OX09Qo2jDjJt/X
 UkEw==
X-Gm-Message-State: AOAM533eg3+6nl+OpWrez2RzLRZXt6Nj0k+Nk9G2N5zvusjrdt2r0UKw
 qCkVEiHATFfxqECRQqaJ2MHrnZ/Of1S6rhX93xppmQ==
X-Google-Smtp-Source: ABdhPJxuvMrHRPwKqZbqN5gyYgmCOa4l97FZyIlTypHJt0xxr1unY6V30B7hA0Q6iweKUYOPaInmrXUZAsFmMeJkoxE=
X-Received: by 2002:aca:568c:: with SMTP id k134mr4249179oib.48.1592332355418; 
 Tue, 16 Jun 2020 11:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqx6VjRhT6xBzJ-UYs7cPDXVK=PNdfNVdad3Tqhe43P=Ew@mail.gmail.com>
In-Reply-To: <CA+XhMqx6VjRhT6xBzJ-UYs7cPDXVK=PNdfNVdad3Tqhe43P=Ew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 19:32:24 +0100
Message-ID: <CAFEAcA_NjB4m6mg-cbH5WrLukSnMx4aZ=bpqoMHB1KLVV87iLg@mail.gmail.com>
Subject: Re: [PATCH V4] util/oslib-posix : qemu_init_exec_dir implementation
 for Mac
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 17:12, David CARLIER <devnexen@gmail.com> wrote:
>
> From 7eef8b803cdb0e7148fdf894d2992052695c1ff8 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 21:35:27 +0100
> Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac
>
> Using dyld API to get the full path of the current process.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/oslib-posix.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 916f1be224..3612c2c80e 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -57,6 +57,10 @@
>  #include <lwp.h>
>  #endif
>
> +#ifdef __APPLE__
> +#include <mach-o/dyld.h>
> +#endif
> +
>  #include "qemu/mmap-alloc.h"
>
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> @@ -375,6 +379,16 @@ void qemu_init_exec_dir(const char *argv0)
>              p = buf;
>          }
>      }
> +#elif defined(__APPLE__)
> +    {
> +        uint32_t len = sizeof(buf);
> +        if (_NSGetExecutablePath(buf, &len) == 0) {
> +     char fpath[PATH_MAX];

(Something seems to have gone wrong with the indentation here;
QEMU indent is always-spaces, 4-spaces-per-indent.)

> +            buf[len - 1] = 0;

_NSGetExecutablePath() will 0-terminate the string, so
you don't need to write this 0 here. (The function call
will fail if the buffer is not long enough for both the
path string and the terminating NUL character.)

> +      realpath(buf, fpath);

You need to check the return value from realpath() in
case it returns an error; compare the code just below
that handles calling realpath() on argv0.

> +            p = fpath;

This is setting p to a pointer to a buffer which goes
out of scope, and then using it after it's out of scope,
which is undefined behaviour. You can avoid that by
doing _NSGetExecutablePath() into the tightly-scoped
'fpath[]', and then doing realpath() into 'buf[]'
(which is still live to the end of the function).

> +        }
> +    }
>  #endif
>      /* If we don't have any way of figuring out the actual executable
>         location then try argv[0].  */

thanks
-- PMM

