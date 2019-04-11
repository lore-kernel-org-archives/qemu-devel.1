Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B4C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007722133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxmwuncU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007722133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXWa-0005E8-7X
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:05:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEXS6-0002Jt-On
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEXRz-0000QK-P5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:01:04 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEXRk-00042N-DE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:00:59 -0400
Received: by mail-oi1-x22f.google.com with SMTP id 3so4509783oir.7
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 04:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=halBmWWCApfzc7ZVLPfqRJpEuD31B5OTbGmlt2Lax9o=;
	b=JxmwuncUwNrdFggyvVYzMWavKcZEadlKJm5S6JGuDuxfq28/h7JYCi0Hf8YALAIdID
	Om6MmD55CIeeaWAtKjkAkusRI428O9o0rghRhwMqhIBLZI67ptB2xDLdvwryOiq3D2vY
	F3EjWNJbM9pn7uugGUQ76jz723Vjze55CqLgLoA3iWOo2p0CfzK7dHPyrvheOBlAdaXw
	WmnyKHJfXoZnAq7WiEYShlBK2qs9MKQ5uS7UH8w1AIBAsXq4W2pAckDiB+giLEppogbi
	gJwapNQAWBx0wMDNJuTli0cuSeQhnI9A0J/mRT3aGTVhoR/ELh4WuPjgmXHYP68MqgB/
	9xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=halBmWWCApfzc7ZVLPfqRJpEuD31B5OTbGmlt2Lax9o=;
	b=B71fRpr+l5S0es2eRDFWgSBiPz0rGkylrBpVU/6/kLGLfEcO8uO7ktjUEVEMwbCa8Y
	6J3y547tN9/dQNwaelzUJNfX3TeAU9KPCKSeQv8FzZsZS5cxZ6iXyI9Zu15Zv7IZ3k5U
	suDAwcKxqG+JY4SbtgugpSxy8iSnKysWhaJt5oWiXWTekO7jn0MBdB70SOjSmz20zrr8
	MEGdrhgKJaXXf+q01JItnVbSNFeJlZc7b1twYFs4tee4f68H5HTMCWO4tt6c6WzsY8EY
	BocjMAmhgCXmZMCqd7LVotAUbClIU7L9BkNNy2PfKx1TTpg8Z7LmDUQeI4UE7Ozhtb9W
	fJNQ==
X-Gm-Message-State: APjAAAVg3UNVjtc30jEOjLvWtRKeME2tvtGA3DxJb85yNZT5qEy2Y11A
	ZaEXNd3n0EzpryXAEgYQ2MJUiIgi4lbdONzwEgqNMw==
X-Google-Smtp-Source: APXvYqwPf3p3NRDbGnXujdVLUgREGdEy1tSqdr85fWBVsEsUTxJH2K20k+lwJ3gkf7m0bwxRI1Bd6EXl1W+5yaLosZ8=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr5728758oih.163.1554980438912; 
	Thu, 11 Apr 2019 04:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <201904110044.38853.randrianasulu@gmail.com>
	<CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
	<201904111258.04551.randrianasulu@gmail.com>
In-Reply-To: <201904111258.04551.randrianasulu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 12:00:27 +0100
Message-ID:
 <CAFEAcA8BuzPkGKkeHH0EgDn08MJuWXbQwiwjuxT1vu5irmw4hg@mail.gmail.com>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411110027.T7GL4CTfurmQAWioEpJ_2QoGBOIFpU4hGn3SOQUAix4@z>

On Thu, 11 Apr 2019 at 11:03, Andrew Randrianasulu
<randrianasulu@gmail.com> wrote:
>
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 11 April 2019 12:14:45 Peter Maydell =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(=D0=B0):
> > On Wed, 10 Apr 2019 at 22:51, Andrew Randrianasulu
> > <randrianasulu@gmail.com> wrote:
> > >
> > > Please also include this patch in next -rc or final, it fixes 32-bit =
compilation:
> > >
> > > https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
> > > ([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)
> > >
> > > without it I get
> > >
> > > ui/curses.c: In function 'get_ucs':
> > > ui/curses.c:456:25: error: format '%x' expects argument of type 'unsi=
gned int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=3Dform=
at=3D]
> > >          fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UC=
S-2: %s\n",
> > >
> >
> > Rats, I'd forgotten about that one. What platform does it fail
> > to compile on, though? I test on 32-bit Linux and Windows compiles,
> > and they work OK.
>
> This is slackware (mix of many versions) + gcc (GCC) 5.5.0.
> Probably, this error will not show up if you don't have ncurses-dev packa=
ges,
> so configure will NOT enable curses ui ?

It turns out my 32-bit system has libncurses5-dev but not
libncursesw5-dev, so when we added the widechar requirement
it just stopped building the curses UI. I've now fixed that.
On the other hand, I still don't see the error. I think
my gcc/glibc combo must define wchar_t as 'int' anyway
(this is 32-bit arm).

thanks
-- PMM

