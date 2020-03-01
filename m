Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C1BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 23:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5FF2469C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 23:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5FF2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8XeY-0002Sy-BK
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 18:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <t.glaser@tarent.de>) id 1j8Xdl-0001zg-5R
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 18:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <t.glaser@tarent.de>) id 1j8Xdh-0007Nt-IQ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 18:04:52 -0500
Received: from lixid.tarent.de ([193.107.123.118]:46353 helo=mail.lixid.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <t.glaser@tarent.de>) id 1j8Xdh-0007Nf-8R
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 18:04:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.lixid.net (MTA) with ESMTP id 0C722140724
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 00:04:47 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
 by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
 id IMkQw1xe6W5v for <qemu-devel@nongnu.org>;
 Mon,  2 Mar 2020 00:04:46 +0100 (CET)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.lixid.net (MTA) with ESMTPS id E14891403C6
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 00:04:46 +0100 (CET)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
 id 8A07E220E56; Mon,  2 Mar 2020 00:04:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by tglase.lan.tarent.de (Postfix) with ESMTP id 72BC2220DCF
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 00:04:46 +0100 (CET)
Date: Mon, 2 Mar 2020 00:04:46 +0100 (CET)
From: Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To: qemu-devel@nongnu.org
Subject: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
Message-ID: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I got this while running qemu under VNC, and was told to report it.

including the following information:

  - Operating system
=09Debian GNU/Linux sid/x32
  - X11 Server
=09x11vnc  0.9.16-3
  - xprop -root
=09_NET_ACTIVE_WINDOW(WINDOW): window id # 0x1400010
=09_NET_CLIENT_LIST(WINDOW): window id # 0x400010, 0x100000b, 0x1400010
=09_NET_CLIENT_LIST_STACKING(WINDOW): window id # 0x100000b, 0x1400010, 0x4=
00010
=09_WIN_CLIENT_LIST(CARDINAL) =3D 16777227, 20971536, 4194320
=09ICEWM_GUI_EVENT(ICEWM_GUI_EVENT) =3D 0xf
=09_WIN_DESKTOP_BUTTON_PROXY(CARDINAL) =3D 12583282
=09_WIN_WORKAREA(CARDINAL) =3D 0, 0, 1000, 743
=09_NET_WORKAREA(CARDINAL) =3D 0, 0, 1000, 743, 0, 0, 1000, 743, 0, 0, 1000=
, 743, 0, 0, 1000, 743
=09_NET_CURRENT_DESKTOP(CARDINAL) =3D 0
=09_WIN_WORKSPACE(CARDINAL) =3D 0
=09_NET_SHOWING_DESKTOP(CARDINAL) =3D 0
=09_NET_DESKTOP_VIEWPORT(CARDINAL) =3D 0, 0, 0, 0, 0, 0, 0, 0
=09_NET_DESKTOP_GEOMETRY(CARDINAL) =3D 1000, 768
=09_NET_NUMBER_OF_DESKTOPS(CARDINAL) =3D 4
=09_WIN_WORKSPACE_COUNT(CARDINAL) =3D 4
=09_NET_DESKTOP_NAMES(UTF8_STRING) =3D " 1 ", " 2 ", " 3 ", " 4 "
=09_WIN_WORKSPACE_NAMES(STRING) =3D " 1 ", " 2 ", " 3 ", " 4 "
=09WM_ICON_SIZE(WM_ICON_SIZE):
=09=09=09minimum icon size: 32 by 32
=09=09=09maximum icon size: 32 by 32
=09=09=09incremental size change: 1 by 1
=09_NET_SUPPORTING_WM_CHECK(WINDOW): window id # 0xc00014
=09_NET_SUPPORTED(ATOM) =3D _NET_ACTIVE_WINDOW, _NET_CLIENT_LIST, _NET_CLIE=
NT_LIST_STACKING, _NET_CLOSE_WINDOW, _NET_CURRENT_DESKTOP, _NET_DESKTOP_GEO=
METRY, _NET_DESKTOP_LAYOUT, _NET_DESKTOP_NAMES, _NET_DESKTOP_VIEWPORT, _NET=
_FRAME_EXTENTS, _NET_MOVERESIZE_WINDOW, _NET_NUMBER_OF_DESKTOPS, _NET_REQUE=
ST_FRAME_EXTENTS, _NET_RESTACK_WINDOW, _NET_SHOWING_DESKTOP, _NET_STARTUP_I=
D, _NET_SUPPORTED, _NET_SUPPORTING_WM_CHECK, _NET_SYSTEM_TRAY_MESSAGE_DATA,=
 _NET_SYSTEM_TRAY_OPCODE, _NET_SYSTEM_TRAY_ORIENTATION, _NET_SYSTEM_TRAY_VI=
