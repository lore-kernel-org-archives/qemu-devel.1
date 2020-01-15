Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5ADC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1617A2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snQS0X+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1617A2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhIC-0007n6-6k
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 06:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irhHP-0007B5-4m
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irhHN-0008Eb-JB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:56:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irhHN-0008DT-Cc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:56:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id 20so17494019wmj.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 03:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HMxYUPvmYuzmR2gIYNDawhi+qRRlEB5dSL2s1TCoK04=;
 b=snQS0X+HGOCYgm4CMzHeOK+gqcJazXc8A7kPE7jB2NhCEa3ujalPAheU3uJYa4dI/H
 TkTfG2t5qHhmaIIqawV8JaXfIuU5A88DRq1LJiYCWoJNIZQ2FqJdGHRiFaYHgUPJl8rh
 FDr6HZepd15MWE1/YTbz3/mgvQUEDe2gC0fKDt90iE/4nj66HBQuT5cEnQaTauqXudSY
 xYrmNs6D3NWvpj6hMkaciDS3GV6m+ZFVmRYX+QwhLaL1ueI8DoL0JweLzu3OEhBdFnk4
 0DRTfzx7FMkrT/wERHsmoehKoU6KRYv4vZQGkOdkACRaepYUB9ReoIxloyzh/9RITWdw
 UKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HMxYUPvmYuzmR2gIYNDawhi+qRRlEB5dSL2s1TCoK04=;
 b=tXar0gj91Xg+46hyWbDWgW9nTQ5PNxyGIXTtSGp6B1XgwKN61e05+FlIMXFloTiiNH
 2S8pibUvm75nzfdTBr3NzyVLPIhHo3K+oxXGaYal4nXfhMdPywdTgyV8xnIKXdCvARuA
 D7nsZP510r5NQiR0gs4OMQ+Vl5opHPEeVNPR1mv6G5xUR1cagoSl8ZQnHAKpzyOn0EDg
 MMMichCfODxtaXG/afozfcX2+4pMGU60b36K3lA6PWYiIL9eeJkMIrjPZ4Xs41pSMmGj
 iwaMnffiCWNGVH+6Hj/ZZFOGdoODa/OwQHWfIfAc2pQr+aypOoQ9JKXzK8XvG0h6gZtE
 XDqg==
X-Gm-Message-State: APjAAAVN8693iLMmqEfC8cotRxX406g0MhAm6FXAw5HCaGCVsN3cJyCL
 CEJsZtIbuEm05JXY/uiEckglR/UM4Vc=
X-Google-Smtp-Source: APXvYqxSmtCK0dS9tJzzg+uCZWRFdWMlrC+JQ7bpDgmswuJU+bGoA4r1NrIqgup7Awdw8saf4NV09g==
X-Received: by 2002:a1c:b7c4:: with SMTP id
 h187mr33367730wmf.105.1579089366664; 
 Wed, 15 Jan 2020 03:56:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm24496270wrr.40.2020.01.15.03.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 03:56:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D6BE1FF87;
 Wed, 15 Jan 2020 11:56:04 +0000 (GMT)
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
In-reply-to: <20200115111042.GA163546@stefanha-x1.localdomain>
Date: Wed, 15 Jan 2020 11:56:04 +0000
Message-ID: <87zhepkk6j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Jan 14, 2020 at 12:11:34PM +0100, Thomas Huth wrote:
>> On 13/01/2020 11.35, Alex Benn=C3=A9e wrote:
>> > ..and extemporise a little about their state.
>> >=20
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > ---
>> >  documentation.md | 9 ++++++---
>> >  1 file changed, 6 insertions(+), 3 deletions(-)
>> >=20
>> > diff --git a/documentation.md b/documentation.md
>> > index f4ef9f4..55d5db6 100644
>> > --- a/documentation.md
>> > +++ b/documentation.md
>> > @@ -3,9 +3,12 @@ title: QEMU documentation
>> >  permalink: /documentation/
>> >  ---
>> >=20=20
>> > -The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be=
 read online, courtesy of Stefan Weil.
>> > -More documentation is found in the <a href=3D"https://git.qemu.org/?p=
=3Dqemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
>> > -directory of the QEMU git tree.
>> > +The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be
>> > +read online, courtesy of Stefan Weil. There is a partial set of
>> > +[developer documentation](https://qemu.readthedocs.io/en/latest/)
>> > +which is generated from the QEMU git tree. The process of converting
>> > +the rest of the [`docs`](https://git.qemu.org/?p=3Dqemu.git;a=3Dtree;=
f=3Ddocs;hb=3Dmaster)
>> > +directory is ongoing.
>>=20
>> This has a conflict with Stefan's patch to point to our documentation on
>> www.qemu.org now instead:
>>=20
>>  https://patchwork.kernel.org/patch/11234545/
>>=20
>> ... Stefan, looks like the index.html page is still not there yet,
>> although your other patch that includes index.html.in in the sources is
>> in the repository now? What's the status here?
>
> The qemu.git/master docs are built nightly here (index.html is now
> visible!):
> https://www.qemu.org/docs/master/
>
> qemu.org's docs are more useful at the moment since they include the
> user documentation in addition to the developer documentation.

And I think we want to continue hosting them on qemu.org. Is it possible
to theme them under the website branding? Stefan's version includes a
banner and background icon so it would be nice to at least fit in with
the reset of the site.

> It's good that we got ownership of the readthedocs.org account for QEMU.
> I don't know if rtd will be capable of building QEMU's hodgepodge of
> different documentation systems.  It supports Sphinx and Mkdocs but
> that's not enough.

Yeah at the moment we are just doing the sphinx side of things. AIUI the
long term plan is to convert stuff to .rst (at least for the developer
docs).=20

> Can we redirect readthedocs to qemu.org?

Yeah rtd can label the canonical version of the docs as coming from your
own domain and link back (and importantly SEO juice it).

>
> Stefan


--=20
Alex Benn=C3=A9e

