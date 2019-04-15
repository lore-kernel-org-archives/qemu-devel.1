Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42FDC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9E1206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/LN4tEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9E1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4Iu-0004Ch-PB
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:17:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hG4Hs-0003jK-VR
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hG4Hr-0006u3-Uz
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:16:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hG4Hr-0006mF-Gh
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:16:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id y197so9419885wmd.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=JbrFmr6HYBuBkEp7h7sJ2EbvtRMPZM7CLlM6d7BTjzo=;
	b=F/LN4tECbOYZlV2eA8AOdZSoIt0GtGknUmkBx2NC3RU+rWzYIPgZSafCn6/LQbzN8q
	O1I4j+TJFAiKXfAt/+IxDPwYTLpRMk7Jhz9U64RLAutSJ6JorAcw1fkiyjlRUhhIPhK1
	ED+Fs00uavXHZP43VS7PDFJt6vyr9esnW/SnhIzbK3yuIK9JyX34LC3IW9pAtNDI4+7u
	6j1+33JLX4V9yyy2yNzsOF1oZ3uy06lT1dXGMhFlQRkyo0qlveYjQGjrTf2I2nWcdhHM
	3DanYGEEWkIQdk8KLpPXRyyM6VBHoZMuU8Idl3d7wTC5ZdRX0BeM/weg5Uc/6MFXga4g
	4TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=JbrFmr6HYBuBkEp7h7sJ2EbvtRMPZM7CLlM6d7BTjzo=;
	b=YOWK0GeOsKURmtLBU8+U0+CEkafSrUuOWFLwx4HJKmalKbpZmwxAOWiR5uigmJLv10
	AFs1DV+eg9MpPMBLB/BT5ibHgom5YpQ6yoPabl4WC2kTlpz69Ii4Nv1VUvVz54tJsSuT
	ruy+uvmDhseIsvVjqvrPM0JraADmZsfzH63XDKlcoz/sJc8iApzM+RcEb79+jkvLN7IF
	i0SEc93+/rj1WJc3WjDpR/i3BC6ggGJKTBL6OXXPXSmvRQ6OcsjdjQlyhLcgEyL96Rox
	UmbA3xdHy+Sh7+yCxdddXPxZSwYQbpo+aQKsuz6vPnX55vaBy83kRQ5uZcXwd9+sFU9x
	LM2Q==
X-Gm-Message-State: APjAAAXpwI5WRG82aXOoNtWW1Iu9uMqttrw1t14D0sPZ4kYMXYzE3TAW
	5Xu8WMiVbcP6tFRZIRxGuO+Ol1ENfujpvf9BmlE=
X-Google-Smtp-Source: APXvYqwyUpweWO31ifL/V8VDrBcJQlNkyWU1lEmF5IgKu3oft++M7cqCUrskmUa+m1tXCwR5+xwNoIfL5R11lQ8pMP0=
X-Received: by 2002:a1c:1a46:: with SMTP id a67mr23463633wma.21.1555345005281; 
	Mon, 15 Apr 2019 09:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190415160609.24240-1-marcandre.lureau@redhat.com>
	<20190415160809.GP5718@redhat.com>
In-Reply-To: <20190415160809.GP5718@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Apr 2019 18:16:33 +0200
Message-ID:
 <CAJ+F1CJwW-20YWbYgcHGhtBDZnHGAHSrj-OHht0hFb5O8ndsFQ@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2] socket: allow wait=false for client
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415161633.drU29Ys_-XNMUzNjxJb6AA-wFMZo8l_3AHO0qKdk6-I@z>

On Mon, Apr 15, 2019 at 6:08 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Mon, Apr 15, 2019 at 06:06:09PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> > is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> > thus fail to add client chardev.
> >
> > Make the code more permissive, allowing wait=3Dfalse with client socket
> > chardevs.
> >
> > Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char-socket.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
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
> >          }
> >      }
>
> NB, it should also update qemu-deprecated.texi

Is that clear enough?

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2219386769..0f53d1c228 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -105,6 +105,12 @@ details.
 The ``query-events'' command has been superseded by the more powerful
 and accurate ``query-qmp-schema'' command.

+@subsection chardev client socket with 'wait' option (since 4.0)
+
+The ``chardev-add'' and ``chardev-change'' should not be used to
+create client sockets with a ``wait'' field, which is reserved for
+server sockets only.
+
 @section Human Monitor Protocol (HMP) commands

 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove'
(since 3.1)




--=20
Marc-Andr=C3=A9 Lureau