SUAL, _NET_WM_ACTION_ABOVE, _NET_WM_ACTION_BELOW, _NET_WM_ACTION_CHANGE_DES=
KTOP, _NET_WM_ACTION_CLOSE, _NET_WM_ACTION_FULLSCREEN, _NET_WM_ACTION_MAXIM=
IZE_HORZ, _NET_WM_ACTION_MAXIMIZE_VERT, _NET_WM_ACTION_MINIMIZE, _NET_WM_AC=
TION_MOVE, _NET_WM_ACTION_RESIZE, _NET_WM_ACTION_SHADE, _NET_WM_ACTION_STIC=
K, _NET_WM_ALLOWED_ACTIONS, _NET_WM_DESKTOP, _NET_WM_FULLSCREEN_MONITORS, _=
NET_WM_HANDLED_ICONS, _NET_WM_ICON_NAME, _NET_WM_ICON, _NET_WM_MOVERESIZE, =
_NET_WM_NAME, _NET_WM_PID, _NET_WM_PING, _NET_WM_STATE, _NET_WM_STATE_ABOVE=
, _NET_WM_STATE_BELOW, _NET_WM_STATE_DEMANDS_ATTENTION, _NET_WM_STATE_FOCUS=
ED, _NET_WM_STATE_FULLSCREEN, _NET_WM_STATE_HIDDEN, _NET_WM_STATE_MAXIMIZED=
_HORZ, _NET_WM_STATE_MAXIMIZED_VERT, _NET_WM_STATE_MODAL, _NET_WM_STATE_SHA=
DED, _NET_WM_STATE_SKIP_PAGER, _NET_WM_STATE_SKIP_TASKBAR, _NET_WM_STATE_ST=
ICKY, _NET_WM_STRUT, _NET_WM_STRUT_PARTIAL, _NET_WM_USER_TIME, _NET_WM_USER=
_TIME_WINDOW, _NET_WM_VISIBLE_ICON_NAME, _NET_WM_VISIBLE_NAME, _NET_WM_WIND=
OW_OPACITY, _NET_WM_WINDOW_TYPE, _NET_WM_WINDOW_TYPE_COMBO, _NET_WM_WINDOW_=
TYPE_DESKTOP, _NET_WM_WINDOW_TYPE_DIALOG, _NET_WM_WINDOW_TYPE_DND, _NET_WM_=
WINDOW_TYPE_DOCK, _NET_WM_WINDOW_TYPE_DROPDOWN_MENU, _NET_WM_WINDOW_TYPE_ME=
NU, _NET_WM_WINDOW_TYPE_NORMAL, _NET_WM_WINDOW_TYPE_NOTIFICATION, _NET_WM_W=
INDOW_TYPE_POPUP_MENU, _NET_WM_WINDOW_TYPE_SPLASH, _NET_WM_WINDOW_TYPE_TOOL=
BAR, _NET_WM_WINDOW_TYPE_TOOLTIP, _NET_WM_WINDOW_TYPE_UTILITY, _NET_WORKARE=
A
=09_WIN_AREA(CARDINAL) =3D 0, 0
=09_WIN_AREA_COUNT(CARDINAL) =3D 1, 1
=09_WIN_SUPPORTING_WM_CHECK(CARDINAL) =3D 12582932
=09_WIN_PROTOCOLS(ATOM) =3D _WIN_AREA, _WIN_AREA_COUNT, _WIN_CLIENT_LIST, _=
WIN_DESKTOP_BUTTON_PROXY, _WIN_HINTS, _WIN_ICONS, _WIN_LAYER, _WIN_PROTOCOL=
S, _WIN_STATE, _WIN_SUPPORTING_WM_CHECK, _ICEWM_TRAY, _WIN_WORKAREA, _WIN_W=
ORKSPACE, _WIN_WORKSPACE_COUNT, _WIN_WORKSPACE_NAMES
=09_XROOTCOLOR_PIXEL(CARDINAL) =3D 8256
=09_XROOTPMAP_ID(PIXMAP): pixmap id # 0x0
=09_ICEWMBG_PID_S0(CARDINAL) =3D 4749
=09RESOURCE_MANAGER(STRING) =3D "*VT100*translations:\t#override \\n Shift~=
Ctrl<KeyPress>Insert:insert-selection(PRIMARY) \\n Shift Ctrl<KeyPress>Inse=
rt:insert-selection(CLIPBOARD) \\n ~Shift~Ctrl<Btn2Up>:insert-selection(PRI=
MARY) \\n Shift~Ctrl<Btn2Up>:insert-selection(CLIPBOARD) \\n ~Shift<BtnUp>:=
select-end(PRIMARY) \\n Shift<BtnUp>:select-end(CLIPBOARD) \\n\nXTerm*VT100=
*loginShell:\ttrue\nXTerm*keepSelection:\ttrue\nXTerm*ScrollBar:\tfalse\nXT=
erm*SaveLines:\t4096\nXTerm*eightBitInput:\ttrue\nXTerm*eightBitOutput:\ttr=
ue\nXTerm*backarrowKeyIsErase:\ttrue\nXTerm*deleteIsDEL:\tfalse\nXTerm*ptyI=
nitialErase:\ttrue\nXTerm*VT100*background:\tblack\nXTerm*VT100*foreground:=
\trgb:AA/AA/AA\nXTerm*termName:\txterm\nXTerm*pointerColor:\trgb:FF/B0/00\n=
XTerm*pointerMode:\t0\nXTerm*cursorBlink:\ttrue\nXTerm*cursorUnderLine:\ttr=
ue\nXTerm*cursorColor:\trgb:FF/B0/00\nXTerm*VT100*colorMode:\ttrue\nXTerm*V=
T100*colorBDMode:\ttrue\nXTerm*VT100*colorBLMode:\tfalse\nXTerm*VT100*color=
ULMode:\tfalse\nXTerm*VT100*boldColors:\ttrue\nXTerm*VT100*boldMode:\tfalse=
\nXTerm*allowBoldFonts:\tfalse\nXTerm*VT100*dynamicColors:\ttrue\nXTerm*VT1=
00*utf8:\t1\nXTerm*VT100*color0:\trgb:00/00/00\nXTerm*VT100*color1:\trgb:AA=
/00/00\nXTerm*VT100*color2:\trgb:00/AA/00\nXTerm*VT100*color3:\trgb:AA/55/0=
0\nXTerm*VT100*color4:\trgb:00/00/AA\nXTerm*VT100*color5:\trgb:AA/00/AA\nXT=
erm*VT100*color6:\trgb:00/AA/AA\nXTerm*VT100*color7:\trgb:AA/AA/AA\nXTerm*V=
T100*color8:\trgb:55/55/55\nXTerm*VT100*color9:\trgb:FF/55/55\nXTerm*VT100*=
color10:\trgb:55/FF/55\nXTerm*VT100*color11:\trgb:FF/FF/55\nXTerm*VT100*col=
or12:\trgb:55/55/FF\nXTerm*VT100*color13:\trgb:FF/55/FF\nXTerm*VT100*color1=
4:\trgb:55/FF/FF\nXTerm*VT100*color15:\trgb:FF/FF/FF\nXTerm*VT100*colorBD:\=
twhite\nXTerm*fontMenu*background:\tAntiqueWhite\nXTerm*fontMenu*foreground=
:\tgray15\nXTerm*fontMenu.Label:\tUCS Fonts\nXTerm*VT100*font:\t-misc-fixed=
-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1\nXTerm*VT100*boldFont=
:\t-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1\nXTerm*=
VT100*wideFont:\t-misc-fixed-medium-r-normal-ja-13-120-75-75-c-120-iso10646=
-1\nXTerm*VT100*wideBoldFont:\t-misc-fixed-medium-r-normal-ja-13-120-75-75-=
c-120-iso10646-1\nXTerm*fontMenu*font1*Label:\tFixedMisc\nXTerm*VT100*font1=
:\t-miros-fixedmisc-medium-r-normal--18-120-100-100-c-90-iso10646-1\nXTerm*=
VT100*font2:\t-misc-fixed-medium-r-normal--7-70-75-75-c-50-iso10646-1\nXTer=
m*VT100*font3:\t-misc-fixed-medium-r-normal--10-100-75-75-c-60-iso10646-1\n=
XTerm*VT100*font4:\t-misc-fixed-medium-r-normal--13-120-75-75-c-70-iso10646=
-1\nXTerm*VT100*font5:\t-misc-fixed-medium-r-normal--15-140-75-75-c-90-iso1=
0646-1\nXTerm*VT100*font6:\t-misc-fixed-medium-r-normal--20-200-75-75-c-100=
-iso10646-1\nXTerm*visualBell:\ttrue\nUXTerm*VT100*loginShell:\ttrue\nUXTer=
m*keepSelection:\ttrue\nUXTerm*ScrollBar:\tfalse\nUXTerm*SaveLines:\t4096\n=
UXTerm*eightBitInput:\ttrue\nUXTerm*eightBitOutput:\ttrue\nUXTerm*backarrow=
KeyIsErase:\ttrue\nUXTerm*deleteIsDEL:\tfalse\nUXTerm*ptyInitialErase:\ttru=
e\nUXTerm*VT100*background:\tblack\nUXTerm*VT100*foreground:\trgb:AA/AA/AA\=
nUXTerm*termName:\txterm\nUXTerm*pointerColor:\trgb:FF/B0/00\nUXTerm*pointe=
rMode:\t0\nUXTerm*cursorBlink:\ttrue\nUXTerm*cursorUnderLine:\ttrue\nUXTerm=
*cursorColor:\trgb:FF/B0/00\nUXTerm*VT100*colorMode:\ttrue\nUXTerm*VT100*co=
lorBDMode:\ttrue\nUXTerm*VT100*colorBLMode:\tfalse\nUXTerm*VT100*colorULMod=
e:\tfalse\nUXTerm*VT100*boldColors:\ttrue\nUXTerm*VT100*boldMode:\tfalse\nU=
XTerm*allowBoldFonts:\tfalse\nUXTerm*VT100*dynamicColors:\ttrue\nUXTerm*VT1=
00*utf8:\t1\nUXTerm*VT100*color0:\trgb:00/00/00\nUXTerm*VT100*color1:\trgb:=
AA/00/00\nUXTerm*VT100*color2:\trgb:00/AA/00\nUXTerm*VT100*color3:\trgb:AA/=
55/00\nUXTerm*VT100*color4:\trgb:00/00/AA\nUXTerm*VT100*color5:\trgb:AA/00/=
AA\nUXTerm*VT100*color6:\trgb:00/AA/AA\nUXTerm*VT100*color7:\trgb:AA/AA/AA\=
nUXTerm*VT100*color8:\trgb:55/55/55\nUXTerm*VT100*color9:\trgb:FF/55/55\nUX=
Term*VT100*color10:\trgb:55/FF/55\nUXTerm*VT100*color11:\trgb:FF/FF/55\nUXT=
erm*VT100*color12:\trgb:55/55/FF\nUXTerm*VT100*color13:\trgb:FF/55/FF\nUXTe=
rm*VT100*color14:\trgb:55/FF/FF\nUXTerm*VT100*color15:\trgb:FF/FF/FF\nUXTer=
m*VT100*colorBD:\twhite\nUXTerm*fontMenu*background:\tAntiqueWhite\nUXTerm*=
fontMenu*foreground:\tgray15\nUXTerm*fontMenu.Label:\tUCS Fonts\nUXTerm*VT1=
00*font:\t-miros-fixedmisc-medium-r-normal--18-120-100-100-c-90-iso10646-1\=
nUXTerm*VT100*boldFont:\t-miros-fixedmisc-medium-r-normal--18-120-100-100-c=
-90-iso10646-1\nUXTerm*VT100*wideFont:\t-miros-fixedmisc-medium-r-normal--1=
8-120-100-100-c-180-iso10646-1\nUXTerm*VT100*wideBoldFont:\t-miros-fixedmis=
c-medium-r-normal--18-120-100-100-c-180-iso10646-1\nUXTerm*fontMenu*font1*L=
abel:\txTerm-like\nUXTerm*fontMenu*font3*Label:\tnarrow tall\nUXTerm*fontMe=
nu*font4*Label:\twide short\nUXTerm*fontMenu*font5*Label:\tFixedMisc\nUXTer=
m*VT100*font1:\t-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10=
646-1\nUXTerm*VT100*font2:\t-misc-fixed-medium-r-normal--8-80-75-75-c-50-is=
o10646-1\nUXTerm*VT100*font3:\t-misc-fixed-medium-r-normal--14-130-75-75-c-=
70-iso10646-1\nUXTerm*VT100*font4:\t-misc-fixed-medium-r-normal--13-120-75-=
75-c-80-iso10646-1\nUXTerm*VT100*font5:\t-miros-fixedmisc-medium-r-normal--=
18-120-100-100-c-90-iso10646-1\nUXTerm*VT100*font6:\t-misc-fixed-medium-r-n=
ormal--20-200-75-75-c-100-iso10646-1\nUXTerm*visualBell:\ttrue\nAXTerm*VT10=
0*loginShell:\ttrue\nAXTerm*keepSelection:\ttrue\nAXTerm*ScrollBar:\tfalse\=
nAXTerm*SaveLines:\t4096\nAXTerm*eightBitInput:\ttrue\nAXTerm*eightBitOutpu=
t:\ttrue\nAXTerm*backarrowKeyIsErase:\ttrue\nAXTerm*deleteIsDEL:\tfalse\nAX=
Term*ptyInitialErase:\ttrue\nAXTerm*VT100*background:\tblack\nAXTerm*VT100*=
foreground:\trgb:FF/B0/00\nAXTerm*termName:\txterm\nAXTerm*pointerColor:\tw=
hite\nAXTerm*pointerMode:\t0\nAXTerm*cursorBlink:\ttrue\nAXTerm*cursorUnder=
Line:\ttrue\nAXTerm*cursorColor:\twhite\nAXTerm*VT100*colorMode:\ttrue\nAXT=
erm*VT100*colorBDMode:\ttrue\nAXTerm*VT100*colorBLMode:\tfalse\nAXTerm*VT10=
0*colorULMode:\tfalse\nAXTerm*VT100*boldColors:\ttrue\nAXTerm*VT100*boldMod=
e:\tfalse\nAXTerm*allowBoldFonts:\tfalse\nAXTerm*VT100*dynamicColors:\ttrue=
\nAXTerm*VT100*utf8:\t1\nAXTerm*VT100*color0:\trgb:00/00/00\nAXTerm*VT100*c=
olor1:\trgb:AA/00/00\nAXTerm*VT100*color2:\trgb:00/AA/00\nAXTerm*VT100*colo=
r3:\trgb:AA/55/00\nAXTerm*VT100*color4:\trgb:00/00/AA\nAXTerm*VT100*color5:=
\trgb:AA/00/AA\nAXTerm*VT100*color6:\trgb:00/AA/AA\nAXTerm*VT100*color7:\tr=
gb:AA/AA/AA\nAXTerm*VT100*color8:\trgb:55/55/55\nAXTerm*VT100*color9:\trgb:=
FF/55/55\nAXTerm*VT100*color10:\trgb:55/FF/55\nAXTerm*VT100*color11:\trgb:F=
F/FF/55\nAXTerm*VT100*color12:\trgb:55/55/FF\nAXTerm*VT100*color13:\trgb:FF=
/55/FF\nAXTerm*VT100*color14:\trgb:55/FF/FF\nAXTerm*VT100*color15:\trgb:FF/=
FF/FF\nAXTerm*VT100*colorBD:\trgb:FF/EF/00\nAXTerm*fontMenu*background:\tAn=
tiqueWhite\nAXTerm*fontMenu*foreground:\tgray15\nAXTerm*fontMenu.Label:\tUC=
S Fonts\nAXTerm*VT100*font:\t-miros-fixedmisc-medium-r-normal--18-120-100-1=
00-c-90-iso10646-1\nAXTerm*VT100*boldFont:\t-miros-fixedmisc-medium-r-norma=
l--18-120-100-100-c-90-iso10646-1\nAXTerm*VT100*wideFont:\t-miros-fixedmisc=
-medium-r-normal--18-120-100-100-c-180-iso10646-1\nAXTerm*VT100*wideBoldFon=
t:\t-miros-fixedmisc-medium-r-normal--18-120-100-100-c-180-iso10646-1\nAXTe=
rm*fontMenu*font1*Label:\txTerm-like\nAXTerm*fontMenu*font3*Label:\tnarrow =
tall\nAXTerm*fontMenu*font4*Label:\twide short\nAXTerm*fontMenu*font5*Label=
:\tFixedMisc\nAXTerm*VT100*font1:\t-misc-fixed-medium-r-semicondensed--13-1=
20-75-75-c-60-iso10646-1\nAXTerm*VT100*font2:\t-misc-fixed-medium-r-normal-=
-8-80-75-75-c-50-iso10646-1\nAXTerm*VT100*font3:\t-misc-fixed-medium-r-norm=
al--14-130-75-75-c-70-iso10646-1\nAXTerm*VT100*font4:\t-misc-fixed-medium-r=
-normal--13-120-75-75-c-80-iso10646-1\nAXTerm*VT100*font5:\t-miros-fixedmis=
c-medium-r-normal--18-120-100-100-c-90-iso10646-1\nAXTerm*VT100*font6:\t-mi=
sc-fixed-medium-r-normal--20-200-75-75-c-100-iso10646-1\nAXTerm*visualBell:=
\ttrue\nBXTerm*VT100*loginShell:\ttrue\nBXTerm*keepSelection:\ttrue\nBXTerm=
*ScrollBar:\tfalse\nBXTerm*SaveLines:\t4096\nBXTerm*eightBitInput:\ttrue\nB=
XTerm*eightBitOutput:\ttrue\nBXTerm*backarrowKeyIsErase:\ttrue\nBXTerm*dele=
teIsDEL:\tfalse\nBXTerm*ptyInitialErase:\ttrue\nBXTerm*VT100*background:\tw=
hite\nBXTerm*VT100*foreground:\tblack\nBXTerm*termName:\txterm-r6\nBXTerm*p=
ointerColor:\trgb:FF/B0/00\nBXTerm*pointerMode:\t0\nBXTerm*cursorBlink:\ttr=
ue\nBXTerm*cursorUnderLine:\ttrue\nBXTerm*cursorColor:\trgb:FF/B0/00\nBXTer=
m*VT100*colorMode:\tfalse\nBXTerm*VT100*colorBDMode:\tfalse\nBXTerm*VT100*c=
olorBLMode:\tfalse\nBXTerm*VT100*colorULMode:\tfalse\nBXTerm*VT100*boldColo=
rs:\tfalse\nBXTerm*VT100*boldMode:\ttrue\nBXTerm*allowBoldFonts:\tfalse\nBX=
Term*VT100*dynamicColors:\tfalse\nBXTerm*VT100*utf8:\t1\nBXTerm*fontMenu*ba=
ckground:\tAntiqueWhite\nBXTerm*fontMenu*foreground:\tgray15\nBXTerm*fontMe=
nu.Label:\tUCS Fonts\nBXTerm*VT100*font:\t-misc-fixed-medium-r-semicondense=
d--13-120-75-75-c-60-iso10646-1\nBXTerm*VT100*wideFont:\t-misc-fixed-medium=
-r-normal-ja-13-120-75-75-c-120-iso10646-1\nBXTerm*fontMenu*font1*Label:\tF=
ixedMisc\nBXTerm*VT100*font1:\t-miros-fixedmisc-medium-r-normal--18-120-100=
-100-c-90-iso10646-1\nBXTerm*VT100*font2:\t-misc-fixed-medium-r-normal--7-7=
0-75-75-c-50-iso10646-1\nBXTerm*VT100*font3:\t-misc-fixed-medium-r-normal--=
10-100-75-75-c-60-iso10646-1\nBXTerm*VT100*font4:\t-misc-fixed-medium-r-nor=
mal--13-120-75-75-c-70-iso10646-1\nBXTerm*VT100*font5:\t-misc-fixed-medium-=
r-normal--15-140-75-75-c-90-iso10646-1\nBXTerm*VT100*font6:\t-misc-fixed-me=
dium-r-normal--20-200-75-75-c-100-iso10646-1\nBXTerm*visualBell:\ttrue\nTXT=
erm*VT100*loginShell:\ttrue\nTXTerm*keepSelection:\ttrue\nTXTerm*ScrollBar:=
\tfalse\nTXTerm*SaveLines:\t4096\nTXTerm*eightBitInput:\ttrue\nTXTerm*eight=
BitOutput:\ttrue\nTXTerm*backarrowKeyIsErase:\ttrue\nTXTerm*deleteIsDEL:\tf=
alse\nTXTerm*ptyInitialErase:\ttrue\nTXTerm*VT100*background:\tblack\nTXTer=
m*VT100*foreground:\trgb:AA/AA/AA\nTXTerm*termName:\txterm\nTXTerm*pointerC=
olor:\trgb:FF/B0/00\nTXTerm*pointerMode:\t0\nTXTerm*cursorBlink:\ttrue\nTXT=
erm*cursorUnderLine:\ttrue\nTXTerm*cursorColor:\trgb:FF/B0/00\nTXTerm*VT100=
*colorMode:\ttrue\nTXTerm*VT100*colorBDMode:\ttrue\nTXTerm*VT100*colorBLMod=
e:\tfalse\nTXTerm*VT100*colorULMode:\tfalse\nTXTerm*VT100*boldColors:\ttrue=
\nTXTerm*VT100*boldMode:\tfalse\nTXTerm*allowBoldFonts:\tfalse\nTXTerm*VT10=
0*dynamicColors:\ttrue\nTXTerm*VT100*utf8:\t1\nTXTerm*VT100*color0:\trgb:00=
/00/00\nTXTerm*VT100*color1:\trgb:AA/00/00\nTXTerm*VT100*color2:\trgb:00/AA=
/00\nTXTerm*VT100*color3:\trgb:AA/55/00\nTXTerm*VT100*color4:\trgb:00/00/AA=
\nTXTerm*VT100*color5:\trgb:AA/00/AA\nTXTerm*VT100*color6:\trgb:00/AA/AA\nT=
XTerm*VT100*color7:\trgb:AA/AA/AA\nTXTerm*VT100*color8:\trgb:55/55/55\nTXTe=
rm*VT100*color9:\trgb:FF/55/55\nTXTerm*VT100*color10:\trgb:55/FF/55\nTXTerm=
*VT100*color11:\trgb:FF/FF/55\nTXTerm*VT100*color12:\trgb:55/55/FF\nTXTerm*=
VT100*color13:\trgb:FF/55/FF\nTXTerm*VT100*color14:\trgb:55/FF/FF\nTXTerm*V=
T100*color15:\trgb:FF/FF/FF\nTXTerm*VT100*colorBD:\twhite\nTXTerm*fontMenu*=
background:\tAntiqueWhite\nTXTerm*fontMenu*foreground:\tgray15\nTXTerm*font=
Menu.Label:\tTerminus Fonts\nTXTerm*VT100*font:\t-xos4-terminus-medium-r-no=
rmal--16-160-72-72-c-80-iso10646-1\nTXTerm*VT100*boldFont:\t-xos4-terminus-=
medium-r-normal--16-160-72-72-c-80-iso10646-1\nTXTerm*fontMenu*font1*Label:=
\txTerm-like\nTXTerm*fontMenu*font2*Label:\tFixedMisc\nTXTerm*fontMenu*font=
3*Label:\tTerminusNorm\nTXTerm*fontMenu*font4*Label:\tTerminusBold\nTXTerm*=
fontMenu*font5*Label:\tTerminusMed\nTXTerm*fontMenu*font6*Label:\tTerminusB=
ig\nTXTerm*VT100*font1:\t-misc-fixed-medium-r-semicondensed--13-120-75-75-c=
-60-iso10646-1\nTXTerm*VT100*font2:\t-miros-fixedmisc-medium-r-normal--18-1=
20-100-100-c-90-iso10646-1\nTXTerm*VT100*font3:\t-xos4-terminus-medium-r-no=
rmal--14-140-72-72-c-80-iso10646-1\nTXTerm*VT100*font4:\t-xos4-terminus-bol=
d-r-normal--14-140-72-72-c-80-iso10646-1\nTXTerm*VT100*font5:\t-xos4-termin=
us-medium-r-normal--16-160-72-72-c-80-iso10646-1\nTXTerm*VT100*font6:\t-xos=
4-terminus-medium-r-normal--20-200-72-72-c-100-iso10646-1\nTXTerm*visualBel=
l:\ttrue\nRXTerm*VT100*loginShell:\ttrue\nRXTerm*keepSelection:\ttrue\nRXTe=
rm*ScrollBar:\tfalse\nRXTerm*SaveLines:\t4096\nRXTerm*eightBitInput:\ttrue\=
nRXTerm*eightBitOutput:\ttrue\nRXTerm*backarrowKeyIsErase:\ttrue\nRXTerm*de=
leteIsDEL:\tfalse\nRXTerm*ptyInitialErase:\ttrue\nRXTerm*VT100*background:\=
trgb:FF/FF/FF\nRXTerm*VT100*foreground:\trgb:00/00/00\nRXTerm*termName:\txt=
erm\nRXTerm*pointerColor:\trgb:00/FF/00\nRXTerm*pointerMode:\t0\nRXTerm*cur=
sorBlink:\ttrue\nRXTerm*cursorUnderLine:\ttrue\nRXTerm*cursorColor:\trgb:00=
/CC/00\nRXTerm*VT100*colorMode:\ttrue\nRXTerm*VT100*colorBDMode:\ttrue\nRXT=
erm*VT100*colorBLMode:\tfalse\nRXTerm*VT100*colorULMode:\tfalse\nRXTerm*VT1=
00*boldColors:\ttrue\nRXTerm*VT100*boldMode:\tfalse\nRXTerm*allowBoldFonts:=
\tfalse\nRXTerm*VT100*dynamicColors:\ttrue\nRXTerm*VT100*utf8:\t1\nRXTerm*V=
T100*color0:\trgb:00/00/00\nRXTerm*VT100*color1:\trgb:AA/00/00\nRXTerm*VT10=
0*color2:\trgb:00/AA/00\nRXTerm*VT100*color3:\trgb:AA/55/00\nRXTerm*VT100*c=
olor4:\trgb:00/00/AA\nRXTerm*VT100*color5:\trgb:AA/00/AA\nRXTerm*VT100*colo=
r6:\trgb:00/AA/AA\nRXTerm*VT100*color7:\trgb:AA/AA/AA\nRXTerm*VT100*color8:=
\trgb:55/55/55\nRXTerm*VT100*color9:\trgb:FF/55/55\nRXTerm*VT100*color10:\t=
rgb:55/FF/55\nRXTerm*VT100*color11:\trgb:FF/FF/55\nRXTerm*VT100*color12:\tr=
gb:55/55/FF\nRXTerm*VT100*color13:\trgb:FF/55/FF\nRXTerm*VT100*color14:\trg=
b:55/FF/FF\nRXTerm*VT100*color15:\trgb:FF/FF/FF\nRXTerm*VT100*colorBD:\trgb=
:00/CC/33\nRXTerm*fontMenu*background:\tAntiqueWhite\nRXTerm*fontMenu*foreg=
round:\tgray15\nRXTerm*fontMenu.Label:\tUCS Fonts\nRXTerm*VT100*font:\t-mir=
os-fixedmisc-medium-r-normal--18-120-100-100-c-90-iso10646-1\nRXTerm*VT100*=
boldFont:\t-miros-fixedmisc-medium-r-normal--18-120-100-100-c-90-iso10646-1=
\nRXTerm*VT100*wideFont:\t-miros-fixedmisc-medium-r-normal--18-120-100-100-=
c-180-iso10646-1\nRXTerm*VT100*wideBoldFont:\t-miros-fixedmisc-medium-r-nor=
mal--18-120-100-100-c-180-iso10646-1\nRXTerm*fontMenu*font1*Label:\txTerm-l=
ike\nRXTerm*fontMenu*font3*Label:\tnarrow tall\nRXTerm*fontMenu*font4*Label=
:\twide short\nRXTerm*fontMenu*font5*Label:\tFixedMisc\nRXTerm*VT100*font1:=
\t-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1\nRXTerm*=
VT100*font2:\t-misc-fixed-medium-r-normal--8-80-75-75-c-50-iso10646-1\nRXTe=
rm*VT100*font3:\t-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso10646-1\=
nRXTerm*VT100*font4:\t-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso106=
46-1\nRXTerm*VT100*font5:\t-miros-fixedmisc-medium-r-normal--18-120-100-100=
-c-90-iso10646-1\nRXTerm*VT100*font6:\t-misc-fixed-medium-r-normal--20-200-=
75-75-c-100-iso10646-1\nRXTerm*visualBell:\ttrue\nVXTerm*VT100*loginShell:\=
ttrue\nVXTerm*keepSelection:\ttrue\nVXTerm*ScrollBar:\tfalse\nVXTerm*SaveLi=
nes:\t4096\nVXTerm*eightBitInput:\ttrue\nVXTerm*eightBitOutput:\ttrue\nVXTe=
rm*backarrowKeyIsErase:\ttrue\nVXTerm*deleteIsDEL:\tfalse\nVXTerm*ptyInitia=
lErase:\ttrue\nVXTerm*VT100*background:\tblack\nVXTerm*VT100*foreground:\tr=
gb:AA/AA/AA\nVXTerm*termName:\txterm\nVXTerm*pointerColor:\trgb:FF/B0/00\nV=
XTerm*pointerMode:\t0\nVXTerm*cursorBlink:\ttrue\nVXTerm*cursorUnderLine:\t=
true\nVXTerm*cursorColor:\trgb:FF/B0/00\nVXTerm*VT100*colorMode:\ttrue\nVXT=
erm*VT100*colorBDMode:\ttrue\nVXTerm*VT100*colorBLMode:\tfalse\nVXTerm*VT10=
0*colorULMode:\tfalse\nVXTerm*VT100*boldColors:\ttrue\nVXTerm*VT100*boldMod=
e:\tfalse\nVXTerm*allowBoldFonts:\tfalse\nVXTerm*VT100*dynamicColors:\ttrue=
\nVXTerm*VT100*utf8:\t0\nVXTerm*VT100*color0:\trgb:00/00/00\nVXTerm*VT100*c=
olor1:\trgb:AA/00/00\nVXTerm*VT100*color2:\trgb:00/AA/00\nVXTerm*VT100*colo=
r3:\trgb:AA/55/00\nVXTerm*VT100*color4:\trgb:00/00/AA\nVXTerm*VT100*color5:=
\trgb:AA/00/AA\nVXTerm*VT100*color6:\trgb:00/AA/AA\nVXTerm*VT100*color7:\tr=
gb:AA/AA/AA\nVXTerm*VT100*color8:\trgb:55/55/55\nVXTerm*VT100*color9:\trgb:=
FF/55/55\nVXTerm*VT100*color10:\trgb:55/FF/55\nVXTerm*VT100*color11:\trgb:F=
F/FF/55\nVXTerm*VT100*color12:\trgb:55/55/FF\nVXTerm*VT100*color13:\trgb:FF=
/55/FF\nVXTerm*VT100*color14:\trgb:55/FF/FF\nVXTerm*VT100*color15:\trgb:FF/=
FF/FF\nVXTerm*VT100*colorBD:\twhite\nVXTerm*fontMenu*background:\tAntiqueWh=
ite\nVXTerm*fontMenu*foreground:\tgray15\nVXTerm*fontMenu.Label:\tVGA Fonts=
\nVXTerm*VT100*font:\t-miros-fixedmiscpc-medium-r-normal--16-120-100-100-c-=
80-ibm-cp437\nVXTerm*VT100*boldFont:\t-miros-fixedmiscpc-medium-r-normal--1=
6-120-100-100-c-80-ibm-cp437\nVXTerm*fontMenu*font1*Label:\tSmall\nVXTerm*f=
ontMenu*font2*Label:\tFixedMiscPC\nVXTerm*fontMenu*font3*Label:\tTerminusSm=
all\nVXTerm*fontMenu*font4*Label:\tTerminusMed\nVXTerm*fontMenu*font5*Label=
:\tvga8x14\nVXTerm*fontMenu*font6*Label:\tvga8x16\nVXTerm*VT100*font1:\t6x1=
0\nVXTerm*VT100*font2:\t-miros-fixedmiscpc-medium-r-normal--16-120-100-100-=
c-80-ibm-cp437\nVXTerm*VT100*font3:\t-xos4-terminus-bold-r-normal--14-140-7=
2-72-c-80-iso8859-1\nVXTerm*VT100*font4:\t-xos4-terminus-medium-r-normal--1=
6-160-72-72-c-80-iso8859-1\nVXTerm*VT100*font5:\t-misc-vga-bold-r-normal--1=
4-110-96-96-c-80-ibm-cp437\nVXTerm*VT100*font6:\t-misc-vga-bold-r-normal--1=
6-120-96-96-c-80-ibm-cp437\nVXTerm*visualBell:\ttrue\nVXTerm*VT100*geometry=
:\t80x25\nKTerm*VT100*loginShell:\ttrue\nKTerm*keepSelection:\ttrue\nKTerm*=
ScrollBar:\tfalse\nKTerm*SaveLines:\t4096\nKTerm*eightBitInput:\ttrue\nKTer=
m*eightBitOutput:\ttrue\nKTerm*backarrowKeyIsErase:\ttrue\nKTerm*deleteIsDE=
L:\tfalse\nKTerm*ptyInitialErase:\ttrue\nKTerm*VT100*background:\tblack\nKT=
erm*VT100*foreground:\trgb:AA/AA/AA\nKTerm*termName:\tkterm\nKTerm*pointerC=
olor:\trgb:FF/B0/00\nKTerm*pointerMode:\t0\nKTerm*cursorBlink:\ttrue\nKTerm=
*cursorUnderLine:\ttrue\nKTerm*cursorColor:\trgb:FF/B0/00\nKTerm*VT100*colo=
rMode:\ttrue\nKTerm*VT100*colorBDMode:\ttrue\nKTerm*VT100*colorBLMode:\tfal=
se\nKTerm*VT100*colorULMode:\tfalse\nKTerm*VT100*boldColors:\ttrue\nKTerm*V=
T100*boldMode:\tfalse\nKTerm*allowBoldFonts:\tfalse\nKTerm*VT100*dynamicCol=
ors:\ttrue\nKTerm*VT100*utf8:\t0\nKTerm*VT100*color0:\trgb:00/00/00\nKTerm*=
VT100*color1:\trgb:AA/00/00\nKTerm*VT100*color2:\trgb:00/AA/00\nKTerm*VT100=
*color3:\trgb:AA/55/00\nKTerm*VT100*color4:\trgb:00/00/AA\nKTerm*VT100*colo=
r5:\trgb:AA/00/AA\nKTerm*VT100*color6:\trgb:00/AA/AA\nKTerm*VT100*color7:\t=
rgb:AA/AA/AA\nKTerm*VT100*color8:\trgb:55/55/55\nKTerm*VT100*color9:\trgb:F=
F/55/55\nKTerm*VT100*color10:\trgb:55/FF/55\nKTerm*VT100*color11:\trgb:FF/F=
F/55\nKTerm*VT100*color12:\trgb:55/55/FF\nKTerm*VT100*color13:\trgb:FF/55/F=
F\nKTerm*VT100*color14:\trgb:55/FF/FF\nKTerm*VT100*color15:\trgb:FF/FF/FF\n=
KTerm*VT100*colorBD:\twhite\nKTerm*fontMenu*background:\tAntiqueWhite\nKTer=
m*fontMenu*foreground:\tgray15\nKTerm*visualBell:\ttrue\nKTerm*VT100*kanjiM=
ode:\teuc\nKTerm*VT100*Translations:\t#override Shift<Key>space: begin-conv=
ersion(_JAPANESE_CONVERSION) \\n\nXTerm*charClass:\t33:33,35:35,37:37,38:38=
,43:43,44:44,45:45,46:46,47:47,58:58,61:61,62:62,63:63,64:64,95:48,126:126\=
nUXTerm*charClass:\t33:33,35:35,37:37,38:38,43:43,44:44,45:45,46:46,47:47,5=
8:58,61:61,62:62,63:63,64:64,95:48,126:126\nAXTerm*charClass:\t33:33,35:35,=
37:37,38:38,43:43,44:44,45:45,46:46,47:47,58:58,61:61,62:62,63:63,64:64,95:=
48,126:126\nBXTerm*charClass:\t33:33,35:35,37:37,38:38,43:43,44:44,45:45,46=
:46,47:47,58:58,61:61,62:62,63:63,64:64,95:48,126:126\nTXTerm*charClass:\t3=
3:33,35:35,37:37,38:38,43:43,44:44,45:45,46:46,47:47,58:58,61:61,62:62,63:6=
3,64:64,95:48,126:126\nRXTerm*charClass:\t33:33,35:35,37:37,38:38,43:43,44:=
44,45:45,46:46,47:47,58:58,61:61,62:62,63:63,64:64,95:48,126:126\nVXTerm*ch=
arClass:\t33:33,35:35,37:37,38:38,43:43,44:44,45:45,46:46,47:47,58:58,61:61=
,62:62,63:63,64:64,95:48,126:126\nKTerm*charClass:\t33:33,35:35,37:37,38:38=
,43:43,44:44,45:45,46:46,47:47,58:58,61:61,62:62,63:63,64:64,95:48,126:126\=
nXTerm*selectToClipboard:\tfalse\nUXTerm*selectToClipboard:\tfalse\nAXTerm*=
selectToClipboard:\tfalse\nBXTerm*selectToClipboard:\tfalse\nTXTerm*selectT=
oClipboard:\tfalse\nRXTerm*selectToClipboard:\tfalse\nVXTerm*selectToClipbo=
ard:\tfalse\nKTerm*selectToClipboard:\tfalse\nNetscape*drawingArea*translat=
ions:\t#replace <Btn1Down>: ArmLink() \\n <Btn2Down>: ArmLink() \\n ~Shift<=
Btn1Up>: ActivateLink() \\n ~Shift<Btn2Up>: ActivateLink(new-window)DisarmL=
ink() \\n Shift<Btn1Up>: ActivateLink(save-only)DisarmLink() \\n Shift<Btn2=
Up>: ActivateLink(save-only)DisarmLink() \\n <Btn1Motion>: DisarmLinkIfMove=
d() \\n <Btn2Motion>: DisarmLinkIfMoved() \\n <Btn3Motion>: DisarmLinkIfMov=
ed() \\n <Motion>: DescribeLink() \\n <Btn3Down>: xfeDoPopup() \\n <Btn3Up>=
: ActivatePopup() \\n Ctrl<Btn4Down>: PageUp()\\n Ctrl<Btn5Down>: PageDown(=
)\\n Shift<Btn4Down>: LineUp()\\n Shift<Btn5Down>: LineDown()\\n None<Btn4D=
own>: LineUp()LineUp()LineUp()LineUp()LineUp()LineUp()\\n None<Btn5Down>: L=
ineDown()LineDown()LineDown()LineDown()LineDown()LineDown()\\n Alt<Btn4Down=
>: xfeDoCommand(forward)\\n Alt<Btn5Down>: xfeDoCommand(back)\\n\nNetscape*=
globalNonTextTranslations:\t#override\\n Shift<Btn4Down>: LineUp()\\n Shift=
<Btn5Down>: LineDown()\\n None<Btn4Down>: LineUp()LineUp()LineUp()LineUp()L=
ineUp()LineUp()\\n None<Btn5Down>: LineDown()LineDown()LineDown()LineDown()=
LineDown()LineDown()\\n Alt<Btn4Down>: xfeDoCommand(forward)\\n Alt<Btn5Dow=
n>: xfeDoCommand(back)\\n\n"
  - xdpyinfo
