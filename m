Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64578C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E28C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPCsOw4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E28C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22tL-0000zJ-Bp
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j22sf-0000XZ-8n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j22sd-0004FZ-Lb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:01:25 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:37812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j22sd-0004Dl-9J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:01:23 -0500
Received: by mail-lf1-x136.google.com with SMTP id b15so2966489lfc.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 17:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Et4F/S9IyEYrBBoJb7DDt7GYe/MQ3dShDp2tKjZMSj0=;
 b=lPCsOw4eXRK1ve+3msiiSK0C1EfXF3OwbZwwR9lF3iqN6Y5oHgPckBz283oDXSBlYv
 ec3+ezwvE2EQGUCxPmSQdk1w/WaeR8lz82xwYTkjfXQcCz1uiyzilrOovEx1bLyh0waK
 JnxMKQVXLEfWmmJF88lJKIQ6H6F5wBGm4fkx9Idg5D1Ks0ygi8aDgNDN5HyFRR/dHTkY
 k8yXLGURwByTmPTbrC/Blbe4O90s1EcN6in6ozkmqWChwQrSPic5Bw7RVsTyZj/ToE4W
 +8B6ACyvbmjfbUDXkx+rUWeDjsO07aFglNY8h0k8QQDpoavUOwd3LSKj6rC3ho6pElo2
 6y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Et4F/S9IyEYrBBoJb7DDt7GYe/MQ3dShDp2tKjZMSj0=;
 b=Rft8GVqw0CurxpPx85xKKHnUknxrCHBGx61LI5PuSRZl/IbfcdyDtcYSkj2Pa1ZHX4
 gud3j0WzqZhdtOWZgH3Xk8LoWSqt2E/i4ILBfwSiQJq07WdE+PSvLdGJUZTIPgcQXH5c
 2gtrjl93gnA7g2tahGbb0K7dgvYQeTrL/J6s7PyDUOyrKotP5+tyvyGbMy7dQYjIsskA
 P3+rXTJ3sziNGR0L2C15XcEEI/qwxV/neb7DY/Ohcc67rT42WTWxP8BqUm5HawyddeuP
 0DLolv11yegcb/MZu9ZtYPFBD51dlHKvsy0V5xvFUMYygPm1OJ5pwFV2gYcvJHBKc+/1
 dOHw==
X-Gm-Message-State: APjAAAW8SzekESmu6hQ1lfjDGnWEMdLpgYkOXOZHeOx4+DSSqX6BWzQh
 miNPkfFbuuyHP/t7C9S1OZI1U3WEg5DXUpC7sp0=
X-Google-Smtp-Source: APXvYqwfK0Ilj0Ypn5eNpjp3R796VzKQuVW1At51EdOqnQYV1vAaCRNUgTi2YU10ivYKhCdyBotTVKB0uOWXj5r5D08=
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr7734459lfc.196.1581555681549; 
 Wed, 12 Feb 2020 17:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-4-coiby.xu@gmail.com>
 <20200116140429.GJ163546@stefanha-x1.localdomain>
 <CAJAkqrVhvi-8MZ-mPjZ67yfjOaick5Gu_g3GxYAeYvH3Cp6QVw@mail.gmail.com>
 <20200117101158.GC7394@dhcp-200-226.str.redhat.com>
 <CAJAkqrUYp7uCH80Ui0S4GXnAaKasNGPAYM5oJEjC2LuJ02cfPg@mail.gmail.com>
 <20200202093336.GB3456@localhost.localdomain>
In-Reply-To: <20200202093336.GB3456@localhost.localdomain>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Thu, 13 Feb 2020 09:00:45 +0800
Message-ID: <CAJAkqrUpn0aaJsew91h-Lqfkasxr67ygVWYTWWu=P7t1=5zxTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] a standone-alone tool to directly share disk image
 file via vhost-user protocol
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::136
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > Yes, I think at least for the moment it should work fine this way.
> > > Eventually, I'd like to integrate it with --export (and associated QMP
> > > commands, which are still to be created), too. Maybe at that point we
> > > want to make the QOM object not user creatable any more.
> >
> > Does it mean TYPE_USER_CREATABLE interface in QOM will become
> > deprecated in the future? I'm curious what are the reasons for making
> > QOM object no user creatable? Because we may still need to start
> > vhost-user block device backend through HMP or QMP instead of stating
> > it as a standalone-alone daemon.

> Not in general, but if we have something like a block-export-add QMP
> command, the QOM interface would be redundant. We could still leave it
> there and have both a low-level and a high-level interface, but whether
> we would want to is something we still have to decide.

