Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE6C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7B52173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7B52173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kRi-00067k-0M
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <t.glaser@tarent.de>) id 1j8kPk-00046T-EC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <t.glaser@tarent.de>) id 1j8kPi-0004av-Rt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:43:16 -0500
Received: from lixid.tarent.de ([193.107.123.118]:54544 helo=mail.lixid.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <t.glaser@tarent.de>) id 1j8kPi-0004ah-Iz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:43:14 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.lixid.net (MTA) with ESMTP id BFE9B140B8F;
 Mon,  2 Mar 2020 13:43:12 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
 by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
 id QOpnrkw5B7r8; Mon,  2 Mar 2020 13:43:12 +0100 (CET)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.lixid.net (MTA) with ESMTPS id 933B2140B83;
 Mon,  2 Mar 2020 13:43:12 +0100 (CET)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
 id 4E733220F0A; Mon,  2 Mar 2020 13:43:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by tglase.lan.tarent.de (Postfix) with ESMTP id 2FAED2206A8;
 Mon,  2 Mar 2020 13:43:12 +0100 (CET)
Date: Mon, 2 Mar 2020 13:43:12 +0100 (CET)
From: Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
In-Reply-To: <20200302102841.GD1679990@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 193.107.123.118
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020, Daniel P. Berrang=C3=A9 wrote:

> "x11vnc" suggests you had a regular X11 desktop session, and are
> exporting it via VNC ?

No, x11vnc is a standalone VNC server.

> Can you tell me a bit more detail about how you launch this all.

Sure:

$ vncserver -geometry 1000x768 -name nowm :2
$ (export DISPLAY=3D:2; exec </dev/null >>.xsession-errors; exec 2>&1; icew=
m-session &)

(I could run icewm-session from ~/.vnc/xstartup but this way it
inherits some more desirable environment variables.)

My ~/.vnc/xstartup looks like:

=09#!/bin/sh

=09xrdb $HOME/.Xresources
=09xsetroot -solid grey
=09uxterm &

> ...this suggests your running a VNC server, with embedded X11 server

Yes, indeed.

> >   - xprop -root
>=20
> ...there's no _XKB_RULES_NAMES(STRING) property listed, which is the key
> thing we'd expect to see for a modern X server. eg
>=20
>   _XKB_RULES_NAMES(STRING) =3D "evdev", "pc105", "us", "", ""
>=20
> is what most X servers on Linux will report.

This is not a good assumption to make. For example, I=E2=80=99m also using
xmodmap instead of xkb for my keyboard layout under the main X.org
desktop. (It does carry the xkb information because Debian starts
it that way, but I replace it with xmodmap right in .xsessioinrc.)

> Can you also say what QEMU version ?

qemu-system-x86 1:4.2-3

> So either your QEMU is fairly old, or you are using a keycode mapping
> that QEMU has no understanding of (we support evdev, or the classic
> xfree86 'kbd' mapping).

The latter is the Xmodmap one? If so, then okay.

> It would be highly unusual not to use one of
> those two, but none the less, that appears to be the case here ?

I must admit not knowing all that much about the VNC servers.
I used to use tightvnc, but that had issues with=E2=80=A6 somewhat I
don=E2=80=99t remember, so I now use tightvnc=E2=80=99s client but X11vnc a=
s
standalone server. There=E2=80=99s also tigervnc, but that works even
worse for me.

I also tested this in an RDP session with xrdp and xorgxrdp,
but things work thereunder just fine. (No surprise, xorgxrdp
just provides keyboard, mouse and video modules to an other=E2=80=90
wise distro-standard X.org server, so the whole xkb first,
xmodmap later, dance also applies there, although it doesn=E2=80=99t
use evdev keycodes but the earlier PC standard ones from
XFree86=C2=AE and pre-evdev X.org.)

But if I can do anything to help debugging this, sure.

bye,
//mirabilos
--=20
tarent solutions GmbH
Rochusstra=C3=9Fe 2-4, D-53123 Bonn =E2=80=A2 http://www.tarent.de/
Tel: +49 228 54881-393 =E2=80=A2 Fax: +49 228 54881-235
HRB 5168 (AG Bonn) =E2=80=A2 USt-ID (VAT): DE122264941
Gesch=C3=A4ftsf=C3=BChrer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Ale=
xander Steeg

**********

Mit der tarent Academy bieten wir auch Trainings und Schulungen in den
Bereichen Softwareentwicklung, Agiles Arbeiten und Zukunftstechnologien an.

Besuchen Sie uns auf www.tarent.de/academy. Wir freuen uns auf Ihren Kontak=
t.

**********

