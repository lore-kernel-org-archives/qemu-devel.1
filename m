Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB4C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04ACE24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaNP43my"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ACE24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFHN-0004f4-Ne
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEcs-0008Vp-6t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEcf-0004f7-1R
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:30:25 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEcd-0004ZB-Pd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:30:20 -0500
Received: by mail-oi1-x241.google.com with SMTP id k196so6344280oib.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/KspdGdP7K/PQayeS7xsmAbBYWAkYS2E0Qgcj0459Vs=;
 b=uaNP43myR3QO1AmiVPPBkjqd4KBspi4jXhvSNCAJioBK5kI7Ae+8HLbmvClf6J535k
 MWL7se3wahPAEJVWbocr12EjouLxmvNoWripQ0AtqGdlRLivKFx48YyUQhTSu4NQB6PI
 thJS0zv3zAxCFJPwZ/fNob39AWR1NuUgodT3s79bOVFqZ13EXxXS5Yp9cWWKMjPfPNof
 hMksAzP7DwAZhbJwxztSAO4o4GGLE9gXUb+oY+p4mTe2/dRYVUjpMmSznAsbVNZMbK4d
 8cJ2ZfKnh95M6Txaue3dtcM4mxaYmqAPAWtRJlbEPH//cjjwGgVp7Hh4MtV7QHrfCKgr
 AcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/KspdGdP7K/PQayeS7xsmAbBYWAkYS2E0Qgcj0459Vs=;
 b=QYaor6id4xnbhhoi2XkG09CRizO9bBW7hY01XOK+CyHa6i9Tw72tj4PxG7ZcS0Be4b
 LNKkTrACFwCpzVC+lVhOSTX9ovTmcmOSyNVKmZQPhfdaWTKZ8kcnPtqaw76VnImXenM7
 fFq9wGnC+exYFUPskyavi1vgfO8Bl9lD1ONlzsuyg95eGfXycs58Jkx2Yf0k38iYc0/R
 yJzVKNYbFIK0tPExNwdOfxAgjWHb47CWfmJ8LXt6PGJ2AJ+lRw+hGTjKs098WsVimbfn
 hcUPQ7S7AoV9934qfXgYWq2W2vn/Y8x1LGsvvvLAs1dZMVWX1Spdbz73zbggoc0LH2L9
 nNRA==
X-Gm-Message-State: APjAAAW88EdwHgfqVNc9o5O0WQO1Hk41NYR1jhLkTd67mHNrguWP29Pb
 N9Ri2C5+Z2zquOgMKDcUNtbEXgXfJWD3/uFSrPOZCZIe
X-Google-Smtp-Source: APXvYqwytgOasFrYI/MMxN25mf9GzbOXCl5caSFO8OQuvyMwvIzsf64Dn5CIdIxFRLeLdR5IDQnjQThKy0NvWjs6IiI=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr11646289oic.146.1575639629936; 
 Fri, 06 Dec 2019 05:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20191206044134.259488-1-david@gibson.dropbear.id.au>
 <CAFEAcA-oGLx+mcgqxC6-QRv9dSdzOqvM8g7q7SzUuAqKSZU-tA@mail.gmail.com>
 <20191206102903.GM5031@umbus.fritz.box>
 <CAFEAcA_j3VdVGgu8=vTPtmafEjX34OMKjyjdYuRkKNU=yAW7BA@mail.gmail.com>
In-Reply-To: <CAFEAcA_j3VdVGgu8=vTPtmafEjX34OMKjyjdYuRkKNU=yAW7BA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 13:40:19 +0000
Message-ID: <CAFEAcA8Q9u=fXsBDqemur2EkbQYtepYu4qYpfi=ibKMFUmQjEA@mail.gmail.com>
Subject: Re: [PULL 0/1] ppc-for-4.2 queue 20191206
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 11:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 6 Dec 2019 at 10:43, David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > On Fri, Dec 06, 2019 at 09:52:54AM +0000, Peter Maydell wrote:
> > > On Fri, 6 Dec 2019 at 04:41, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >
> > > > The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9278e:
> > > >
> > > >   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191206
> > > >
> > > > for you to fetch changes up to d887a8cfc083bcf3856f9f42352989f3624e0cae:
> > > >
> > > >   pseries: Update SLOF firmware image (2019-12-06 15:33:23 +1100)
> > > >
> > > > ----------------------------------------------------------------
> > > > ppc patch queue 2019-12-06
> > > >
> > > > This is a last minute pull request for ppc-for-4.2.  I know it's very
> > > > late in freeze, but this does fix a regression: a bad interaction
> > > > between the new qemu and SLOF device tree construction code means that
> > > > SLOF will crash if PCI to PCI bridges are included in the system.
> > >
> > > I really really really don't want to do an rc5. This would
> > > have to be "everybody using ppc gets crashes" for me to
> > > really want to put it in at this point...
> >
> > Yeah, alright.  I'll send it to Mike for a 4.2.1.
>
> Paolo says he has something that needs to go into rc5, so maybe
> we can take this too. How confident are you that the change is
> small and safe? It's a bit hard to tell with updates to
> firmware binaries.

...I just read the commit message for the firmware blob update.
That is way too many random changes to go into rc5. I'd have
taken a firmware blob update that was just "one change, fixing
this specific bug", but not one which has all that other stuff too.

thanks
-- PMM