I see. So QOM interface will still be used as a low-level interface.
In the draft version, vhost-user-blk-server is started using specific
command vhost_user_server_start/vhost_user_server_stop which proivide
interfaces easier for implementing block-export-add QMP command. But
in later versions, only object_add/object_del syntax is supported to
start/stop vhost-user-blk-server. I'll keep an eye on how the storage
daemon develops and adapt my code accordingly.


On Sun, Feb 2, 2020 at 5:33 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 31.01.2020 um 17:42 hat Coiby Xu geschrieben:
> > > Yes, I think at least for the moment it should work fine this way.
> > > Eventually, I'd like to integrate it with --export (and associated QMP
> > > commands, which are still to be created), too. Maybe at that point we
> > > want to make the QOM object not user creatable any more.
> >
> > Does it mean TYPE_USER_CREATABLE interface in QOM will become
> > deprecated in the future? I'm curious what are the reasons for making
> > QOM object no user creatable? Because we may still need to start
> > vhost-user block device backend through HMP or QMP instead of stating
> > it as a standalone-alone daemon.
>
> Not in general, but if we have something like a block-export-add QMP
> command, the QOM interface would be redundant. We could still leave it
> there and have both a low-level and a high-level interface, but whether
> we would want to is something we still have to decide.
>
> > > As for test cases, do you think it would be hard to just modify the
> > > tests to send an explicit 'quit' command to the daemon?
> >
> > Accroding to https://patchew.org/QEMU/20191017130204.16131-1-kwolf@redhat.com/20191017130204.16131-10-kwolf@redhat.com/,
> >
> > > +static bool exit_requested = false;
> > > +
> > > +void qemu_system_killed(int signal, pid_t pid)
> > > +{
> > > +    exit_requested = true;
> > > +}
> >
> > if exit_requested = true, qemu-storage-daemon will exit the main loop
> > and then quit. So is calling qemu_system_killed by what you means "to
> > send an explicit 'quit' command to the daemon"?
>
> qemu_system_killed() is call in the signal handlers for, amongst others,
> SIGTERM and SIGINT. This is one way to stop the storage daemon (for
> manual use, sending SIGINT with Ctrl-C is probably the easiest way).
>
> What I actually meant is the 'quit' QMP command which will cause
> qmp_quit() to be run, which contains the same code. But if sending a
> signal is more convenient, that's just as good.
>
> Kevin
>
> > On Fri, Jan 17, 2020 at 6:12 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 17.01.2020 um 09:12 hat Coiby Xu geschrieben:
> > > > Excellent! I will add an option (or object property) for
> > > > vhost-user-blk server oject which will tell the daemon process to exit
> > > > when the client disconnects, thus "make check-qtest" will not get held
> > > > by this daemon process. After that since Kevin's qemu-storage-daemon
> > > > support "-object" option
> > > > (https://patchew.org/QEMU/20191017130204.16131-1-kwolf@redhat.com/20191017130204.16131-3-kwolf@redhat.com/)
> > > > and vhost-user-server is a user-creatable QOM object, it will work out
> > > > of the box.
> > >
> > > Yes, I think at least for the moment it should work fine this way.
> > > Eventually, I'd like to integrate it with --export (and associated QMP
> > > commands, which are still to be created), too. Maybe at that point we
> > > want to make the QOM object not user creatable any more.
> > >
> > > Would it make sense to prefix the object type name with "x-" so we can
> > > later retire it from the external user interface without a deprecation
> > > period?
> > >
> > > As for test cases, do you think it would be hard to just modify the
> > > tests to send an explicit 'quit' command to the daemon?
> > >
> > > > I'm curious when will be formal version of qemu-storage-daemon
> > > > finished so I can take advantage of it? Or should I apply the RFC
> > > > PATCHes to my working branch directly and submit them together with
> > > > the patches on vhost-user-blk server feature when posting v3?
> > >
> > > It's the next thing I'm planning to work on after completing the
> > > coroutine-base QMP handlers (which I hope to get finished very soon).
> > >
> > > For the time being I would suggest that you put any patches that depend
> > > on qemu-storage-daemon (if you do need it) at the end of your series so
> > > that we could apply the first part even if the storage daemon isn't in
> > > yet.
> > >
> > > The latest version of my patches is at:
> > >
> > >     git://repo.or.cz/qemu/kevin.git storage-daemon
> > >
> > > But if you just need something for testing your code, I think it would
> > > even make sense if you kept your standalone tool around (even though
> > > we'll never merge it) and we'll deal with integration in the storage
> > > daemon once both parts are ready.
> > >
> > > Kevin
> > >
> >
> >
> > --
> > Best regards,
> > Coiby
> >
>


--
Best regards,
Coiby

