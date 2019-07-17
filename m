Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC40C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A93A217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJYzX7hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A93A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnpUM-0002Fi-Iy
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 15:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnpUC-0001pd-JS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnpUB-0007Im-D2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:21:08 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hnpUB-0007I5-7e
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:21:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id r21so20225747otq.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6lWVMStwuI15jFl2YwqxLoUkSzhpAJOlQIP5pUQ9X6c=;
 b=JJYzX7hWH+nv0JaY5fHiYRyNi/n0Zdncxz5gN4dmD/7jGn4VyWMy4DGhS1Lm8lv5Ft
 HLDtSemNLcak00PuAMsHfFl2yVW4L546QxTzJ2DjMzkL+w0eGob99bnzdWDo1L622RA2
 BROa517iHbNkhUT9Ascno4ryb7XR2YKPbTUwkL5Llj1NhkRIRpGixn7Cdx1TARuAL1GK
 4Uz2wZS/QARqLH+Ak3/P6Dw8SBIrGPb3lIzACwzV+gQbJpCJWx5zqIU/RUPjQZW9mRzm
 QeMNC1WOEKCrZbXNEgIAgfzP9mWckkyoiPMAdcJzH18XreFCYlqjwTzeV45jFw9ci6Pm
 EOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6lWVMStwuI15jFl2YwqxLoUkSzhpAJOlQIP5pUQ9X6c=;
 b=YXRXlJ18Ruoo3/1fwGdjqW1pJ0MiWJCDPZVN9dJLxJuUWszfLTiWTAvRDcaX8kjFtl
 53cL1i1oz7TM4ckq01LWKrztlt++st0vabiRR06A+rubMNdOpZ1T4s4WMJQ9FbcLBfuy
 0fRkUSvyI3kBnpLZ5G6Q+B9wMuCGPbE1H4tLDKI9nX5tRlQYUOAOG5Lb8C/pC8D2b8L5
 rjnRImdhXru2tHoGD0aRr9ge++fHCM/3md8xa2/YDY4VbQlwYGSRxlPzg0rsl0sG9yl+
 CCGZMH8Gn1eFjdVemx2Hcm+cfmyo78iWKamXx0aRNjFUD81dfR8ZTFkyAUn2Rb7PNd26
 SnFw==
X-Gm-Message-State: APjAAAVIy9qiumP6pR/AWE2UTeRMjsNYkjqvch0d5PbfuOAZj7lwKsnY
 f0uesyLLJ9q+K8Xs+CNVF/JELV3lzbk+abJjfb1tRVs2
X-Google-Smtp-Source: APXvYqy8zLsjepKMa7p7VgvkOBU5EB3gXDgsv3sKIMiLaxwfKubbODMd8pg7SQVkTsDqM+pvxm0qB474O0PvEadb4WE=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr6718316otr.295.1563391265617; 
 Wed, 17 Jul 2019 12:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
 <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
 <5b6d1130-73fd-b7c7-28ef-f553d33972e0@redhat.com>
In-Reply-To: <5b6d1130-73fd-b7c7-28ef-f553d33972e0@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 17 Jul 2019 21:20:54 +0200
Message-ID: <CAL1e-=iJwVGfX-fbHkpYmVFH+YxvDr6LG9ZJXesgmog5q_JhPA@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 8:57 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 7/17/19 1:34 PM, Aleksandar Markovic wrote:
>
> >
> > Daniel, that is fine, I don't question that, I basically wanted to start a talk
> > between us to clarify some things. Related to our situation in the field,
> > I have a sub-question to you:
> >
> > Let's say there is a build system with SDL 1.2, and not SDL 2.0. Should
> > QEMU refuse to build?
>
> If the dependency is soft (when SDL 2.0 is available, we can compile
> more things than when it is not), then the build shouldn't fail, but
> your resulting binaries will not use SDL.  For example, we treat librbd
> as a soft dependency: if it is available, you can build in Ceph support;
> if it is not, you lose out on that particular block format, but can
> still run guests locally.
>
> If the dependency is hard (when SDL 2.0 is unavailable, we cannot
> perform our job), then the build should fail.  For example, we treat
> glib2 as a hard dependency: if it is unavailable, we can't implement our
> main loop, and there's really nothing left worth compiling.
>

Eric, I truly appreciate your clarification.

But, does "configure" list somewhere unmet soft dependencies? (the
question is general, not looking at SDL only) Is there any other way for
an end user to have info on unmet dependencies (whether soft or hard),
other than see QEMU is not building, or something is not working in
QEMU run-time?

Daniel,

We had message "SDL 1.2 is going to be deprecated" in QEMU 3.0
"configure" and, if I remember well, in QEMU 3.1 as well. And now,
when we finally deprecated it, is it true that there is no message
whatsoever on systems with SDL 1.2 only?

Yours,
Aleksandar

> Some qemu dependencies are hard, some are soft. And your choice of
> configure options may further influence things (our KConfig setup may
> mean that some libraries are hard dependencies for one board type, but
> soft dependencies for others).  Off-hand, I'd guess that SDL 2.0 should
> be a soft dependency (but if it is a hard dependency, patches to make it
> a soft dependency are welcome); if I'm right, then building when only
> SDL 1.2 is available should not fail, but also will not use SDL.
>
> But the presence or absence of SDL 1.2 on a build machine has no bearing
> on the real question of whether SDL 2.0 is a hard or soft dependency,
> now that the project has decided that SDL 2.0 is easy enough to obtain
> across all of the set of systems included in our documented list of
> minimum development setups.  In short, if you want to build with SDL,
> you need to have SDL 2.0 available because we are not going to support
> builds against SDL 1.2 as a reasonable development target any longer;
> but having SDL 2.0 development libraries available does not preclude
> also keeping SDL 1.2 on the same machine for other reasons.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

