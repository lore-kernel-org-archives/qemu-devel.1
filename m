Received: from eggs.gnu.org ([2001:4830:134:3::10]:49690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUFva-0004fa-8n
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUFvX-00031n-4R
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:55:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUFvW-0002zU-Tb
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:55:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUFvU-0001K5-DQ
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 17:55:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 639BA2E80C7
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 17:55:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Dec 2017 17:48:48 -0000
From: Michal Nowak <mnowak@startmail.com>
Reply-To: Bug 1738283 <1738283@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151328724563.26325.11755910452939969450.malonedeb@wampee.canonical.com>
Message-Id: <151439692880.26125.9637733122997213757.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738283] Re: 'Less than' (<), 'more than' (>),
 and 'pipe' (|) can't be typed via VNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I found Adam's patch from Fedora Rawhide
(https://src.fedoraproject.org/rpms/qemu/c/f81be8f0261cce74799f946e99f23d57=
f8db7e17?branch=3Dmaster)
when applied to openSUSE's 2.11.0 QEMU effective in openQA as well as
manually with vncviewer.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738283

Title:
  'Less than' (<), 'more than' (>), and 'pipe' (|) can't be typed via
  VNC

Status in QEMU:
  New

Bug description:
  If I start QEMU 2.11 (from
  https://build.opensuse.org/package/show/Virtualization/qemu) VM with
  VNC, I am unable to type following three characters: 'less than' (<),
  'more than' (>), and 'pipe' (|) on en_US QWERTY keyboard. Other
  characters work fine. QEMu version 2.10.1 worked fine.

  /usr/bin/qemu-kvm -m 2048 -cpu kvm64 -drive
  media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3DOI-hipster-
  minimal-20171031.iso -device ide-cd,drive=3Dcd0 -boot once=3Dd,menu=3Don
  ,splash-time=3D5000 -device usb-ehci -device usb-tablet -smp 1 -enable-
  kvm -vnc :91,share=3Dforce-shared

  The ISO can be downloaded here: https://www.openindiana.org/download/

  Also tried Fedora-Server-dvd-x86_64-25-1.3.iso and it's the same
  situation.

  If I run the same command without '-vnc :91,share=3Dforce-shared',
  everything works just fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738283/+subscriptions
