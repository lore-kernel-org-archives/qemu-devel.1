Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270B9C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E515824659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvl2mVQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E515824659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEcl-0007kN-KH
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEMO-0007Y2-M5
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEMM-00074z-J1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:32 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEMJ-00072Z-Ih
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id x14so2705152oic.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J2q1f98KR0wGElWIwm3u+M2lDD8HEzvSwjuSvmqxxb0=;
 b=zvl2mVQ6N547pgiGIqf6rQdQq4UqCgnj0aDYcc39Sz6VrXJZv+trHJe4eTTwjBknZE
 ZQCYxVYuBuYAAEOO0XKzPZjGSLkLkic5raZTDQbAeAWzxVqAQANEXFyNdG4r2oTEAC7E
 V1rcN4evSXaTYCs/6H8AcEoGAniydfVgxrm/xd3PKTWyIVcqnxQ2/BWSwGXTMx6r+Nmc
 aaw4oUUI/+VGzG96DLfVgcfneSZklGcDjpbdQZg84yCBdM4+MTOfpDGsUaqH+AJnKi4V
 6UrVsrfRJMDCv85zOu/tlVSStR0Xp0BYxnej4VgFM7wmf/hCux1IS9gAoTGGdEoDKxBi
 2/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J2q1f98KR0wGElWIwm3u+M2lDD8HEzvSwjuSvmqxxb0=;
 b=pk0jkteVYQsZVfG1eoTzDT/4Tm3iDIsF62Rmi/YLtglZ2Z1tLAgWJV7vEZZ/DV5nUS
 itXd/cWSEiD6DPdHpFDDp5mFwqOBpyQBU8vPiTGcxCk4PFSvjm4qVuOoIk1rv2maUKOt
 W6CL3c7/PVA1D8gQGQqAjRE8g1Ln0uCoJDykB4exwjtneooGCPLTmNcC7XtMXMPewN9t
 CRb7psB86+hcO9XAkPtiDfhKz9jmGLdl/CpXXIHJZxoyjT60h2+itU21qtW7UeXL7wwH
 62NSIr3FYmCGKpZHl5g27GjEUJ+iS2IH8lp8HWSr4bFmTBxEQiMur/FossSVw0ATe4dr
 02HA==
X-Gm-Message-State: APjAAAVfTNNSQSas7u9cfNPmvxCsWFrgoJMmWZCCO/zcYdm7i+a0dZ8j
 XQZ8YSMNDIPVdlO/BNLeDB1Z06pCxUEWYNmes+sQCHPv
X-Google-Smtp-Source: APXvYqxEWvKxw9pBmETAIUihguHt0dQSLv9UjpNJ4nn2jfCwGcUK7nHshxpg7hVPCCQ6N0ipuk1rEWJlSiFDh1/SVYA=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr12043755oih.98.1575631205358; 
 Fri, 06 Dec 2019 03:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20191206044134.259488-1-david@gibson.dropbear.id.au>
 <CAFEAcA-oGLx+mcgqxC6-QRv9dSdzOqvM8g7q7SzUuAqKSZU-tA@mail.gmail.com>
 <20191206102903.GM5031@umbus.fritz.box>
In-Reply-To: <20191206102903.GM5031@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 11:19:54 +0000
Message-ID: <CAFEAcA_j3VdVGgu8=vTPtmafEjX34OMKjyjdYuRkKNU=yAW7BA@mail.gmail.com>
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

On Fri, 6 Dec 2019 at 10:43, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Fri, Dec 06, 2019 at 09:52:54AM +0000, Peter Maydell wrote:
> > On Fri, 6 Dec 2019 at 04:41, David Gibson <david@gibson.dropbear.id.au> wrote:
> > >
> > > The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9278e:
> > >
> > >   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191206
> > >
> > > for you to fetch changes up to d887a8cfc083bcf3856f9f42352989f3624e0cae:
> > >
> > >   pseries: Update SLOF firmware image (2019-12-06 15:33:23 +1100)
> > >
> > > ----------------------------------------------------------------
> > > ppc patch queue 2019-12-06
> > >
> > > This is a last minute pull request for ppc-for-4.2.  I know it's very
> > > late in freeze, but this does fix a regression: a bad interaction
> > > between the new qemu and SLOF device tree construction code means that
> > > SLOF will crash if PCI to PCI bridges are included in the system.
> >
> > I really really really don't want to do an rc5. This would
> > have to be "everybody using ppc gets crashes" for me to
> > really want to put it in at this point...
>
> Yeah, alright.  I'll send it to Mike for a 4.2.1.

Paolo says he has something that needs to go into rc5, so maybe
we can take this too. How confident are you that the change is
small and safe? It's a bit hard to tell with updates to
firmware binaries.

thanks
-- PMM

