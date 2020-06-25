Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1037EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 20:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DC3206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 20:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7p6LH4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DC3206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joYHn-0003N3-15
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 16:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joYH4-0002lG-Vy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 16:15:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joYH2-0000nl-DH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 16:15:06 -0400
Received: by mail-ot1-x342.google.com with SMTP id k4so3339223otr.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M3sfa9UB0nyQvlAY8Xm9cS8h6o6s1/TOY4XM/KOtTZM=;
 b=y7p6LH4NaZlX2U96oBq+Bqj2OGZIGLZMuyIQAfNDKjlSWF97Wd5A3OOipQBXnZQEdN
 eN6Uh7/7OdJ3TCvmoNotKWE6edZTdtKrLOKteEIbNQ2y+byWYeaC3CZjOCyv96JHtYB/
 pcvSCyFpeSDQccWxlrsukqFPilYnesGDTnFHuS2HnVWau6MMhmQh9ulow4WSladt2AqS
 +K2ccCCoLfV31kXhy4UtJdQynBA+fMNNx45JfNdFdlh7+7FK4nBrrqwhE1KdpduTXynA
 Dtg+iJgd7JYI1V8gfWX6c5MilQNrjIkn/4vtJ3IRvGSu97c6yatGE4ISz57RgHzIFlZn
 mYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M3sfa9UB0nyQvlAY8Xm9cS8h6o6s1/TOY4XM/KOtTZM=;
 b=hQ1zH68ExGPOvmqvYghiocykOoNeUgoSxOIl+PhkPr0VKL6miSy48S+vsVLwPF5INc
 N/ADUwZMFalAqtXa5pJeD1mcNOM0RbAGjZNCFPWDUvWAMFXvWZa1zJ7cbtv7P4z8oi7R
 M4Y+PKPitY+Z6ZkRyBuR5tiNXfvvUYsXTFFHkDvMe/o0OsXlmIhf3lFDM6b6ngvod/Jk
 xVZ9JeoeShOUb9QUiXuk06ARVl6iCmWKn10JTOAZF7x7aR6/oJkLtvScPzNZ1FquIXEB
 8sDpYxivt8WtYLYx7UKUe1poLIVnIQaWROOKSod1u8qflFSH/hIm9X3qi834FfJGbInd
 JUIg==
X-Gm-Message-State: AOAM530hIVUyX4SgUcG86OBjMVPPTABaSCRwGRph0GoBeDHdwxLsiJaU
 FPPKF/d1fns2IXccH6IdO4cCcD4xy2HhOa5UkOuRRw==
X-Google-Smtp-Source: ABdhPJz7V5h+G9SoUAAB2XjWzkw9nfhMNM25o+8yqpSXglJ3/ZXmgsFkfuizGfPz4lo7EdAVxypIMPP1emJhaQZn28U=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr27111673otn.221.1593116102477; 
 Thu, 25 Jun 2020 13:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqyTLP5_Jf=t8OCsMifrme0DgimM8-D=Y0RRR+779052Bg@mail.gmail.com>
In-Reply-To: <CA+XhMqyTLP5_Jf=t8OCsMifrme0DgimM8-D=Y0RRR+779052Bg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 21:14:50 +0100
Message-ID: <CAFEAcA_hSMxAFj5yNcmBKicgmbE-rSr8ih0j-z8KbjnxDmby4A@mail.gmail.com>
Subject: Re: build: haiky system build fix
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Thu, 25 Jun 2020 at 19:37, David CARLIER <devnexen@gmail.com> wrote:
>
> From 25adbdcdc17ef51a41759f16576901338ed8a469 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Thu, 25 Jun 2020 19:32:42 +0000
> Subject: [PATCH] build: haiku system build fix
>
> Most of missing features resides in the bsd library.
> Also defining constant equivalence.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> --

Hi; thanks for this patch. I have some review comments
below, mostly relating to better ways to implement
the compatibility fixes.

> diff --git a/os-posix.c b/os-posix.c
> index 3cd52e1e70..ca07b7702d 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -42,6 +42,8 @@
>  #include <sys/prctl.h>
>  #endif
>
> +#include <sys/mman.h>

I think this either should not be necessary, or if it's
fixing something the fix should be elsewhere. For
POSIX-compatible host OSes, sys/mman.h is included
via include/sysemu/os-posix.h which in turn is pulled in
by include/qemu/osdep.h, which is always included by every
C file in QEMU. I think looking at configure that Haiku
host builds should set CONFIG_POSIX, so I would expect
that sys/mman.h has already been included here.

