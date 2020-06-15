Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D3DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C2420739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6pGZGjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C2420739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuak-0005Mv-He
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jkuZB-0002r6-S6; Mon, 15 Jun 2020 15:14:45 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jkuZA-0002Nn-7h; Mon, 15 Jun 2020 15:14:45 -0400
Received: by mail-ej1-x642.google.com with SMTP id n24so18692541ejd.0;
 Mon, 15 Jun 2020 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/PZIkwcwhzhRlZneTkXlf5lYswFN8eMJy20kuMcHczQ=;
 b=N6pGZGjMLmUd8/7oYFH71fWWfLS242QkfYDwYOvXgZcDNDivjTEnzQ7Yu7dxZobn/u
 h1LHoPMGVAXhDA0FQYncQB6o5QuXLcJ+TY40PoXahYWrEnnRu3ykANuUXWHpqNx3Fouo
 Io37MJNqMiEGJ3UYUMoKmXvIooNRcMtZHjKIARPu7eR9kE2+OREZZKOT926UXFBLPQ3Y
 9ke/LdGnInMO7S5wzbfAZ4quIOl3W0/nOZ9q6PjaZ7Cw+NAdRuA6Jz2CPR4TGKG4GLxa
 B8rgwwtQovauan0SXjA65SX2cK882iXtZGMvzERw7+bTtCDUbviBriEIY09nxRWZPDBH
 cMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/PZIkwcwhzhRlZneTkXlf5lYswFN8eMJy20kuMcHczQ=;
 b=qxCgio2otgdgjetnqfzG23ZmTMNdEIKsIkH3GspMpbUCPvfhXYQ2afSgMgfm0CbSva
 w72OygljhdB8MZZkIQx1T3sqN06x8Q2JrwVO/OragrLd/Nbz/+1JCdsjncTwkTmTL32P
 9ScOieABz8RZuKZ1vWDcKdMEfS49Gk+D7qMuOTl9CnQ2XjCuT7eNKNJk7eNR0ei+7dN1
 tiLAUt3SeOqFPanmFr0dWUCIiIqUBQto+5SDgQ1uzfSpH/BZ6ln6sbMjlpOv8mLEii88
 UzR7UCMvUGfS2k0STh+kigC2WH9HCL/kJeI3/4nK8NPIjoOH3h/9be51ltlXUmWguf4a
 rDHQ==
X-Gm-Message-State: AOAM5320eHVWYfCdo0e3ZVZbp2jVX+SD9VeJjrD/OvqHFv4oiumKTEFC
 Qqqx+RunrKyIYprc4ymn/Rqrw4OgsdTnB4DHgHEnxj40g0Wshw==
X-Google-Smtp-Source: ABdhPJyDiEuHYyBUunRhB6tFTqeb9Bbr6c8MrjsAVdZdQiAaNg7APqQmo0IKLa23truTii9VAe3jWuWIWVJC2vcBAT0=
X-Received: by 2002:a17:907:35c2:: with SMTP id
 ap2mr25570720ejc.530.1592248482466; 
 Mon, 15 Jun 2020 12:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqyzW=ah4Q=OCE9KP6DYpiQN18oQpVWjqFCvzQfH3MvQFA@mail.gmail.com>
 <CAFEAcA_e_0rFWGU2VtN3270sUhssHwe0eEgqb-U2Qq-HQKGLWA@mail.gmail.com>
In-Reply-To: <CAFEAcA_e_0rFWGU2VtN3270sUhssHwe0eEgqb-U2Qq-HQKGLWA@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 15 Jun 2020 20:14:31 +0100
Message-ID: <CA+XhMqwe5ro+hw9=rVHuXb+7PhbCuU6jEOi=UOJzXu44E1Q8Cw@mail.gmail.com>
Subject: Re: [PATCH v3] util/oslib-posix: : qemu_init_exec_dir implementation
 for Mac
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

With this basic program

#include <mach-o/dyld.h>
#include <stdio.h>

int main(void)
{
char buf[4096];
uint32_t bufsize = sizeof(buf);
_NSGetExecutablePath(buf, &bufsize);
printf("%s\n", buf);
return 0;
}

I get

Davids-MacBook-Pro-2:Contribs dcarlier$ ./a.out
/Users/dcarlier/Contribs/./a.out

The cast was to avoid possible warning with pedantic compile flags if used.

On Mon, 15 Jun 2020 at 20:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 15 Jun 2020 at 18:06, David CARLIER <devnexen@gmail.com> wrote:
> >
> > From dfa1e900dd950f4d3fca17fbf5d3dfb5725c83fa Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Tue, 26 May 2020 21:35:27 +0100
> > Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac
> >
> > Using dyld API to get the full path of the current process.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> > +#elif defined(__APPLE__)
> > +    {
> > +        uint32_t len = (uint32_t)sizeof(buf);
>
> Why do we need the cast?
>
> > +        if (_NSGetExecutablePath(buf, &len) == 0) {
> > +            buf[len - 1] = 0;
> > +            p = buf;
> > +        }
> > +    }
>
> What does this return if you start QEMU with a relative
> path (eg "./qemu-system-x86_64") ?  The documentation
> suggests that you need to call realpath() to resolve that kind
> of relative path.
>
> Did you try the test I suggested with checking that this
> actually does return something different from argv[0] ?
>
> thanks
> -- PMM

