Received: from eggs.gnu.org ([2001:4830:134:3::10]:48241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7f3l-0006WF-Dj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7f3g-0005pG-G0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:06:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:42304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7f3g-0005oc-9r
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:06:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7f3f-00027e-8s
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 10:06:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2B5C82E80C3
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 10:06:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 09:55:05 -0000
From: Thomas Huth <1127053@bugs.launchpad.net>
Reply-To: Bug 1127053 <1127053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130216085307.29031.52810.malonedeb@chaenomeles.canonical.com>
Message-Id: <150901170566.17568.2996198735785432296.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1127053] Re: assertion failed in exec.c while
 attempting to start a guest (latest commit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1127053

Title:
  assertion failed in exec.c while attempting to start a guest (latest
  commit)

Status in QEMU:
  Incomplete

Bug description:
  Hi team,

  I decided to try the latest commit on git (previously used version
  1.3.0), and I got failed assertions while attempting to start my
  guests:

  eclipse ~ # qemu-kvm -enable-kvm -hda arch.img -m 4096 -smp sockets=3D1,c=
ores=3D4 -vnc :0 -cpu host -vga std -net nic,model=3De1000,macaddr=3D00:00:=
00:00:00:00 -net tap,ifname=3Dvm0 -qmp tcp:0.0.0.0:4900,server,nowait
  qemu-kvm: /var/tmp/portage/app-emulation/qemu-9999/work/qemu-9999/exec.c:=
982: qemu_ram_set_idstr: Assertion `!new_block->idstr[0]' failed.
  Aborted

  The assertion seems valid, so whatever's causing it is probably to
  blame. I haven't dug around much to find out what calls the method
  (qemu_ram_set_idstr()), but that is probably the best place to start.

  The host contains a Xeon E3-1240 CPU, virtualising a bunch of guests
  one of which is Arch Linux 64-bit, if that helps.

  eclipse ~ # qemu-kvm -version
  QEMU emulator version 1.4.50, Copyright (c) 2003-2008 Fabrice Bellard

  It looks like this assertion happens if you call the executable
  without any parameters as well:

  eclipse ~ # qemu-kvm
  qemu-kvm: /var/tmp/portage/app-emulation/qemu-9999/work/qemu-9999/exec.c:=
982: qemu_ram_set_idstr: Assertion `!new_block->idstr[0]' failed.
  Aborted

  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1127053/+subscriptions
