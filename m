Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Lg-0001b3-DG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Le-0000mu-H3
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:38992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0Le-0000m6-7Q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0Ld-00033N-9H
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:41:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 435BF2E851E
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:41:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:29:23 -0000
From: Thomas Huth <1767176@bugs.launchpad.net>
Reply-To: Bug 1767176 <1767176@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152476695027.6122.1941123400059547378.malonedeb@chaenomeles.canonical.com>
Message-Id: <153483296402.5393.10871807979386027516.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1767176] Re: GTK build fails with qemu 2.12.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1767176

Title:
  GTK build fails with qemu 2.12.0

Status in QEMU:
  Fix Released

Bug description:
  With the 2.12.0 release of QEMU passing `--enable-gtk` to configure
  causes the build to fail. I'm running macOS 10.13.5 with Xcode 9.3
  FWIW.

  I'm building against GTK 2.24.32, which I appreciate is no longer the
  preferred version here, but I don't think the error is related to that
  aspect. I'll try and find the time later to attempt a GTK3 build to
  check that though.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  ui/gtk.c:1147:16: error: use of undeclared identifier 'qemu_input_map_osx=
_to_qcode'; did you mean 'qemu_input_map_usb_to_qcode'?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return qemu_input_map_osx=
_to_qcode;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0qemu_input_map_usb_to_qcode
  /private/tmp/qemu-20180426-60786-1av6pq8/qemu-2.12.0/include/ui/input.h:9=
9:22: note: 'qemu_input_map_usb_to_qcode' declared here
  extern const guint16 qemu_input_map_usb_to_qcode[];
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I tried poking around locally by applying the following diff, based
  off of a very brief glance over the code involved, but that simply
  causes the build to error out in a different way at a later point, so
  I assume I'm doing something stupid.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  diff --git a/Makefile b/Makefile
  index d71dd5b..e857c3c 100644
  --- a/Makefile
  +++ b/Makefile
  @@ -313,6 +313,7 @@ KEYCODEMAP_FILES =3D \
  =C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-qnum-to-qcode.c \
  =C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-usb-to-qcode.c \
  =C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-win32-to-qcode.c \
  +     ui/input-keymap-osx-to-qcode.c \
  =C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-x11-to-qcode.c \
  =C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-xorgevdev-to-qcode.c \
  =C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-xorgkbd-to-qcode.c \
  diff --git a/include/ui/input.h b/include/ui/input.h
  index 16395ab..8183840 100644
  --- a/include/ui/input.h
  +++ b/include/ui/input.h
  @@ -101,6 +101,9 @@ extern const guint16 qemu_input_map_usb_to_qcode[];
  =C2=A0extern const guint qemu_input_map_win32_to_qcode_len;
  =C2=A0extern const guint16 qemu_input_map_win32_to_qcode[];

  +extern const guint qemu_input_map_osx_to_qcode_len;
  +extern const guint16 qemu_input_map_osx_to_qcode[];
  +
  =C2=A0extern const guint qemu_input_map_x11_to_qcode_len;
  =C2=A0extern const guint16 qemu_input_map_x11_to_qcode[];
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1767176/+subscriptions
