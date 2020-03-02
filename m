Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CCC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F6E20836
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F6E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pg7-0003ym-Ma
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <t.glaser@tarent.de>) id 1j8pen-0002O1-LH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <t.glaser@tarent.de>) id 1j8pel-000143-Eq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:09 -0500
Received: from lixid.tarent.de ([193.107.123.118]:59085 helo=mail.lixid.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <t.glaser@tarent.de>) id 1j8pel-00010T-4Y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.lixid.net (MTA) with ESMTP id 7E286140B6F;
 Mon,  2 Mar 2020 19:19:05 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
 by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
 id QE_jVf6-EtOL; Mon,  2 Mar 2020 19:19:05 +0100 (CET)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.lixid.net (MTA) with ESMTPS id 5DCE7140355;
 Mon,  2 Mar 2020 19:19:05 +0100 (CET)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
 id 08123220F11; Mon,  2 Mar 2020 19:19:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by tglase.lan.tarent.de (Postfix) with ESMTP id E4994220F0A;
 Mon,  2 Mar 2020 19:19:04 +0100 (CET)
Date: Mon, 2 Mar 2020 19:19:04 +0100 (CET)
From: Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
In-Reply-To: <20200302130353.GL1679990@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2003021901160.14371@tglase.lan.tarent.de>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
 <20200302130353.GL1679990@redhat.com>
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

> There's two translations happening
>=20
>  * The scancode emitted by the kernel and/or hardware device,
>    and then translated/mangled by X11 and reported as the
>    hardware keycode
>=20
>  * The keysym which is the mapping from the hardware keycode
>    done by XKB and/or Xmodmap

Yes, sure.

> We're dealing with the first point in QEMU, taking the hardware
> keycode and trying to undo the X11 mangling that was performed.

That=E2=80=99s where VNC often fails, generally, anyway=E2=80=A6 (asd often=
 get
translated back as adf).

> > But if I can do anything to help debugging this, sure.
>=20
> Can you launch 'xev' inside your VNC session and press the 'Page Up'
> button and let me know what it reports the keycode and keysym.

Sure.

> Specifically I'm interested in this line of text:
>=20
>     state 0x0, keycode 112 (keysym 0xff55, Prior), same_screen YES,
>=20
> On evdev it reports 112 as hardware code which is 0x70 hex, while with
> 'kbd' it reports 99 which is 0x63 hex. These are the only two scenarios
> QEMU knows how to cope with.

Then we=E2=80=99re somewhat out of luck:

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624181177, (244,533), root:(250,560),
    state 0x0, keycode 71 (keysym 0xff55, Prior), same_screen YES,
    XLookupString gives 0 bytes:
    XmbLookupString gives 0 bytes:
    XFilterEvent returns: False

I=E2=80=99ve also done a,s,d:

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624183753, (244,533), root:(250,560),
    state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
    XLookupString gives 1 bytes: (61) "a"
    XmbLookupString gives 1 bytes: (61) "a"
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624184249, (244,533), root:(250,560),
    state 0x0, keycode 56 (keysym 0x73, s), same_screen YES,
    XLookupString gives 1 bytes: (73) "s"
    XmbLookupString gives 1 bytes: (73) "s"
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624184641, (244,533), root:(250,560),
    state 0x0, keycode 41 (keysym 0x64, d), same_screen YES,
    XLookupString gives 1 bytes: (64) "d"
    XmbLookupString gives 1 bytes: (64) "d"
    XFilterEvent returns: False

I=E2=80=99ve tried looking at the sources for x11vnc-0.9.16 and tightvnc-1.=
3.9
but could not, within a quarter hour at least (got to go=E2=80=A6), find ou=
t
where those codes are mapped anyway other than a reference to
XKeysymToKeycode (from libX11 probably).

> For that matter, if you have time to help, it would be interesting to
> see what it reports for a random selection of other keys too. For
> example:
>=20
>   @

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624747092, (82,98), root:(88,125),
    state 0x0, keycode 10 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes:
    XmbLookupString gives 0 bytes:
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624747284, (82,98), root:(88,125),
    state 0x1, keycode 19 (keysym 0x40, at), same_screen YES,
    XLookupString gives 1 bytes: (40) "@"
    XmbLookupString gives 1 bytes: (40) "@"
    XFilterEvent returns: False

>   #

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624748276, (82,98), root:(88,125),
    state 0x0, keycode 10 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes:
    XmbLookupString gives 0 bytes:
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624748772, (82,98), root:(88,125),
    state 0x1, keycode 20 (keysym 0x23, numbersign), same_screen YES,
    XLookupString gives 1 bytes: (23) "#"
    XmbLookupString gives 1 bytes: (23) "#"
    XFilterEvent returns: False

