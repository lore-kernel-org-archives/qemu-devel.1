Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A733C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 22:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E846E20833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 22:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZA9KXIQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E846E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibY5X-0005DH-5e
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 17:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibY4V-0004dg-D5
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibY4U-00082z-8H
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:52:07 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibY4U-00082T-08
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:52:06 -0500
Received: by mail-oi1-x242.google.com with SMTP id e9so30725677oif.8
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 14:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IseQ1yMIAUS2jCMaYl3VxZeZJQk1+p0QJl3nw4mJTGE=;
 b=ZA9KXIQ3HKXqA5b8YXHh3v0NxMpNtsG1PCebeqLAX/g9Shdb4ak7/rQmEhRDOmjOTA
 03uEXv+WMfiif/qbklGUxe4uoXO+ZTgkiUeFsaWwXS2KEx5JYFOm54UtwJG+BLK1G+Hu
 XgHqQMvy0lg+8cnQvb9+TMYDlbxspDZS7j0QuU03l+CfmlA06mkhfabY1odMyolwvDso
 yfj3upR4NkcINkCcijmP47fKIq72ODP+D9qn3L12ZTXnOoOWMdBkKGpyDJZnz7eW7gDU
 s3qAFXa8rqeQveGZu4dfjKJgeK3reCYTfg8VnentglkgLRIwPlyv/+/voDOcqCzDjfOb
 s9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IseQ1yMIAUS2jCMaYl3VxZeZJQk1+p0QJl3nw4mJTGE=;
 b=aJFktl+66/LHDYs6SppJVsp11DcOYbqgLyPwmzKuk9ZGKRMIaFHEemN2H7Fn0LrdqS
 p1zDq4NPhxaXzUna+ZWCn19KDhDaSFqkrRgs2/67plvIVOG/Pn3q2Jp/2UeFhuKPbv20
 J5I3BkeYthDYtRbt+MuU6XpuWhwbIu0K/+oWxqSkc5Ld4XbdMuyTQShJySt656bQLrZB
 f7GFga1Ipr0+TCgkrGA7mj9S/lzCoJCDlUMHzJO0muZLS9gp0LeCG8VxxDb1/iRj//AS
 1AWe3GghbKMgY040T1GE3NnIbYd9ZKidoRzVNIt9ulrP0pK9mZVLo4EyibPdvQNaY279
 lBBA==
X-Gm-Message-State: APjAAAWZBZcocLhFoKr9wXrLrMlCT8dRKhWQzMxzmNhceC3MWabnz15g
 r271fx0yDTNJT810KQiqWsiyWum8ayHsNgBZ8+WBog==
X-Google-Smtp-Source: APXvYqzRDNP3DJ+Ud1ukl0IjNfuHD61ZtiNtcBCnUxc0Z/uwxvZmptGhb3V0PXFz4M/3AwXHh7VziIjGYUT55Zv5idc=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr18593935oih.163.1575240725047; 
 Sun, 01 Dec 2019 14:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20191125124055.19286-1-jean-hugues.deschenes@ossiaco.com>
 <3e2857fd-aa5e-acc5-edd6-359715a636a6@linaro.org>
 <CAFEAcA90u0GsZZTX6EB0AzrS+A-ErTEGE2XVeJH8wvSmfF80tQ@mail.gmail.com>
 <YQXPR0101MB1142ACF7B4629FB56926BDF1A0400@YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB1142ACF7B4629FB56926BDF1A0400@YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Dec 2019 22:51:53 +0000
Message-ID: <CAFEAcA8y2bNiyJh1KOLERw_gi-k7nyGLgBEv=oYQZMOaCM_Rrg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Allow loading elf from aliased ROM regions
To: =?UTF-8?Q?Jean=2DHugues_Desch=C3=AAnes?=
 <Jean-Hugues.Deschenes@ossiaco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "martin.galvan@tallertechnologies.com" <martin.galvan@tallertechnologies.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Dec 2019 at 22:50, Jean-Hugues Desch=C3=AAnes
<Jean-Hugues.Deschenes@ossiaco.com> wrote:
> > My preference for fixing this properly is:
> >  * get Damien's three-phase-reset patchset into master
> >  * make the ROM blob loader write its data into ram
> >    in phase 2 ('hold')
> > * make the arm CPU reset read the data in phase 3 ('exit')

> Makes perfect sense. Feel free to drop the patch.

Well, I'm still vaguely tracking this patch; we might want
a temporary-fix if it looks like the phased-reset approach
is going to take too long to get into master.

thanks
-- PMM

