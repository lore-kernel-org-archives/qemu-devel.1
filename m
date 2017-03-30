Received: from eggs.gnu.org ([2001:4830:134:3::10]:42529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaXb-0002jW-RC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaXa-0000YY-R1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:45383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctaXa-0000Xt-MS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctaXZ-0000Ua-RS
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:55:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CA8AD2E8043
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:55:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 13:41:02 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1588473 <1588473@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160602175533.6605.97992.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170330134104.26304.71236.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1588473] Re: Qemu Mate 16.10 and Gtk dont build
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
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1588473

Title:
  Qemu Mate 16.10 and Gtk dont build

Status in QEMU:
  Fix Released

Bug description:
  when i try to build last qemu 2.6 on 16.10 of ubuntu mate i have this.
  note on 16.04 was building without problem
    =

  LINK  i386-softmmu/qemu-system-i386
  ../ui/gtk.o: In function `gd_get_pointer':
  /home/amigaone/src/qemu/ui/gtk.c:486: undefined reference to `gdk_display=
_get_default_seat'
  /home/amigaone/src/qemu/ui/gtk.c:486: undefined reference to `gdk_seat_ge=
t_pointer'
  ../ui/gtk.o: In function `gd_grab_update':
  /home/amigaone/src/qemu/ui/gtk.c:1339: undefined reference to `gdk_displa=
y_get_default_seat'
  /home/amigaone/src/qemu/ui/gtk.c:1353: undefined reference to `gdk_seat_g=
rab'
  /home/amigaone/src/qemu/ui/gtk.c:1356: undefined reference to `gdk_seat_u=
ngrab'
  ../ui/gtk.o: In function `gd_get_pointer':
  /home/amigaone/src/qemu/ui/gtk.c:486: undefined reference to `gdk_display=
_get_default_seat'
  /home/amigaone/src/qemu/ui/gtk.c:486: undefined reference to `gdk_seat_ge=
t_pointer'
  /home/amigaone/src/qemu/ui/gtk.c:486: undefined reference to `gdk_display=
_get_default_seat'
  /home/amigaone/src/qemu/ui/gtk.c:486: undefined reference to `gdk_seat_ge=
t_pointer'
  collect2: error: ld returned 1 exit status

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1588473/+subscriptions
