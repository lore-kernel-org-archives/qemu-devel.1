Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E8AC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD56F217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcNogaIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56F217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWZT-0007r2-T7
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:04:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEWYQ-0007Nv-0N
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEWYO-0004TT-K0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:03:33 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hEWYO-0004Sf-8E
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:03:32 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so3306657pgh.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:user-agent:cc:references:in-reply-to
	:mime-version:content-transfer-encoding:content-disposition
	:message-id; bh=6FZvhnplBC/EumBGTiU+jtfOz3Vs/auPGODHWUYAxak=;
	b=UcNogaIsLkfDXgJJRaklEIM2TODlJmqTfGoyX/iIvmmPIdYsRSPd6F3ZW1E/adrLNw
	r1UqEtVTEXFZlNqdBjEQTjlxQWFyHMDwmD6RGnWVRvULgtXSwTILh/1jDYLWC3l7OlXu
	U0Ih6690/6k6n9+zi+SO4Yzl1C7qfCcQmNTOFwNE4S6ZXGuuUov96VaYYYv0gbUoHQNF
	ZhZtRMLOswq0U/Wyf4Tzv9zuL6txReqarylIGfyWltx3TSrWgnw9bZgqMI5LZxsZRBa4
	EyLKhWWHzAhMJBg1x13co3vOf+SCug/EPfC71XdObKXapv7c4Q1JZYjJ4RKKk6EU7btj
	w/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
	:in-reply-to:mime-version:content-transfer-encoding
	:content-disposition:message-id;
	bh=6FZvhnplBC/EumBGTiU+jtfOz3Vs/auPGODHWUYAxak=;
	b=n3j3+gMxr4RKSpXa2EdaNGzB7g1uT+BV7AIoKUz2QE8oYFn+eVQ1NMQ2QjGnNqVXV/
	8t/0YR7NZWhgHPgNY1LA4n99KrJLWblYw/1m0EPXevPEn19T35px/XprBbdOSNKLGVO/
	ojzTCo/oeDqejvaABviBOSUYXeRWcKLj4X6u4AWXjYWHQXeV1H4LiQUg5vjUM4O+5LOK
	Wjck31xHyirnykQa+pn+4CXPQ3j3AYjksb7Mqelg7/Vp7B12wcbtMLMDxqazi7aA0vPS
	WIpB6KzNpggkDIkVUjUphNsNCxNW9a9viN8hjRQYwELFRGXM9mvJuGFAE4ngnuKSv7/r
	CkEg==
X-Gm-Message-State: APjAAAXJYIiPJ0k+9M3ycKNOI8O7AY9GiNQTdQj8kfZmWVSlytSpxv1A
	8oCgwhh7pP3mLyEQ6iNbht4=
X-Google-Smtp-Source: APXvYqxvSkW3gD2yCWyPzTyOj7bYGcf0BCF+G6FP7FR5NG0FTw0XCxlYCnZQCwh1+Uzav0HFEOqshQ==
X-Received: by 2002:a63:330e:: with SMTP id z14mr45043543pgz.4.1554977010906; 
	Thu, 11 Apr 2019 03:03:30 -0700 (PDT)
Received: from [192.168.1.101] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	k1sm39434789pfc.83.2019.04.11.03.03.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 03:03:30 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 12:58:04 +0300
User-Agent: KMail/1.9.10
References: <201904110044.38853.randrianasulu@gmail.com>
	<CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
In-Reply-To: <CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201904111258.04551.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
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
Message-ID: <20190411095804.8pAfqzm3Hvy386wNDs1KjDqa_C6CXqHs13ygmZM7Rm4@z>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Thursday 11 April 2019 12:14:45 Peter Maydell =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> On Wed, 10 Apr 2019 at 22:51, Andrew Randrianasulu
> <randrianasulu@gmail.com> wrote:
> >
> > Please also include this patch in next -rc or final, it fixes 32-bit co=
mpilation:
> >
> > https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
> > ([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)
> >
> > without it I get
> >
> > ui/curses.c: In function 'get_ucs':
> > ui/curses.c:456:25: error: format '%x' expects argument of type 'unsign=
ed int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=3Dformat=
=3D]
> >          fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-=
2: %s\n",
> >
>=20
> Rats, I'd forgotten about that one. What platform does it fail
> to compile on, though? I test on 32-bit Linux and Windows compiles,
> and they work OK.

This is slackware (mix of many versions) + gcc (GCC) 5.5.0.
Probably, this error will not show up if you don't have ncurses-dev package=
s,=20
so configure will NOT enable curses ui ?

>=20
> Also, this will be only a warning, not a compile error, in the
> release build, so we could get away with releasing without
> the patch applied. We'll see if any other rc4 issues come up.
>=20
> thanks
> -- PMM
>=20



