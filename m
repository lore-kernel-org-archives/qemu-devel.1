Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE67C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325FB20C09
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdZHN1Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325FB20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKjBs-0001g2-85
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 10:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKjBE-00014O-8q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:22:04 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKjBC-0006jO-LP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:22:03 -0400
Received: by mail-ed1-x541.google.com with SMTP id j2so16318371eds.9
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XdVd6lRbP+mNS02CmnBaJNdwO+evQ8zAYOPM5MeA1tg=;
 b=tdZHN1RjmDnRzgPxjrAeZ+hUkQ455pgXyQ05Ic2jy1Opk8veMkduJI0+4/JRo6Do5T
 XCUYWJZgz0AbZ7ZaGAMJa7RUAEo3CgiAjrUJ5DBFnPX4j70UXxQJcj/Dw5SjA+qKLHVu
 WUW5MQtHkr0Vquezu2uN5XOT4HhE6XBoC4ni7ZluGELTvSg4VLgLv1umsEBccrAT4uYi
 NGhmZAWpNiapiJyLiewL31zvw0vRMv/DA7rC6tDFJKo92x7MJjcHtSx+/1tUTm4D7YMm
 eJH0c21yIVvWbIdVdhtz1CVlsiRiO0gGbQxUAUQZautGlzsaS2EdtYSSSl6D4JvdQ3JA
 VQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XdVd6lRbP+mNS02CmnBaJNdwO+evQ8zAYOPM5MeA1tg=;
 b=LsgJhyH80hFVoB3u8Zz6RU6s/M/VYlsBlrNUb7Jz0fQVyFaEz/iwq5IVUX+/o1C16y
 VNPYiJLc/g59f0mplH4+78LrJz9VJFxh4LM3Hn5d6uvXSWZvKJ1e8cHItsk/dibgwg1L
 uoazmSzunACiWbYP0zHDRci0hPCYnA3tNHBpaq2xM5FXHlaQNukT7ad1N5aBS0klGvxz
 NpxMMJ8/ficw9pWmY3VMe4r86aIhtTezg/CsUjiReaIF90N0t5c3jVCSxeAOQmLbLZ0j
 oy7GQWfS3wWHEU61OIVqYiDVhI1JFLBquMt3OQoLynqQPrNKITgY03NDOGHZI9f7G23e
 TX1g==
X-Gm-Message-State: AOAM532tI6oYxktW3ZWZWhmaBZe6AYtUDod1cB/+Z3Lw83nOQCJ5b8rQ
 A4cMpWe0R/fuKfAA1RPV3EEenkqi7jRnOXaUCP3t2g==
X-Google-Smtp-Source: ABdhPJxkoA1PEDiKzcj0xNHgVXfVkEzQM19SM2h/sJlwqWn6swoR2pKUMeeGqKOoBnqjJ4S3OVuLzUxN6jdXLKCsYQE=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr4089806edv.146.1600784520645; 
 Tue, 22 Sep 2020 07:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
 <87wo0mqavm.fsf@dusky.pond.sub.org>
 <CAFEAcA8uYhrpsYM5u+0MJKOK3R_NwPefC1jdJMYF3VWohe4mfA@mail.gmail.com>
 <873639q4qx.fsf@dusky.pond.sub.org>
In-Reply-To: <873639q4qx.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 15:21:49 +0100
Message-ID: <CAFEAcA-8VMwkYJFUepFqodrnMu1Y-kGeEM+bxFYNGqw7ybTwSg@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
To: Markus Armbruster <armbru@redhat.com>
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

On Tue, 22 Sep 2020 at 15:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 22 Sep 2020 at 13:01, Markus Armbruster <armbru@redhat.com> wrote:
> >> If you'd prefer to (re-)add it later, stick in TODO comment.
> >
> > Where would you want a TODO to be ?
>
> Before the patch, the licensing information is in
> docs/interop/qemu-ga-ref.texi.  That file gets replaced by
> docs/interop/qemu-ga-ref.rst, losing the licensing information.  What
> about putting the TODO right there?

I can if you insist, but what makes that .rst file any
different from all the other .rst files we have in docs/
which go into our various manuals and don't have explicit
licensing comments or reader-visible text?

If we want to improve how we inform readers of the docs
license, we might:
 * add a license note to the existing copyright footer line
 * or to have every page to have a larger copyright/license
   text section at the bottom
 * or to have the interop and other manuals have a license.rst
   like the system manual does currently,
and none of those changes would require editing qemu-ga-ref.rst
or qemu-qmp-ref.rst, because the overall problem being addressed
isn't specific to those parts of the documentation, it's a
wider one that you'd fix in a different place.

thanks
-- PMM

