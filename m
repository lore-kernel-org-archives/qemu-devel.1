Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsF-0004qA-AU
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsA-0000Fx-9h
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTgsA-0000Er-30
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTgs6-0001EV-VW
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E30E92E80C3
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Dec 2017 04:17:25 -0000
From: Launchpad Bug Tracker <1127053@bugs.launchpad.net>
Reply-To: Bug 1127053 <1127053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130216085307.29031.52810.malonedeb@chaenomeles.canonical.com>
Message-Id: <151426184604.1219.13728722116306150544.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1127053

Title:
  assertion failed in exec.c while attempting to start a guest (latest
  commit)

Status in QEMU:
  Expired

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