>   $

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624749620, (82,98), root:(88,125),
    state 0x0, keycode 10 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes:
    XmbLookupString gives 0 bytes:
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624750028, (82,98), root:(88,125),
    state 0x1, keycode 21 (keysym 0x24, dollar), same_screen YES,
    XLookupString gives 1 bytes: (24) "$"
    XmbLookupString gives 1 bytes: (24) "$"
    XFilterEvent returns: False

>   `

This one is tricky because on my host keyboard layout ` is on the
Escape key while the key left to 1 has Esc (except when shifted,
so ~ is Shift plus the key left from 1).

This is the physical Escape key, giving `:

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624751028, (82,98), root:(88,125),
    state 0x0, keycode 33 (keysym 0x60, grave), same_screen YES,
    XLookupString gives 1 bytes: (60) "`"
    XmbLookupString gives 1 bytes: (60) "`"
    XFilterEvent returns: False

This is the physical key left to the 1:

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624753908, (82,98), root:(88,125),
    state 0x0, keycode 67 (keysym 0xff1b, Escape), same_screen YES,
    XLookupString gives 1 bytes: (1b) "=1B"
    XmbLookupString gives 1 bytes: (1b) "=1B"
    XFilterEvent returns: False


When I run =E2=80=9Csetxkbmap us=E2=80=9D on the host, I get the following =
for
the physical key left to the 1 (`):

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2625065838, (136,535), root:(142,562),
    state 0x0, keycode 33 (keysym 0x60, grave), same_screen YES,
    XLookupString gives 1 bytes: (60) "`"
    XmbLookupString gives 1 bytes: (60) "`"
    XFilterEvent returns: False

This makes me assume that the VNC viewer+server combination
translates back keysyms into keycodes, losing the original
scancodes, only based on the keysyms they create in the
host keyboard layout. Ouch!


>   -

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624780388, (101,155), root:(107,182),
    state 0x0, keycode 27 (keysym 0x2d, minus), same_screen YES,
    XLookupString gives 1 bytes: (2d) "-"
    XmbLookupString gives 1 bytes: (2d) "-"
    XFilterEvent returns: False

>   +

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624780652, (101,155), root:(107,182),
    state 0x0, keycode 10 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes:
    XmbLookupString gives 0 bytes:
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624781060, (101,155), root:(107,182),
    state 0x1, keycode 28 (keysym 0x2b, plus), same_screen YES,
    XLookupString gives 1 bytes: (2b) "+"
    XmbLookupString gives 1 bytes: (2b) "+"
    XFilterEvent returns: False

>   1
>   2
>   3

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624781516, (101,155), root:(107,182),
    state 0x0, keycode 18 (keysym 0x31, 1), same_screen YES,
    XLookupString gives 1 bytes: (31) "1"
    XmbLookupString gives 1 bytes: (31) "1"
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624781764, (101,155), root:(107,182),
    state 0x0, keycode 19 (keysym 0x32, 2), same_screen YES,
    XLookupString gives 1 bytes: (32) "2"
    XmbLookupString gives 1 bytes: (32) "2"
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624781988, (101,155), root:(107,182),
    state 0x0, keycode 20 (keysym 0x33, 3), same_screen YES,
    XLookupString gives 1 bytes: (33) "3"
    XmbLookupString gives 1 bytes: (33) "3"
    XFilterEvent returns: False

>   a
>   s
>   d

see above

>   q
>   w
>   e

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624782620, (101,155), root:(107,182),
    state 0x0, keycode 54 (keysym 0x71, q), same_screen YES,
    XLookupString gives 1 bytes: (71) "q"
    XmbLookupString gives 1 bytes: (71) "q"
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624782812, (101,155), root:(107,182),
    state 0x0, keycode 60 (keysym 0x77, w), same_screen YES,
    XLookupString gives 1 bytes: (77) "w"
    XmbLookupString gives 1 bytes: (77) "w"
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624782996, (101,155), root:(107,182),
    state 0x0, keycode 42 (keysym 0x65, e), same_screen YES,
    XLookupString gives 1 bytes: (65) "e"
    XmbLookupString gives 1 bytes: (65) "e"
    XFilterEvent returns: False

>   ,
>   .
>   /

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624783972, (101,155), root:(107,182),
    state 0x0, keycode 34 (keysym 0x2c, comma), same_screen YES,
    XLookupString gives 1 bytes: (2c) ","
    XmbLookupString gives 1 bytes: (2c) ","
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624784172, (101,155), root:(107,182),
    state 0x0, keycode 35 (keysym 0x2e, period), same_screen YES,
    XLookupString gives 1 bytes: (2e) "."
    XmbLookupString gives 1 bytes: (2e) "."
    XFilterEvent returns: False

KeyPress event, serial 35, synthetic NO, window 0x1000001,
    root 0x25, subw 0x0, time 2624784412, (101,155), root:(107,182),
    state 0x0, keycode 36 (keysym 0x2f, slash), same_screen YES,
    XLookupString gives 1 bytes: (2f) "/"
    XmbLookupString gives 1 bytes: (2f) "/"
    XFilterEvent returns: False

Thanks,
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

