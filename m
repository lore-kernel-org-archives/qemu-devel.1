Received: from eggs.gnu.org ([2001:4830:134:3::10]:41985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fH4mj-00082u-N7
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fH4mg-00036q-Kn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:56:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:53840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fH4mg-00035y-FH
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:56:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fH4me-0005B3-HO
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:56:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E6172E8F3C
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:56:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 May 2018 09:47:39 -0000
From: Justin <1766841@bugs.launchpad.net>
Reply-To: Bug 1766841 <1766841@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152465178789.21509.8085388028037824608.malonedeb@soybean.canonical.com>
Message-Id: <152603205959.1364.5014474156241909837.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1766841] Re: QEMU 2.12 Running Problem in Windows
 7 Installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rechecked in my site, the new installer (20180430) had solved the 1st
problem, but it leads to another problem: When uninstall QEMU, the
loaders.cache file cannot be deleted automatically.

For 2nd warning, I checked it again, when I choosed fully installing,
the icons are displayed correctly; But when I just installed the x64 &
x64w simulator, the icons are lost and the 2nd warning message shown. It
seems some dependent file is not installed when performing a selected
installation.

** Attachment added: "Screenshot for Icons Lost"
   https://bugs.launchpad.net/qemu/+bug/1766841/+attachment/5137682/+files/=
qemu%20no%20icons.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1766841

Title:
  QEMU 2.12 Running Problem in Windows 7 Installation

Status in QEMU:
  Confirmed

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
