Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4B320718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ4RR98n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4B320718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugq7-0005RL-Az
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuefM-00025b-Oz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuefJ-0003vW-7S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:45:08 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:41899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuefI-0003sh-J1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:45:04 -0500
Received: by mail-oi1-x22d.google.com with SMTP id i1so3286611oie.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BB9rjyG51vTr0FuUHh9u45qpXQPX2gUFn9ETyUI/fFg=;
 b=NZ4RR98nZvXD0bjvxnHtFOLxvbQH+z4EmvIEbLUaISE8+RW4p7hHrWkIMI653AWnJN
 3K/Ni9khtbGjC+cmBjrqhklRhIa71jNANAAbUIbk9Jb9EoRFvFUQkDbXWvq2b3+JLNgY
 4q4r9rGUfGgzeoPaefP34Q3lKehDQdw5BNElMzzxHMOm0whF4sh33lbO1BaCKljEwG6a
 TEHksgr4ZqMXOQJvlx3Jgm74LOayOihA2LYGiYTmdhIWmpTa+v7zuJ2/KZ9iTlsvivF4
 Vc3NchkKEY+MoHCtq7dF+3PVOnNX/IiAI00QOXMre+OD4lSmeqq73TA3fTuCpvHxOBoA
 XcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BB9rjyG51vTr0FuUHh9u45qpXQPX2gUFn9ETyUI/fFg=;
 b=Cgz952sqtxScHBD8lM27Wamkw5t/HtImsc6y2DLp1OQg3qpSdNX7gvoHFBapKU7JCw
 pG+zff9uiUj5MxdO6VB+v/Vh6hmurQWEoWbXNq1Kd/cYWz0QHlmtJULsjf6u60k/tMqg
 FFyPLEBKAKkkFwWQbSv8WlW+Qe7y6UHsOwe13Il/4c2o8iFkS1wXQDiwLIZoeOPYvdUv
 GpxJQRk1DX5f+Azsa7yzrEqg5k89dHlYvfgA/R2Pr+VlwsMhgSfn98YhuebfIVk7EapP
 oO8JgPKdVfqH6DZ6y9cA9XqrRz2tO6F4Mj0ec4S/jAOtUqZvyHGiPvB9XgNodfEe5bTo
 XQqA==
X-Gm-Message-State: APjAAAWLWYS/uuwvFw5iCN1iY7AoTFIfGboY+ifGrpLFBZg3Ozwejuo3
 WzVgICql+3R7UEyscrSU+LJMmtzcl+6nqFmjnNN/qg==
X-Google-Smtp-Source: APXvYqx69vuAbIZ+QGwMpZNXE8EXb2z6u3JLoB3E5sEFu2jqjyKa+0Kp/TYhaqHfSdohH7Js8m/y4ogqWDtpGKUMYhM=
X-Received: by 2002:aca:f484:: with SMTP id s126mr10526703oih.48.1579794303407; 
 Thu, 23 Jan 2020 07:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20200123115841.138849-1-dgilbert@redhat.com>
 <CAFEAcA_7T2Yu8fXv7XycSSN=8xoi8aciR5NMh76o8LQxNU6rDw@mail.gmail.com>
 <20200123153052.GA2732@work-vm>
In-Reply-To: <20200123153052.GA2732@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 15:44:52 +0000
Message-ID: <CAFEAcA8ufZTy=T_iixbHMN6a7GZxxRkod6y_1Vu_vbsoioDV=g@mail.gmail.com>
Subject: Re: [PULL 000/111] virtiofs queue
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 15:31, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On Thu, 23 Jan 2020 at 12:54, Dr. David Alan Gilbert (git)
> > <dgilbert@redhat.com> wrote:
> > >  docs/tools/conf.py                        |   16 +
> > >  docs/tools/index.rst                      |   14 +
> > >  docs/tools/virtiofsd-security.rst         |  118 ++
> >
> > Do we really want a new top-level manual? This isn't
> > in the plan: https://wiki.qemu.org/Features/Documentation
> >
> > What defines what goes in docs/tools rather than
> > docs/interop (like qemu-nbd and qemu-img do) ?
>
> In my v1 patchset this lived in tools/virtiofsd and I hadn't
> wired up the top level index, however discussion with Daniel
> we came up with docs/tools/virtiofsd. See:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg00793.html
>
> My suggestion is that more should move into tools and docs/tools
> since they're not really 'interop' - but I don't have a strong feeling
> as long as we can quickly come to an agreement.

I guess that's probably not unreasonable. It's going to clash
with the various docs patchsets already on list, though.
And it's a bit odd that the only doc file in docs/tools
doesn't seem to be documenting a tool (it's a more general
'security guide'; I think the case would be better if the
doc you were adding was the virtiofsd manpage, which doesn't
seem to exist yet). Our other "stuff between guest and host"
docs (including other vhost-user topics and the qemu-ga guest
agent docs) are all in interop/.

PS: you forgot to add the new docs/tools entry to
docs/index.html.in.

thanks
-- PMM

