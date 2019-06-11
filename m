Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E2C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6104D2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPgOW4Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6104D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hak6v-00028w-QF
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hak2z-0007xJ-7Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hajsj-0003rV-Rd
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:44:22 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hajsj-0003qq-JJ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:44:21 -0400
Received: by mail-ot1-x331.google.com with SMTP id z24so12553635oto.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fLbYiqFwHu+buFPHvKj85AcNauP+XlNz1rmAFQF6A1E=;
 b=LPgOW4CaCd6v1NIuNmFfbXPJgPRthHs+iTgrZoTXQLK6OR4I9yUpfNofDK1s73WaMm
 94Y5gOz4b2CCFeGS1qJPgVDwzze0m+mlMJ4ElZxVI7BE5UNld5cAjm4Ka8Dw6ekJScpp
 +lPa65yI9HoVrBZU+Yr5ncCVVEIuVNsEWgJfBwdmM8Z54ECUrh6L5bDGaWDfe72nxf0n
 oSZLM5z3v30r/i+ZpK4hZZ0kxIDgIrMXD3jn8e+m/7l5q7h5yVhQ0/o+58AOAUgC3Cw0
 3mEPrNxXZMLDEuUBLkzGw0PyQs89CWNs+vfUn893c+5D7DydX659/YbIFMxKMQQqfnxk
 OvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fLbYiqFwHu+buFPHvKj85AcNauP+XlNz1rmAFQF6A1E=;
 b=EHhEnq3gEFKiR3QNwxEk3OfpC0kz61vlRskypLUV8M+zAne0Zl9rEwc2PFvtS5BFi/
 r1IXYyPNdMqS79ZUsrd1aRbJKxyT0bcEE/+OAGV0+jFZ5x8qU/02hyoifJiwz2aRyeEB
 E3oIlbXKIxTRPW/I/BhtY6rVChclVYa3ykzNPcUxPgHnl6HA61WTFpfwUum0JFcgoSlX
 St4oYoZ++ihVO6Y4RvlkNcy49yCCxxJO+iheKAcI71WxBJ8mbGCbkzaDEkiy5ihgBVPO
 fAMKcKb++rVllKA5QndgF8l36sTAZvcn915uAZPeVKOmb3XcMBz5y1oe2tW/vO89ZmHg
 Ii7g==
X-Gm-Message-State: APjAAAXV1WkNHM8syto0lzf9ZvoY6CHLp7DriL8NaMae204idIUHaHYE
 /qoZmnzdK8HyrKZkv0o+epkDmBIfvmwrajQnMSR5Uw==
X-Google-Smtp-Source: APXvYqygZCLdT5PxyH6Ic6BuV74NSNYPy3j6bCz+pxAyExgsUo+t/nIeameQGihF79pyxPHUPRVTa2oHhTAMv5BZzmk=
X-Received: by 2002:a9d:193:: with SMTP id e19mr1074833ote.135.1560271460174; 
 Tue, 11 Jun 2019 09:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190611152448.29436-1-armbru@redhat.com>
 <CAFEAcA-i5kyUp_iGkWMGQvbj7xXqmHkfiKvkBmcubBW_VuadGw@mail.gmail.com>
In-Reply-To: <CAFEAcA-i5kyUp_iGkWMGQvbj7xXqmHkfiKvkBmcubBW_VuadGw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2019 17:44:09 +0100
Message-ID: <CAFEAcA8b73ACXPHkYMWFdY5aZ5w-F+UXadW16Z+nZm09f=LdvQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL 00/12] Miscellaneous patches for 2019-06-11
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

On Tue, 11 Jun 2019 at 17:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 11 Jun 2019 at 16:44, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > The following changes since commit a578cdfbdd8f9beff5ced52b7826ddb1669abbbf:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190610' into staging (2019-06-10 16:09:19 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-06-11
> >
> > for you to fetch changes up to 143a44a4695049223df38335eac72ca30d933a5c:
> >
> >   MAINTAINERS: Polish headline decorations (2019-06-11 16:46:35 +0200)
> >
> > ----------------------------------------------------------------
> > Miscellaneous patches for 2019-06-11
>
> Compile failure, OSX:

...and OpenBSD:

/tmp/qemu-test.rdndjK/bsd-user/main.c: In function 'usage':
/tmp/qemu-test.rdndjK/bsd-user/main.c:657:17: error: expected ')'
before 'QEMU_COPYRIGHT'
            "\n" QEMU_COPYRIGHT "\n"
                 ^
gmake[1]: *** [/tmp/qemu-test.rdndjK/rules.mak:69: bsd-user/main.o] Error 1

thanks
-- PMM

