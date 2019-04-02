Received: from eggs.gnu.org ([209.51.188.92]:55518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBK58-0007sE-Jh
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBK4v-0008Py-6s
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:07:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:52132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBK4r-0008LY-UO
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:07:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBK4o-0002un-TN
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 14:07:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3E452E86B8
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 14:07:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2019 13:51:28 -0000
From: John Frankish <john.frankish@outlook.com>
Reply-To: Bug 1567254 <1567254@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160407073359.3051.6082.malonedeb@chaenomeles.canonical.com>
Message-Id: <155421308859.11822.16068750147501754206.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1567254] Re: qemu-2.5.1 will not run with gtk3/vte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Things seem to work with gtk3 and qemu-3.1.0 - I didn't try vte
though...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1567254

Title:
  qemu-2.5.1 will not run with gtk3/vte

Status in QEMU:
  Incomplete

Bug description:
  Using qemu-2.5.1 and compiling without gtk3 and vte-2.90.

  This works:

  CC=3D"gcc -mtune=3Dgeneric -Os -pipe" CXX=3D"g++ -mtune=3Dgeneric -Os -pi=
pe
  -fno-exceptions -fno-rtti" ./configure --prefix=3D/usr/local
  --localstatedir=3D/var --libexecdir=3D/usr/local/lib/qemu --interp-
  prefix=3D/usr/local/share/qemu --audio-drv-list=3D"oss alsa sdl" --target-
  list=3D"i386-softmmu i386-linux-user x86_64-softmmu x86_64-linux-user"
  --smbd=3D/usr/local/sbin/smbd --disable-curses

  find . -name config-host.mak -type f -exec sed -i 's/-O2//g' {} \;

  make
  sudo make install

  If I then add gtk3 and vte-2.90 development files and compile again,
  this fails with or without --disable-docs:

   sudo make install
  ...
  make -C po install
  make[1]: Entering directory '/usr/src/qemu-2.5.1/po'
    GEN   tr.mo
  /bin/sh: msgfmt: not found
  Makefile:13: recipe for target 'tr.mo' failed
  make[1]: *** [tr.mo] Error 127
  make[1]: Leaving directory '/usr/src/qemu-2.5.1/po'
  Makefile:443: recipe for target 'install' failed
  make: *** [install] Error 2

  If I then add gettext and re-compile, "qemu-system-x86_64 -blah-blah"
  opens a window, displays the bios message and stops.

  * configure script should check for gettext
  * if "--disable-docs" is passed, "make install" should not try to install=
 docs
  * qemu should work when compiled with gtk3 and vte
  * why does qemu insist on vte-2.90, when vte-2.91 has been out +/- 2 year=
s?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1567254/+subscriptions
