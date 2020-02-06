Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61771C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C30214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQoZm5e7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C30214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziJy-0008GT-EJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iziJO-0007pu-Pi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iziJN-0006WJ-Jf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:39:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iziJN-0006OM-Ch
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:39:21 -0500
Received: by mail-ot1-x341.google.com with SMTP id h9so5641989otj.11
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZcpUn5rYK6x9G31s7qh5LAFbj9GvAbXzFXLjNWWS5dY=;
 b=jQoZm5e7PusC6J89sOGvfy/u0uNQh4M+YJ/mLrXueQra9qJ2Qpa+KJwVj0FkVxcxp8
 XpTwI+wQU8GhuPV6/1XMMDM93tpyIzJYnxRZKyhzeMqwMCVKcMCbPEOJnyMW8OzTHBwZ
 DkLJZsBYP1JRXwcG7v643STQAfiH0xKBT9b7IaihzjRtUfz58SXu9fIeVIhFrWsxmeKY
 JdOcXbsgJp+sWsFQU7m8vvTgYQkFL5o1XWFXvNsurfaXQ15R80LykjRggWMnhnhIlRn5
 1GbqAzS5fJwmj6XzKP7vR5Wkippzgx6YZ/L8S04tr1AsEVmC/3wNZLNQj5uVnIlIaNr9
 YDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZcpUn5rYK6x9G31s7qh5LAFbj9GvAbXzFXLjNWWS5dY=;
 b=mruY+wKVTdWRiK+rViqByPzuLI79pmxAogxXozravbqt8rlizlGGtLkEoaAa+OP8ER
 7d/J1m0+rbHWbtR1QBQGthKiHbavQLsxmnrigusMuzbFf16gDqd5aGV8TGx7qdG1iHmD
 McF9ywMr1VgO74XSdKiqXaZec9SE87H8A7cQ/H8NQEPqJmTSRJ23y7dll3J4xUorITUG
 c4BKeM0PrayQirJ+NVDIbH7AwExagLdMaMDAo7wd6ktoCuTBJ/TdTdqEfW2+UlQMGN0D
 zLGTAAOEhRegs/ApInx8ntOq1Moe/AfI6wrSIkTF8qgPNbqotyfOP9yL/FDzeFw3uA4D
 1Biw==
X-Gm-Message-State: APjAAAWBcioxt+seBzWBztTLz/id0suVVWohKB7mXWC/shzpxzuZUM3v
 2GzItxS/Up0dLNEQtBTDtDtmt0ccLV8YwDP/XXUEBA==
X-Google-Smtp-Source: APXvYqwy1Nb2XASuLxZlTP35bfSPGSnO4oKYFRquh2UCyWvKp8reTitD/VJjTQvdlBig+u3U0amlb6VO6QY0Tyy0/Io=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr28829643otq.97.1580999959779; 
 Thu, 06 Feb 2020 06:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20200206112908.5002-1-kraxel@redhat.com>
 <CAFEAcA8eHS7KuMW6RXdxoYAdQAJOJK6thqp5Vn+LZav7B79MWw@mail.gmail.com>
 <20200206132002.6piouqiatuj3tj7f@sirius.home.kraxel.org>
In-Reply-To: <20200206132002.6piouqiatuj3tj7f@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 14:39:08 +0000
Message-ID: <CAFEAcA8X+UW6nfvGQ-Gks9y8YQeRcFa5FLr_KF8qea8OoQh0KQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ui: rework -show-cursor option
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 jpewhacker@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 13:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Feb 06, 2020 at 11:52:05AM +0000, Peter Maydell wrote:
> > On Thu, 6 Feb 2020 at 11:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > This cover letter is missing a description of what the patchset does...
> >
> > The closest thing the patchset seems to get to documentation is the
> > oneliner in ui.json:
> > +# @show-cursor:   Force showing the mouse cursor (default: off).
> >
> > but looking at the ui/cocoa.m implementation that isn't what it
> > actually does -- it just seems to mean "default to shown on
> > startup", because the logic that unconditionally hides the host
> > cursor on mousegrab and unhides it on ungrab remains
> > unchanged. This doesn't on the face of it sound like very
> > useful behaviour, since the option will only have an effect for
> > the short period of time between QEMU startup and the first
> > mouse-grab, but without documentation of what the option
> > is intended to do and in particular how it's intended to
> > interact with grab/ungrab I don't know what your intention
> > for the behaviour was.
>
> Well, it doesn't change actual behavior for SDL and cocoa.  It only adds
> "-display {sdl,cocoa},show-cursor=on" as replacement for the global
> "-show-cursor" option.  Guess I should reorder the patches (move 5/6
> before the individual UI patches) and reword the commit messages.
>
> If you think cocoa behavior isn't useful we can revert commit
> 13aefd303cf996c2d183e94082413885bf1d15bf instead, or drop the
> cursor_hide check in hideCursor() + unhideCursor().  Your call.

I think we should start by documenting what the behaviour we
expect of the UI with this option set and unset is. Once we know
what we're trying to achieve, we can look at what we need to do
to the code to get there from here...

Not having the requirements/expectations on the UI frontend
clearly documented makes it a lot harder to keep the behaviour
of our UIs in sync -- we end up making changes to one UI
or another that make sense in isolation but result in random
unintended inconsistencies between them.

thanks
-- PMM

