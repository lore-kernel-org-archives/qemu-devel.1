Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A7C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E14206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmH1PlRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E14206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionqw-0002ES-C2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ionhc-0000Hi-NJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ionhb-0000o3-BW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:11:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ionhb-0000nc-4q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:11:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so19137560wmf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bT84RsZvfc+7Ezuy38ghlog/7n4wY9ui9iTN2N4rkmc=;
 b=JmH1PlRpQn5nwFU1uAjptB8ylq74cjDbctmYwY7r2vVIjvVSZ8WKt0nJWr5QYWGOBQ
 yzxyeRlrrriQvZcZNWAfrWy0tOD27jlNM6SsCbEXzM5sBDWtVbrmt8VAUg13fhUtK22M
 /+DEvdZHipCYYDMayZk2Hit8gY2q3GGRYV+z81q95Zs8YWE6M7ZEgE7bDK8LPivZlyty
 0N8QpRWr1k4eKDM0E3U998I6jfJl5fidHLZVWj2YXPW0GeAfLtUvFot6jien7xUsBJnz
 Br4esV7fkNzF79tgd7T0KeuX+SLwn+NGZvckjNQKNh4iEKIDznyiuJPo0UTGt6Ui9sja
 0xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bT84RsZvfc+7Ezuy38ghlog/7n4wY9ui9iTN2N4rkmc=;
 b=km6c02+QXNfkCNMiYYDxDtnRHR3B/fclJxA26Y85cHX/GbWraDJ6gGhwj24KEbVO9V
 bD+sVd83oAQB5FNMTNhGJoB/YU+OQJ4hcGwvFCroNTR2eysjMrinGVDvN4a1BatviQ5B
 caA+dneAoLHGtlkH7XYQH2E5hsrLhblltjPBSX0dGzltYwN9/tvJQu0dHkTW/xVzEetv
 T6O/AFsExL+jpWo/ugALWNRFqkEvZt/T+rWlcACgd3HFwq+f0lzV+aDBsu4uQhuSLJmG
 dpRZEkQutD/WOEORdMdqwU44NzToFgGg+sUJ6CTasl7Qtn9fHrpBdWTZAe3RHTqx9PXg
 JThA==
X-Gm-Message-State: APjAAAXn/hXm/fXyAoGWS7hs5GqVOcpEy4P7IcEUfuzxIToE7ZKD9WjC
 AX8PDXIEKy2iZxrSpibX8Fnxuy059mrRTiprnhs=
X-Google-Smtp-Source: APXvYqzmhIuFgZ7lJ/wtzoYvizTQE34O89TPh5zt+8t81eeAsA7DI8f86Evl0iog66Uzj6YHcM1TkjJAYRG3UY3Us1Q=
X-Received: by 2002:a05:600c:2148:: with SMTP id
 v8mr41841951wml.111.1578399074013; 
 Tue, 07 Jan 2020 04:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
 <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
 <20191216120701.GC6610@linux.fritz.box>
 <CAJ+F1CJjrh3LJs=YtNOkk3rYo-MpmXr3ho9pt0z7tnqm4kp96w@mail.gmail.com>
 <20200107051728.GA4076@linux.fritz.box>
In-Reply-To: <20200107051728.GA4076@linux.fritz.box>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Jan 2020 16:11:01 +0400
Message-ID: <CAJ+F1CLocmL-9d06jsbfUFq1peV7w-Ho30vKnp7cVVk8jfXVnw@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Jan 7, 2020 at 9:17 AM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 06.01.2020 um 19:21 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > > What my patch does is moving everything into a coroutine. This is wro=
ng
> > > because not everything can be run in a coroutine, so it needs to be m=
ade
> > > optional (like you did with your async flag).
> >
> > "everything" is a bit too much ;) You proposal is to replace
> > qmp_dispatch_bh by a coroutine version (except for OOB commands). This
> > is nice because indeed, it allows to reenter the mainloop with a
> > simple yield in QMP commands. It is also simpler than my "async"
> > proposal, because some of the state is part of the coroutine, and
> > because it doesn't allow QMP commands concurrency (beside existing
> > OOB).
> >
> > Iow, coroutine (for async) + oob (for concurrency) make my proposal
> > kinda obsolete. I can only regret that a simple callback-based
> > solution looked simpler to me than one that mixes both threads &
> > coroutines, but I don't mind if everybody likes it better :) I can
> > definitely see the point for block commands, which rely on coroutines
> > anyway, and qemu is already that complex in general.
>
> Callbacks are indeed simple enough for implementing the infrastructure,
> but for the users they only look simple as long as they do trivial
> things. :-)
>
> Anyway, now that you have seen my POC hack, do you agree that this
> should help solving the screendump problem, too?

Yes, and I will work on it as soon as you have a working patch series
or branch :)

>
> > > The problem isn't with completely coroutine-unaware code, though: Tha=
t
> > > one would just work, even if not taking advantage from the coroutine.=
 A
> > > potential problem exists with code that behaves differently when run =
in
> > > a coroutine or outside of coroutine context (generally by checking
> > > qemu_in_coroutine())), or calls of coroutine-unaware code into such
> > > functions.
> > >
> > > Running some command handlers outside of coroutine context wouldn't b=
e
> > > hard to add to my patch (basically just a BH), but I haven't looked i=
nto
> > > the QAPI side of making it an option.
> >
> > Yes, I think we should have a 'coroutine': true, for commands that
> > should be run with a coroutine.
> >
> > Or perhaps replace existing allow-oob with 'dispatch':
> > - 'bh' (default)
> > - 'coroutine'
> > - 'allow-oob' (oob + bh fallback, since oob don't have coroutine - at
> > this point)
>
> If it's "at this point", then making it two separate bools would make
> more sense. But I seem to remember that OOB handlers are fundamentally
> not supposed to block, so coroutine support would be pointless for them
> and an enum could work.

I think so too

>
> I'll defer to Markus on this one.

Yup, Markus should take a look at your proposal and give some
guidance. And hopefully, it won't take >2y.

>
> > Your patch looks quite good to me, but make check hangs. Have you
> > looked at it?
>
> I'm not sure if I was looking at some qemu-iotests cases or make check,
> but yes, I did see a hang. My case was a QMP command that just doesn't
> work correctly inside a coroutine without modifications, so requiring
> 'coroutine': true would fix it.

ok, then I suggest you do a "minimal" patch series that works.

thanks!

--=20
Marc-Andr=C3=A9 Lureau

