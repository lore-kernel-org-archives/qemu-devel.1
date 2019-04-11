Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97603C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F11020873
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYsLGNx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F11020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEOUM-0002bb-9B
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 21:26:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hEOTZ-0002IE-0l
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hEOTX-0005jB-Kt
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:26:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hEOTX-0005j5-8L
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:25:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id k21so3780884otf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 18:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cscDqqLc5SgyFFaW1pafhPj5eGjAs1lSqq1091zJ3dU=;
	b=sYsLGNx5Kza/DX0k9M0tGW6mOC4VNkhAAn2jUkQclUdwhLWd+ACA+92WMrukb9Vy1X
	A3CXhWGDFuRTghTislqB+76bjmEp6n9pyjPjfnlpQ6vJsjZ/TxQImSu8yar98D2jfkvf
	X06KFHKZO8mKqCV004weRd+0bH3m1C5SqLAl0Md28TMTMMgGPy4d3a+fKZZozO2WG4cc
	IVWq0lxDR6lNs5SgP5NCJ8ePTGyrO+u8PXT85Yn8zPL9NuV/67nJP7gLpDPSsDub77mY
	ZRvO/mHXB4YOK+KJsxi3+tN/XurfU51wwTQQakVOu71XTZSTL40+Nd9pDKpj4XXpEXdF
	SMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cscDqqLc5SgyFFaW1pafhPj5eGjAs1lSqq1091zJ3dU=;
	b=hLVV8gMHQ6pBrWzRyl54zlv3lZ/fb3tlodlXTTdN4tFdfptAIwIZqw+lw7T/Fi1x+c
	BYqAyA/ykwDdg45AQY8o5Q7P83GiRau8U+8kAX734ZB4kBWf/3/5mKfiK2JOLFEKBT7m
	fxA9Dn8C4sdthFawtte8Tq4A6+7ob1ObxoglGnXfqEzKiKp87PaVmSosTm9kuKE3O5yu
	gefjIwRX89PmU03ITFKxorcfT3HLmj8LzglvOH0it1w0JtWkGj0I8SvJnNJkN4oi6ctS
	Nwoz73Ew0CGEcjV6C3ft+/wiAvjiwsy1rNv5h+UnfxDwIjaLM6SpBnD3zdnjI2FzbKLP
	Z3Aw==
X-Gm-Message-State: APjAAAU8Lwqg44EgRolRY80BtUFIi2mbVGrcucnsNdZGVazwQuazM8iz
	GSfI7nvT/Lf3oM1ayHD+4XhfXWEptpOtgXlIpBg=
X-Google-Smtp-Source: APXvYqxT03NWVUyvOhHGIWrqjA6Qu7Yni1dwC+ztcdeK9569GNZWEv5hHnRUSVjIDhi+/CCpNaAYq45SxAkKWFfxms8=
X-Received: by 2002:a9d:758d:: with SMTP id s13mr31144160otk.306.1554945958361;
	Wed, 10 Apr 2019 18:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408123542.1a4de426@redhat.com>
	<CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
	<20190410145908.GF2980@work-vm>
	<CAEn6zmGGLLJb_7JCZzz-yWYpzkoGN7Vxd4aQ5_pvsMM+Sz8vPw@mail.gmail.com>
	<20190410165736.GG2980@work-vm>
In-Reply-To: <20190410165736.GG2980@work-vm>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Thu, 11 Apr 2019 09:25:46 +0800
Message-ID:
 <CAEn6zmFTTYZwPtQ0UQZz=a8UnAWUDxz6VuZ1Lpdq860MZ6foYg@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: warn when
 memory-backend-file, share=on and in incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411012546.yxooqx3YoD7094WExb9Nvsnpz_fevMiF9gZ2EgFLJZ8@z>

Hi Dr. David

On Thu, 11 Apr 2019 at 00:57, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Catherine Ho (catherine.hecx@gmail.com) wrote:
> > Hi Dr. David
> >
> > On Wed, 10 Apr 2019 at 22:59, Dr. David Alan Gilbert <
> dgilbert@redhat.com>
> > wrote:
> >
> > > * Catherine Ho (catherine.hecx@gmail.com) wrote:
> > > > Hi Igor
> > > >
> > > >
> > > > On Mon, 8 Apr 2019 at 18:35, Igor Mammedov <imammedo@redhat.com>
> wrote:
> > > >
> > > > > On Sun,  7 Apr 2019 22:19:05 -0400
> > > > > Catherine Ho <catherine.hecx@gmail.com> wrote:
> > > > >
> > > > > > Currently it is not forbidden to use "-object
> > > > > memory-backend-file,share=on"
> > > > > > and together with "-incoming". But after incoming migration is
> > > finished,
> > > > > > the memory-backend-file will be definitely written if share=on.
> So
> > > the
> > > > > > memory-backend-file can only be used once, but failed in the 2nd
> time
> > > > > > incoming.
> > > > > >
> > > > > > Thus it gives a warning and the users can run the qemu if they
> really
> > > > > > want to do it.
> > > > >
> > > > > Shouldn't we add a migration blocker in such a case instead of
> warning
> > > > > and letting qemu run wild?
> > > > >
> > > >
> > > > IMO, it doesn't need to block this. With share=on and -incoming, the
> user
> > > > can
> > > > still save the device memory state into memory-backend file again if
> > > > ignore-shared
> > > > capability is on.
> > > >
> > > > If we block this, the user can't use the ignore-shared capability in
> > > > incoming
> > > > migration.
> > >
> > > -incomign with share=on is a perfectly normal thing to do - it just
> > > depends who you are sharing the file with and the lifetime of that
> > > shared file.
> > >
> > > For example; if you're just running a qemu with vhost-user then you
> > > use share=on - however wyou typically select the backend file as
> > > a new file from /dev/shm - it's not a file that you previously migrated
> > > to.
> > >
> > Thanks,
> > but using a new file from /dev/shm means kernel will start from
> > start_kernel or early? Is it different from the x-ignore-shared case?
> > If we remove the share=on in incoming migration, all the writting
> > of ram will not be flush into the memory backend file. Thus we
> > can use the base memory backend file for ever.
> > e.g.
> > 1) save the vm like a snapshot, current ram state is "kernel
> > has been started, systemd has been started"
> > 2) restore it with -incoming and *no* share=on flag
> > 3) restore it with -incoming and *no* share=on again...
> > In contrary, if we use share=on, the base backend file will
> > be written at once after 1st time incoming.
> >
> > So, IMO, no "share=on" is the proper usage of incoming migration
> > when ignore-shared is on.
> > Please correct me if sth is wrong, thanks:)
>
> OK, I see what you're trying to do - you mean for the 'snapshotting'
> case;  but that's not the only use.  Another use is for being able to
> do a very quick upgrade of the running qemu to a new qemu binary
> version; and in that case you want to be able to write to the shared
> file so that you can repeatedly do the quick migrate.
>
> Dave
>
> Ah, that quick upgrade example makes sense to me. Thanks for the
explanation.

B.R.
Catherine
