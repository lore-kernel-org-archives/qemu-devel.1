Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBHhM-0001AP-H4
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBHhH-0006Gr-KM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:30:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:50640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBHhH-0006GB-E1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBHhG-0007yo-Hb
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 10:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 645962E80C9
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 10:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Apr 2018 10:23:07 -0000
From: Justin <1766841@bugs.launchpad.net>
Reply-To: Bug 1766841 <1766841@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152465178789.21509.8085388028037824608.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1766841] [NEW] QEMU 2.12 Running Problem in
 Windows 7 Installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

QEMU Version: 2.12 (Binary installer qemu-w64-setup-20180424.exe  from Stef=
an Weil's website so I am not sure I should report it to Weil by email or b=
y this bug report system.)
Host System: Windows 7 64bit
Guest System: 9front 6350 (Codename=E2=80=9CCONTENTS, MAINTAINED, STABLE=E2=
=80=9D, Release 2018/02/02)

QEMU Command:
qemu-system-x86_64 -usb -device usb-mouse -hda plan9.qcow2.img -cdrom 9fron=
t-6350.iso -boot d

QEMU warning: =

(qemu-system-x86_64.exe:8844): GdkPixbuf-WARNING **: Cannot open pixbuf loa=
der module file 'D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.cache': No such =
file or directory

This likely means that your installation is broken.
Try running the command
  gdk-pixbuf-query-loaders > D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.cache
to make things work again for the time being.

(qemu-system-x86_64.exe:8844): Gtk-WARNING **: Could not find the icon 'win=
dow-minimize-symbolic-ltr'. The 'hicolor' theme was not found either, perha=
ps you need to install it.
You can get a copy from:
        http://icon-theme.freedesktop.org/releases

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: installation windows

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1766841

Title:
  QEMU 2.12 Running Problem in Windows 7 Installation

Status in QEMU:
  New

Bug description:
  QEMU Version: 2.12 (Binary installer qemu-w64-setup-20180424.exe  from St=
efan Weil's website so I am not sure I should report it to Weil by email or=
 by this bug report system.)
  Host System: Windows 7 64bit
  Guest System: 9front 6350 (Codename=E2=80=9CCONTENTS, MAINTAINED, STABLE=
=E2=80=9D, Release 2018/02/02)

  QEMU Command:
  qemu-system-x86_64 -usb -device usb-mouse -hda plan9.qcow2.img -cdrom 9fr=
ont-6350.iso -boot d

  QEMU warning: =

  (qemu-system-x86_64.exe:8844): GdkPixbuf-WARNING **: Cannot open pixbuf l=
oader module file 'D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.cache': No suc=
h file or directory

  This likely means that your installation is broken.
  Try running the command
    gdk-pixbuf-query-loaders > D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.ca=
che
  to make things work again for the time being.

  (qemu-system-x86_64.exe:8844): Gtk-WARNING **: Could not find the icon 'w=
indow-minimize-symbolic-ltr'. The 'hicolor' theme was not found either, per=
haps you need to install it.
  You can get a copy from:
          http://icon-theme.freedesktop.org/releases

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1766841/+subscriptions
