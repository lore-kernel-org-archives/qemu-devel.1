Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C8C43467
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E163220790
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecyqeaXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E163220790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4vK-0003aa-Me
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS4cz-0004fA-PL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:41:06 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS4cs-0003d5-5Y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:41:05 -0400
Received: by mail-lj1-x241.google.com with SMTP id f21so18154844ljh.7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ftMiYdWCTtdk34xLW8mEN0AbZBeQdlhBsW7+2yks58=;
 b=ecyqeaXgj/e0i3EQrIWMhM386lxtY73BLRInntmrQZpjR5Ovn7q2KQEJ8aMz8YHvPZ
 tIkjXEEfF8YgCmZE1gdjZJH3fvY1BIpN8hcj8VK1CNHwR++xIao8CrF3RaKE+vW5xT7P
 Ve2863W+Fbx1mwrSJPmHxxHXHRLbS4TodZuwZLjGwrBDBEcoBvxydRiuobMnbDU7jLom
 RkWpMm3CjRBF8tLSYb38HWSnkEAGb0rN96I7eUzYofc/G5dLgYyC+FtERAvsExc/LyyP
 Xt5TLnyCN2jqKz5pxvpCDGUqcZixXQsIoH24KstURjPAnOW9necVv3RxxifW4ws52naP
 cgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ftMiYdWCTtdk34xLW8mEN0AbZBeQdlhBsW7+2yks58=;
 b=eZhrKOiEN/KEcwhH8QTrrY+Rhrut9+GoTJ2PtdsN3v5EDMRz8l9LEePgUDYMFfG/BW
 r6St1Uas5A8Nx/MEHRcuxQ76oiM4R12e+evl9AD/5kCBkISrQec4poVVJfwFMi+S+ni0
 GVLQb2DfZNuU2FO14QQVg97ipBNIhdqfc3zjKF0qxoavDBEeOIF8T1D4gznkfnMXswdO
 3bYsaFNEbLzd5hJk5hQAvj9aASfoZgVqXrSGrlsqckOXRBIA/wN4USwLYRcWIzsAZdPJ
 gDY+KJRDxhlZGeJs6MZoo5ZZSpea/WTCOVlH9FD3S8YEbYEEnSgZAXiHwgyCrRKZZves
 RUZw==
X-Gm-Message-State: AOAM532nJjUlwoFQU/RKX5ILmmFjvwfBGFKjDm96kQjCBzs7p6i5vOSH
 yvTRiIbMjWCC8JUqLMUhyRbrAtrhl2EyrIbWy+o=
X-Google-Smtp-Source: ABdhPJz7KUaoSQKDk+MYwDmByy4F39JZ/ax9jd7ZMO7rParp5ePfJ9ImKtP0il8rkqwmX1dHcip2FxxIq/6HumWWdgk=
X-Received: by 2002:a2e:9ccd:: with SMTP id g13mr2058189ljj.127.1602535256304; 
 Mon, 12 Oct 2020 13:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201012200725.64137-1-jandryuk@gmail.com>
 <20201012200725.64137-2-jandryuk@gmail.com>
 <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
In-Reply-To: <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 12 Oct 2020 16:40:44 -0400
Message-ID: <CAKf6xpuyr818af9ucB-vpL9JXtmsATJaP--UWRgTjRku_G82mQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel: move qtest CpusAccel functions to a common
 location
To: Claudio Fontana <cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 4:23 PM Claudio Fontana <cfontana@suse.de> wrote:
>
> On 10/12/20 10:07 PM, Jason Andryuk wrote:
> > Move and rename accel/qtest/qtest-cpu.* files to accel/dummy/ so they
> > can be re-used by Xen.
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > ---
> >  .../qtest-cpus.c => dummy/dummy-cpus.c}       | 22 +++++--------------
> >  .../qtest-cpus.h => dummy/dummy-cpus.h}       | 10 ++++-----
> >  accel/dummy/meson.build                       |  6 +++++
> >  accel/meson.build                             |  1 +
> >  accel/qtest/meson.build                       |  1 -
> >  accel/qtest/qtest.c                           |  7 +++++-
> >  6 files changed, 23 insertions(+), 24 deletions(-)
> >  rename accel/{qtest/qtest-cpus.c => dummy/dummy-cpus.c} (76%)
> >  rename accel/{qtest/qtest-cpus.h => dummy/dummy-cpus.h} (59%)
> >  create mode 100644 accel/dummy/meson.build
> >
> > diff --git a/accel/qtest/qtest-cpus.c b/accel/dummy/dummy-cpus.c
> > similarity index 76%
> > rename from accel/qtest/qtest-cpus.c
> > rename to accel/dummy/dummy-cpus.c
> > index 7c5399ed9d..efade99f03 100644
> > --- a/accel/qtest/qtest-cpus.c
> > +++ b/accel/dummy/dummy-cpus.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * QTest accelerator code
> > + * Dummy cpu thread code
> >   *
> >   * Copyright IBM, Corp. 2011
> >   *
> > @@ -13,21 +13,14 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/rcu.h"
> > -#include "qapi/error.h"
> > -#include "qemu/module.h"
> > -#include "qemu/option.h"
> > -#include "qemu/config-file.h"
> > -#include "sysemu/accel.h"
> > -#include "sysemu/qtest.h"
> >  #include "sysemu/cpus.h"
> > -#include "sysemu/cpu-timers.h"
> >  #include "qemu/guest-random.h"
> >  #include "qemu/main-loop.h"
> >  #include "hw/core/cpu.h"
> >
> > -#include "qtest-cpus.h"
> > +#include "dummy-cpus.h"
> >
> > -static void *qtest_cpu_thread_fn(void *arg)
> > +static void *dummy_cpu_thread_fn(void *arg)
> >  {
> >  #ifdef _WIN32
> >      error_report("qtest is not supported under Windows");
>
> I wonder if this should be changed to "dummy cpu thread is not supported under Windows".
>
> Does not matter probably.

I left it since I was just moving the file.  But...

> > diff --git a/accel/dummy/meson.build b/accel/dummy/meson.build
> > new file mode 100644
> > index 0000000000..5fbe27de90
> > --- /dev/null
> > +++ b/accel/dummy/meson.build
> > @@ -0,0 +1,6 @@
> > +dummy_ss = ss.source_set()
> > +dummy_ss.add(files(
> > +  'dummy-cpus.c',
> > +))
> > +
> > +specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)

...  I don't really know meson, but this file is guarded by
CONFIG_POSIX?  If that's true, then this ifdef can just go away.

Regards,
Jason