> +
>  /*
>   * Must set all three of these at once.
>   * Legal combinations are              unset   by name   by uid
> @@ -339,10 +341,12 @@ int os_mlock(void)
>  {
>      int ret = 0;
>
> +#if !defined(__HAIKU__)
>      ret = mlockall(MCL_CURRENT | MCL_FUTURE);
>      if (ret < 0) {
>          error_report("mlockall: %s", strerror(errno));
>      }
>
> +#endif

If Haiku doesn't support an mlockall() equivalent, then the
correct implementation of os_mlock() for it is to return
-ENOSYS -- compare the Win32 stub version in
include/sysemu/os-win32.h.

Also, in general we prefer configure to do feature tests,
rather than for the source code to have OS-specific ifdefs.
So here you'd want a configure test for "does the system
provide mlockall()?", and then the implementation would
be guarded with CONFIG_MLOCKALL.

>      return ret;
>  }
> diff --git a/util/compatfd.c b/util/compatfd.c
> index c296f55d14..ee47dd8089 100644
> --- a/util/compatfd.c
> +++ b/util/compatfd.c
> @@ -16,7 +16,9 @@
>  #include "qemu/osdep.h"
>  #include "qemu/thread.h"
>
> +#if defined(CONFIG_SIGNALFD)
>  #include <sys/syscall.h>
> +#endif
>
>  struct sigfd_compat_info
>  {
> diff --git a/util/drm.c b/util/drm.c
> index a23ff24538..8540578c09 100644
> --- a/util/drm.c
> +++ b/util/drm.c
> @@ -38,9 +38,11 @@ int qemu_drm_rendernode_open(const char *rendernode)
>
>      fd = -1;
>      while ((e = readdir(dir))) {
> +#if !defined(__HAIKU__)
>          if (e->d_type != DT_CHR) {
>              continue;
>          }
> +#endif

Does Haiku really provide /dev/dri ? If not then rather than
making this code which can't be used on this host OS compile
it would probably be better to just arrange that it doesn't
get compiled. I suspect that the answer here is that the
$(CONFIG_POSIX) guard on compiling drm.o in util/Makefile.objs
should really be a $(CONFIG_LINUX).

>
>          if (strncmp(e->d_name, "renderD", 7)) {
>              continue;
> diff --git a/util/main-loop.c b/util/main-loop.c
> index eda63fe4e0..1ce3081ced 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -85,6 +85,9 @@ static int qemu_signal_init(Error **errp)
>       * by sigwait() in the signal thread. Otherwise, the cpu thread will
>       * not catch it reliably.
>       */
> +#ifndef SIGIO
> +#define SIGIO SIGPOLL
> +#endif

If Haiku's SIGPOLL really behaves like Linux's SIGIO then
include/qemu/osdep.h is the best place to put this kind
of fixup, so that all files get the benefit of it.

>      sigemptyset(&set);
>      sigaddset(&set, SIG_IPI);
>      sigaddset(&set, SIGIO);
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 39ddc77c85..a18d90a68a 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -38,7 +38,12 @@
>  #include "qemu/sockets.h"
>  #include "qemu/thread.h"
>  #include <libgen.h>
> +#if !defined(__HAIKU__)
>  #include <sys/signal.h>
> +#else
> +#include <kernel/image.h>
> +#include <signal.h>
> +#endif
>  #include "qemu/cutils.h"
>
>  #ifdef CONFIG_LINUX
> @@ -390,6 +395,21 @@ void qemu_init_exec_dir(const char *argv0)
>              }
>          }
>      }
> +#elif defined(__HAIKU__)
> +    {
> +        image_info ii;
> +        int32_t c = 0;
> +
> +    *buf = '\0';
> +    while (get_next_image_info(0, &c, &ii) == B_OK) {
> +            if (ii.type == B_APP_IMAGE) {
> +                strncpy(buf, ii.name, sizeof(buf));
> +            buf[sizeof(buf) - 1] = '\0';
> +        p = buf;
> +                break;
> +            }
> +        }

Your indentation here has got messed up.

> +    }
>  #endif
>      /* If we don't have any way of figuring out the actual executable
>         location then try argv[0].  */
> diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
> index 2e8b43bdf5..c29fc2cbf9 100644
> --- a/util/qemu-openpty.c
> +++ b/util/qemu-openpty.c
> @@ -35,7 +35,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>
> -#if defined(__GLIBC__)
> +#if defined(__GLIBC__) || defined(__HAIKU__)
>  # include <pty.h>
>  #elif defined CONFIG_BSD
>  # include <termios.h>

This would be neater if we dropped the GLIBC/HAIKU check
in favour of a configure "is openpty() in pty.h?" test.

thanks
-- PMM

