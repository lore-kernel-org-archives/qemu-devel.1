Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A628C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5AF20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYKHCL9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5AF20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jts9r-0000w4-0p
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jts8s-000070-9C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:28:38 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:35640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jts8q-0003cA-Jy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:28:38 -0400
Received: by mail-oo1-xc44.google.com with SMTP id k47so965935ool.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tAhT98u+mXtGg8InJai9YyGZoVTk/YzjhatPhr0w4j4=;
 b=RYKHCL9YZ2uGdLV3qLqKwS0h8C+W4tKuPcfkLSlRGlRzsi9AZSsieZoEneO9O2HwT2
 tkAeEIOEfkAiLDidzL87+9pRWHh4W/L14opLO2XizcbHOPqVKRdZkZYqnPAT6AXi3D6N
 mvR6agLS1Vp0uOlKPhSC6ZuljAL1oSW1xdtGDhgj+MUDYdRBkxCI5PV4/rnKds7DMyBc
 0P/XBOtwGVt4JAZh11kXhiPc1M0j6IuiUApnU9MBzgan/RMMjOi7M30CoSIk1Y0Khm8t
 0Y4x9dNmqG6KyQ4BBJ0TJFrH9DADZKNNvvz622ic2h1wrbV13olP1JRsEF7SMRpme/Wd
 Y6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tAhT98u+mXtGg8InJai9YyGZoVTk/YzjhatPhr0w4j4=;
 b=VI3S+7Zo8LxSgPKugn6cBp2NIuqawnELURnU3vBSxaA9skyQwwbUjMqpNvUMf8LRrZ
 wPmzDN7bc1EDgvzvtIMS/HT5fpRDBflxDqm/ugng2dte0iBAgsrh4xmCZoNHnskh1mkl
 7lNMEvc1W+oUX0EOkaGneFle9KXwY9ThBXCr4bCUaNoAkT/Szru/m/FR6vmUMwaD/vJT
 1jQBxrUjyScZI4xjU7nOWnteVJWBc55qaq2bNeDIS2s6VhBUneKGuaBTLNFM8wXsb0Lf
 iKidxAbKQ6Wn7XJjIHo0BAHjVo5Z91/X4TxrS+lAZJ6ihs3kdIq++Py8HK1T2D8SAfHe
 ktcQ==
X-Gm-Message-State: AOAM530Ouepr/sIBl3KZiVxpktT02bC/9RmiKQeBb2jZgb9HFaE6AAgc
 HtaJXO7GMfCNIlWsxbvAvMdzc8JQ6WZgjTj9597uwQ==
X-Google-Smtp-Source: ABdhPJzrA0ZRH0Y/GANJW8bSmqkS989NYu06mdp9rim1weLKHLXoMWxM9sSP31Ccb5GV5eyvhHPNoeb4xWkHgTKYWMc=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr51426224ood.69.1594384115344; 
 Fri, 10 Jul 2020 05:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 13:28:24 +0100
Message-ID: <CAFEAcA-hVrJ90E=qQP+3CONPozQLrnaAP3LC1DwP7KuJ0nAwQA@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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

On Fri, 10 Jul 2020 at 13:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 8 Jul 2020 at 22:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit eb2c66b10efd2b914b56b20ae90655914310c925:
> >
> >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-06' into staging (2020-07-07 19:47:26 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 392f34e59755f99d69586a63e0f5d80a7ef67f94:
> >
> >   apic: Report current_count via 'info lapic' (2020-07-08 10:01:08 -0400)
>
> Hi; this still has the OSX failure, I'm afraid:
>
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: implicit
> declaration of function 'cpu_throttle_set' is invalid in C99 [-
> Werror,-Wimplicit-function-declaration]
>         cpu_throttle_set(throttle_pct);
>         ^
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: this
> function declaration is not a prototype [-Werror,-Wstrict-prototypes]

Squashing this into "cpu-throttle: new module, extracted from cpus.c"
should fix this (ui/cocoa.m was just forgotten when adding #include lines
after moving the function into its own header):

diff --git a/ui/cocoa.m b/ui/cocoa.m
index cb556e4e66..0910b4a716 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,6 +32,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
+#include "sysemu/cpu-throttle.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-misc.h"

(am just doing a compile-and-test run with that change).

thanks
-- PMM

