Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A4C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E3E24125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOuSSzrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E3E24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1its6G-0008BM-VV
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1its5e-0007m4-E0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1its5c-0004b3-VO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:53:02 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:45277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1its5c-0004aK-Op
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:53:00 -0500
Received: by mail-oi1-x22d.google.com with SMTP id n16so2232178oie.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 03:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tnxoWNsfg33FrzgMxmI34BhBQ8qxOcDEyn/517VPWKw=;
 b=FOuSSzrOWyWdmdh89uj3IsEBS9zj1+y1OY+r6UgNDm+6JP5x2ucPWMp1LcIX/I41Hx
 QSj+KOEo4KiyV+J5oIRFSlCW/7uAeb1ESqfxYJvmVNeocvMGWIFD9ZEQ/ApSxHm0KeTK
 bZOJFjj+c6ruSBPZS+R5DQIGQg9bDwVZt+VHXZwbol4oBcWRkUCRvT/GLwOum+wdiboY
 AfYaiI7cLPkpHjFPW9qs0E1SKZEq4ZFKlCgllJPU9TlC8sMBDnVWX7w/u7vcxvpGQLQH
 Oz1GiDyhp6oZfAZRKv/zTIJLDiMmFPEiEJF4tZJ/9AvabL8+lAUoyd46PaUGE7cXf998
 a1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tnxoWNsfg33FrzgMxmI34BhBQ8qxOcDEyn/517VPWKw=;
 b=OvsvycqUXDMhwS3q0W+uUFhVHFzM2BemK/dAnt1jqxBZgt8ZUaj3p00sw94AWpm/+r
 cLrDf5ge3DMGT8CMI90y0mJSRMogSZvqfaCAsBUZGALGnCQcL9mcrCtbIuOIfrtIe+nT
 88rWkZYThrEZcZgz65fF+/iado/VFAqFeIBTojLzvr64qDmOnC3yYmhHNUUQVCvUxEjz
 dme1ptPp0p3a83/U/G3gjxNxEqnhpNkcTgpwKg3bnXK/A72OsruxeNtO/LAOaWNW+I80
 /SR8vMg0VwAYxptcWy34SpMdPbK4+B7yZ0Vz1jifImQJzlOFHh25xPaeCVO7oAT1HzDm
 0KBw==
X-Gm-Message-State: APjAAAX8rGKMw7WPVDzMZYJ5z748W/ENf3lb6MjgG9rK6UmLf2dutCxl
 R2IaZDouQHeQv4yQ5TXfQyEnkv3fq0Y+cfgyRNIP9A==
X-Google-Smtp-Source: APXvYqwZutevBXjnOUwu89S5skpQa+/N+yGvkFOfILpZQpY3NAmjVTZQbUPKn83/C4/g4WP3DSfMz4Wd9LABJ0c/9oU=
X-Received: by 2002:aca:f484:: with SMTP id s126mr2604284oih.48.1579607579790; 
 Tue, 21 Jan 2020 03:52:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-_Y0Qaw-S83tMAph21opaDx-2y6aPbv5J_J0Bo4bgJuA@mail.gmail.com>
 <96e75f84-fc52-9f19-3733-671aec6dc7fc@redhat.com>
 <87k15ll3c3.fsf@dusky.pond.sub.org>
 <CAFEAcA_JyNUbKcuaXn0J_isGqGpxJrou-wyOiUsms89RRMzW3A@mail.gmail.com>
In-Reply-To: <CAFEAcA_JyNUbKcuaXn0J_isGqGpxJrou-wyOiUsms89RRMzW3A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2020 11:52:48 +0000
Message-ID: <CAFEAcA8C0-HyqnJjc6Bik8E3w3goWr-KB+daObGDp7ZcXqxYDA@mail.gmail.com>
Subject: Re: Proposal for handling .hx files with Sphinx
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 11:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 21 Jan 2020 at 06:40, Markus Armbruster <armbru@redhat.com> wrote:
> > John Snow <jsnow@redhat.com> writes:
> > > Still, I do want to ask: Are we sure we want to double-down on keeping
> > > the .hx files around instead of trying to move to a more generic data
> > > format?
> >
> > One the one hand, I'd prefer to invest as little as practical into .hx.
> > On the other hand, adding more hard dependencies on QAPIfication is not
> > a good idea.
> >
> > What's the stupidest solution that could possibly work now?  Is it the
> > one Peter sketched?
>
> FWIW, I wrote some code for the Sphinx extension approach yesterday,
> along the 'simplest possible thing' lines. It's less than 200 lines
> of Python (though I still need to put in the support for DEFHEADING
> and ARCHHEADING). The actual texinfo fragments in the various .hx
> files of course would also need to be hand-converted to rST, same
> as the hand-written manual .texi file contents.

Incidentally, I am definitely coming to the conclusion that the
best way to do generation of docs to go in Sphinx manuals is
to use/write a Sphinx extension -- this lets you properly create
doctree nodes, for instance and it fits the flow better. So a
in potential future where we were generating these docs from
json, I think we'd want to have a Sphinx extension driving the
'parse the json for docs', rather than a separate script that
spit out rst-format-text to include.

thanks
-- PMM

