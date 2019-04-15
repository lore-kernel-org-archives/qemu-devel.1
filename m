Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB1C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4C82087C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4C82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4Xh-0001nl-IX
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:33:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hG4Wr-0001Ul-B2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hG4Wq-0005LY-0w
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:32:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hG4Wp-0005Jh-Ps
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:32:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id n187so14326902oih.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 09:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=yEMeCSfKXRpCtY0HXwiizvaSjB3WsXV0kaYUj++8BVg=;
	b=R0Mf3xBVzyVY658F8U1PFtHLQPVkKAZiDWHr2JKt4wWnjS2CnqJkSHfUOuzy4BY/fr
	xZnJLSzxs9mo/KiX0Ngy2nabt0ZmqwOYHiZolTVt7L0x6j15O9YVsfu+SMEjotNio6nf
	3Ti075eNeY6t3svX5sDbqKbWywWMxmGC1XyX2K/JGRGtgyCR0hxa2HApRQCLnN4EYS72
	ifBPDour8v2TXlCGxfYktU7ByJJ2/JGBUGs3OIuDyEPh4iDYYQVZJKk5Ze4Zvr1xZp5T
	FAfDmYRdLnuKyE4PvGAMcV7vVgb010ns8JabVlh9Mqzr3f2ERo9cemRW1RDmthWoMmyX
	aCdg==
X-Gm-Message-State: APjAAAWNEeSjbwCz+3T7h3sz/NaIPrmN0i9dABejerJoH/czcyN7hpSN
	vfpwdZ+UCY0C8aTHcrshjMsGH9TdFZ0A3+k5E4Xgpg==
X-Google-Smtp-Source: APXvYqxQLxzK4MJ1QDHwF0FD8hhg6dRRZJEFI96EA+WqM1zJz5HKvViSmyukqKd668S1UOqU4rHGSfAIay2ixDrNwAk=
X-Received: by 2002:aca:d614:: with SMTP id n20mr20337129oig.46.1555345935628; 
	Mon, 15 Apr 2019 09:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190415162129.30511-1-marcandre.lureau@redhat.com>
	<20190415162725.GR5718@redhat.com>
In-Reply-To: <20190415162725.GR5718@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Apr 2019 18:32:04 +0200
Message-ID:
 <CAMxuvax-FimWMXEoUcDPeJehbC3bmQ4MoG1iERk-k_wLeBRxRA@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.193
Subject: Re: [Qemu-devel] [PATCH v3] socket: allow wait=false for client
 socket
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415163204.eZAQwZkR12NNW0HfqAEJDkKu9RqfJoM5ci3X8jNjASk@z>

On Mon, Apr 15, 2019 at 6:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Mon, Apr 15, 2019 at 06:21:29PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> > is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> > thus fail to add client chardev.
> >
> > Make the code more permissive, allowing wait=3Dfalse with client socket
> > chardevs. Deprecate usage of 'wait' with client sockets.
> >
> > Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char-socket.c | 10 +++++++---
> >  qemu-deprecated.texi  |  5 +++++
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 3916505d67..ebc1adb83e 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -1263,9 +1263,13 @@ static bool qmp_chardev_validate_socket(ChardevS=
ocket *sock,
> >              return false;
> >          }
> >          if (sock->has_wait) {
> > -            error_setg(errp, "%s",
> > -                       "'wait' option is incompatible with "
> > -                       "socket in client connect mode");
> > +            warn_report("'wait' option is deprecated with "
> > +                        "socket in client connect mode");
> > +            if (sock->wait) {
> > +                error_setg(errp, "%s",
> > +                           "'wait' option is incompatible with "
> > +                           "socket in client connect mode");
> > +            }
> >              return false;
>
> Oh wait, don't you need to put the 'return false' inside the
> if branch above, otherwise we're still failing validation.

indeed, v4 on the way

>
> >          }
> >      }
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index 2219386769..842e71b11d 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -105,6 +105,11 @@ details.
> >  The ``query-events'' command has been superseded by the more powerful
> >  and accurate ``query-qmp-schema'' command.
> >
> > +@subsection chardev client socket with 'wait' option (since 4.0)
> > +
> > +Character devices creating sockets in client mode should not specify
> > +the 'wait' field, which is only applicable to sockets in server mode
> > +
> >  @section Human Monitor Protocol (HMP) commands
> >
> >  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (=
since 3.1)
> > --
> > 2.21.0.313.ge35b8cb8e2
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