=09name of display:    :2
=09version number:    11.0
=09vendor string:    AT&T Laboratories Cambridge
=09vendor release number:    3332
=09maximum request size:  4194300 bytes
=09motion buffer size:  256
=09bitmap unit, bit order, padding:    32, LSBFirst, 32
=09image byte order:    LSBFirst
=09number of supported pixmap formats:    2
=09supported pixmap formats:
=09    depth 1, bits_per_pixel 1, scanline_pad 32
=09    depth 24, bits_per_pixel 32, scanline_pad 32
=09keycode range:    minimum 8, maximum 255
=09focus:  window 0x1400010, revert to None
=09number of extensions:    7
=09    BIG-REQUESTS
=09    MIT-SHM
=09    MIT-SUNDRY-NONSTANDARD
=09    SHAPE
=09    SYNC
=09    XC-MISC
=09    XTEST
=09default screen number:    0
=09number of screens:    1

=09screen #0:
=09  dimensions:    1000x768 pixels (339x260 millimeters)
=09  resolution:    75x75 dots per inch
=09  depths (1):    24
=09  root window id:    0x25
=09  depth of root window:    24 planes
=09  number of colormaps:    minimum 1, maximum 1
=09  default colormap:    0x21
=09  default number of colormap cells:    256
=09  preallocated pixels:    black 0, white 16777215
=09  options:    backing-store YES, save-unders YES
=09  largest cursor:    1000x768
=09  current input event mask:    0xfa200c
=09    ButtonPressMask          ButtonReleaseMask        ButtonMotionMask  =
      =20
=09    StructureNotifyMask      SubstructureNotifyMask   SubstructureRedire=
ctMask=20
=09    FocusChangeMask          PropertyChangeMask       ColormapChangeMask=
      =20
=09  number of visuals:    1
=09  default visual id:  0x22
=09  visual:
=09    visual id:    0x22
=09    class:    TrueColor
=09    depth:    24 planes
=09    available colormap entries:    256 per subfield
=09    red, green, blue masks:    0xff0000, 0xff00, 0xff
=09    significant bits in color specification:    8 bits

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

