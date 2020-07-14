Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B264AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B59520658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsRPp4iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B59520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRvp-0001io-O5
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvRv9-00015R-W8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:53:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvRv8-0003E1-0k
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:52:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id r8so65669oij.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h3OqVDua9rI0LQfK4/qcIuTZ9e9E4RGmXdKfFSMaRcE=;
 b=YsRPp4iDG3rI8ta+MSGKFVeANfDSBRdJnHSwWjUkF3kBKraLwX4yj7up26UiPFGnTm
 j8f/SC8AZfj3dbiraryqNfu3NcyYhg3ABDRCfcQv2YPR65GlRAAIBcRyYw1UKaiNwLKv
 ORNxruNnBZJcXvnjrr4tk1oGLFVfmXTPWt5MjFHeAvBnIWLcCow/v9dcBOfjcUVvs/mo
 NT8Yx/ssygrAUWWBnPd1WqsoFnn64GAXqYj3O/k+E254cm6e4BCTYGfDz09gCdf17+2U
 axczQfmnFm6iKB7i4tNmadr3tNsZCkRZk0fEaY7F9DissR3MPxILEJXryCzhMbtK8EeC
 Xa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h3OqVDua9rI0LQfK4/qcIuTZ9e9E4RGmXdKfFSMaRcE=;
 b=eTCOMebTGmI39FUSNYQVuAY/OMm+8FwlEYLiEqBmtK4PKt1Su/EZuPRgjNeoVWzTDN
 RmbN/6PPQQYFzXHFykU+MLImL+pVZ8VC4rU38jieHdVEwEk+fau/tVRmw7wIsKxRZGyS
 i2g/mP4QjfxaKf9eZnRxzYTESdrTdK8kVgUTwjjKSZc1eCE2gS6C4WXcBfH5BZ1lZJJH
 GT0mJwn2qJMglou4L1EjDcnmU/0dDJovq7b4TnrB/jfFCHvmitpf8MdHsPuejPVwjS6K
 F1TkEqFU4DDprhvWHhmy3ppE4c3ZmZCRg1aWivh6HVe/YG1ycyWNRFqX5D8ZNH3NL7wA
 Y19A==
X-Gm-Message-State: AOAM530mkfKytubkcxvZ2cgHqOK4D3pAXdl7j4gLsenUE9RL+iX4q5Kj
 1Eehln1NJKoMYpdzLkjlVXvRzPeiO7VzdZWmgkR7tA==
X-Google-Smtp-Source: ABdhPJx6m0pGpSdKNwnQbtxIPVY1bDCRv8ueQzCzcTGzFdATp8wJF1ai0eBt70k11MUoy4sCWL+ud2Dtar/iODQxhMc=
X-Received: by 2002:aca:1706:: with SMTP id j6mr5049615oii.146.1594759976512; 
 Tue, 14 Jul 2020 13:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwMKk1eCNg-T15KRAa_e1-r0cmZ49f-135sppTFWpTerQ@mail.gmail.com>
In-Reply-To: <CA+XhMqwMKk1eCNg-T15KRAa_e1-r0cmZ49f-135sppTFWpTerQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 21:52:45 +0100
Message-ID: <CAFEAcA-N2BnE25+kXCmZV_KBJk6H3=De7eV0B-d+Qrjd=t5hzQ@mail.gmail.com>
Subject: Re: [PATCH v1] util: OpenBSD build fix
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 20:45, David CARLIER <devnexen@gmail.com> wrote:
>
> From e2103b86b031ab74ff4c8dd0a3944cb488c9333e Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 14 Jul 2020 21:34:59 +0100
> Subject: [PATCH] util: OpenBSD build fix.
>
> thread id implementation, using getthrid syscall.
> qemu_exec_dir implementation as beast as we can as
> path is not always possible to resolve this on this platform.

Hi; thanks for the patch.

These look like two separate changes, so they should be
in separate patches, please.

It would be useful to have a comment in the code documenting
what the limitations of the OpenBSD call are, and when
it's better than just using realpath() on the argv[0]
that we already have. (ie, in which cases is the argv[0]
which we get back via KERN_PROC_ARGV something other than
the argv[0] that was passed to the process?)

> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/oslib-posix.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 72907d4d7f..4a0cce15b4 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -56,6 +56,10 @@
>  #include <lwp.h>
>  #endif
>
> +#ifdef __OpenBSD__
> +#include <sys/sysctl.h>
> +#endif
> +
>  #ifdef __APPLE__
>  #include <mach-o/dyld.h>
>  #endif
> @@ -100,6 +104,8 @@ int qemu_get_thread_id(void)
>      return (int)tid;
>  #elif defined(__NetBSD__)
>      return _lwp_self();
> +#elif defined(__OpenBSD__)
> +    return getthrid();
>  #else
>      return getpid();
>  #endif
> @@ -408,6 +414,23 @@ void qemu_init_exec_dir(const char *argv0)
>              }
>          }
>      }
> +#elif defined(__OpenBSD__)
> +    {
> +
> +        char **args;
> +        size_t len;
> +        int mib[4] = {CTL_KERN, KERN_PROC_ARGS, getpid(), KERN_PROC_ARGV};
> +
> +        *buf = 0;
> +        if (!sysctl(mib, ARRAY_SIZE(mib), NULL, &len, NULL, 0)) {
> +            args = malloc(len);

If you want to use malloc() you need to check the return value.
But better to use g_malloc(), which can't return a failure value.

> +            if (!sysctl(mib, ARRAY_SIZE(mib), args, &len, NULL, 0)) {
> +                p = realpath(*args, buf);
> +            }
> +
> +            free(args);
> +        }
> +    }
>  #endif
>      /* If we don't have any way of figuring out the actual executable
>         location then try argv[0].  */
> --

thanks
-- PMM

