Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C52420863
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyayInBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C52420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kkk-0005GB-S9
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j8kjv-0004iF-QD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j8kju-0001le-2Q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:04:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j8kjt-0001kp-U6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583154245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zoru/AFSP9V2m38KOU1Z3u+IKoaNb1k7zlhaBagdmP4=;
 b=QyayInBg91CGOJbbbZabnUm8YQ+ynfBM+7Yopomh/zfqrMZOmnGjy2jzraTky0vjxTx6mg
 rU/R0dt24uupKfsBmgZFkdad616PhenIeAE9Wgj20Gtyxnl6NxEF/zFVikUSG0y8aORRhj
 XD8TKsCZlWF+j04Twx4KdBCRxJ7HaQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-WblNVpelPwaw1yNobJD9Ag-1; Mon, 02 Mar 2020 08:03:58 -0500
X-MC-Unique: WblNVpelPwaw1yNobJD9Ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 562511034B34;
 Mon,  2 Mar 2020 13:03:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F89810013A1;
 Mon,  2 Mar 2020 13:03:56 +0000 (UTC)
Date: Mon, 2 Mar 2020 13:03:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thorsten Glaser <t.glaser@tarent.de>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
Message-ID: <20200302130353.GL1679990@redhat.com>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 01:43:12PM +0100, Thorsten Glaser wrote:
> On Mon, 2 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
>=20
> > "x11vnc" suggests you had a regular X11 desktop session, and are
> > exporting it via VNC ?
>=20
> No, x11vnc is a standalone VNC server.
>=20
> > Can you tell me a bit more detail about how you launch this all.
>=20
> Sure:
>=20
> $ vncserver -geometry 1000x768 -name nowm :2
> $ (export DISPLAY=3D:2; exec </dev/null >>.xsession-errors; exec 2>&1; ic=
ewm-session &)
>=20
> (I could run icewm-session from ~/.vnc/xstartup but this way it
> inherits some more desirable environment variables.)
>=20
> My ~/.vnc/xstartup looks like:
>=20
> =09#!/bin/sh
>=20
> =09xrdb $HOME/.Xresources
> =09xsetroot -solid grey
> =09uxterm &
>=20
> > ...this suggests your running a VNC server, with embedded X11 server
>=20
> Yes, indeed.
>=20
> > >   - xprop -root
> >=20
> > ...there's no _XKB_RULES_NAMES(STRING) property listed, which is the ke=
y
> > thing we'd expect to see for a modern X server. eg
> >=20
> >   _XKB_RULES_NAMES(STRING) =3D "evdev", "pc105", "us", "", ""
> >=20
> > is what most X servers on Linux will report.

Or 'kbd' instead of 'evdev' is fine too

>=20
> This is not a good assumption to make. For example, I=E2=80=99m also usin=
g
> xmodmap instead of xkb for my keyboard layout under the main X.org
> desktop. (It does carry the xkb information because Debian starts
> it that way, but I replace it with xmodmap right in .xsessioinrc.)

That shouldn't be a problem, as its a different level in the stack

There's two translations happening

 * The scancode emitted by the kernel and/or hardware device,
   and then translated/mangled by X11 and reported as the
   hardware keycode

 * The keysym which is the mapping from the hardware keycode
   done by XKB and/or Xmodmap

The 2nd point here doesn't matter for QEMU.

We're dealing with the first point in QEMU, taking the hardware
keycode and trying to undo the X11 mangling that was performed.
This mangling is different depending on whether the X11 server
is using 'evdev' or 'kbd' as its input driver.

So the key thing to understand is what values your X11 server
is using for the hardware keycodes.


> > Can you also say what QEMU version ?
>=20
> qemu-system-x86 1:4.2-3
>=20
> > So either your QEMU is fairly old, or you are using a keycode mapping
> > that QEMU has no understanding of (we support evdev, or the classic
> > xfree86 'kbd' mapping).
>=20
> The latter is the Xmodmap one? If so, then okay.
>=20
> > It would be highly unusual not to use one of
> > those two, but none the less, that appears to be the case here ?
>=20
> I must admit not knowing all that much about the VNC servers.
> I used to use tightvnc, but that had issues with=E2=80=A6 somewhat I
> don=E2=80=99t remember, so I now use tightvnc=E2=80=99s client but X11vnc=
 as
> standalone server. There=E2=80=99s also tigervnc, but that works even
> worse for me.

Ok, that's useful info to know.

> But if I can do anything to help debugging this, sure.

Can you launch 'xev' inside your VNC session and press the 'Page Up'
button and let me know what it reports the keycode and keysym.

Specifically I'm interested in this line of text:

    state 0x0, keycode 112 (keysym 0xff55, Prior), same_screen YES,

On evdev it reports 112 as hardware code which is 0x70 hex, while with
'kbd' it reports 99 which is 0x63 hex. These are the only two scenarios
QEMU knows how to cope with.

I'm strongly suspecting your X11 server will report something different
from either evdev or kbd driver hardware codes.

For that matter, if you have time to help, it would be interesting to
see what it reports for a random selection of other keys too. For
example:

  @
  #
  $
  `
  -
  +
  1
  2
  3
  a
  s
  d
  q
  w
  e
  ,
  .
  /


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


