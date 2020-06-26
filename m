Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BB22080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKVEbIi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BB22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jomHO-0002om-4b
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jomGi-00028Y-AN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:11:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jomGe-00065m-NX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:11:40 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so8263376otj.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tD71sa0xYPaWy6eynOdIiWluMBJFn+QbGnkZOeTLkIQ=;
 b=MKVEbIi3bWy4o1+f+yvbMN740W72sF9ZtJNvotDySBSEhBdn/mdm9Va5Gi91tp5fJE
 ScCxSDV1gAaSEwNdKu4brzvOEjqobKETNe+1OX3knyAs/nQ62EHg4lBPV62qhSJN4sV7
 9YnblNGjjssI5XJCkGNrZGGqXLr39WeJWiyEvB5kzu3VLzVrdaoNFnRRJrYTCmA/PgSS
 ZvZrFR2l4ofmWt2oEz7pWu3t4oIZ65WaWtldytnEQXMyPFz3ia4Bcyw/o9avV+rLxRlN
 TYBD6iGupP3JEEoeCtxK3EC1BjrIDMdE4EKfiAIHPDmc7273X473zao18mv8mML6UfOG
 rI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tD71sa0xYPaWy6eynOdIiWluMBJFn+QbGnkZOeTLkIQ=;
 b=id7FmYw+ogi43Jv4oQRp7d7TIlYxOqhgGRRbHTINiIpHF0FPgCmlefx581kTQvuW1F
 Sbjtp1Qz/3QnsFntQZJYY7CU1q3n5OB/QD44spADAKOyfNrJj2feQYQTdiICpi24yIS5
 wp4IvJyQ8NgaMoDPt0PFxlW+LzwfMuGA7p2fmn8HNzUfMY0n/1TydTkjW0gtGcOyiRNI
 aYwstPqNYGPr1XludWCpx7PPhq3+ut92tzUMbbJjeicjZnNwOvT8w7MQ6VPyK5UugMJ3
 99g1QiBBL8XQb9fgCOgn+y8OpGdqqdPhWpTHRWZ7zuu22/tBoevicLCwmp6U0Lx+iGD3
 LaVg==
X-Gm-Message-State: AOAM532JjVFIxwFedUUYQM+ecTiwQvrmhAw1EI5jlTGCdLU2/gUJeuN4
 7SqdEIsZnWhED0LINHEE0MU4p4KUCglr1dn3kwZQ6w==
X-Google-Smtp-Source: ABdhPJyIAWLWFUrZM+5K8IxICgW1lWtQAWvnIWU0Tz6ZOm4C6zXk9/K6yuq3vg2UofO6wpzAs6IATVg8MNmfW3t0ljo=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr1914636ooi.85.1593169894679; 
 Fri, 26 Jun 2020 04:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzFX3_kNmrLeuk7TCn9MQ5wwe-wWdDdWsGPBViuiHRAAg@mail.gmail.com>
In-Reply-To: <CA+XhMqzFX3_kNmrLeuk7TCn9MQ5wwe-wWdDdWsGPBViuiHRAAg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 12:11:23 +0100
Message-ID: <CAFEAcA-8fVstxegNFP9pVYi3v4iznqLd2GpGVvcYY6ZPazFVcg@mail.gmail.com>
Subject: Re: [PATCH 4/5] haiku build fix
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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

On Fri, 26 Jun 2020 at 11:09, David CARLIER <devnexen@gmail.com> wrote:
>
> From 775173ded5657de4d4b467f2f68e747f6a9c0750 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 26 Jun 2020 10:44:36 +0000
> Subject: [PATCH 4/5] Platform specific changes qemu_exec_dir implementation

If you could provide more detailed commit messages that
would be helpful (mostly it will save me having to expand
them myself when I apply the patches :-)).

> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/qemu/osdep.h |  4 ++++
>  util/oslib-posix.c   | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index ff7c17b857..da970cf654 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -388,6 +388,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #define HAVE_CHARDEV_PARPORT 1
>  #endif
>
> +#if defined(__HAIKU__)
> +#define SIGIO SIGPOLL
> +#endif

This isn't part of the qemu_exec_dir change, so it
shouldn't be in this patch.

> +
>  #if defined(CONFIG_LINUX)
>  #ifndef BUS_MCEERR_AR
>  #define BUS_MCEERR_AR 4
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 39ddc77c85..ff36fa41ff 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -38,7 +38,12 @@
>  #include "qemu/sockets.h"
>  #include "qemu/thread.h"
>  #include <libgen.h>
> +#if !defined __HAIKU__
>  #include <sys/signal.h>
> +#else
> +#include <kernel/image.h>
> +#include <signal.h>
> +#endif

osdep.h already includes signal.h, so you shouldn't need
to include it here. Looking at osdep.h it already includes
sys/signal.h for OpenBSD, so I think the right answer is:

In one patch:
 * have configure check whether sys/signal.h exists
 * change the "#ifdef __OpenBSD__" guard on including
   sys/signal.h in osdep.h to check CONFIG_SYS_SIGNAL instead
 * remove the #include of <sys/signal.h> from util/oslib-posix.c
   and hw/xen/xen-legacy-backend.c

In another patch:
 * have the workaround in osdep.h for Haiku not providing SIGIO

In a third patch:
 * have the new qemu_init_exec_dir() implementation (which
   should now only need to add kernel/image.h to the #includes
   in oslib-posix.c and not also change the signal related includes)

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
> +        *buf = '\0';
> +        while (get_next_image_info(0, &c, &ii) == B_OK) {
> +            if (ii.type == B_APP_IMAGE) {
> +                strncpy(buf, ii.name, sizeof(buf));
> +                buf[sizeof(buf) - 1] = '\0';
> +                p = buf;
> +                break;
> +            }
> +        }
> +    }
>  #endif
>      /* If we don't have any way of figuring out the actual executable
>         location then try argv[0].  */

thanks
-- PMM

