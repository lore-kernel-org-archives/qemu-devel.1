Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7z3R-0002u3-SZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7z3O-0007Ih-P7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:27:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:59642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7z3O-0007Hh-It
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:27:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7z3K-000678-78
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 07:27:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CACD32E80E9
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 07:27:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 07:07:38 -0000
From: Bug Watch Updater <586175@bugs.launchpad.net>
Reply-To: Bug 586175 <586175@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100527023758.1600.77688.malonedeb@soybean.canonical.com>
Message-Id: <150908806004.24641.17693285384793259460.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 586175] Re: Windows XP/2003 doesn't boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: fedora
       Status: Unknown =3D> Won't Fix

** Changed in: fedora
   Importance: Unknown =3D> High

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/586175

Title:
  Windows XP/2003 doesn't boot

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in Debian:
  Fix Released
Status in Fedora:
  Won't Fix

Bug description:
  Hello everyone,

  my qemu doesn't boot any Windows XP/2003 installations if I try to boot t=
he image.
  If I boot the install cd first, it's boot manager counts down and trigger=
s the boot on it's own. That's kinda stupid.

  I'm using libvirt, but even by a simple
  > qemu-kvm -drive file=3Dimage.img,media=3Ddisk,if=3Dide,boot=3Don
  it won't boot. Qemu hangs at the message "Booting from Hard Disk..."

  I'm using qemu-kvm-0.12.4 with SeaBIOS 0.5.1 on Gentoo (No-Multilib
  and AMD64). It's a server, that means I'm using VNC as the primary
  graphic output but i don't think it should be an issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/586175/+subscriptions
