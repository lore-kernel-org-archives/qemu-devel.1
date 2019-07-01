Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B7C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3B820B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxTNhaWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3B820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi454-0001FU-NI
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:43:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45353)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3EN-0001yc-S8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3EG-0001mt-JG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:51 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3EG-0001kJ-Ct
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:48 -0400
Received: by mail-ot1-f52.google.com with SMTP id r6so14909871oti.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0HBeY563DDijZ17XU0K5vwaJdep9/sH2hOHsw6x2ptw=;
 b=AxTNhaWuAuNXR5kClJrLz+VYxaIHRooCDuJ8WTKaUrI2lU+3tImfZCGGtkn9OdjdxT
 D5v68cQG19L4z7NsOvtPOy2QrCRUPEue0qrpBfmxIcordPLEP67QaPrTdseZRuxEmGuQ
 95njUbhp2gL+vKKK/48MOhoIX5rNreZHd6HGuFfBTW62ex2nrm2fUlGSFBeC21i3QhEJ
 6JhXTDijqJHMKnWJ+84QDQ/1LUxvdsXNYbsQcE/SGsK8/HuJtECqLJYW+u/bVB363Hoa
 qNj+kC+JKZay6ynX5LU0IqL2YsC5pDByNi3QhQaMv0qC+F1RxqVQ6mqoPF6jHJjgttLD
 jwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0HBeY563DDijZ17XU0K5vwaJdep9/sH2hOHsw6x2ptw=;
 b=iGGNqHKmOWILc2dnA1cicGV7NV02XFkRn8TokQixeTzj86xgNHm201vSX3hIbSkgs8
 bLOAAn6b1ZP2DasCLYy9BktQfoZEpOfHWAmyU2bq5JGgsaCrtLQhobtjmsxUMZKm3evj
 /c+PlZodb9YHQvu0LtJS17l0muqF74xVP/3bl2XQ6El9SAxH8nUxLgMVIRBG5PTEc9Om
 rk2arOoOrgOKdUhtx5cxktQEwI3sGyMRGotFwtbd4Zk6NJLivhCP0XOKQWSyJnlPm1eS
 zkqgMshZdjQHVJZz28YBEv5JeWMj42xDzZ8foGR9j8wCHGDiTwYcn/xwi6xE+xxcNOw0
 rWFg==
X-Gm-Message-State: APjAAAWX87Cr1NLvAlj6w7J/1uQb/YAxXkAiuSxL8pWQfHAJzRlKAasu
 W+Woigt0eZYxbWY8e2ZCJKDNVNbLS4YLYVdvA37olDle13twcA==
X-Google-Smtp-Source: APXvYqxHpwyJ08FviEDZ7qQr55nRCT2lhoxT6K6JUx8uA9VXJkm/wSpSRIRsM4Yq6Uf/M1FDYFG+bBClWmFARt1LFiU=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr21669215oti.91.1562010665400; 
 Mon, 01 Jul 2019 12:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190627124815.29536-1-minyard@acm.org>
 <CAFEAcA_YcEtXDMR-7D4R0Tdb0zM7LARpisvV5VjTnoki=9_WPw@mail.gmail.com>
 <20190701182503.GA4336@minyard.net>
In-Reply-To: <20190701182503.GA4336@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 20:50:54 +0100
Message-ID: <CAFEAcA81i3d228UP52j_eCxbS8rq91OLDMmCwxGJM8VuAVxt7w@mail.gmail.com>
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.52
Subject: Re: [Qemu-devel] [PULL 0/2] Add a UUID device property to IPMI
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

On Mon, 1 Jul 2019 at 19:25, Corey Minyard <minyard@acm.org> wrote:
>
> On Mon, Jul 01, 2019 at 07:10:50PM +0100, Peter Maydell wrote:
> > I have to say I'm not entirely happy with applying a pullreq
> > with patches that are unreviewed and were last posted on list
> > over six months ago. Can you post a v2 to try to solicit code
> > review for them before we put them into master, please?
> >
> > (Sometimes patches don't get review, and we generally take
> > them anyway; I do that myself from time to time. It's the
> > combination of the six-months-since-patches-posted plus the
> > imminent freeze deadline that gives me pause in this case.)
>
> Will do.
>
> I looked around and tried to find the freeze dates, and I couldn't
> find anything published.  If I had known it was close, I would have
> waited.

Thanks. (Our schedule is on the wiki at
https://wiki.qemu.org/Planning/4.1 -- but we don't publicise
that url very much so it's easy to overlook it.)

This is a pretty small change so if it gets review we can
probably fit it in before rc0 or rc1.

-- PMM

